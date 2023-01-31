module namespace nonce = "ddtekjava:com.ivitechnologies.pipeline.ext.security.Nonce"; 
declare function nonce:calculateSignature($value as xs:string, $seed as xs:string) as xs:string external;