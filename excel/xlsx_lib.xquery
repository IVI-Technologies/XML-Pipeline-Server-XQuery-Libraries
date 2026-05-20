(:~
 : XLSX Reader Library
 : ===================
 :
 : Extracts cell content from Microsoft Excel .xlsx files (Office Open XML)
 : using the XPS XQuery processor's `jar:` URL scheme to read the inner XML
 : parts directly out of the .xlsx zip without unpacking it.
 :
 : .xlsx layout (the parts this library reads):
 :   [Content_Types].xml
 :   xl/workbook.xml              -- list of sheets, 1904 date-mode flag
 :   xl/_rels/workbook.xml.rels   -- maps r:id -> worksheet path
 :   xl/sharedStrings.xml         -- string pool referenced by cells with t="s"
 :   xl/styles.xml                -- cellXfs[@s] -> numFmtId -> formatCode
 :   xl/worksheets/sheetN.xml     -- sheet data (or Sheet1.xml etc. -- case varies)
 :
 : Each query that uses this library should be specific to the spreadsheet
 : it is processing (caller picks the sheet and the header row).
 :
 : Public API:
 :   xlsx:getSheetNames($url)                              -> sequence of sheet names
 :   xlsx:getCells($url, $sheetNumber, $headerRow)         -> <table> of typed <row>s
 :   xlsx:getCellsByName($url, $sheetName, $headerRow)     -> same, by sheet name
 :
 : Output structure:
 :   <table xmlns:xsi="...">
 :     <row>
 :       <ColumnName xsi:type="xs:integer">1001</ColumnName>
 :       <ColumnName xsi:type="xs:date" format="m/d/yyyy" raw="45730">2025-03-14</ColumnName>
 :       <ColumnName xsi:type="xs:decimal" format='"$"#,##0.00' currency="USD" raw="1234.56">1234.56</ColumnName>
 :       <ColumnName xsi:nil="true"/>      <!-- missing cell in sparse row -->
 :       ...
 :     </row>
 :   </table>
 :
 : Cell type -> xsi:type mapping:
 :   shared / inline / formula string ........... xs:string
 :   boolean (t="b") ............................ xs:boolean ("true"/"false")
 :   error   (t="e") ............................ xs:string with error="true"
 :   number, style = date format ................ xs:date
 :   number, style = time format ................ xs:time
 :   number, style = date+time format ........... xs:dateTime
 :   number, style = currency format ............ xs:decimal with currency=, format=
 :   number, style = percentage format .......... xs:decimal (raw fraction, e.g. 0.05)
 :   number, integer literal .................... xs:integer
 :   number, otherwise .......................... xs:decimal
 :
 : Notes:
 :   - Column positions are preserved using @r (so a missing cell in a sparse
 :     row emits an xsi:nil placeholder rather than shifting other columns left).
 :   - Date serials use Excel's 1900 base (compensated epoch 1899-12-30) or the
 :     1904 base if workbook.xml/workbookPr/@date1904 = "1".
 :   - Sheet path is resolved via xl/_rels/workbook.xml.rels so capitalization
 :     (e.g. "Sheet1.xml" vs "sheet1.xml") and non-standard paths both work.
 :   - Rich-text shared strings (<si><r>...<t/></r><r>...<t/></r></si>) are
 :     concatenated into a single string.
 :   - Merged cells are NOT expanded: the value appears only in the top-left
 :     cell of the merge range; the rest are empty.
 :)

module namespace xlsx = "urn:ivi:xlsx";

declare namespace spml = "http://schemas.openxmlformats.org/spreadsheetml/2006/main";
declare namespace r    = "http://schemas.openxmlformats.org/officeDocument/2006/relationships";
declare namespace pr   = "http://schemas.openxmlformats.org/package/2006/relationships";
declare namespace mc   = "http://schemas.openxmlformats.org/markup-compatibility/2006";
declare namespace xs   = "http://www.w3.org/2001/XMLSchema";
declare namespace xsi  = "http://www.w3.org/2001/XMLSchema-instance";


(: ============================================================
   URL helpers
   ============================================================ :)

(: Normalize a path or URL into a file: URL suitable for doc(): backslashes
   become forward slashes; literal spaces become %20. :)
declare function xlsx:safeUrl($urlOrFileName as xs:string) as xs:string
{
  let $url := if(fn:starts-with($urlOrFileName, 'file:')) then $urlOrFileName else concat('file:',$urlOrFileName)
  return replace(replace($url, '\\', '/'), ' ', '%20')
};

