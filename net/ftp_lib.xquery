module namespace xps_ftp = "ddtekjava:com.ivitechnologies.pipeline.ext.net.FTP";

declare function xps_ftp:sendFile($element as element(), $uriLocalFile as xs:string, $targetPath as xs:string) as xs:boolean external;
declare function xps_ftp:sendString($element as element(), $data as xs:string, $targetPath as xs:string) as xs:boolean external; 

declare function xps_ftp:listFiles($config as element()) as element() external; 
declare function xps_ftp:get($config as element(), $sourcePath as xs:string, $urlOrLocalPathTarget as xs:string) as xs:boolean external;
declare function xps_ftp:getAsString($config as element(), $sourcePath as xs:string) as xs:string external;

declare function xps_ftp:deleteFile($element as element(),$targetPath as xs:string) as xs:boolean external;
declare function xps_ftp:renameFile($element as element(),$sourcePath as xs:string,$targetPath as xs:string) as xs:boolean external; 
declare function xps_ftp:makeFolder($element as element(),$targetPath as xs:string) as xs:boolean external; 
declare function xps_ftp:deleteFolder($element as element(),$targetPath as xs:string) as xs:boolean external;
declare function xps_ftp:fileExists($element as element(),$targetPath as xs:string) as xs:boolean external;

