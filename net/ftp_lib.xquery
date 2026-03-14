(:~
 : FTP operations library.
 : Provides functions for file transfer and management over FTP/FTPS.
 : Supports connection pooling via the connection_time_to_live_in_seconds attribute.
 :
 : All functions accept a config element with the following attributes:
 :   host — FTP server hostname
 :   port — FTP server port (default: 21)
 :   user — Username
 :   password — Password
 :   connection_time_to_live_in_seconds — Enables connection pooling when > 0
 :   max_connection_tries — Number of connection retries (default: 1)
 :   wait_before_retry_in_millisecond — Wait time between retries in milliseconds
 :
 : @author IVI Technologies
 :)
module namespace xps_ftp = "ddtekjava:com.ivitechnologies.pipeline.ext.net.FTP";

(:~
 : Uploads a local file to the FTP server.
 :
 : @param $element Config element with FTP connection properties
 : @param $uriLocalFile Local file path or file:// URI of the file to upload
 : @param $targetPath Remote path on the FTP server where the file will be stored
 : @return true on success
 :)
declare function xps_ftp:sendFile($element as element(), $uriLocalFile as xs:string, $targetPath as xs:string) as xs:boolean external;

(:~
 : Uploads string content as a file to the FTP server.
 :
 : @param $element Config element with FTP connection properties
 : @param $data String content to upload
 : @param $targetPath Remote path on the FTP server where the file will be stored
 : @return true on success
 :)
declare function xps_ftp:sendString($element as element(), $data as xs:string, $targetPath as xs:string) as xs:boolean external;

(:~
 : Lists files in a directory on the FTP server.
 :
 : @param $config Config element with FTP connection properties and optional path/filter attributes
 : @return An XML element describing the files in the remote directory
 :)
declare function xps_ftp:listFiles($config as element()) as element() external;

(:~
 : Downloads a file from the FTP server to a local path.
 :
 : @param $config Config element with FTP connection properties
 : @param $sourcePath Remote file path on the FTP server
 : @param $urlOrLocalPathTarget Local file path or file:// URI for the downloaded file
 : @return true on success
 :)
declare function xps_ftp:get($config as element(), $sourcePath as xs:string, $urlOrLocalPathTarget as xs:string) as xs:boolean external;

(:~
 : Downloads a file from the FTP server and returns its content as a string.
 :
 : @param $config Config element with FTP connection properties
 : @param $sourcePath Remote file path on the FTP server
 : @return The file content as a string
 :)
declare function xps_ftp:getAsString($config as element(), $sourcePath as xs:string) as xs:string external;

(:~
 : Deletes a file on the FTP server.
 :
 : @param $element Config element with FTP connection properties
 : @param $targetPath Remote file path to delete
 : @return true on success
 :)
declare function xps_ftp:deleteFile($element as element(),$targetPath as xs:string) as xs:boolean external;

(:~
 : Renames or moves a file on the FTP server.
 :
 : @param $element Config element with FTP connection properties
 : @param $sourcePath Current remote file path
 : @param $targetPath New remote file path
 : @return true on success
 :)
declare function xps_ftp:renameFile($element as element(),$sourcePath as xs:string,$targetPath as xs:string) as xs:boolean external;

(:~
 : Creates a directory on the FTP server.
 :
 : @param $element Config element with FTP connection properties
 : @param $targetPath Remote directory path to create
 : @return true on success
 :)
declare function xps_ftp:makeFolder($element as element(),$targetPath as xs:string) as xs:boolean external;

(:~
 : Deletes a directory on the FTP server.
 :
 : @param $element Config element with FTP connection properties
 : @param $targetPath Remote directory path to delete
 : @return true on success
 :)
declare function xps_ftp:deleteFolder($element as element(),$targetPath as xs:string) as xs:boolean external;

(:~
 : Checks whether a file exists on the FTP server.
 :
 : @param $element Config element with FTP connection properties
 : @param $targetPath Remote file path to check
 : @return true if the file exists
 :)
declare function xps_ftp:fileExists($element as element(),$targetPath as xs:string) as xs:boolean external;
