module namespace pgp = "ddtekjava:com.ivitechnologies.pipeline.ext.security.PGP";

declare function pgp:encryptFile( $encryptedOutputURL as xs:string,$inputURL as xs:string,$publicKeyURL as xs:string, $armor as xs:boolean, $withIntegrityCheck as xs:boolean) as xs:boolean external;
declare function pgp:decryptFile( $encryptedInputURL as xs:string, $decryptedOutputURL as xs:string, $passphrase as xs:string, $privateKeyURL as xs:string) as xs:boolean external;
