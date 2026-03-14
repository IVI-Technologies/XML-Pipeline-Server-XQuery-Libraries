(:~
 : RSA encryption library.
 : Provides string encryption and decryption using RSA public/private key pairs.
 : Keys should be in PEM format (X509 for public, PKCS8 for private).
 :
 : @author IVI Technologies
 :)
module namespace rsa = "ddtekjava:com.ivitechnologies.pipeline.ext.security.RSA";

(:~
 : Encrypts a string using an RSA public key.
 :
 : @param $source The plaintext string to encrypt
 : @param $publicKeyURL File path or file:// URI to the X509 public key PEM file
 : @return The encrypted data as a base64-encoded string
 :)
declare function rsa:encryptString( $source as xs:string, $publicKeyURL as xs:string) as xs:string external;

(:~
 : Decrypts a base64-encoded string using an RSA private key.
 :
 : @param $encryptedSourceBase64 The encrypted data as a base64-encoded string
 : @param $privateKeyURL File path or file:// URI to the PKCS8 private key PEM file
 : @return The decrypted plaintext string
 :)
declare function rsa:decryptString( $encryptedSourceBase64 as xs:string, $privateKeyURL as xs:string) as xs:string external;
