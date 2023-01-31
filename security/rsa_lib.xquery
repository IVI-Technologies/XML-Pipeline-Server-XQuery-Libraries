module namespace rsa = "ddtekjava:com.ivitechnologies.pipeline.ext.security.RSA"; 

declare function rsa:encryptString( $source as xs:string, $publicKeyURL as xs:string) as xs:string external; 
declare function rsa:decryptString( $encryptedSourceBase64 as xs:string, $privateKeyURL as xs:string) as xs:string external;