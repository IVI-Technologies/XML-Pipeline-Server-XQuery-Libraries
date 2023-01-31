module namespace xps_sftp = "ddtekjava:com.ivitechnologies.pipeline.ext.net.SFTP"; 

declare function xps_sftp:sendFile($element as element(), $uriLocalFile as xs:string, $targetPath as xs:string) as xs:boolean external; 
declare function xps_sftp:sendString($element as element(), $data as xs:string, $targetPath as xs:string) as xs:boolean external; 

declare function xps_sftp:listFiles($config as element()) as element() external; 
declare function xps_sftp:get($config as element(), $sourcePath as xs:string, $urlOrLocalPathTarget as xs:string) as xs:boolean external;
declare function xps_sftp:getAsString($config as element(), $sourcePath as xs:string) as xs:string external;

declare function xps_sftp:deleteFile($element as element(),$targetPath as xs:string) as xs:boolean external;
declare function xps_sftp:renameFile($element as element(),$sourcePath as xs:string,$targetPath as xs:string) as xs:boolean external; 
declare function xps_sftp:makeFolder($element as element(),$targetPath as xs:string) as xs:boolean external; 
declare function xps_sftp:deleteFolder($element as element(),$targetPath as xs:string) as xs:boolean external;
declare function xps_sftp:fileExists($element as element(),$targetPath as xs:string) as xs:boolean external;