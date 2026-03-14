(:~
 : Email message library.
 : Provides functions for creating and inspecting email messages.
 :
 : @author IVI Technologies
 :)
module namespace em="ddtekjava:com.ivitechnologies.pipeline.ext.email.Email";

(:~
 : Creates a new Email object.
 :
 : @param $sender Sender email address
 : @param $recipients Comma-separated recipient email addresses
 : @param $subject Email subject line
 : @param $body Email body content
 : @param $message_mime_type MIME type for the body (e.g., "text/plain", "text/html", "html")
 : @param $atatchments A sequence of local file paths or file:// URIs to attach
 : @return An Email Java object
 :)
declare function em:Email($sender as xs:string, $recipients as xs:string, $subject as xs:string, $body as xs:string, $message_mime_type as xs:string, $atatchments as xs:string*) as ddtek:javaObject external;

(:~
 : Sets a custom header on the email message.
 :
 : @param $name Header name
 : @param $value Header value
 : @return The header value that was set
 :)
declare function em:setHeader($name as xs:string, $value as xs:string) as xs:string external;

(:~
 : Returns the subject of the email.
 :
 : @param $this The Email object
 : @return The email subject
 :)
declare function em:getSubject($this as ddtek:javaObject) as xs:string external;

(:~
 : Returns the IMAP unique identifier (UID) of the email.
 :
 : @param $this The Email object
 : @return The UID as a long integer
 :)
declare function em:getUID($this as ddtek:javaObject) as xs:long external;

(:~
 : Returns the content type of the email (e.g., "text/plain", "multipart/mixed").
 :
 : @param $this The Email object
 : @return The MIME content type string
 :)
declare function em:getContentType($this as ddtek:javaObject) as xs:string external;

(:~
 : Returns the sender's email address.
 :
 : @param $this The Email object
 : @return The sender address string
 :)
declare function em:getSender($this as ddtek:javaObject) as xs:string external;

(:~
 : Returns the sent date in ISO format with timezone.
 :
 : @param $this The Email object
 : @return The sent date as an ISO date string
 :)
declare function em:getSentISODate($this as ddtek:javaObject) as xs:string external;

(:~
 : Returns the received date in ISO format with timezone.
 :
 : @param $this The Email object
 : @return The received date as an ISO date string
 :)
declare function em:getReceivedISODate($this as ddtek:javaObject) as xs:string external;

(:~
 : Returns the To recipients as a comma-separated string.
 :
 : @param $this The Email object
 : @return Comma-separated recipient addresses
 :)
declare function em:getRecipients($this as ddtek:javaObject) as xs:string external;

(:~
 : Returns the CC recipients as a comma-separated string.
 :
 : @param $this The Email object
 : @return Comma-separated CC addresses
 :)
declare function em:getRecipients_CC($this as ddtek:javaObject) as xs:string external;

(:~
 : Returns the BCC recipients as a comma-separated string.
 :
 : @param $this The Email object
 : @return Comma-separated BCC addresses
 :)
declare function em:getRecipients_BCC($this as ddtek:javaObject) as xs:string external;

(:~
 : Returns the content of a specific message part as a string.
 :
 : @param $this The Email object
 : @param $index Zero-based index of the message part
 : @return The part content as a string
 :)
declare function em:getPart($this as ddtek:javaObject, $index as xs:int) as xs:string external;

(:~
 : Returns a specific message part as an EmailMessagePart Java object.
 :
 : @param $this The Email object
 : @param $index Zero-based index of the message part
 : @return An EmailMessagePart Java object
 :)
declare function em:getPartObject($this as ddtek:javaObject, $index as xs:int) as ddtek:javaObject external;

(:~
 : Returns a message part (attachment) by its filename.
 :
 : @param $this The Email object
 : @param $FileName The attachment filename to search for
 : @return An EmailMessagePart Java object, or null if not found
 :)
declare function em:getPartObjectByFileName($this as ddtek:javaObject, $FileName as xs:string) as ddtek:javaObject external;

(:~
 : Returns an XML document describing all message parts (body and attachments).
 :
 : @param $this The Email object
 : @return An XML document listing all parts with their content types and filenames
 :)
declare function em:getParts($this as ddtek:javaObject) as document-node()? external;

(:~
 : Saves a named attachment to a local file.
 :
 : @param $this The Email object
 : @param $attachmentName The filename of the attachment to extract
 : @param $fileOrUri Local file path or file:// URI for the output file
 : @return true on success
 :)
declare function em:saveAttachmentToFile($this as ddtek:javaObject, $attachmentName as xs:string, $fileOrUri as xs:string) as xs:boolean external;

(:~
 : Adds an attachment from base64-encoded data.
 :
 : @param $this The Email object
 : @param $filename The filename for the attachment
 : @param $base64 The attachment data encoded as base64
 : @return true on success
 :)
declare function em:addBase64Attachment($this as ddtek:javaObject, $filename as xs:string, $base64 as xs:string) as xs:boolean external;

(:~
 : Checks whether the email has any attachments.
 :
 : @param $this The Email object
 : @return true if the email has one or more attachments
 :)
declare function em:hasAttachments($this as ddtek:javaObject) as xs:boolean external;
