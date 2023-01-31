declare namespace pdf = "ddtekjava:com.ivitechnologies.pipeline.ext.pdf.PDF";
declare function pdf:getFormFieldsFromPDFasBase64( $pdfDocAsBase64 as xs:string, $filterRegEx as xs:string) as element() external;
declare function pdf:getFormFieldsFromPDFasFilePath( $pdfFilePathOrLocalUrl as xs:string, $filterRegEx as xs:string) as element() external;