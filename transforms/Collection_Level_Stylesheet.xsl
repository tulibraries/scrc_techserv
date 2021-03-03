<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:ead="http://ead3.archivists.org/schema/" 
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">
    
    <xsl:strip-space elements="*"/>
    <xsl:output method="text" indent="no"/>
    
    <!-- transforms EAD in XML from aspace to plain text following TU finding aid template -->
    <xsl:template match="text() | @*"/>
    <xsl:template match="ead:ead">
    	
Collection Summary
    
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
<xsl:apply-templates select="ead:archdesc/ead:did/ead:physdesc[@localtype = 'container_summary']"/>

Repository
Special Collections Research Center, Temple University Libraries

Language
<xsl:apply-templates select="ead:archdesc/ead:did/ead:langmaterial"/>

Detailed Collection Information

<!-- Historical Note [or] Biographical Note -->

<xsl:apply-templates select="ead:archdesc/ead:bioghist"/>
        
Description of Collection

<xsl:apply-templates select="ead:archdesc/ead:scopecontent"/>

Organization and Arrangement

<xsl:apply-templates select="ead:archdesc/ead:arrangement"/>
        
<xsl:apply-templates select="ead:archdesc/ead:dsc/ead:c01/ead:odd"/>
Patron Information

<!-- Alternate Form Available -->

<xsl:apply-templates select="ead:archdesc/ead:altformavail"/>

<!-- Other Finding Aids -->

<xsl:apply-templates select="ead:archdesc/ead:otherfindaid"/>

Catalog Record
  
A record for this collection is available in Temple University’s online library catalog: [Link to catalog record is in an External Document note, but does not appear in EAD - add manually?]
  
Research Access
  
<xsl:apply-templates select="ead:archdesc/ead:accessrestrict"/>
        
Collections Stored Off-Site   

<xsl:apply-templates select="ead:archdesc/ead:did/ead:physloc"/>
     
<!-- Technical Access -->

<xsl:apply-templates select="ead:archdesc/ead:phystech"/>

<!-- Accruals -->

<xsl:apply-templates select="ead:archdesc/ead:accruals"/>

Condition Note 

[Add manually if applicable, or delete note if not applicable]
<xsl:apply-templates select="ead:archdesc/ead:physdesc"/>
Publication and Copyright Information

<xsl:apply-templates select="ead:archdesc/ead:userestrict"/>

Preferred Citation
        
<xsl:apply-templates select="ead:archdesc/ead:prefercite"/>
        
<!-- Related Material -->

<xsl:apply-templates select="ead:archdesc/ead:relatedmaterial"/>
        
Administrative Information

Acquisition Information

<xsl:apply-templates select="ead:archdesc/ead:custodhist"/>
        
<!-- Separated Material -->

<xsl:apply-templates select="ead:archdesc/ead:separatedmaterial"/>
        
Processing Information
        
<xsl:apply-templates select="ead:archdesc/ead:processinfo"/>        
        
Index Terms
        
<p>The following headings have been used to index the description of this collection in Temple University’s electronic catalog:</p>
        