(: Wrap a file URL as a jar: URL, ready to be suffixed with /entry/inside/zip :)
declare function xlsx:jarUrl($urlOrFileName as xs:string) as xs:string
{
  concat('jar:', xlsx:safeUrl($urlOrFileName), '!')
};


(: ============================================================
   Column name & reference helpers
   ============================================================ :)

(: Sanitize an arbitrary cell value into a legal XML element name (A-Z, a-z,
   0-9, _). Empty -> "EmptyColumnName"; leading digit gets a "_" prefix. :)
declare function xlsx:makeQname($unsafeValue as xs:string) as xs:string
{
  let $letters         := 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz_0123456789'
  let $unsafe_letters  := fn:translate($unsafeValue, $letters, '')
  let $safeName        := fn:translate($unsafeValue, $unsafe_letters , '_')
  let $leading         := if(matches($safeName, '^[0-9]')) then concat('_', $safeName) else $safeName
  return
  if(string-length($leading) = 0) then 'EmptyColumnName' else $leading
};

(: Recursive accumulator for columnLetterToIndex; processes one letter at a time. :)
declare function xlsx:colLetterRec($letters as xs:string, $pos as xs:integer, $acc as xs:integer) as xs:integer
{
  if($pos > string-length($letters)) then $acc
  else
    let $code := string-to-codepoints(substring($letters, $pos, 1))[1]
    return xlsx:colLetterRec($letters, $pos + 1, $acc * 26 + ($code - 64))
};

(: Excel column letters to 1-based index. A=1, B=2, ..., Z=26, AA=27, AB=28, ... :)
declare function xlsx:columnLetterToIndex($letters as xs:string) as xs:integer
{
  xlsx:colLetterRec(upper-case($letters), 1, 0)
};

(: Convert a cell reference like "C5" to its 1-based column index (3). :)
declare function xlsx:refToColIndex($ref as xs:string) as xs:integer
{
  xlsx:columnLetterToIndex(replace($ref, '[0-9]+$', ''))
};


(: ============================================================
   Workbook / styles inspection
   ============================================================ :)

(: True if the workbook uses the 1904 date base (older Excel-for-Mac default). :)
declare function xlsx:is1904Mode($workbook) as xs:boolean
{
  if(empty($workbook)) then false()
  else
    let $val := string($workbook/spml:workbook/spml:workbookPr/@date1904)
    return $val = '1' or $val = 'true'
};

(: Built-in numFmtId -> format code (ids 0-49 are reserved by the OOXML spec). :)
declare function xlsx:builtinNumFmt($id as xs:integer) as xs:string
{
  if($id = 0)  then 'General'
  else if($id = 1)  then '0'
  else if($id = 2)  then '0.00'
  else if($id = 3)  then '#,##0'
  else if($id = 4)  then '#,##0.00'
  else if($id = 9)  then '0%'
  else if($id = 10) then '0.00%'
  else if($id = 11) then '0.00E+00'
  else if($id = 12) then '# ?/?'
  else if($id = 13) then '# ??/??'
  else if($id = 14) then 'm/d/yyyy'
  else if($id = 15) then 'd-mmm-yy'
  else if($id = 16) then 'd-mmm'
  else if($id = 17) then 'mmm-yy'
  else if($id = 18) then 'h:mm AM/PM'
  else if($id = 19) then 'h:mm:ss AM/PM'
  else if($id = 20) then 'h:mm'
  else if($id = 21) then 'h:mm:ss'
  else if($id = 22) then 'm/d/yyyy h:mm'
  else if($id = 37) then '#,##0 ;(#,##0)'
  else if($id = 38) then '#,##0 ;[Red](#,##0)'
  else if($id = 39) then '#,##0.00;(#,##0.00)'
  else if($id = 40) then '#,##0.00;[Red](#,##0.00)'
  else if($id = 45) then 'mm:ss'
  else if($id = 46) then '[h]:mm:ss'
  else if($id = 47) then 'mmss.0'
  else if($id = 48) then '##0.0E+0'
  else if($id = 49) then '@'
  else ''
};

(: Look up the format code that applies to a cell's @s style index, via
   styles.xml/cellXfs -> numFmtId -> either numFmts (custom) or built-in. :)
declare function xlsx:formatCodeForStyle($styles, $styleIdx as xs:integer) as xs:string
{
  if(empty($styles)) then ''
  else
    let $xfs    := $styles/spml:styleSheet/spml:cellXfs/spml:xf
    let $xf     := $xfs[$styleIdx + 1]
    let $numId  := xs:integer((string($xf/@numFmtId), '0')[. != ''][1])
    let $custom := $styles/spml:styleSheet/spml:numFmts/spml:numFmt[@numFmtId = string($numId)]/@formatCode
    return
      if(string($custom) != '') then string($custom)
      else xlsx:builtinNumFmt($numId)
};

