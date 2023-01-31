module namespace emp="ddtekjava:com.ivitechnologies.pipeline.ext.email.EmailMessagePart";

declare function emp:getFileName($this as ddtek:javaObject) as xs:string external; 
declare function emp:getContentType($this as ddtek:javaObject) as xs:string external; 
declare function emp:getDescription($this as ddtek:javaObject) as xs:string external; 
declare function emp:getDisposition($this as ddtek:javaObject) as xs:string external; 
declare function emp:geContent($this as ddtek:javaObject) as xs:base64Binary* external; 
declare function emp:toFileOrUrl($this as ddtek:javaObject, $FileName as xs:string) as xs:boolean external;
