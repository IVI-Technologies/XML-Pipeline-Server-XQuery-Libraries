(:~
 : Date/Time formatting library.
 : Provides functions to format the current date and time in local or UTC time zones.
 :
 : @author IVI Technologies
 :)
module namespace t = "ddtekjava:com.ivitechnologies.pipeline.ext.time.DateTime";

(:~
 : Returns the current local date/time formatted according to the specified pattern.
 :
 : @param $format A Java DateTimeFormatter pattern (e.g., "yyyy-MM-dd HH:mm:ss", "yyyyMMddHHmmssSSS")
 : @return The current local date/time as a formatted string
 :)
declare function t:local_now_formatted($format as xs:string) as xs:string external;

(:~
 : Returns the current UTC date/time formatted according to the specified pattern.
 :
 : @param $format A Java DateTimeFormatter pattern (e.g., "yyyy-MM-dd HH:mm:ss", "yyyyMMddHHmmssSSS")
 : @return The current UTC date/time as a formatted string
 :)
declare function t:utc_now_formatted($format as xs:string) as xs:string external;