(: Remove [..] sections, "..." quoted literals, and \X escapes from a format
   code so token detection (m/d/y/h/s) isn't confused by colour codes,
   currency-locale tags, or quoted text. :)
declare function xlsx:stripFormatLiterals($fmt as xs:string) as xs:string
{
  let $noBrackets := replace($fmt, '\[[^\]]*\]', '')
  let $noQuoted   := replace($noBrackets, '"[^"]*"', '')
  let $noBacks    := replace($noQuoted, '\\.', '')
  return $noBacks
};

(: Classify a format code as one of: date, time, datetime, percentage,
   currency, number. 'm' is treated as month (date) when no 'h' or 's' is
   present; otherwise it is treated as minute (and ignored for date detection). :)
declare function xlsx:detectTypeFromFormat($fmt as xs:string) as xs:string
{
  let $stripped := xlsx:stripFormatLiterals($fmt)
  let $hasDY    := matches($stripped, '[dy]')
  let $hasHS    := matches($stripped, '[hs]')
  let $hasM     := contains($stripped, 'm')
  let $hasDate  := $hasDY or ($hasM and not($hasHS))
  let $hasTime  := $hasHS
  return
    if($hasDate and $hasTime) then 'datetime'
    else if($hasDate) then 'date'
    else if($hasTime) then 'time'
    else if(contains($stripped, '%')) then 'percentage'
    else if(matches($fmt, '\[\$') or contains($fmt, '$') or contains($fmt, '&#8364;') or contains($fmt, '&#163;') or contains($fmt, '&#165;')) then 'currency'
    else 'number'
};

(: Extract an ISO currency code from a format code. Prefers the explicit
   [$XXX-LCID] form; otherwise infers from the symbol ($, EUR, GBP, JPY). :)
declare function xlsx:extractCurrencyCode($fmt as xs:string) as xs:string
{
  let $bracketed := replace($fmt, '.*\[\$([^-\]]*).*', '$1')
  return
    if($bracketed != $fmt and string-length($bracketed) > 0) then $bracketed
    else if(contains($fmt, '$'))      then 'USD'
    else if(contains($fmt, '&#8364;')) then 'EUR'
    else if(contains($fmt, '&#163;')) then 'GBP'
    else if(contains($fmt, '&#165;')) then 'JPY'
    else ''
};


(: ============================================================
   Excel serial number -> xs:date / xs:dateTime / xs:time
   ============================================================ :)

(: Excel stores dates as days since the epoch. In 1900 mode the compensated
   epoch is 1899-12-30 (this absorbs Excel's well-known phantom Feb 29 1900
   leap-year bug for all dates from 1900-03-01 onward). In 1904 mode the epoch
   is 1904-01-01. :)
declare function xlsx:serialToDate($serial as xs:double, $is1904 as xs:boolean) as xs:date
{
  let $epoch := if($is1904) then xs:date('1904-01-01') else xs:date('1899-12-30')
  let $days  := xs:integer(floor($serial))
  return $epoch + xs:dayTimeDuration(concat('P', $days, 'D'))
};

(: Days + fractional-day seconds. Split into P{days}DT{seconds}S because
   collapsing into PT{huge}S overflows int parsing in some processors. :)
declare function xlsx:serialToDateTime($serial as xs:double, $is1904 as xs:boolean) as xs:dateTime
{
  let $epoch        := if($is1904) then xs:dateTime('1904-01-01T00:00:00') else xs:dateTime('1899-12-30T00:00:00')
  let $days         := xs:integer(floor($serial))
  let $frac         := $serial - $days
  let $totalSeconds := xs:integer(round($frac * 86400))
  return $epoch + xs:dayTimeDuration(concat('P', $days, 'DT', $totalSeconds, 'S'))
};

(: Time-of-day from the fractional part of an Excel serial. The integer part
   (which would be the date) is discarded. :)
declare function xlsx:serialToTime($serial as xs:double) as xs:time
{
  let $frac         := $serial - floor($serial)
  let $totalSeconds := xs:integer(round($frac * 86400))
  return xs:time('00:00:00') + xs:dayTimeDuration(concat('PT', $totalSeconds, 'S'))
};


(: ============================================================
   Cell value extraction
   ============================================================ :)

