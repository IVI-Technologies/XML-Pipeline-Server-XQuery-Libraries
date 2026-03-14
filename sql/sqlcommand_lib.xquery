(:~
 : SQL command execution library.
 : Executes SQL queries defined in an XML profile and returns results as streaming XML.
 :
 : The SQL profile XML structure:
 :   <SQLCommand driverClass="..." user="..." password="..." url="...">
 :     <SQL>SELECT * FROM table WHERE id = ?</SQL>
 :     <Parameters>
 :       <Parameter value="123"/>
 :     </Parameters>
 :   </SQLCommand>
 :
 : Supported JDBC types for parameter binding: BIGINT, DECIMAL, DOUBLE, INTEGER,
 : BOOLEAN, VARCHAR, and others. Parameters are 1-based indexed.
 :
 : @author IVI Technologies
 :)
module namespace ex="ddtekjava:com.ivitechnologies.pipeline.ext.jdbc.SQLCommand";

(:~
 : Executes a SQL command defined in an XML profile file and returns the result as XML.
 :
 : @param $profile URI to the SQL profile XML file
 : @return An XML document containing the query results
 :)
declare function ex:execute($profile as xs:anyURI) as document-node() external;
