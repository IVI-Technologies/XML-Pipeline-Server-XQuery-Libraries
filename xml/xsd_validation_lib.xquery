module namespace xsdv = "ddtekjava:com.ivitechnologies.pipeline.ext.xml.XSDValidation";

declare function xsdv:validate($node as node(), $schema_uri as xs:string, $bReportErroLocation as xs:boolean, $bUseCache as xs:boolean) as node() external;
declare function xsdv:isWellFormed($xml as xs:string) as document-node() external;
declare function xsdv:isWellFormed($xml_document_URI as xs:anyURI) as document-node() external;