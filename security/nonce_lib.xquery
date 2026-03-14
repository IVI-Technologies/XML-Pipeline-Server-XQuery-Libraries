(:~
 : Nonce/HMAC signature library.
 : Computes HMAC-SHA1 signatures for message authentication.
 :
 : @author IVI Technologies
 :)
module namespace nonce = "ddtekjava:com.ivitechnologies.pipeline.ext.security.Nonce";

(:~
 : Computes a URL-safe HMAC-SHA1 signature.
 : The result uses URL-safe base64 encoding (/ replaced with _, + replaced with -).
 :
 : @param $value The data string to sign
 : @param $seed The secret key used for signing
 : @return The HMAC-SHA1 signature as a URL-safe base64-encoded string
 :)
declare function nonce:calculateSignature($value as xs:string, $seed as xs:string) as xs:string external;
