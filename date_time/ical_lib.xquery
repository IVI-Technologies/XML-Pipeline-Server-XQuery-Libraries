module namespace jcal = "ddtekjava:com.ivitechnologies.pipeline.ext.ical.ICALParser";

declare function jcal:convert_ICAL_to_xCAL($ICAL as xs:string) as document-node() external;
declare function jcal:convert_xCAL_to_ICAL($xCAL as document-node()) as xs:string external;