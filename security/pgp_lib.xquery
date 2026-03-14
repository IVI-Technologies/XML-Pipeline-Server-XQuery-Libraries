(:~
 : PGP encryption library.
 : Provides file encryption and decryption using PGP (Pretty Good Privacy)
 : with BouncyCastle provider.
 :
 : @author IVI Technologies
 :)
module namespace pgp = "ddtekjava:com.ivitechnologies.pipeline.ext.security.PGP";

(:~
 : Encrypts a file using a PGP public key.
 :
 : @param $encryptedOutputURL Output file path or file:// URI for the encrypted file
 : @param $inputURL Input file path or file:// URI of the file to encrypt
 : @param $publicKeyURL File path or file:// URI to the PGP public key file
 : @param $armor When true, outputs ASCII-armored format; when false, binary format
 : @param $withIntegrityCheck When true, adds a SHA1 integrity verification packet
 : @return true on success
 :)
declare function pgp:encryptFile( $encryptedOutputURL as xs:string,$inputURL as xs:string,$publicKeyURL as xs:string, $armor as xs:boolean, $withIntegrityCheck as xs:boolean) as xs:boolean external;

(:~
 : Decrypts a PGP-encrypted file using a private key and passphrase.
 :
 : @param $encryptedInputURL File path or file:// URI of the encrypted file
 : @param $decryptedOutputURL Output file path or file:// URI for the decrypted file
 : @param $passphrase Passphrase for the private key
 : @param $privateKeyURL File path or file:// URI to the PGP private key file
 : @return true on success
 :)
declare function pgp:decryptFile( $encryptedInputURL as xs:string, $decryptedOutputURL as xs:string, $passphrase as xs:string, $privateKeyURL as xs:string) as xs:boolean external;
