module namespace ems="ddtekjava:com.ivitechnologies.pipeline.ext.email.Emails";

declare function ems:size($this as ddtek:javaObject) as xs:int external; 
declare function ems:get($this as ddtek:javaObject, $index as xs:int) as ddtek:javaObject external;
declare function ems:closeFolder($this as ddtek:javaObject) as empty-sequence() external;