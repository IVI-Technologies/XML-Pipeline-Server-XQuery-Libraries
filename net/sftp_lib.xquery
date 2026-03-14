(:~
 : SFTP operations library.
 : Provides functions for file transfer and management over SFTP.
 : Supports connection pooling via the connection_time_to_live_in_seconds attribute.
 :
 : All functions accept a config element with the following attributes:
 :   host — SFTP server hostname
 :   port — SFTP server port (default: 22)
 :   user — Username
 :   password — Password
 :   private_key — Path to private key file (alternative to password)
 :   connection_time_to_live_in_seconds — Enables connection pooling when > 0
 :   max_connection_tries — Number of connection retries (default: 1)
 :   wait_before_retry_in_millisecond — Wait time between retries in milliseconds
 :
 : @author IVI Technologies
 :)
module namespace xps_sftp = "ddtekjava:com.ivitechnologies.pipeline.ext.net.SFTP";

(:~
 : Uploads a local file to the SFTP server.
 :
 : @param $element Config element with SFTP connection properties
 : @param $uriLocalFile Local file path or file:// URI of the file to upload
 : @param $targetPath Remote path on the SFTP server where the file will be stored
 : @return true on success
 :)
declare function xps_sftp:sendFile($element as element(), $uriLocalFile as xs:string, $targetPath as xs:string) as xs:boolean external;

(:~
 : Uploads string content as a file to the SFTP server.
 :
 : @param $element Config element with SFTP connection properties
 : @param $data String content to upload
 : @param $targetPath Remote path on the SFTP server where the file will be stored
 : @return true on success
 :)
declare function xps_sftp:sendString($element as element(), $data as xs:string, $targetPath as xs:string) as xs:boolean external;

(:~
 : Lists files in a directory on the SFTP server.
 :
 : @param $config Config element with SFTP connection properties and optional path/filter attributes
 : @return An XML element describing the files in the remote directory
 :)
declare function xps_sftp:listFiles($config as element()) as element() external;

(:~
 : Downloads a file from the SFTP server to a local path.
 :
 : @param $config Config element with SFTP connection properties
 : @param $sourcePath Remote file path on the SFTP server
 : @param $urlOrLocalPathTarget Local file path or file:// URI for the downloaded file
 : @return true on success
 :)
declare function xps_sftp:get($config as element(), $sourcePath as xs:string, $urlOrLocalPathTarget as xs:string) as xs:boolean external;

(:~
 : Downloads a file from the SFTP server and returns its content as a string.
 :
 : @param $config Config element with SFTP connection properties
 : @param $sourcePath Remote file path on the SFTP server
 : @return The file content as a string
 :)
declare function xps_sftp:getAsString($config as element(), $sourcePath as xs:string) as xs:string external;

(:~
 : Deletes a file on the SFTP server.
 :
 : @param $element Config element with SFTP connection properties
 : @param $targetPath Remote file path to delete
 : @return true on success
 :)
declare function xps_sftp:deleteFile($element as element(),$targetPath as xs:string) as xs:boolean external;

(:~
 : Renames or moves a file on the SFTP server.
 :
 : @param $element Config element with SFTP connection properties
 : @param $sourcePath Current remote file path
 : @param $targetPath New remote file path
 : @return true on success
 :)
declare function xps_sftp:renameFile($element as element(),$sourcePath as xs:string,$targetPath as xs:string) as xs:boolean external;

(:~
 : Creates a directory on the SFTP server.
 :
 : @param $element Config element with SFTP connection properties
 : @param $targetPath Remote directory path to create
 : @return true on success
 :)
declare function xps_sftp:makeFolder($element as element(),$targetPath as xs:string) as xs:boolean external;

(:~
 : Deletes a directory on the SFTP server.
 :
 : @param $element Config element with SFTP connection properties
 : @param $targetPath Remote directory path to delete
 : @return true on success
 :)
declare function xps_sftp:deleteFolder($element as element(),$targetPath as xs:string) as xs:boolean external;

(:~
 : Checks whether a file exists on the SFTP server.
 :
 : @param $element Config element with SFTP connection properties
 : @param $targetPath Remote file path to check
 : @return true if the file exists
 :)
declare function xps_sftp:fileExists($element as element(),$targetPath as xs:string) as xs:boolean external;
