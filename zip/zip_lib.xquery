(:~
 : ZIP compression library.
 : Provides functions for creating ZIP archives from files and for
 : compressing/decompressing strings using GZIP.
 :
 : @author IVI Technologies
 :)
module namespace xps_zip = "ddtekjava:com.ivitechnologies.pipeline.ext.Zip";

(:~
 : Compresses one or more files or folders into a ZIP archive.
 : The archive is written atomically (via a .tmp file then rename).
 :
 : @param $fileNames A sequence of file paths or file:// URIs to include in the archive
 : @param $zipURI Output ZIP file path or file:// URI
 : @param $moveFiles When true, deletes the original files after adding them to the archive
 : @param $zipOnlyFolderContent When true, includes only the folder contents without
 :        the folder itself as a wrapper (e.g., zipping "MyFolder" containing "File1"
 :        would produce "File1" at the root of the ZIP instead of "MyFolder/File1")
 : @return true on success
 :)
declare function xps_zip:zip_files_to_url($fileNames as xs:string*, $zipURI as xs:string, $moveFiles as xs:boolean, $zipOnlyFolderContent as xs:boolean) as xs:boolean external;

(:~
 : Compresses a string using GZIP and returns the result as base64Binary.
 :
 : @param $str The string to compress
 : @return The GZIP-compressed data as base64Binary
 :)
declare function xps_zip:zipString($str as xs:string) as xs:base64Binary external;

(:~
 : Decompresses GZIP-compressed base64Binary data back to a string.
 :
 : @param $bytes The GZIP-compressed data as base64Binary
 : @return The decompressed string
 :)
declare function xps_zip:unzipString($bytes as xs:base64Binary) as xs:string external;
