module namespace em="ddtekjava:com.ivitechnologies.pipeline.ext.email.Email"; 

declare function em:Email($sender as xs:string, $recipients as xs:string, $subject as xs:string, $body as xs:string, $message_mime_type as xs:string, $atatchments as xs:string*) as ddtek:javaObject external;

declare function em:setHeader($name as xs:string, $value as xs:string) as xs:string external;
declare function em:getSubject($this as ddtek:javaObject) as xs:string external; 
declare function em:getUID($this as ddtek:javaObject) as xs:long external; 
declare function em:getContentType($this as ddtek:javaObject) as xs:string external; 
declare function em:getSender($this as ddtek:javaObject) as xs:string external; 
declare function em:getSentISODate($this as ddtek:javaObject) as xs:string external; 
declare function em:getReceivedISODate($this as ddtek:javaObject) as xs:string external; 
declare function em:getRecipients($this as ddtek:javaObject) as xs:string external; 
declare function em:getRecipients_CC($this as ddtek:javaObject) as xs:string external; 
declare function em:getRecipients_BCC($this as ddtek:javaObject) as xs:string external; 
declare function em:getPart($this as ddtek:javaObject, $index as xs:int) as xs:string external; 
declare function em:getPartObject($this as ddtek:javaObject, $index as xs:int) as ddtek:javaObject external; 
declare function em:getPartObjectByFileName($this as ddtek:javaObject, $FileName as xs:string) as ddtek:javaObject external;
declare function em:getParts($this as ddtek:javaObject) as document-node()? external; 
declare function em:saveAttachmentToFile($this as ddtek:javaObject, $attachmentName as xs:string, $fileOrUri as xs:string) as xs:boolean external;
declare function em:addBase64Attachment($this as ddtek:javaObject, $filename as xs:string, $base64 as xs:string) as xs:boolean external;
declare function em:hasAttachments($this as ddtek:javaObject) as xs:boolean external;
