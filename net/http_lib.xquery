module namespace xps_http = "ddtekjava:com.ivitechnologies.pipeline.ext.net.HTTP";

declare function xps_http:VERB($verb as xs:string, $url as xs:string, $user as xs:string, $password as xs:string, $payload as document-node()) as document-node() external;
declare function xps_http:POST($url as xs:string, $user as xs:string, $password as xs:string, $payload as document-node()) as document-node() external;
