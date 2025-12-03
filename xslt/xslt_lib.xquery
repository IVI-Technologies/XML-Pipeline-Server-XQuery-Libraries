module namespace xps_xslt = "ddtekjava:com.ivitechnologies.pipeline.ext.xslt.XSLT";


declare function xps_xslt:transformToDOM($xsltURL as xs:string, $input as node(), $parameters as element()?) as node() external;
declare function xps_xslt:transformToString($xsltURL as xs:string, $input as node(), $parameters as element()?) as xs:string external;

