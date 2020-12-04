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
        <xsl:apply-templates select="ead:archdesc/ead:did/ead:physdesc[@localtype = 'container_summary']"/>

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
 
[Need to figure out how to include all c01 series notes here, they will also be repeated in the box/folder list]
 
--Patron Information--
  
Catalog Record
  
  A record for this collection is available in Temple University’s online library catalog: [Link to catalog record is in an External Document note, but does not appear in EAD - add manually?]
  
Research Access
  
<xsl:apply-templates select="ead:archdesc/ead:accessrestrict"/>
        
Collections Stored Off-Site   

<xsl:apply-templates select="ead:archdesc/ead:did/ead:physloc"/>
     
Technical Access

<xsl:apply-templates select="ead:archdesc/ead:phystech"/>

Accruals

<xsl:apply-templates select="ead:archdesc/ead:accruals"/>

Condition Note 

<xsl:apply-templates select="ead:archdesc/ead:physdesc"/>

Publication and Copyright Information

<xsl:apply-templates select="ead:archdesc/ead:userestrict"/>

Preferred Citation
        
<xsl:apply-templates select="ead:archdesc/ead:prefercite"/>
        
Related Material

<xsl:apply-templates select="ead:archdesc/ead:relatedmaterial"/>
        
--Administrative Information--

Acquisition Information

<xsl:apply-templates select="ead:archdesc/ead:acqinfo"/>
        
Separated Material

<xsl:apply-templates select="ead:archdesc/ead:separatedmaterial"/>
        
Processing Information
        
<xsl:apply-templates select="ead:archdesc/ead:processinfo"/>
        
        
        
--Index Terms--
        
<p>The following headings have been used to index the description of this collection in Temple University’s electronic catalog:</p>
        
Personal/Family Names:
<xsl:apply-templates select="ead:archdesc/ead:controlaccess/ead:persname"/>
        
Corporate Names:
<xsl:apply-templates select="ead:archdesc/ead:controlaccess/ead:corpname"/>
        
Subjects:
<xsl:apply-templates select="ead:archdesc/ead:controlaccess/ead:subject"/>
        
Places:
<xsl:apply-templates select="ead:archdesc/ead:controlaccess/ead:geogname"/>
        
Material Types:
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
        <xsl:value-of select="ead:p" separator="&#10;&#009;"/>
    </xsl:template>
    
    <!-- scopecontent -->
    <xsl:template match="ead:archdesc/ead:scopecontent">
        <xsl:value-of select="ead:p" separator="&#10;&#009;"/>
    </xsl:template>
    
    <!-- arrangement -->
    <xsl:template match="ead:archdesc/ead:arrangement">
        <xsl:value-of select="ead:p"/>
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
        <xsl:value-of select="ead:p" separator="&#10;&#009;"/>
    </xsl:template>
    
    <!-- accruals -->
    <xsl:template match="ead:archdesc/ead:accruals">
        <xsl:value-of select="ead:p" separator="&#10;&#009;"/>
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
        <xsl:value-of select="ead:p" separator="&#10;&#009;"/>
    </xsl:template>
    
    <!-- acqinfo -->
    <xsl:template match="ead:archdesc/ead:acqinfo">
        <xsl:value-of select="ead:p" separator="&#10;&#009;"/>
    </xsl:template>
    
    <!-- separatedmaterial -->
    <xsl:template match="ead:archdesc/ead:separatedmaterial">
        <xsl:value-of select="ead:p" separator="&#10;&#009;"/>
    </xsl:template>
    
    <!-- processinfo -->
    <xsl:template match="ead:archdesc/ead:processinfo">
        <xsl:value-of select="ead:p" separator="&#10;&#009;"/>
    </xsl:template>
    
    <!-- persname -->
    <xsl:template match="ead:archdesc/ead:controlaccess/ead:persname">
        <xsl:value-of select="ead:part" separator="&#10;&#009;"/>
    </xsl:template>
    
    <!-- corpname -->
    <xsl:template match="ead:archdesc/ead:controlaccess/ead:corpname">
        <xsl:value-of select="ead:part" separator="&#10;&#009;"/>
    </xsl:template>
    
    <!-- subject -->
    <xsl:template match="ead:archdesc/ead:controlaccess/ead:subject">
        <xsl:value-of select="ead:part" separator="&#10;&#009;"/>
    </xsl:template>
    
    <!-- geogname -->
    <xsl:template match="ead:archdesc/ead:controlaccess/ead:geogname">
        <xsl:value-of select="ead:part" separator="&#10;&#009;"/>
    </xsl:template>
    
    <!-- genreform -->
    <xsl:template match="ead:archdesc/ead:controlaccess/ead:genreform">
        <xsl:value-of select="ead:part" separator="&#10;&#009;"/>
    </xsl:template>
    
    <!-- materialspec -->
    <xsl:template match="ead:archdesc/ead:did/ead:materialspec">
        <xsl:value-of select="ead:materialspec" separator="&#10;&#009;"/>
    </xsl:template>
    
    
<!-- END FRONTMATTER -->  
    
<!-- BEGIN BOX AND FOLDER LIST --> 

</xsl:stylesheet>

