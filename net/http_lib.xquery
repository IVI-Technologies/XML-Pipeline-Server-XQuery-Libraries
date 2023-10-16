module namespace xps_http = "ddtekjava:com.ivitechnologies.pipeline.ext.net.HTTP";

declare function xps_http:VERB($verb as xs:string, $url as xs:string, $user as xs:string, $password as xs:string, $payload as document-node(), $output_URI as xs:anyURI?) as document-node() external;
declare function xps_http:POST($url as xs:string, $user as xs:string, $password as xs:string, $payload as document-node()) as document-node() external;
(: Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" useresolver="no" url="" outputurl="" processortype="saxon" tcpport="0" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" host="" port="0" user="" password="" validateoutput="no" validator="internal"
		          customvalidator="">
			<advancedProperties name="bSchemaAware" value="false"/>
			<advancedProperties name="iWhitespace" value="0"/>
			<advancedProperties name="bWarnings" value="false"/>
			<advancedProperties name="bUseDTD" value="false"/>
			<advancedProperties name="bXml11" value="false"/>
			<advancedProperties name="bTinyTree" value="true"/>
			<advancedProperties name="bGenerateByteCode" value="false"/>
			<advancedProperties name="bExtensions" value="true"/>
			<advancedProperties name="iValidation" value="0"/>
			<advancedProperties name="xQueryVersion" value="1.0"/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
:)