(:~
 : File operations library.
 : Provides functions for file and directory manipulation including copy, move, delete,
 : read, write, list, and synchronization. Accepts both file:// URIs and local paths.
 :
 : @author IVI Technologies
 :)
module namespace xps_file = "ddtekjava:com.ivitechnologies.pipeline.ext.io.FileOperations";

(:~
 : Copies a file, replacing the target if it already exists.
 :
 : @param $uriSourceFile Source file path or file:// URI
 : @param $uriTargetFile Target file path or file:// URI
 : @return true on success
 :)
declare function xps_file:copy($uriSourceFile as xs:string, $uriTargetFile as xs:string) as xs:boolean external;

(:~
 : Recursively copies an entire directory tree.
 :
 : @param $uriSourceFile Source directory path or file:// URI
 : @param $uriTargetFile Target directory path or file:// URI
 : @return true on success
 :)
declare function xps_file:copyTree($uriSourceFile as xs:string, $uriTargetFile as xs:string) as xs:boolean external;

(:~
 : Moves a file or directory, replacing the target if it already exists.
 :
 : @param $uriSourceFile Source path or file:// URI
 : @param $uriTargetFile Target path or file:// URI
 : @return true on success
 :)
declare function xps_file:move($uriSourceFile as xs:string, $uriTargetFile as xs:string) as xs:boolean external;

(:~
 : Deletes a single file.
 :
 : @param $uriLocalFile File path or file:// URI to delete
 : @param $deleteIfExists When false, throws an exception if the file does not exist.
 :        When true, returns false if the file does not exist.
 : @return true if the file was deleted, false if it did not exist (when $deleteIfExists is true)
 :)
declare function xps_file:delete($uriLocalFile as xs:string, $deleteIfExists as xs:boolean) as xs:boolean external;

(:~
 : Recursively deletes a directory and all its contents.
 :
 : @param $uriLocalFile Directory path or file:// URI
 : @param $doNotThrowIfAlreadyExists When true, suppresses errors if the directory does not exist
 : @return true on success
 :)
declare function xps_file:deleteTree($uriLocalFile as xs:string, $doNotThrowIfAlreadyExists as xs:boolean) as xs:boolean external;

(:~
 : Creates a directory. Does not throw if the directory already exists.
 :
 : @param $uriLocalFile Directory path or file:// URI
 : @return true on success
 :)
declare function xps_file:createDirectory($uriLocalFile as xs:string) as xs:boolean external;

(:~
 : Recursively deletes a directory and all its contents.
 :
 : @param $uriLocalFile Directory path or file:// URI
 : @return true on success
 :)
declare function xps_file:deleteTree($uriLocalFile as xs:string) as xs:boolean external;

(:~
 : Checks whether a file or directory exists.
 :
 : @param $uriFile File or directory path or file:// URI
 : @return true if the file or directory exists
 :)
declare function xps_file:fileExists($uriFile as xs:string) as xs:boolean external;

(:~
 : Converts a file:// URI to a local file system path.
 :
 : @param $url A file:// URI (e.g., "file:///C:/temp/data.xml")
 : @return The local path (e.g., "C:\temp\data.xml")
 :)
declare function xps_file:urlToLocalPath($url as xs:string) as xs:string external;

(:~
 : Converts a local file system path to a file:// URI.
 :
 : @param $path A local path (e.g., "C:\temp\data.xml")
 : @return The file:// URI (e.g., "file:///C:/temp/data.xml")
 :)
declare function xps_file:localPathToUrl($path as xs:string) as xs:string external;

(:~
 : Reads the entire contents of a file as a string using the default character encoding.
 :
 : @param $uriOrLocalPath File path or file:// URI
 : @return The file contents as a string
 :)
declare function xps_file:readAll($uriOrLocalPath as xs:string) as xs:string external;

(:~
 : Reads the entire contents of a file as a string using the specified character encoding.
 :
 : @param $uriOrLocalPath File path or file:// URI
 : @param $encoding Character encoding name (e.g., "UTF-8", "ISO-8859-1")
 : @return The file contents as a string
 :)
declare function xps_file:readAll($uriOrLocalPath as xs:string, $encoding as xs:string) as xs:string external;

(:~
 : Writes a string to a file using the default character encoding. Overwrites if the file exists.
 :
 : @param $uriOrLocalPath File path or file:// URI
 : @param $data The string data to write
 : @return true on success
 :)
declare function xps_file:writeAll($uriOrLocalPath as xs:string, $data as xs:string) as xs:boolean external;

(:~
 : Writes a string to a file using the specified character encoding. Overwrites if the file exists.
 :
 : @param $uriOrLocalPath File path or file:// URI
 : @param $data The string data to write
 : @param $encoding Character encoding name (e.g., "UTF-8", "ISO-8859-1")
 : @return true on success
 :)
declare function xps_file:writeAll($uriOrLocalPath as xs:string, $data as xs:string, $encoding as xs:string) as xs:boolean external;

(:~
 : Deletes files older than the specified duration from a folder.
 :
 : @param $folder Folder path or file:// URI
 : @param $file_filter_regex Regex pattern to match file names (e.g., ".*\.xml")
 : @param $olderThan An xs:dayTimeDuration string (e.g., "P30D" for 30 days, "PT30H" for 30 hours)
 : @return true if any files were deleted
 :)
declare function xps_file:deleteOldFilesFromFolder( $folder as xs:string, $file_filter_regex as xs:string, $olderThan as xs:string) as xs:boolean external;

(:~
 : Lists files in a folder, optionally recursive, filtered by a pattern.
 : Returns an XML document with file information.
 :
 : @param $folderOrUrl Folder path or file:// URI
 : @param $filter Wildcard filter pattern (e.g., "*.xml")
 : @param $recursive When true, lists files in subdirectories recursively
 : @return An XML document describing the matching files
 :)
declare function xps_file:listFiles($folderOrUrl as xs:string, $filter as xs:string, $recursive as xs:boolean) as document-node() external;

(:~
 : Synchronizes files from a source folder to a target folder.
 : Only copies files that are newer in the source or do not exist in the target.
 :
 : @param $uriOrPathSourceFolder Source folder path or file:// URI
 : @param $uriOrPathTargetFolder Target folder path or file:// URI
 : @param $filter Wildcard filter pattern (e.g., "*.xml", "*.*")
 : @return A sequence of URIs of the files that were copied
 :)
declare function xps_file:syncFiles($uriOrPathSourceFolder as xs:string, $uriOrPathTargetFolder as xs:string,$filter as xs:string) as xs:string* external;
