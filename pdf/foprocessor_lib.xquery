module namespace xps_pdf = "ddtekjava:com.ivitechnologies.pipeline.ext.fo.FOProcessor"; 

declare function xps_pdf:run($fo_root as node(), $pdfFilePath as xs:string) as xs:boolean external; 
declare function xps_pdf:run2($foFileURL as xs:string, $pdfURL as xs:string) as xs:boolean external;