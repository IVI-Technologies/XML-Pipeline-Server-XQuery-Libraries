(:~
 : JSON Web Token (JWT) library.
 : Creates and verifies RSA-256 signed JWT tokens.
 :
 : @author IVI Technologies
 :)
module namespace jwt = "ddtekjava:com.ivitechnologies.pipeline.ext.security.JSONWebToken";

(:~
 : Creates an RSA-256 signed JWT token.
 : Header and body element attributes become JWT claims. If "iat" (issued-at) is not
 : provided, the current time is used. If "exp" (expiration) is not provided, it defaults
 : to iat + 3600 seconds.
 :
 : @param $header An element whose attributes become JWT header claims
 : @param $body An element whose attributes become JWT payload claims
 : @param $privateKeyURL File path or file:// URI to the RSA private key PEM file
 : @return The signed JWT token string
 :)
declare function jwt:createToken( $header as element(), $body as element(), $privateKeyURL as xs:string) as xs:string external;

(:~
 : Verifies and decodes an RSA-256 signed JWT token.
 :
 : @param $token The JWT token string to verify and decode
 : @param $publicKeyURL File path or file:// URI to the RSA public key PEM file
 : @param $privateKeyURL File path or file:// URI to the RSA private key PEM file
 : @return An XML element with "header" and "payload" child elements containing the decoded claims
 : @error Throws an exception if the signature is invalid
 :)
declare function jwt:parseToken( $token as xs:string, $publicKeyURL as xs:string, $privateKeyURL as xs:string) as element() external;
