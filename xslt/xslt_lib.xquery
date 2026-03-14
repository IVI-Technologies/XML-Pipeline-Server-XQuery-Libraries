(:~
 : XSLT transformation library.
 : Executes XSLT transformations from XQuery using Saxon Enterprise Edition.
 : Compiled transformers are cached by URL for performance.
 :
 : @author IVI Technologies
 :)
module namespace xps_xslt = "ddtekjava:com.ivitechnologies.pipeline.ext.xslt.XSLT";

(:~
 : Transforms an XML node using an XSLT stylesheet and returns the result as a DOM node.
 :
 : @param $xsltURL File path or file:// URI to the XSLT stylesheet
 : @param $input The XML node to transform
 : @param $parameters Optional element with parameter bindings:
 :        &lt;parameters&gt;&lt;parameter name="paramName" value="paramValue"/&gt;&lt;/parameters&gt;
 :        Pass () for no parameters.
 : @return The transformation result as a DOM node
 :)
declare function xps_xslt:transformToDOM($xsltURL as xs:string, $input as node(), $parameters as element()?) as node() external;

(:~
 : Transforms an XML node using an XSLT stylesheet and returns the result as a string.
 :
 : @param $xsltURL File path or file:// URI to the XSLT stylesheet
 : @param $input The XML node to transform
 : @param $parameters Optional element with parameter bindings:
 :        &lt;parameters&gt;&lt;parameter name="paramName" value="paramValue"/&gt;&lt;/parameters&gt;
 :        Pass () for no parameters.
 : @return The transformation result as a serialized string
 :)
declare function xps_xslt:transformToString($xsltURL as xs:string, $input as node(), $parameters as element()?) as xs:string external;