<!-- Personal/Family Names: -->
<xsl:apply-templates select="ead:archdesc/ead:controlaccess/ead:persname"/>        
<!-- Corporate Names: -->
<xsl:apply-templates select="ead:archdesc/ead:controlaccess/ead:corpname"/>        
<!-- Subjects: -->
<xsl:apply-templates select="ead:archdesc/ead:controlaccess/ead:subject"/>
<!-- Places: -->
<xsl:apply-templates select="ead:archdesc/ead:controlaccess/ead:geogname"/>
<!-- Material Types: -->
<xsl:apply-templates select="ead:archdesc/ead:controlaccess/ead:genreform"/>  


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
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>
    
    <!-- physical description -->
    <xsl:template match="ead:archdesc/ead:did/ead:physdescstructured">
        <xsl:value-of select="ead:quantity"/><xsl:text> </xsl:text><xsl:value-of select="ead:unittype"/>
    </xsl:template>
    <xsl:template match="ead:archdesc/ead:did/ead:physdesc[@localtype = 'container_summary']">
        <xsl:text> (</xsl:text><xsl:value-of select="."/><xsl:text>)</xsl:text>
    </xsl:template>
    
    <!-- language -->
    <xsl:template match="ead:archdesc/ead:did/ead:langmaterial">
        <xsl:value-of select="ead:language" separator="&#10;&#009;"/>
    </xsl:template>
    
    <!-- bioghist -->
    <xsl:template match="ead:archdesc/ead:bioghist">
        <xsl:if test="normalize-space(.)!=''">
            <xsl:value-of>Historical Note [or] Biographical Note</xsl:value-of>
            <xsl:text>&#xa;</xsl:text>
            <xsl:text>&#xa;</xsl:text>
            <xsl:value-of select="ead:p" separator="&#10;&#009;"/>
        </xsl:if>
    </xsl:template>
    
    <!-- scopecontent -->
    <xsl:template match="ead:archdesc/ead:scopecontent">
        <xsl:value-of select="ead:p" separator="&#10;&#009;"/>
    </xsl:template>
    
    <!-- arrangement -->
    <xsl:template match="ead:archdesc/ead:arrangement">
        <xsl:value-of select="ead:p" separator="&#10;&#009;"/>
        <xsl:text>&#xa;</xsl:text><xsl:text>&#xa;</xsl:text>
    </xsl:template>
    
    <!-- frontmatter series notes -->
    <xsl:template match="ead:archdesc/ead:dsc/ead:c01/ead:odd">
        <xsl:if test="normalize-space(.)!=''">
            <xsl:value-of select="ead:p" separator="&#10;&#009;"/>
            <xsl:text>&#xa;</xsl:text><xsl:text>&#xa;</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <!-- Alternate Form Available -->
    <xsl:template match="ead:archdesc/ead:altformavail">
        <xsl:if test="normalize-space(.)!=''">
            <xsl:value-of>Alternate Form Available</xsl:value-of>
            <xsl:text>&#xa;</xsl:text>
            <xsl:text>&#xa;</xsl:text>
            <xsl:value-of select="ead:p" separator="&#10;&#009;"/>
            <xsl:text>&#xa;</xsl:text>
            <xsl:text>&#xa;</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <!-- otherfindaid -->
    <xsl:template match="ead:archdesc/ead:otherfindaid">
        <xsl:if test="normalize-space(.)!=''">
            <xsl:value-of>Other Finding Aids</xsl:value-of>
            <xsl:text>&#xa;</xsl:text>
            <xsl:text>&#xa;</xsl:text>
            <xsl:value-of select="ead:p" separator="&#10;&#009;"/>
        </xsl:if>
    </xsl:template>
    
    <!-- accessrestrict -->
    <xsl:template match="ead:archdesc/ead:accessrestrict">
        <xsl:value-of select="ead:p" separator="&#10;&#009;"/>
    </xsl:template>
    
    <!-- physloc -->     
    <xsl:template match="ead:archdesc/ead:did/ead:physloc">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <!-- phystech -->
    <xsl:template match="ead:archdesc/ead:phystech">
        <xsl:if test="normalize-space(.)!=''">
            <xsl:text>&#xa;</xsl:text>
            <xsl:text>&#xa;</xsl:text>
            <xsl:value-of>Technical Access</xsl:value-of>
            <xsl:text>&#xa;</xsl:text>
            <xsl:text>&#xa;</xsl:text>
            <xsl:value-of select="ead:p" separator="&#10;&#009;"/>
        </xsl:if>
    </xsl:template>
    
    <!-- accruals -->
    <xsl:template match="ead:archdesc/ead:accruals">
        <xsl:if test="normalize-space(.)!=''">
            <xsl:text>&#xa;</xsl:text>
            <xsl:text>&#xa;</xsl:text>
            <xsl:value-of>Accruals </xsl:value-of>
            <xsl:text>&#xa;</xsl:text>
            <xsl:text>&#xa;</xsl:text>
            <xsl:value-of select="ead:p" separator="&#10;&#009;"/>
        </xsl:if>
    </xsl:template>
    
    <!-- physdesc currently for Condition Note but needs work -->
    <xsl:template match="ead:archdesc/ead:did/ead:physdesc">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <!-- userestrict -->
    <xsl:template match="ead:archdesc/ead:userestrict">
        <xsl:value-of select="ead:p" separator="&#10;&#009;"/>
    </xsl:template>
    
    <!-- prefercite -->
    <xsl:template match="ead:archdesc/ead:prefercite">
        <xsl:value-of select="ead:p" separator="&#10;&#009;"/>
    </xsl:template>
    
    <!-- relatedmaterial -->
    <xsl:template match="ead:archdesc/ead:relatedmaterial">
        <xsl:if test="normalize-space(.)!=''">
            <xsl:text>&#xa;</xsl:text>
            <xsl:text>&#xa;</xsl:text>
            <xsl:value-of>Related Material</xsl:value-of>
            <xsl:text>&#xa;</xsl:text>
            <xsl:text>&#xa;</xsl:text>
            <xsl:value-of select="ead:p" separator="&#10;&#009;"/>
        </xsl:if>
    </xsl:template>
    
    <!-- custodhist -->
    <xsl:template match="ead:archdesc/ead:custodhist">
        <xsl:value-of select="ead:p" separator="&#10;&#009;"/>
    </xsl:template>
    
    <!-- separatedmaterial -->
    <xsl:template match="ead:archdesc/ead:separatedmaterial">
        <xsl:if test="normalize-space(.)!=''">
            <xsl:text>&#xa;</xsl:text>
            <xsl:text>&#xa;</xsl:text>
            <xsl:value-of>Separated Material</xsl:value-of>
            <xsl:text>&#xa;</xsl:text>
            <xsl:text>&#xa;</xsl:text>
            <xsl:value-of select="ead:p" separator="&#10;&#009;"/>
        </xsl:if>
    </xsl:template>
    
    <!-- processinfo -->
    <xsl:template match="ead:archdesc/ead:processinfo">
        <xsl:value-of select="ead:p" separator="&#10;&#009;"/>
    </xsl:template>
    
    <!-- persname -->
    <xsl:template match="ead:archdesc/ead:controlaccess/ead:persname">
        <xsl:if test="normalize-space(.)!=''">
            <xsl:text>&#xa;</xsl:text>
            <xsl:text>&#xa;</xsl:text>
            <xsl:value-of>Personal/Family Names:</xsl:value-of>
            <xsl:text>&#xa;</xsl:text>
            <xsl:value-of select="ead:part"/>
            <xsl:text>&#xa;</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <!-- corpname -->
    <xsl:template match="ead:archdesc/ead:controlaccess/ead:corpname">
        <xsl:if test="normalize-space(.)!=''">
            <xsl:text>&#xa;</xsl:text>
            <xsl:value-of>Corporate Names:</xsl:value-of>
            <xsl:text>&#xa;</xsl:text>
            <xsl:value-of select="ead:part"/>
            <xsl:text>&#xa;</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <!-- subject -->
    <xsl:template match="ead:archdesc/ead:controlaccess/ead:subject">
        <xsl:if test="normalize-space(.)!=''">
            <xsl:text>&#xa;</xsl:text>
            <xsl:value-of>Subjects:</xsl:value-of>
            <xsl:text>&#xa;</xsl:text>
            <xsl:value-of select="ead:part"/>
            <xsl:text>&#xa;</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <!-- geogname -->
    <xsl:template match="ead:archdesc/ead:controlaccess/ead:geogname">
        <xsl:if test="normalize-space(.)!=''">
            <xsl:text>&#xa;</xsl:text>
            <xsl:value-of>Places:</xsl:value-of>
            <xsl:text>&#xa;</xsl:text>
            <xsl:value-of select="ead:part"/>
            <xsl:text>&#xa;</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <!-- genreform -->
    <xsl:template match="ead:archdesc/ead:controlaccess/ead:genreform">
    <xsl:if test="normalize-space(.)!=''">
        <xsl:text>&#xa;</xsl:text>
        <xsl:value-of>Material Types:</xsl:value-of>
        <xsl:text>&#xa;</xsl:text>
        <xsl:value-of select="ead:part"/>
        <xsl:text>&#xa;</xsl:text>
    </xsl:if>
    </xsl:template>
    
<!-- END FRONTMATTER --> 

</xsl:stylesheet>