(: Concatenated string content of a shared-string <si>. Handles both plain
   <si><t>text</t></si> and rich-text <si><r><t>part</t></r>...</si>. :)
declare function xlsx:sharedStringText($si) as xs:string
{
  if(empty($si)) then ''
  else string-join($si//spml:t, '')
};

(: Convert a single <c> cell to a <cell> element with xsi:type and the
   appropriate textual value. Dispatches on @t (cell type) first; for plain
   numbers (the default), uses the style's format code to decide whether the
   numeric value should be interpreted as a date, time, dateTime, currency,
   percentage, integer, or decimal. :)
declare function xlsx:getCellTypedValue($cell, $sharedStrings, $styles, $is1904 as xs:boolean)
{
  let $t      := string(($cell/@t, 'n')[. != ''][1])
  let $s      := xs:integer((string($cell/@s), '0')[. != ''][1])
  let $vText  := string($cell/spml:v)
  let $fmt    := xlsx:formatCodeForStyle($styles, $s)
  return
    if($t = 's') then
      let $idx := xs:integer($vText)
      let $si  := $sharedStrings/spml:sst/spml:si[$idx + 1]
      return <cell xsi:type="xs:string">{xlsx:sharedStringText($si)}</cell>
    else if($t = 'inlineStr') then
      <cell xsi:type="xs:string">{xlsx:sharedStringText($cell/spml:is)}</cell>
    else if($t = 'str') then
      <cell xsi:type="xs:string">{$vText}</cell>
    else if($t = 'b') then
      <cell xsi:type="xs:boolean">{if($vText = '1') then 'true' else 'false'}</cell>
    else if($t = 'e') then
      <cell xsi:type="xs:string" error="true">{$vText}</cell>
    else if($vText = '') then
      <cell xsi:nil="true"/>
    else
      let $kind := xlsx:detectTypeFromFormat($fmt)
      return
        if($kind = 'date') then
          <cell xsi:type="xs:date" format="{$fmt}" raw="{$vText}">{string(xlsx:serialToDate(xs:double($vText), $is1904))}</cell>
        else if($kind = 'datetime') then
          <cell xsi:type="xs:dateTime" format="{$fmt}" raw="{$vText}">{string(xlsx:serialToDateTime(xs:double($vText), $is1904))}</cell>
        else if($kind = 'time') then
          <cell xsi:type="xs:time" format="{$fmt}" raw="{$vText}">{string(xlsx:serialToTime(xs:double($vText)))}</cell>
        else if($kind = 'currency') then
          let $cc := xlsx:extractCurrencyCode($fmt)
          return
            if($cc != '') then
              <cell xsi:type="xs:decimal" format="{$fmt}" currency="{$cc}" raw="{$vText}">{$vText}</cell>
            else
              <cell xsi:type="xs:decimal" format="{$fmt}" raw="{$vText}">{$vText}</cell>
        else if($kind = 'percentage') then
          <cell xsi:type="xs:decimal" format="{$fmt}" raw="{$vText}">{$vText}</cell>
        else
          if(matches($vText, '^-?[0-9]+$')) then
            <cell xsi:type="xs:integer">{$vText}</cell>
          else
            <cell xsi:type="xs:decimal">{$vText}</cell>
};


(: ============================================================
   Row / header assembly
   ============================================================ :)

(: From the designated header row, produce one <header col="N" name="..."/>
   per cell. Column positions come from @r so sparse header rows are honored. :)
declare function xlsx:buildHeaders($sheetData, $sharedStrings, $styles, $is1904 as xs:boolean, $headerRowIdx as xs:integer)
{
  let $headerRow := $sheetData/spml:row[xs:integer(@r) = $headerRowIdx]
  for $cell in $headerRow/spml:c
  let $colIdx  := xlsx:refToColIndex(string($cell/@r))
  let $valElt  := xlsx:getCellTypedValue($cell, $sharedStrings, $styles, $is1904)
  let $name    := xlsx:makeQname(string($valElt))
  return <header col="{$colIdx}" name="{$name}"/>
};

(: Build one <row> element from a data row. Iterates the header list so that
   the output always has one child per defined column; missing cells become
   xsi:nil placeholders (preserving column position). :)
declare function xlsx:buildRow($row, $sharedStrings, $styles, $is1904 as xs:boolean, $headers)
{
  <row>{
    for $h in $headers
    let $colIdx := xs:integer($h/@col)
    let $name   := string($h/@name)
    let $match  := $row/spml:c[xlsx:refToColIndex(string(@r)) = $colIdx]
    return
      if(exists($match)) then
        let $valElt := xlsx:getCellTypedValue($match, $sharedStrings, $styles, $is1904)
        return element { $name } { $valElt/@*, $valElt/node() }
      else
        element { $name } { attribute xsi:nil { 'true' } }
  }</row>
};


(: ============================================================
   Sheet resolution + public API
   ============================================================ :)

(: Resolve a <sheet> entry from workbook.xml into its actual worksheet path
   inside the zip, by looking up @r:id in xl/_rels/workbook.xml.rels. Needed
   because real-world .xlsx files use varying capitalization (Sheet1.xml vs
   sheet1.xml) and the path is what the rels file declares -- not a fixed
   convention. :)
declare function xlsx:resolveSheetTarget($jarURL as xs:string, $sheetEntry) as xs:string
{
  let $rels     := doc(concat($jarURL, '/xl/_rels/workbook.xml.rels'))
  let $rid      := string($sheetEntry/@r:id)
  let $target   := string($rels/pr:Relationships/pr:Relationship[@Id = $rid]/@Target)
  return if(starts-with($target, '/')) then $target else concat('/xl/', $target)
};

(: Shared worker: load sheet + sharedStrings + styles + workbook, derive
   1904 mode and headers, then emit the <table> of typed rows. :)
declare function xlsx:getCellsFromPath($excelURL as xs:string, $sheetPath as xs:string, $headerRow as xs:integer)
{
  let $jarURL           := xlsx:jarUrl($excelURL)
  let $sheetURL         := concat($jarURL, $sheetPath)
  let $sharedStringsURL := concat($jarURL, '/xl/sharedStrings.xml')
  let $stylesURL        := concat($jarURL, '/xl/styles.xml')
  let $workbookURL      := concat($jarURL, '/xl/workbook.xml')

  let $sheet            := doc($sheetURL)
  let $sharedStrings    := if(fn:doc-available($sharedStringsURL)) then doc($sharedStringsURL) else ()
  let $styles           := if(fn:doc-available($stylesURL))        then doc($stylesURL)        else ()
  let $workbook         := if(fn:doc-available($workbookURL))      then doc($workbookURL)      else ()
  let $is1904           := xlsx:is1904Mode($workbook)

  let $sheetData        := $sheet/spml:worksheet/spml:sheetData
  let $headers          := xlsx:buildHeaders($sheetData, $sharedStrings, $styles, $is1904, $headerRow)

  return
    <table xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">{
      for $row in $sheetData/spml:row[xs:integer(@r) > $headerRow]
      return xlsx:buildRow($row, $sharedStrings, $styles, $is1904, $headers)
    }</table>
};

