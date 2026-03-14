(:~
 : PDF form fields extraction library.
 : Extracts form field data from PDF documents using Apache PDFBox.
 :
 : @author IVI Technologies
 :)
declare namespace pdf = "ddtekjava:com.ivitechnologies.pipeline.ext.pdf.PDF";

(:~
 : Extracts form fields from a base64-encoded PDF document.
 :
 : @param $pdfDocAsBase64 The PDF document content as a base64-encoded string
 : @param $filterRegEx A regex pattern to filter field names (e.g., ".*" for all fields)
 : @return An XML element containing the matching form fields and their values
 :)
declare function pdf:getFormFieldsFromPDFasBase64( $pdfDocAsBase64 as xs:string, $filterRegEx as xs:string) as element() external;

(:~
 : Extracts form fields from a PDF file on disk.
 :
 : @param $pdfFilePathOrLocalUrl File path or file:// URI to the PDF document
 : @param $filterRegEx A regex pattern to filter field names (e.g., ".*" for all fields)
 : @return An XML element containing the matching form fields and their values
 :)
declare function pdf:getFormFieldsFromPDFasFilePath( $pdfFilePathOrLocalUrl as xs:string, $filterRegEx as xs:string) as element() external;
