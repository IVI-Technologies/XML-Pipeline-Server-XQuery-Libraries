(:~
 : Email message part library.
 : Provides functions for inspecting and extracting individual parts (body, attachments)
 : of an email message.
 :
 : @author IVI Technologies
 :)
module namespace emp="ddtekjava:com.ivitechnologies.pipeline.ext.email.EmailMessagePart";

(:~
 : Returns the filename of the message part (attachment name).
 :
 : @param $this The EmailMessagePart object
 : @return The filename, or empty string for inline body parts
 :)
declare function emp:getFileName($this as ddtek:javaObject) as xs:string external;

(:~
 : Returns the MIME content type of the message part (e.g., "text/plain", "application/pdf").
 :
 : @param $this The EmailMessagePart object
 : @return The content type string
 :)
declare function emp:getContentType($this as ddtek:javaObject) as xs:string external;

(:~
 : Returns the description of the message part.
 :
 : @param $this The EmailMessagePart object
 : @return The description string, or empty if not set
 :)
declare function emp:getDescription($this as ddtek:javaObject) as xs:string external;

(:~
 : Returns the content disposition of the message part (e.g., "attachment", "inline").
 :
 : @param $this The EmailMessagePart object
 : @return The disposition string
 :)
declare function emp:getDisposition($this as ddtek:javaObject) as xs:string external;

(:~
 : Returns the binary content of the message part as base64.
 :
 : @param $this The EmailMessagePart object
 : @return The part content as base64Binary
 :)
declare function emp:geContent($this as ddtek:javaObject) as xs:base64Binary* external;

(:~
 : Writes the message part content to a local file.
 :
 : @param $this The EmailMessagePart object
 : @param $FileName Local file path or file:// URI for the output file
 : @return true on success
 :)
declare function emp:toFileOrUrl($this as ddtek:javaObject, $FileName as xs:string) as xs:boolean external;
