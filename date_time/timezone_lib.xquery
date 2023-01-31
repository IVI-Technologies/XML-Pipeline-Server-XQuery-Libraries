module namespace tzo = "ddtekjava:com.ivitechnologies.pipeline.ext.time.TimeZoneToOffset";


(:
 timeZoneToOffest("2021-04-19T17:15:42.147", "America/Los_Angeles")
:)

declare function tzo:timeZoneToOffest($UTCDate as xs:string, $timeZoneName as xs:string) as xs:string external;
