(:~
 : Email collection library.
 : Provides functions for iterating over a collection of emails returned by es:readEmails().
 :
 : @author IVI Technologies
 :)
module namespace ems="ddtekjava:com.ivitechnologies.pipeline.ext.email.Emails";

(:~
 : Returns the number of emails in the collection.
 :
 : @param $this The Emails collection object
 : @return The number of emails
 :)
declare function ems:size($this as ddtek:javaObject) as xs:int external;

(:~
 : Returns the email at the specified index.
 :
 : @param $this The Emails collection object
 : @param $index Zero-based index of the email to retrieve
 : @return An Email Java object
 :)
declare function ems:get($this as ddtek:javaObject, $index as xs:int) as ddtek:javaObject external;

(:~
 : Closes the underlying IMAP folder. Should be called when done processing emails
 : to release server resources.
 :
 : @param $this The Emails collection object
 :)
declare function ems:closeFolder($this as ddtek:javaObject) as empty-sequence() external;
