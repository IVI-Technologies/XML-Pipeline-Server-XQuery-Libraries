(:~
 : iCalendar conversion library.
 : Converts between iCalendar (RFC 5545) text format and xCalendar (XML) format.
 :
 : @author IVI Technologies
 :)
module namespace jcal = "ddtekjava:com.ivitechnologies.pipeline.ext.ical.ICALParser";

(:~
 : Converts an iCalendar (ICAL) text string to an xCalendar (xCAL) XML document.
 :
 : @param $ICAL The iCalendar text content (VCALENDAR format)
 : @return An XML document in xCalendar format
 :)
declare function jcal:convert_ICAL_to_xCAL($ICAL as xs:string) as document-node() external;

(:~
 : Converts an xCalendar (xCAL) XML document to an iCalendar (ICAL) text string.
 :
 : @param $xCAL An XML document in xCalendar format
 : @return The iCalendar text content (VCALENDAR format)
 :)
declare function jcal:convert_xCAL_to_ICAL($xCAL as document-node()) as xs:string external;