(:~
 : Get cells from the Nth sheet (1-based) using the given header row.
 : Returns a <table> of <row>s with typed elements named after the header cells.
 :)
declare function xlsx:getCells($excelURL as xs:string, $sheetNumber as xs:integer, $headerRow as xs:integer)
{
  let $jarURL     := xlsx:jarUrl($excelURL)
  let $workbook   := doc(concat($jarURL, '/xl/workbook.xml'))
  let $sheetEntry := $workbook/spml:workbook/spml:sheets/spml:sheet[$sheetNumber]
  let $sheetPath  := xlsx:resolveSheetTarget($jarURL, $sheetEntry)
  return xlsx:getCellsFromPath($excelURL, $sheetPath, $headerRow)
};

(:~
 : List the names of all sheets declared in the workbook, in document order.
 :)
declare function xlsx:getSheetNames($excelURL as xs:string) as xs:string*
{
  let $jarURL   := xlsx:jarUrl($excelURL)
  let $workbook := doc(concat($jarURL, '/xl/workbook.xml'))
  for $sheet in $workbook/spml:workbook/spml:sheets/spml:sheet
  return string($sheet/@name)
};

(:~
 : Get cells from the named sheet using the given header row. Sheet name is
 : matched against <sheet/@name> in workbook.xml.
 :)
declare function xlsx:getCellsByName($excelURL as xs:string, $sheetName as xs:string, $headerRow as xs:integer)
{
  let $jarURL     := xlsx:jarUrl($excelURL)
  let $workbook   := doc(concat($jarURL, '/xl/workbook.xml'))
  let $sheetEntry := $workbook/spml:workbook/spml:sheets/spml:sheet[@name = $sheetName]
  let $sheetPath  := xlsx:resolveSheetTarget($jarURL, $sheetEntry)
  return xlsx:getCellsFromPath($excelURL, $sheetPath, $headerRow)
};
