module namespace t = "ddtekjava:com.ivitechnologies.pipeline.ext.time.DateTime";


declare function t:local_now_formatted($format as xs:string) as xs:string external;
declare function t:utc_now_formatted($format as xs:string) as xs:string external;
