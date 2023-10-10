module namespace xps_file = "ddtekjava:com.ivitechnologies.pipeline.ext.io.FileOperations"; 

declare function xps_file:copy($uriSourceFile as xs:string, $uriTargetFile as xs:string) as xs:boolean external;
declare function xps_file:copyTree($uriSourceFile as xs:string, $uriTargetFile as xs:string) as xs:boolean external;
declare function xps_file:move($uriSourceFile as xs:string, $uriTargetFile as xs:string) as xs:boolean external;
declare function xps_file:delete($uriLocalFile as xs:string, $deleteIfExists as xs:boolean) as xs:boolean external;
declare function xps_file:deleteTree($uriLocalFile as xs:string, $doNotThrowIfAlreadyExists as xs:boolean) as xs:boolean external;
declare function xps_fle:createDirectory($uriLocalFile as xs:string) as xs:boolean external; declare function xps_file:deleteTree($uriLocalFile as xs:string) as xs:boolean external; declare function xps_file:urlToLocalPath($url as xs:string) as xs:string external;
declare function xps_file:fileExists($uriFile as xs:string) as xs:boolean external;
declare function xps_file:urlToLocalPath($url as xs:string) as xs:string external;
declare function xps_file:readAll($uriOrLocalPath as xs:string) as xs:string external;
declare function xps_file:writeAll($uriOrLocalPath as xs:string, $data as xs:string) as xs:boolean external;
declare function xps_file:deleteOldFilesFromFolder( $folder as xs:string, $file_filter_regex as xs:string, $olderThan as xs:string) as xs:boolean external;
