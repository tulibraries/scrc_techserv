<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:ead="http://ead3.archivists.org/schema/" 
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">
    
    <xsl:strip-space elements="*"/>
    <xsl:output method="text" indent="no"/>
    
    <!-- WORK IN PROGRESS -->
    
    <!-- transforms EAD in XML from aspace to plain text following TU finding aid template -->
    
    <!-- Sample finding aid: https://library.temple.edu/finding_aids/arthur-langley-searles-collection-of-h-p-lovecraft-research-files -->

    <xsl:template match="text() | @*"/>

    <xsl:template match="ead:ead">
--Collection Summary--
    
Title
    
    <xsl:apply-templates select="ead:archdesc/ead:did/ead:unittitle"/>    
        
Dates
        
    <xsl:apply-templates select="ead:archdesc/ead:did/ead:unitdate"/>
    
Collection ID
        
    <xsl:apply-templates select="//ead:unitid"/>    

Creator(s)
    
    <xsl:apply-templates select="ead:archdesc/ead:did/ead:origination[@label = 'Creator']/*"/>

Quantity
        
    <xsl:apply-templates select="ead:archdesc/ead:did/ead:physdescstructured"/>
    <xsl:apply-templates select="ead:archdesc/ead:did/ead:physdesc"/>

Repository

    Special Collections Research Center, Temple University Libraries

Language
    
    <xsl:apply-templates select="ead:archdesc/ead:did/ead:langmaterial"/>

--Detailed Collection Information--

Historical Note [or] Biographical Note

    <xsl:apply-templates select="ead:archdesc/ead:bioghist"/>
        
Description of Collection

    <xsl:apply-templates select="ead:archdesc/ead:scopecontent"/>

Organization and Arrangement

    <xsl:apply-templates select="ead:archdesc/ead:arrangement"/>
 
--Patron Information--
    <!-- alternate form available; update with xpath ; you this as a template to use a header only if data is available in record -->
    <xsl:apply-templates select="ead:xpath/ead:altform"/>

    </xsl:template>
    
    <!-- TEMPLATES -->
    
    <!-- title -->
    <xsl:template match="ead:archdesc/ead:did/ead:unittitle">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <!-- dates -->
    <xsl:template match="ead:archdesc/ead:did/ead:unitdate[@unitdatetype != 'bulk']">
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template match="ead:archdesc/ead:did/ead:unitdate[@unitdatetype = 'bulk']">
        <xsl:text>, bulk </xsl:text><xsl:value-of select="."/>
    </xsl:template>
    
    <!-- collection ID -->
    <xsl:template match="//ead:unitid">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <!-- creators -->
    <xsl:template match="ead:archdesc/ead:did/ead:origination[@label = 'Creator']/*">
        <xsl:value-of select="ead:part" separator="&#10;&#009;"/>
    </xsl:template>
    
    <!-- physical description -->
    <xsl:template match="ead:archdesc/ead:did/ead:physdescstructured">
        <xsl:value-of select="ead:quantity"/><xsl:text> </xsl:text><xsl:value-of select="ead:unittype"/>
    </xsl:template>
    <xsl:template match="ead:archdesc/ead:did/ead:physdesc">
        <xsl:text> (</xsl:text><xsl:value-of select="."/><xsl:text>)</xsl:text>
    </xsl:template>
    
    <!-- language -->
    <xsl:template match="ead:archdesc/ead:did/ead:langmaterial">
        <xsl:value-of select="ead:language" separator="&#10;&#009;"/>
    </xsl:template>
    
    <!-- bioghist -->
    <xsl:template match="ead:archdesc/ead:bioghist">
        <xsl:value-of select="ead:p" separator="&#10;&#009;"/>
    </xsl:template>
    
    <!-- scopecontent -->
    <xsl:template match="ead:archdesc/ead:scopecontent">
        <xsl:value-of select="ead:p" separator="&#10;&#009;"/>
    </xsl:template>
    
    <!-- arrangement -->
    <xsl:template match="ead:archdesc/ead:arrangement">
        <xsl:value-of select="ead:p" separator="&#10;&#009;"/>
    </xsl:template>
    
    <!-- alt form ; not sure of xpath to this node -->
    <xsl:template match="ead:xpath/ead:altform">
Alternate Form Available
        <xsl:value-of select="ead:p" separator="&#10;&#009;"/>

    </xsl:template>

</xsl:stylesheet>

