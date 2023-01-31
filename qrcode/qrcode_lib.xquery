module namespace qr="ddtekjava:com.ivitechnologies.pipeline.ext.qrcode.QrCodeManager" 

declare function qr:encode_qrcode($value as xs:string, $bCompress as xs:boolean, $imageFormat as xs:string, $outputUrl as xs:string) as xs:boolean external; 
declare function qr:encode_qrcode_base64($value as xs:string, $bCompress as xs:boolean, $imageFormat as xs:string) as xs:string external; 
declare function qr:decode_qrcode_base64($qrcodeAsBase64 as xs:string, $bDecompress as xs:boolean) as xs:string external;