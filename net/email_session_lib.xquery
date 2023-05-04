module namespace es="ddtekjava:com.ivitechnologies.pipeline.ext.email.EmailSession"; 
declare function es:EmailSession( $settings as element()) as ddtek:javaObject external; 
declare function es:sendEmail($this as ddtek:javaObject, $email as ddtek:javaObject ) as xs:boolean external; 
declare function es:readEmails($filters) as ddtek:javaObject external; 
declare function es:readEmails($folder as xs:string, $subjectFilter as xs:string, $fromFilter as xs:string, $startingFrom as xs:string) as ddtek:javaObject external; 
declare function es:moveEmails( $session as ddtek:javaObject, $settings as element(*, xs:untyped), $targetFolder as xs:string) as xs:boolean external;
