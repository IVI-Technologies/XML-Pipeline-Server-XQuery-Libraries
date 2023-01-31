module namespace jwt = "ddtekjava:com.ivitechnologies.pipeline.ext.security.JSONWebToken";

declare function jwt:createToken( $header as element(), $body as element(), $privateKeyURL as xs:string) as xs:string external;
declare function jwt:parseToken( $token as xs:string, $publicKeyURL as xs:string, $privateKeyURL as xs:string) as element() external;