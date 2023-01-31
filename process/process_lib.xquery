module namespace pb = "ddtekjava:com.ivitechnologies.pipeline.ext.execution.SimpleProcessBuilder";

declare function pb:startAndWaitForCompletion($workingFolderOrFileInWorkingFolder as xs:string, $fullPathToCommand as xs:string, $args as xs:string*, $waitInMillisecond as xs:long) as xs:int external;