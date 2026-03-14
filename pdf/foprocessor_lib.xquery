(:~
 : XSL-FO to PDF processor library.
 : Converts XSL-FO documents to PDF using Apache FOP.
 :
 : @author IVI Technologies
 :)
module namespace xps_pdf = "ddtekjava:com.ivitechnologies.pipeline.ext.fo.FOProcessor";

(:~
 : Processes an XSL-FO node (DOM) and generates a PDF file.
 :
 : @param $fo_root The XSL-FO document or element node
 : @param $pdfFilePath Output PDF file path or file:// URI
 : @return true on success
 :)
declare function xps_pdf:run($fo_root as node(), $pdfFilePath as xs:string) as xs:boolean external;

(:~
 : Processes an XSL-FO file and generates a PDF file.
 :
 : @param $foFileURL Input XSL-FO file path or file:// URI
 : @param $pdfURL Output PDF file path or file:// URI
 : @return true on success
 :)
declare function xps_pdf:run2($foFileURL as xs:string, $pdfURL as xs:string) as xs:boolean external;
