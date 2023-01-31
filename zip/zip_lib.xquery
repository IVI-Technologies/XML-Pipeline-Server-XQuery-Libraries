module namespace xps_zip = "ddtekjava:com.ivitechnologies.pipeline.ext.Zip";

declare function xps_zip:zip_files_to_url($fileNames as xs:string*, $zipURI as xs:string, $moveFiles as xs:boolean, $zipOnlyFolderContent as xs:boolean) as xs:boolean external;

declare function xps_zip:zipString($str as xs:string) as xs:base64Binary external; 
declare function ex:unzipString($bytes as xs:base64Binary) as xs:string external;