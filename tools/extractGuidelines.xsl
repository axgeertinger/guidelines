<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:egx="http://www.tei-c.org/ns/Examples"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:rng="http://relaxng.org/ns/structure/1.0"
    xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    xmlns:saxon="http://saxon.sf.net/"
    xmlns:mei="http://www.music-encoding.org/ns/mei"
    xmlns:tools="local"
    exclude-result-prefixes="xs math xd xhtml tei rng sch egx saxon mei tools"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Nov 16, 2018</xd:p>
            <xd:p><xd:b>Author:</xd:b> Johannes Kepper</xd:p>
            <xd:p>
                This XSL generates HTML / Markdown output for the website version of the MEI 
                Guidelines from a canonicalized ODD file. It's a complete rewrite and focusses 
                solely on the website (no code for generating PDFs anymore). 
            </xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:output indent="true" method="html" saxon:suppress-indentation="egx:egXML tei:classes tei:content tei:list tei:item" name="html" omit-xml-declaration="true"/>
    
    <xsl:param name="version" select="'{{ site.baseurl }}/{{ page.version }}'" as="xs:string"/>
    <xsl:param name="guidelines.version" select="'v4'" as="xs:string"/>
    
    <xd:doc scope="component">
        <xd:desc>
            <xd:p>
                $image.prefix is a general prefix prepended to all image paths generated by this stylesheet.
            </xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:param name="image.prefix" as="xs:string">
        <xsl:value-of select="'{{ site.baseurl }}/images/{{ page.version }}/'"/>
    </xsl:param>
    
    <xsl:include href="xsl/globalVariables.xsl"/>
    <xsl:include href="xsl/globalFunctions.xsl"/>
    <xsl:include href="xsl/elementHandling.xsl"/>
    <xsl:include href="xsl/modelClassHandling.xsl"/>
    <xsl:include href="xsl/attClassHandling.xsl"/>
    <xsl:include href="xsl/datatypeHandling.xsl"/>
    <xsl:include href="xsl/macrogroupHandling.xsl"/>
    <xsl:include href="xsl/parseOdd.xsl"/>
    <xsl:include href="xsl/javascript.xsl"/>
    
    <xd:doc scope="component">
        <xd:desc>
            <xd:p>
                $output.folder is the base folder where all outputs will be stored.
            </xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:variable name="output.folder" select="'../' || $guidelines.version || '/'" as="xs:string"/>
    
    <xd:doc scope="component">
        <xd:desc>
            <xd:p>
                $includes.folder is the folder where all descriptions and examples will be stored
            </xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:variable name="includes.folder" select="'../_includes/' || $guidelines.version || '/'" as="xs:string"/>
    
    <xd:doc scope="component">
        <xd:desc>
            <xd:p>
                $mei.source makes the input of this XSL (unmodified compiled ODD) available in a variable. 
            </xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:variable name="mei.source" select="/" as="node()"/>
    
    <xd:doc scope="component">
        <xd:desc>
            <xd:p>
                This is where processing starts.
            </xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:template match="/">
        
        <xsl:message select="'INFO: $output.folder is ' || $output.folder || ', $includes.folder is ' || $includes.folder"/>
        
        <!-- handling of all specs -->
        <xsl:for-each select="$elements | $att.classes | $model.classes | $data.types | $macro.groups">
            <xsl:variable name="object" select="."/>
            
            <!-- create desc snippet in _includes for inclusion in guidelines -->
            <xsl:variable name="path" select="$includes.folder || 'desc/' || @ident || '.txt'" as="xs:string"/>
            <xsl:result-document href="{lower-case($path)}" omit-xml-declaration="yes">
                <xsl:apply-templates select="./tei:desc/node()" mode="plain"/>
            </xsl:result-document>
            
            <!-- create desc snippets in _includes for all directly defined attributes -->
            <xsl:for-each select=".//tei:attDef">
                <xsl:variable name="path" select="$includes.folder || 'desc/' || $object/@ident || '/' || replace(@ident,':','---') || '.txt'" as="xs:string"/>
                <xsl:result-document href="{lower-case($path)}" omit-xml-declaration="yes">
                    <xsl:apply-templates select="./tei:desc/node()" mode="plain"/>
                </xsl:result-document>
            </xsl:for-each>
            
            <!-- create the spec page for each element -->
            <xsl:call-template name="processObject">
                <xsl:with-param name="object" select="$object"/>
            </xsl:call-template>
        </xsl:for-each>
        
        <xsl:call-template name="createOverviewPage">
            <xsl:with-param name="objects" select="$elements"/>
        </xsl:call-template>
        
        <xsl:call-template name="createOverviewPage">
            <xsl:with-param name="objects" select="$att.classes"/>
        </xsl:call-template>
        
        <xsl:call-template name="createOverviewPage">
            <xsl:with-param name="objects" select="$model.classes"/>
        </xsl:call-template>
        
        <xsl:call-template name="createOverviewPage">
            <xsl:with-param name="objects" select="$data.types"/>
        </xsl:call-template>
        
        <xsl:call-template name="createOverviewPage">
            <xsl:with-param name="objects" select="$macro.groups"/>
        </xsl:call-template>
        
        
    </xsl:template>
    
    <xd:doc scope="component">
        <xd:desc>
            <xd:p>
                This function generates the required output page for an object, depending on its type
            </xd:p>
        </xd:desc>
        <xd:param name="object">
            <xd:p>This is the object which needs to be processed.</xd:p>
        </xd:param>
    </xd:doc>
    <xsl:template name="processObject">
        <xsl:param name="object" as="node()"/>
        
        <!-- identifies type of object -->
        <xsl:variable name="type" as="xs:string">
            <xsl:choose>
                <xsl:when test="local-name($object) = 'elementSpec'">
                    <xsl:value-of select="'element'"/>
                </xsl:when>
                <xsl:when test="local-name($object) = 'classSpec' and $object/@type = 'atts'">
                    <xsl:value-of select="'class.atts'"/>
                </xsl:when>
                <xsl:when test="local-name($object) = 'classSpec' and $object/@type = 'model'">
                    <xsl:value-of select="'class.model'"/>
                </xsl:when>
                <xsl:when test="local-name($object) = 'macroSpec' and $object/@type = 'dt'">
                    <xsl:value-of select="'macro.dt'"/>
                </xsl:when>
                <xsl:when test="local-name($object) = 'macroSpec' and $object/@type = 'pe'">
                    <xsl:value-of select="'macro.pe'"/>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        
        <!-- the folder where this object needs to go, depending on its type -->
        <xsl:variable name="object.folder" as="xs:string">
            <xsl:choose>
                <xsl:when test="$type = 'element'">
                    <xsl:value-of select="'elements/'"/>
                </xsl:when>
                <xsl:when test="$type = 'class.atts'">
                    <xsl:value-of select="'attribute-classes/'"/>
                </xsl:when>
                <xsl:when test="$type = 'class.model'">
                    <xsl:value-of select="'model-classes/'"/>
                </xsl:when>
                <xsl:when test="$type = 'macro.dt'">
                    <xsl:value-of select="'data-types/'"/>
                </xsl:when>
                <xsl:when test="$type = 'macro.pe'">
                    <xsl:value-of select="'macro-groups/'"/>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="target.folder" select="$output.folder || $object.folder" as="xs:string"/>
        <xsl:result-document href="{$target.folder || lower-case($object/@ident)}.md" format="html">
            <xsl:text>---</xsl:text>
            <xsl:text>&#xa;</xsl:text>
            <xsl:text>layout: sidebar</xsl:text>
            <xsl:text>&#xa;</xsl:text>
            <xsl:text>sidebar: s1</xsl:text>
            <xsl:text>&#xa;</xsl:text>
            <xsl:text>version: "</xsl:text><xsl:value-of select="$guidelines.version"/><xsl:text>"</xsl:text>
            <xsl:text>&#xa;</xsl:text>
            <xsl:text>title: "</xsl:text><xsl:value-of select="$object/@ident"/><xsl:text>"</xsl:text>
            <xsl:text>&#xa;</xsl:text>
            <xsl:text>---</xsl:text>
            <xsl:text>&#xa;</xsl:text>
            <div class="specPage">
                <xsl:apply-templates select="$object" mode="parse.odd"/> 
            </div>
        </xsl:result-document>
        
    </xsl:template>
    
</xsl:stylesheet>