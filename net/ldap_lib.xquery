(:~
 : LDAP search library.
 : Executes LDAP searches and returns results as streaming XML.
 :
 : The settings element supports the following attributes:
 :   url — LDAP server URL (e.g., "ldap://localhost:389")
 :   dn — Base DN for searches (e.g., "ou=users,dc=example,dc=com")
 :   Context.SECURITY_AUTHENTICATION — "none", "simple", "SASL", or "GSSAPI"
 :   Context.SECURITY_PRINCIPAL — User DN for authentication
 :   Context.SECURITY_CREDENTIALS — Password
 :   query — LDAP filter expression (default: "(objectClass=*)")
 :   property_list_to_omit_separated_by_comma — Attributes to exclude from results
 :   property_list_returning_attributes_separated_by_comma — Attributes to include (default: "*")
 :   returning_object_true_false — Include LDAP objects in results (default: "false")
 :   read_timeout_in_milliseconds — Read timeout (default: 60000)
 :   connection_timeout_in_milliseconds — Connection timeout (default: 60000)
 :   sortBy — Attribute name for sorting results
 :   paginationTrueFalse — Enable pagination (default: "true")
 :   pageSize — Page size, range 100-1000 (default: 500)
 :   connect_n_retries — Number of connection retries, range 1-10 (default: 1)
 :   connect_before_retry_in_milliseconds — Wait between retries (default: 10000)
 :
 : @author IVI Technologies
 :)
module namespace xps_ldap = "ddtekjava:com.ivitechnologies.pipeline.ext.ldap.";

(:~
 : Executes an LDAP search using the provided settings and returns results as an XML document.
 : The search runs asynchronously and results are streamed as XML.
 :
 : @param $settings An element containing LDAP connection and search properties
 : @return An XML document containing the LDAP search results
 :)
declare function xps_ldap:search_xmlreader($settings as element()) as document-node() external;
