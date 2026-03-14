(:~
 : Time zone offset conversion library.
 : Converts a UTC date to a timezone-aware offset duration string.
 :
 : @author IVI Technologies
 :)
module namespace tzo = "ddtekjava:com.ivitechnologies.pipeline.ext.time.TimeZoneToOffset";

(:~
 : Converts a UTC date string to an xs:dayTimeDuration offset for the specified time zone.
 : Accounts for daylight saving time based on the date provided.
 :
 : Example: tzo:timeZoneToOffest("2021-04-19T17:15:42.147", "America/Los_Angeles") returns "-PT7H"
 :
 : @param $UTCDate A date string in "yyyy-MM-ddTHH:mm:ss" format
 : @param $timeZoneName An IANA time zone name (e.g., "America/Los_Angeles", "Europe/London")
 : @return An xs:dayTimeDuration string representing the UTC offset (e.g., "-PT8H", "PT5H30M")
 :)
declare function tzo:timeZoneToOffest($UTCDate as xs:string, $timeZoneName as xs:string) as xs:string external;
