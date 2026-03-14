(:~
 : External process execution library.
 : Provides functions for starting and waiting on external OS processes.
 :
 : @author IVI Technologies
 :)
module namespace pb = "ddtekjava:com.ivitechnologies.pipeline.ext.execution.SimpleProcessBuilder";

(:~
 : Starts an external process and waits for it to complete.
 :
 : @param $workingFolderOrFileInWorkingFolder Working directory for the process,
 :        or a file whose parent directory will be used as the working directory
 : @param $fullPathToCommand Full path to the executable
 : @param $args A sequence of command-line arguments
 : @param $waitInMillisecond Maximum time to wait for completion in milliseconds
 : @return The process exit code (0 typically indicates success)
 :)
declare function pb:startAndWaitForCompletion($workingFolderOrFileInWorkingFolder as xs:string, $fullPathToCommand as xs:string, $args as xs:string*, $waitInMillisecond as xs:long) as xs:int external;
