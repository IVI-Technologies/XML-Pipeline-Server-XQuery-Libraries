(:~
 : XML Schema validation library.
 : Validates XML documents against XSD schemas and checks for well-formedness.
 :
 : @author IVI Technologies
 :)
module namespace xsdv = "ddtekjava:com.ivitechnologies.pipeline.ext.xml.XSDValidation";

(:~
 : Validates an XML node against an XSD schema.
 : Returns an XML document with a validation-result root element containing
 : any validation errors with line and column information.
 :
 : @param $node The XML node to validate
 : @param $schema_uri File path or file:// URI to the XSD schema file
 : @param $bReportErroLocation When true, re-parses the XML as a stream to report
 :        accurate line and column numbers for errors
 : @param $bUseCache When true, caches the compiled schema for better performance
 :        on repeated validations against the same schema
 : @return An XML document with validation results (empty error list means valid)
 :)
declare function xsdv:validate($node as node(), $schema_uri as xs:string, $bReportErroLocation as xs:boolean, $bUseCache as xs:boolean) as node() external;

(:~
 : Checks whether an XML string is well-formed.
 :
 : @param $xml The XML content as a string
 : @return An XML document with result element: &lt;result wellFormed="true|false"/&gt;.
 :         On error, includes an error child element with line, column, system-id, and public-id.
 :)
declare function xsdv:isWellFormed($xml as xs:string) as document-node() external;

(:~
 : Checks whether an XML document at the given URI is well-formed.
 :
 : @param $xml_document_URI URI to the XML document to check
 : @return An XML document with result element: &lt;result wellFormed="true|false"/&gt;.
 :         On error, includes an error child element with line, column, system-id, and public-id.
 :)
declare function xsdv:isWellFormed($xml_document_URI as xs:anyURI) as document-node() external;
