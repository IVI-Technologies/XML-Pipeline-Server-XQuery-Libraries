(:~
 : HTTP operations library.
 : Provides functions for making HTTP requests with support for all HTTP verbs,
 : authentication (Basic, Digest), proxy, multipart uploads, and custom headers.
 :
 : The options element supports the following attributes:
 :   username, password — Basic authentication credentials
 :   force_authentication — "BASIC" or "DIGEST" to force preemptive auth
 :   realm, nonce — DIGEST authentication parameters
 :   proxy-host, proxy-port, proxy-username, proxy-password — Proxy settings
 :   connection-timeout, connection-request-timeout, socket-timeout — Timeouts in milliseconds
 :   retries — Number of retry attempts (default: 1)
 :   wrap-exception — "true" to return error element instead of throwing
 :   ssl-common-name-whitelist — Comma-separated list of allowed SSL CN values
 :
 : The payload element structure:
 :   <request>
 :     <parameters>
 :       <parameter name="..." type="text|file|base64" content-type="...">value</parameter>
 :     </parameters>
 :     <form>
 :       <parameters>
 :         <parameter name="..." type="text|file|base64">value</parameter>
 :       </parameters>
 :     </form>
 :   </request>
 :
 : The response element structure:
 :   <response http-version="..." status-code="..." reason="...">
 :     <response-header>
 :       <header name="..." value="..."/>
 :     </response-header>
 :     <response-body>...</response-body>
 :   </response>
 :
 : @author IVI Technologies
 :)
module namespace xps_http = "ddtekjava:com.ivitechnologies.pipeline.ext.net.HTTP";

(:~
 : Executes an HTTP request with the specified verb, URL, credentials, and payload.
 : When $output_URI is provided, the response body is written to that file instead of
 : being included in the returned XML document.
 :
 : @param $verb The HTTP method (GET, POST, PUT, DELETE, PATCH, HEAD, OPTIONS, TRACE)
 : @param $url The target URL
 : @param $user Username for Basic authentication (empty string for no auth)
 : @param $password Password for Basic authentication
 : @param $payload An XML document containing the request body and/or parameters
 : @param $output_URI Optional file:// URI to write the response body to. Pass () for inline response.
 : @return An XML document with response status, headers, and body (unless $output_URI is specified)
 :)
declare function xps_http:VERB($verb as xs:string, $url as xs:string, $user as xs:string, $password as xs:string, $payload as document-node(), $output_URI as xs:anyURI?) as document-node() external;

(:~
 : Executes an HTTP POST request with Basic authentication.
 :
 : @param $url The target URL
 : @param $user Username for Basic authentication
 : @param $password Password for Basic authentication
 : @param $payload An XML document containing the request body
 : @return An XML document with response status, headers, and body
 :)
declare function xps_http:POST($url as xs:string, $user as xs:string, $password as xs:string, $payload as document-node()) as document-node() external;
