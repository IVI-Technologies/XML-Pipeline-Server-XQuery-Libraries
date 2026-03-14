(:~
 : QR Code encoding and decoding library.
 : Generates and reads QR code images with optional GZIP compression.
 :
 : @author IVI Technologies
 :)
module namespace qr="ddtekjava:com.ivitechnologies.pipeline.ext.qrcode.QrCodeManager";

(:~
 : Encodes a string value into a QR code image and writes it to a file.
 :
 : @param $value The string value to encode in the QR code
 : @param $bCompress When true, the value is GZIP-compressed and base64-encoded before encoding
 : @param $imageFormat Image format (e.g., "png", "jpg")
 : @param $outputUrl Output file path or file:// URI
 : @return true on success
 :)
declare function qr:encode_qrcode($value as xs:string, $bCompress as xs:boolean, $imageFormat as xs:string, $outputUrl as xs:string) as xs:boolean external;

(:~
 : Encodes a string value into a QR code image and returns it as a base64 string.
 :
 : @param $value The string value to encode in the QR code
 : @param $bCompress When true, the value is GZIP-compressed and base64-encoded before encoding
 : @param $imageFormat Image format (e.g., "png", "jpg")
 : @return The QR code image as a base64-encoded string
 :)
declare function qr:encode_qrcode_base64($value as xs:string, $bCompress as xs:boolean, $imageFormat as xs:string) as xs:string external;

(:~
 : Decodes a QR code from a base64-encoded image and returns the encoded string.
 :
 : @param $qrcodeAsBase64 The QR code image as a base64-encoded string
 : @param $bDecompress When true, the decoded value is base64-decoded and GZIP-decompressed
 : @return The decoded string value
 :)
declare function qr:decode_qrcode_base64($qrcodeAsBase64 as xs:string, $bDecompress as xs:boolean) as xs:string external;
