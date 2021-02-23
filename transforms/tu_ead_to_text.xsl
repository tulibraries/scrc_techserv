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
        
--Index Terms--
        
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

--Inventory--

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
    
<!-- BEGIN CONTAINER LIST -->
    
<!-- ***********************Section 11:  Formats the description of subordinate components																	 -->

	<!-- ***********************Section 11a:  Formats the dsc head and paragraph   **********************************************************	-->
	<xsl:template match="ead:dsc">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="ead:dsc/ead:head">
		<h2 stye="text-align:left" id="{generate-id()}">
			<xsl:apply-templates/>
		</h2>
	</xsl:template>
	<xsl:template match="ead:dsc/ead:p">
		<div style="margin-left:25pt" text-align="left">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<!--	The following section of the stylesheet contains a separate template for each component level c01 through level c10.  The contents of each is identical 
				except for the spacing that is inserted to create the proper columnar display for that level.-->
	<!-- 	Each component level in turn calls one or two named templates to process its container elements, then calls another template to process its children 
				other than did, and then applies the applicable templates for the next lower component level. -->

	<!-- ***********************Section 12a:  Transforms c01.  **********************************************************	-->

	<!--This template creates an HTML table for each c01 and its component children.-->
	<xsl:template match="ead:c01">
		<table style="width:600px; table-layout:fixed">
			<tr>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
				<col width="30px"/>
			</tr>
			<xsl:for-each select="ead:did">
				<!-- ********  Test to determine whether this did element has a container child or not -->
				<xsl:choose>
					<!--      If there is a container child....   ********************* -->
					<xsl:when test="ead:container">
						<!-- Insert column heads based on the value of the localtype attribute, followed
						-->
						<tr style="font-weight:bold">
							<td>
								<xsl:apply-templates select="ead:container[1]/@ead:localtype"/>
							</td>
							<td style="font-weight:bold">
								<xsl:apply-templates select="ead:container[2]/@ead:localtype"/>
							</td>
						</tr>
						<!--    Insert the values of each of the container elements  -->
						<tr>
							<td>
								<xsl:apply-templates select="ead:container[1]"/>
							</td>
							<td>
								<xsl:apply-templates select="ead:container[2]"/>
							</td>
							<td colspan="18" valign="top" style="font-weight:bold">
								<!-- Generates a name attribute with the value "series" and its number to serve as 
										the target for internal hyperlinks. -->
								<a>
									<xsl:attribute name="name">
										<xsl:text>series</xsl:text>
										<xsl:number from="ead:dsc" count="ead:c01"/>
									</xsl:attribute>
								</a>
								<xsl:call-template name="component-did"/>
							</td>
						</tr>
						<xsl:for-each
							select="ead:abstract | ead:didnote | ead:langmaterial | ead:materialspec">
							<tr>
								<td colspan="3"> </td>
								<td colspan="17" valign="top">
									<xsl:if test="./@ead:label">
										<xsl:apply-templates select="@ead:label"/>
										<xsl:text>: </xsl:text>
									</xsl:if>
									<xsl:apply-templates/>
								</td>
							</tr>
						</xsl:for-each>
					</xsl:when>
					<!-- ********  If there is no container child...******************* -->
					<xsl:otherwise>
						<tr>
							<td colspan="20" valign="top" style="font-weight:bold">
								<!-- Generates a name attribute with the value "series" and its number in the sequence 
									of c01 elements to serve as the target for internal hyperlinks. -->
								<a>
									<xsl:attribute name="name">
										<xsl:text>series</xsl:text>
										<xsl:number from="ead:dsc" count="ead:c01"/>
									</xsl:attribute>
								</a>
								<xsl:call-template name="component-did"/>
							</td>
						</tr>
						<xsl:for-each
							select="ead:abstract | ead:didnote | ead:langmaterial | ead:materialspec">
							<tr>
								<td/>
								<td colspan="19" valign="top">
									<xsl:if test="@ead:label">
										<xsl:apply-templates select="@ead:label"/>
										<xsl:text>: </xsl:text>
									</xsl:if>
									<xsl:apply-templates/>
								</td>
							</tr>
						</xsl:for-each>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
			<xsl:for-each
				select="
					ead:scopecontent | ead:bioghist | ead:arrangement
					| ead:userestrict | ead:accessrestrict | ead:processinfo |
					ead:acqinfo | ead:custodhist | ead:controlaccess/ead:controlaccess | ead:odd">
				<xsl:for-each select="ead:p">
					<xsl:choose>
						<!--   Tests to determine if this component has a did element with a container attribute 
						in order to determine the amount of indention required.  ****************   -->
						<xsl:when test="preceding::ead:did[1]/ead:container">
							<tr>
								<td colspan="2"/>
								<td colspan="18">
									<xsl:apply-templates/>
								</td>
							</tr>
						</xsl:when>
						<!--When there are no container elements associated with this component,
					adjust the columns to the left.  Each paragraph gos on a separate line.-->
						<xsl:otherwise>
							<tr>
								<td colspan="2"/>
								<td colspan="18">
									<!--    Tests to see if this element has a head child.  If so, display it followed by a colon and a space-->
									<xsl:apply-templates/>
								</td>
							</tr>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:for-each>
			<!--   Processes any other c01 children that follow the did with
				each paragraph on a separate line . -->
			<xsl:apply-templates select="ead:c02"/>
		</table>
	</xsl:template>

	<!--*****  Section 12b:  Transforms c02   ************************************-->
	<xsl:template match="ead:c02">
		<xsl:for-each select="ead:did">
			<!-- ********  There are two xsl:when tests in this template: first to determine whether this did element has 
				a container child or not and then, if it does, to determine whether or not the value of the first container 
				repeats that of the first container in the previous element.-->

			<xsl:choose>
				<!--      If there is a container child....   ********************* -->
				<xsl:when test="ead:container">
					<!--  If the first container's value equals that of the same element in the previous component, 
								suppress the value of the first container and omit the column heads, eg. Box and Folder. -->
					<xsl:choose>
						<xsl:when test="ead:container[1] = preceding::ead:did[1]/ead:container[1]">
							<tr>
								<td> </td>
								<td>
									<xsl:apply-templates select="ead:container[2]"/>
								</td>
								<td colspan="18" valign="top">
									<xsl:call-template name="component-did"/>
								</td>
							</tr>
						</xsl:when>
						<xsl:otherwise>
							<!-- Insert column heads based on the value of the localtype attribute on one line.  -->
							<tr>
								<td style="font-weight:bold">
									<xsl:apply-templates select="ead:container[1]/@localtype"/>
								</td>
								<td style="font-weight:bold">
									<xsl:apply-templates select="ead:container[2]/@localtype"/>
								</td>
							</tr>
							<!--    Insert the values of each of the container elements and the "primary" did children on the next line. -->
							<tr>
								<td>
									<xsl:apply-templates select="ead:container[1]"/>
								</td>
								<td>
									<xsl:apply-templates select="ead:container[2]"/>
								</td>
								<td colspan="18" valign="top">
									<xsl:call-template name="component-did"/>
								</td>
							</tr>
						</xsl:otherwise>
					</xsl:choose>
					<!--    Display the remainder of the did children -->
					<xsl:for-each
						select="ead:abstract | ead:didnote | ead:langmaterial/ead:descriptivenote/ead:p | ead:materialspec">
						<tr>
							<td colspan="3"> </td>
							<td colspan="17" valign="top">
								<xsl:apply-templates/>
							</td>
						</tr>
					</xsl:for-each>
				</xsl:when>
				<!-- ********  If there is no container child, there is minimal indention....******************* -->
				<xsl:otherwise>
					<tr>
						<td colspan="2"/>
						<td colspan="18" valign="top" style="font-weight:bold">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
					<xsl:for-each
						select="ead:abstract | ead:didnote | ead:langmaterial | ead:materialspec">
						<tr>
							<td colspan="2"/>
							<td colspan="18" valign="top">
								<xsl:apply-templates/>
							</td>
						</tr>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>

		<!--   Processes any other c02 children that follow the did. -->
		<xsl:for-each
			select="
				ead:scopecontent | ead:bioghist | ead:arrangement
				| ead:userestrict | ead:accessrestrict | ead:processinfo |
				ead:acqinfo | ead:custodhist | ead:controlaccess/ead:controlaccess | ead:odd">
			<xsl:for-each select="ead:p">
				<xsl:choose>
					<!--   Tests to determine if this component has a did element with a container attribute 
						in order to determine the amount of indention required.  ****************   -->
					<!--   If this c02 has a did with containers, intent these remaining elements to the right to accommodate the 
				space taken by the container values.   -->
					<xsl:when test="preceding::ead:did[1]/ead:container">
						<tr>
							<td colspan="3"/>
							<td colspan="17">
								<xsl:apply-templates/>
							</td>
						</tr>
					</xsl:when>
					<!--    If this c02 has no containers associated with it, indent accordingly. -->
					<xsl:otherwise>
						<tr>
							<td colspan="3"/>
							<td colspan="17">
								<xsl:apply-templates/>
							</td>
						</tr>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:apply-templates select="ead:c03"/>
	</xsl:template>

	<!--*****  Section 12c:  Transforms c03   ************************************-->
	<xsl:template match="ead:c03">
		<xsl:for-each select="ead:did">
			<!--  If the first container's value equals that of the same element in the previous component, 
								suppress the value of the first container and omit the column heads, eg. Box and Folder. -->
			<xsl:choose>
				<xsl:when test="ead:container[1] = preceding::ead:did[1]/ead:container[1]">
					<tr>
						<td> </td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td/>
						<td colspan="17" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<!-- Insert column heads based on the value of the localtype attribute on one line.  -->
					<tr>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[1]/@localtype"/>
						</td>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[2]/@localtype"/>
						</td>
					</tr>
					<!--    Insert the values of each of the container elements and the "primary" did children on the next line. -->
					<tr>
						<td>
							<xsl:apply-templates select="ead:container[1]"/>
						</td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="2"/>
						<td colspan="16" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
			<!--    Display the remainder of the did children -->
			<xsl:for-each select="ead:abstract | ead:didnote | ead:langmaterial | ead:materialspec">
				<tr>
					<td colspan="5"> </td>
					<td colspan="15" valign="top">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<!--   Processes any other c03 children that follow the did. -->
		<xsl:for-each
			select="
				ead:scopecontent | ead:bioghist | ead:arrangement
				| ead:userestrict | ead:accessrestrict | ead:processinfo |
				ead:acqinfo | ead:custodhist | ead:controlaccess/ead:controlaccess | ead:odd">
			<xsl:for-each select="ead:p">
				<tr>
					<td colspan="5"/>
					<td colspan="15">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:apply-templates select="ead:c04"/>
	</xsl:template>

	<!--   Section 12d:   Transforms c04 ************ -->
	<xsl:template match="ead:c04">
		<xsl:for-each select="ead:did">
			<!--  If the first container's value equals that of the same element in the previous component, 
								suppress the value of the first container and omit the column heads, eg. Box and Folder. -->
			<xsl:choose>
				<xsl:when test="ead:container[1] = preceding::ead:did[1]/ead:container[1]">
					<tr>
						<td> </td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="2"/>
						<td colspan="16" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<!-- Insert column heads based on the value of the localtype attribute on one line.  -->
					<tr>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[1]/@localtype"/>
						</td>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[2]/@localtype"/>
						</td>
					</tr>
					<!--    Insert the values of each of the container elements and the "primary" did children on the next line. -->
					<tr>
						<td>
							<xsl:apply-templates select="ead:container[1]"/>
						</td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="2"/>
						<td colspan="16" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
			<!--    Display the remainder of the did children -->
			<xsl:for-each select="ead:abstract | ead:didnote | ead:langmaterial | ead:materialspec">
				<tr>
					<td colspan="6"> </td>
					<td colspan="14" valign="top">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<!--   Processes any other c04 children that follow the did. -->
		<xsl:for-each
			select="
				ead:scopecontent | ead:bioghist | ead:arrangement
				| ead:userestrict | ead:accessrestrict | ead:processinfo |
				ead:acqinfo | ead:custodhist | ead:controlaccess/ead:controlaccess | ead:odd">
			<xsl:for-each select="ead:p">
				<tr>
					<td colspan="6"/>
					<td colspan="14">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:apply-templates select="ead:c05"/>
	</xsl:template>

	<!--   Section 12e:   Transforms c05 ************ -->
	<xsl:template match="ead:c05">
		<xsl:for-each select="ead:did">
			<!--  If the first container's value equals that of the same element in the previous component, 
								suppress the value of the first container and omit the column heads, eg. Box and Folder. -->
			<xsl:choose>
				<xsl:when test="ead:container[1] = preceding::ead:did[1]/ead:container[1]">
					<tr>
						<td> </td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="3"/>
						<td colspan="15" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<!-- Insert column heads based on the value of the localtype attribute on one line.  -->
					<tr>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[1]/@localtype"/>
						</td>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[2]/@localtype"/>
						</td>
					</tr>
					<!--    Insert the values of each of the container elements and the "primary" did children on the next line. -->
					<tr>
						<td>
							<xsl:apply-templates select="ead:container[1]"/>
						</td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="3"/>
						<td colspan="15" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
			<!--    Display the remainder of the did children -->
			<xsl:for-each select="ead:abstract | ead:didnote | ead:langmaterial | ead:materialspec">
				<tr>
					<td colspan="7"> </td>
					<td colspan="13" valign="top">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<!--   Processes any other c05 children that follow the did. -->
		<xsl:for-each
			select="
				ead:scopecontent | ead:bioghist | ead:arrangement
				| ead:userestrict | ead:accessrestrict | ead:processinfo |
				ead:acqinfo | ead:custodhist | ead:controlaccess/ead:controlaccess | ead:odd">
			<xsl:for-each select="ead:p">
				<tr>
					<td colspan="7"/>
					<td colspan="13">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:apply-templates select="ead:c06"/>
	</xsl:template>

	<!--   Section 12f:   Transforms  <c06> ************ -->
	<xsl:template match="ead:c06">
		<xsl:for-each select="ead:did">
			<!--  If the first container's value equals that of the same element in the previous component, 
								suppress the value of the first container and omit the column heads, eg. Box and Folder. -->
			<xsl:choose>
				<xsl:when test="ead:container[1] = preceding::ead:did[1]/ead:container[1]">
					<tr>
						<td> </td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="4"/>
						<td colspan="14" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<!-- Insert column heads based on the value of the localtype attribute on one line.  -->
					<tr>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[1]/@localtype"/>
						</td>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[2]/@localtype"/>
						</td>
					</tr>
					<!--    Insert the values of each of the container elements and the "primary" did children on the next line. -->
					<tr>
						<td>
							<xsl:apply-templates select="ead:container[1]"/>
						</td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="6"/>
						<td colspan="14" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
			<!--    Display the remainder of the did children -->
			<xsl:for-each select="ead:abstract | ead:didnote | ead:langmaterial | ead:materialspec">
				<tr>
					<td colspan="8"> </td>
					<td colspan="12" valign="top">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<!--   Processes any other c06 children that follow the did. -->
		<xsl:for-each
			select="
				ead:scopecontent | ead:bioghist | ead:arrangement
				| ead:userestrict | ead:accessrestrict | ead:processinfo |
				ead:acqinfo | ead:custodhist | ead:controlaccess/ead:controlaccess | ead:odd">
			<xsl:for-each select="ead:p">
				<tr>
					<td colspan="8"/>
					<td colspan="12">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:apply-templates select="ead:c07"/>
	</xsl:template>

	<!--   Section 12g:   Transforms c07 ************ -->
	<xsl:template match="ead:c07">
		<xsl:for-each select="ead:did">
			<!--  If the first container's value equals that of the same element in the previous component, 
								suppress the value of the first container and omit the column heads, eg. Box and Folder. -->
			<xsl:choose>
				<xsl:when test="ead:container[1] = preceding::ead:did[1]/ead:container[1]">
					<tr>
						<td> </td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="5"/>
						<td colspan="13" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<!-- Insert column heads based on the value of the localtype attribute on one line.  -->
					<tr>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[1]/@localtype"/>
						</td>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[2]/@localtype"/>
						</td>
					</tr>
					<!--    Insert the values of each of the container elements and the "primary" did children on the next line. -->
					<tr>
						<td>
							<xsl:apply-templates select="ead:container[1]"/>
						</td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="5"/>
						<td colspan="13" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
			<!--    Display the remainder of the did children -->
			<xsl:for-each select="ead:abstract | ead:didnote | ead:langmaterial | ead:materialspec">
				<tr>
					<td colspan="9"> </td>
					<td colspan="11" valign="top">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<!--   Processes any other c07 children that follow the did. -->
		<xsl:for-each
			select="
				ead:scopecontent | ead:bioghist | ead:arrangement
				| ead:userestrict | ead:accessrestrict | ead:processinfo |
				ead:acqinfo | ead:custodhist | ead:controlaccess/ead:controlaccess | ead:odd">
			<xsl:for-each select="ead:p">
				<tr>
					<td colspan="9"/>
					<td colspan="11">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:apply-templates select="ead:c08"/>
	</xsl:template>

	<!--   Section 12h:   Transforms c08 ************ -->
	<xsl:template match="ead:c08">
		<xsl:for-each select="ead:did">
			<!--  If the first container's value equals that of the same element in the previous component, 
								suppress the value of the first container and omit the column heads, eg. Box and Folder. -->
			<xsl:choose>
				<xsl:when test="ead:container[1] = preceding::ead:did[1]/ead:container[1]">
					<tr>
						<td> </td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="6"/>
						<td colspan="12" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<!-- Insert column heads based on the value of the localtype attribute on one line.  -->
					<tr>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[1]/@localtype"/>
						</td>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[2]/@localtype"/>
						</td>
					</tr>
					<!--    Insert the values of each of the container elements and the "primary" did children on the next line. -->
					<tr>
						<td>
							<xsl:apply-templates select="ead:container[1]"/>
						</td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="6"/>
						<td colspan="12" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
			<!--    Display the remainder of the did children -->
			<xsl:for-each select="ead:abstract | ead:didnote | ead:langmaterial | ead:materialspec">
				<tr>
					<td colspan="10"> </td>
					<td colspan="10" valign="top">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<!--   Processes any other c08 children that follow the did. -->
		<xsl:for-each
			select="
				ead:scopecontent | ead:bioghist | ead:arrangement
				| ead:userestrict | ead:accessrestrict | ead:processinfo |
				ead:acqinfo | ead:custodhist | ead:controlaccess/ead:controlaccess | ead:odd">
			<xsl:for-each select="ead:p">
				<tr>
					<td colspan="10"/>
					<td colspan="10">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:apply-templates select="ead:c09"/>
	</xsl:template>

	<!--   Section 12i:   Transforms c09 ************ -->
	<xsl:template match="ead:c09">
		<xsl:for-each select="ead:did">
			<!--  If the first container's value equals that of the same element in the previous component, 
								suppress the value of the first container and omit the column heads, eg. Box and Folder. -->
			<xsl:choose>
				<xsl:when test="ead:container[1] = preceding::ead:did[1]/ead:container[1]">
					<tr>
						<td> </td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="7"/>
						<td colspan="11" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<!-- Insert column heads based on the value of the localtype attribute on one line.  -->
					<tr>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[1]/@localtype"/>
						</td>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[2]/@localtype"/>
						</td>
					</tr>
					<!--    Insert the values of each of the container elements and the "primary" did children on the next line. -->
					<tr>
						<td>
							<xsl:apply-templates select="ead:container[1]"/>
						</td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="7"/>
						<td colspan="11" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
			<!--    Display the remainder of the did children -->
			<xsl:for-each select="ead:abstract | ead:didnote | ead:langmaterial | ead:materialspec">
				<tr>
					<td colspan="11"> </td>
					<td colspan="9" valign="top">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<!--   Processes any other c09 children that follow the did. -->
		<xsl:for-each
			select="
				ead:scopecontent | ead:bioghist | ead:arrangement
				| ead:userestrict | ead:accessrestrict | ead:processinfo |
				ead:acqinfo | ead:custodhist | ead:controlaccess/ead:controlaccess | ead:odd">
			<xsl:for-each select="ead:p">
				<tr>
					<td colspan="11"/>
					<td colspan="9">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:apply-templates select="ead:c09"/>
	</xsl:template>
    
<!--   Section 12j:   Transforms c10 ************ -->
	<xsl:template match="ead:c09">
		<xsl:for-each select="ead:did">
			<!--  If the first container's value equals that of the same element in the previous component, 
								suppress the value of the first container and omit the column heads, eg. Box and Folder. -->
			<xsl:choose>
				<xsl:when test="ead:container[1] = preceding::ead:did[1]/ead:container[1]">
					<tr>
						<td> </td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="8"/>
						<td colspan="10" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<!-- Insert column heads based on the value of the localtype attribute on one line.  -->
					<tr>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[1]/@localtype"/>
						</td>
						<td style="font-weight:bold">
							<xsl:apply-templates select="ead:container[2]/@localtype"/>
						</td>
					</tr>
					<!--    Insert the values of each of the container elements and the "primary" did children on the next line. -->
					<tr>
						<td>
							<xsl:apply-templates select="ead:container[1]"/>
						</td>
						<td>
							<xsl:apply-templates select="ead:container[2]"/>
						</td>
						<td colspan="8"/>
						<td colspan="10" valign="top">
							<xsl:call-template name="component-did"/>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
			<!--    Display the remainder of the did children -->
			<xsl:for-each select="ead:abstract | ead:didnote | ead:langmaterial | ead:materialspec">
				<tr>
					<td colspan="12"> </td>
					<td colspan="8" valign="top">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<!--   Processes any other c10 children that follow the did. -->
		<xsl:for-each
			select="
				ead:scopecontent | ead:bioghist | ead:arrangement
				| ead:userestrict | ead:accessrestrict | ead:processinfo |
				ead:acqinfo | ead:custodhist | ead:controlaccess/ead:controlaccess | ead:odd">
			<xsl:for-each select="ead:p">
				<tr>
					<td colspan="12"/>
					<td colspan="8">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>


	<!--****************** Section 13:   Specifies the content of several generic and named templates which are invoked 
		at various points in the stylesheet.******-->

	<!-- ************ *****  Section 13a:  Creates HTML META tags that are added to the <head> element created in section 1a.***** -->
	<!--	HTML meta tags are inserted into the HTML ouput for use by web search engines indexing this file.  The content of each
					resulting META tag uses Dublin Core semantics and is drawn from the text of the finding aid.-->

	<xsl:template name="metadata">
		<meta http-equiv="Content-Type" name="dc.ead:title"
			content="{ead:control/ead:filedesc/ead:titlestmt/ead:titleproper&#x20; }{ead:control/ead:filedesc/ead:titlestmt/ead:subtitle}"/>
		<meta http-equiv="Content-Type" name="dc.author"
			content="{ead:archdesc/ead:did/ead:origination}"/>
		<xsl:for-each select="//ead:controlaccess/ead:persname | //ead:controlaccess/ead:corpname">
			<xsl:choose>
				<xsl:when test="@encodinganalog = '600'">
					<meta http-equiv="Content-Type" name="dc.ead:subject" content="{.}"/>
				</xsl:when>
				<xsl:when test="//@encodinganalog = '610'">
					<meta http-equiv="Content-Type" name="dc.ead:subject" content="{.}"/>
				</xsl:when>
				<xsl:when test="//@encodinganalog = '611'">
					<meta http-equiv="Content-Type" name="dc.ead:subject" content="{.}"/>
				</xsl:when>
				<xsl:when test="//@encodinganalog = '700'">
					<meta http-equiv="Content-Type" name="dc.contributor" content="{.}"/>
				</xsl:when>
				<xsl:when test="//@encodinganalog = '710'">
					<meta http-equiv="Content-Type" name="dc.contributor" content="{.}"/>
				</xsl:when>
				<xsl:otherwise>
					<meta http-equiv="Content-Type" name="dc.contributor" content="{.}"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<xsl:for-each select="//ead:controlaccess/ead:subject">
			<meta http-equiv="Content-Type" name="dc.ead:subject" content="{.}"/>
		</xsl:for-each>
		<xsl:for-each select="//ead:controlaccess/ead:geogname">
			<meta http-equiv="Content-Type" name="dc.ead:subject" content="{.}"/>
		</xsl:for-each>
		<meta http-equiv="Content-Type" name="dc.ead:title"
			content="{ead:archdesc/ead:did/ead:unittitle}"/>
		<meta http-equiv="Content-Type" name="dc.type" content="text"/>
		<meta http-equiv="Content-Type" name="dc.format" content="manuscripts"/>
		<meta http-equiv="Content-Type" name="dc.format" content="finding aids"/>
	</xsl:template>
	<!--***************** Section 13b: Creates a table of contents for the finding. This template is called in Section 1b  ****.-->
	<xsl:template name="toc">
		<h3>TABLE OF CONTENTS</h3>
		<br/>
		<!-- The Table of Contents template performs a series of tests to
		determine which elements will be included in the table
		of contents.  Each if statement tests to see if there is
		a matching element with content in the finding aid.-->
		<xsl:if test="string(ead:archdesc/ead:did/ead:head)">
			<p>
				<b>
					<a href="#{generate-id(ead:archdesc/ead:did/ead:head)}">
						<xsl:value-of select="ead:archdesc/ead:did/ead:head"/>
					</a>
				</b>
			</p>
		</xsl:if>
		<xsl:if test="string(ead:archdesc/ead:bioghist/ead:head)">
			<p style="margin-top:-5pt">
				<b>
					<a href="#{generate-id(ead:archdesc/ead:bioghist/ead:head)}">
						<xsl:value-of select="ead:archdesc/ead:bioghist/ead:head"/>
					</a>
				</b>
			</p>
		</xsl:if>
		<xsl:if test="string(ead:archdesc/ead:scopecontent/ead:head)">
			<p style="margin-top:-5pt">
				<b>
					<a href="#{generate-id(ead:archdesc/ead:scopecontent/ead:head)}">
						<xsl:value-of select="ead:archdesc/ead:scopecontent/ead:head"/>
					</a>
				</b>
			</p>
		</xsl:if>
		<xsl:if test="string(ead:archdesc/ead:arrangement/ead:head)">
			<p style="margin-top:-5pt">
				<b>
					<a href="#{generate-id(ead:archdesc/ead:arrangement/ead:head)}">
						<xsl:value-of select="ead:archdesc/ead:arrangement/ead:head"/>
					</a>
				</b>
			</p>
		</xsl:if>
		<xsl:if
			test="
				string(ead:archdesc/ead:userestrict/ead:head)
				or string(ead:archdesc/ead:accessrestrict/ead:head)">
			<p style="margin-top:-5pt">
				<b>
					<a href="#restrictlink">
						<xsl:text>Restrictions</xsl:text>
					</a>
				</b>
			</p>
		</xsl:if>
		<xsl:if test="string(ead:archdesc/ead:controlaccess/ead:head)">
			<p style="margin-top:-5pt">
				<b>
					<a href="#{generate-id(ead:archdesc/ead:controlaccess/ead:head)}">
						<xsl:value-of select="ead:archdesc/ead:controlaccess/ead:head"/>
					</a>
				</b>
			</p>
		</xsl:if>
		<xsl:if
			test="
				string(ead:archdesc/ead:relatedmaterial)
				or string(ead:archdesc/separatedmaterial)">
			<p style="margin-top:-5pt">
				<b>
					<a href="#relatedmatlink">
						<xsl:text>Related Material</xsl:text>
					</a>
				</b>
			</p>
		</xsl:if>
		<xsl:if
			test="
				string(ead:archdesc/ead:acqinfo/*)
				or string(ead:archdesc/ead:processinfo/*)
				or string(ead:archdesc/ead:preferecite/*)
				or string(ead:archdesc/ead:custodialhist/*)
				or string(ead:archdesc/ead:processinfo/*)
				or string(ead:archdesc/ead:appraisal/*)
				or string(ead:archdesc/ead:accruals/*)">
			<p style="margin-top:-5pt">
				<b>
					<a href="#adminlink">
						<xsl:text>Administrative Information</xsl:text>
					</a>
				</b>
			</p>
		</xsl:if>
		<xsl:if
			test="
				string(ead:archdesc/ead:prefercite/ead:*)
				or string(ead:archdesc/ead:otherfindaid/ead:*)
				or string(ead:archdesc/ead:bibliography/ead:*)
				or string(ead:archdesc/ead:fileplan/ead:*)
				or string(ead:archdesc/ead:originalsloc/ead:*)
				or string(ead:archdesc/ead:legalstatus/ead:*)
				or string(ead:archdesc/ead:odd/ead:*)
				or string(ead:archdesc/ead:index/ead:*)">
			<p style="margin-top:-5pt">
				<b>
					<a href="#associatedlink">
						<xsl:text>Associated Information</xsl:text>
					</a>
				</b>
			</p>
		</xsl:if>
		<xsl:if test="string(ead:archdesc/ead:dsc/ead:head)">
			<p style="margin-top:-5pt">
				<b>
					<a href="#{generate-id(ead:archdesc/ead:dsc/ead:head)}">
						<xsl:value-of select="ead:archdesc/ead:dsc/ead:head"/>
					</a>
				</b>
			</p>
			<!-- Displays the unittitle and unitdates for a c01 if it is a
			subgrp, subcollection,series or subseries (as
			evidenced by the value of @level) and numbers them
			to form a hyperlink to each.   Delete this section if you do not
			wish the ead:c01 ead:titles that are so identified
			to appear in the table of contents.-->
			<xsl:for-each
				select="
					ead:archdesc/ead:dsc/ead:c01[@level = 'series' or @level = 'subseries'
					or @level = 'subgrp' or @level = 'subcollection']">
				<p style="margin-top:-5pt; margin-left:15pt; font-size:10pt">
					<b>
						<a>
							<xsl:attribute name="href">
								<xsl:text>#series</xsl:text>
								<xsl:number count="ead:c01" from="ead:dsc"/>
							</xsl:attribute>
							<xsl:apply-templates select="ead:did/ead:unittitle"/>
							<xsl:text>, </xsl:text>
							<xsl:apply-templates select="ead:did/ead:unitdate"/>
						</a>
					</b>
				</p>
			</xsl:for-each>
			<!--This ends the section that causes the c01 titles to appear in the table of contents.-->
		</xsl:if>
		<!--End of the table of contents. -->
	</xsl:template>

	<!-- ********* Section 13d.  A generic template that formats and supplies punctuation for the "access" 
		elements in repository,	origination and controlaccess that have a child part element.	 Punctuation 
		is base on the values in @localtype which are assumed to follow the conventionns of MARC21.   
		Excluded are parts of titles that are children of title in a paragraph.-->
	<xsl:template
		match="
			ead:persname/ead:part | ead:corpname/ead:part | ead:famname/ead:part |
			ead:name/ead:part | ead:subject/ead:part | ead:title[not(parent::ead:p)]/ead:part | ead:function/ead:part
			| ead:occupation/ead:part | ead:geogname/ead:part | ead:genreform/ead:part">
		<!--   There are four secenarios for handling the part element and its punctuation. -->
		<xsl:choose>
			<!-- The first scenario occurs when there is no @localtype.  Each part element 
				is processed and a generic period and space are inserted following it.-->
			<xsl:when test="not[@localtype]">
				<xsl:apply-templates/>
				<xsl:text>.&#x20;</xsl:text>
			</xsl:when>
			<!--	 The second scenario is where there is an @localtype AND this particlar part element is 
				not the last child of its parent element AND the value of @localtype is not a q, 
				a name qualifier that must be inserted between square brackets.	
				The supplied punctuation for each part depends on the value of the following part.  -->
			<xsl:when test="position() != last() and @localtype != 'q'">
				<!-- Proceess the part element -->
				<xsl:apply-templates/>
				<!-- Insert punctuation following this part.  The particular punctuation inserted depends
				on the @localtype for the following part.-->
				<xsl:if
					test="
						following-sibling::ead:part[1][@localtype = 'v'] or following-sibling::ead:part[1][@localtype = 'x']
						or following-sibling::ead:part[1][@localtype = 'y'] or following-sibling::ead:part[1][@localtype = 'z']">
					<xsl:text>--</xsl:text>
				</xsl:if>
				<xsl:if test="following-sibling::ead:part[1][@localtype = 'b']">
					<xsl:text>.&#x20;</xsl:text>
				</xsl:if>
				<xsl:if test="following-sibling::ead:part[1][@localtype = 'q']">
					<xsl:text>&#x20;[</xsl:text>
				</xsl:if>
				<xsl:if test="following-sibling::ead:part[1][@localtype = 'd']">
					<xsl:text>,&#x20;</xsl:text>
				</xsl:if>
			</xsl:when>
			<!--When @localtype is a q, apply the template and insert a following square bracket.  -->
			<xsl:when test="@localtype = 'q'">
				<xsl:apply-templates/>
				<xsl:text>]&#x20;</xsl:text>
			</xsl:when>
			<!-- In all other cases such as when this part is the last child of 
			its parent, apply the template and add a following period and space. -->
			<xsl:otherwise>
				<xsl:apply-templates/>
				<xsl:text>.&#x20;</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ********** Section 13e.  Formats one or more phydescstructured elements in archdesc/did.   This named template 
		is called for physdesctructured element in section 3e for archdesc/did and in section 12m for component/did elements.********************************************-->
	<!--    This template does not attempt to process all conceivable scenarios with this element since so many encoding variations are possible.
		
					Several issues arise with this element.
					
					1.  With four possible values for @physdescstructured and two for @coverage, the number of possible variations in encoding is quite large
					2.  There is slim guidance in archival descriptive standards as to the proper way to display this information.
					3.  The author of this stylesheet does not believe that simply stating the number of boxes or cubic feet occupied is sufficiently 
							informative about the extent of the materials for most researcher.   
					4.	Some of terms used in statements of extent, e.g. cubic feet and linear feet, are as mysterious to most researchers as the expectation of library catalogers
							that users somehow understand that the initials s.n. stands for the Latin expression sine nomine.  This stylesheet attempts to clarify this situation for archival 
							descriptions by including text that hopefully more clearly explains the content.  If you do't like this approach, change or delete the text and/or insert punctuation as
							you feel best.-->
	<!--		This template concatenates one or more physdescstructred elements into a single text string. 
					It processes the first occurence of physdescstructured and then appends any subsequent physdescstructured elements.  Explanatory text is inseted before any subsequent 
					elements.  
					
					The template uses an xsl:choose element to select and transform one of three possible encoding scenarios, based on the value of the attribute physdescstructuredtype.
					
					1. when the first physdescstructured element has the @physdescstructuredtype value of "spaceoccupied", followed by a @physdescstructuredtype='carrier' 
							and/or physdescstructuredtype='materialtype' if either or both are present.
					2. when the first physdescstructured element has the @physdescstructuredtype value of "carrier", followed by a @physdescstructuredtype='spaceoccupied' 
							and/or a @physdescstructuredtype='materialtype' if either or both are present
							if they are present.
					3. when the first physdescstructured element has the @physdescstructuredtype value of "materialtype", followed by a @physdescstructuredtype='carrier' 
							and/or @physdescstructuredtype='spaceoccupied' if either or both they are present.-->

	<xsl:template name="concat-physdescstructured">
		<!-- Scenario 1: when the first physdescstructed element has the @physdescstructuredtype value of "spaceoccupied", optionally followed by 
			other physdesstructured elements that have @physdescstructuredtype='carrier' and/or @physdescstructuredtype='materialtype'. -->
		<xsl:choose>
			<xsl:when test="position() = 1 and ./@physdescstructuredtype = 'spaceoccupied'">
				<!-- Insert its quantity and type with a blank space between them-->
				<xsl:apply-templates select="ead:quantity"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="ead:unittype"/>
				<!-- If a subsequent physdescstructured element has the @physdescstructuredtype='carrier', insert the word "in" and a blank space,
				then its quantity and type with a blank space between them.-->
				<xsl:if
					test="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'carrier']">
					<xsl:text> in  </xsl:text>
					<xsl:apply-templates
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'carrier']/ead:quantity"/>
					<xsl:text>  </xsl:text>
					<xsl:apply-templates
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'carrier']/ead:unittype"
					/>
				</xsl:if>

				<!-- If a subsequent physdescstructured element has the @physdescstructuredtype='materialtype', insert the words "consisting of" and a blank space,
				then its quantity and type with a blank space between them.-->
				<xsl:if
					test="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'materialtype']">
					<xsl:text> and consisting of </xsl:text>
					<xsl:apply-templates
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'materialtype']/ead:quantity"/>
					<xsl:text>  </xsl:text>
					<xsl:apply-templates
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'materialtype']/ead:unittype"
					/>
				</xsl:if>
			</xsl:when>

			<!-- Scenario 2: When the first physdescstructed element has the @physdescstructuredtype="carrier", optionally followed by 
			other physdesstructured elements that have @physdescstructuredtype='spaceoccupied' and/or @physdescstructuredtype='materialtype'-->
			<xsl:when test="position() = 1 and ./@physdescstructuredtype = 'carrier'">
				<!-- Insert its quantity and type with a blank space between them-->
				<xsl:apply-templates select="ead:quantity"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="ead:unittype"/>
				<!-- If a subsequent physdescstructured element has the @physdescstructuredtype='spaceoccupied', insert the word "occupying" with blank spaces
					surrounding it,	then inset its quantity and type with a blank space between them.-->
				<xsl:if
					test="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'spaceoccupied']">
					<xsl:text> occupying </xsl:text>
					<xsl:apply-templates
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'spaceoccupied']/ead:quantity"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'spaceoccupied']/ead:unittype"
					/>
				</xsl:if>
				<!-- If a subsequent physdescstructured element has the @physdescstructuredype='materialtype', insert the words "and consisting of" with blank spaces
					surrounding it, then insert its quantity and type with a blank space between them.-->
				<xsl:if
					test="following-sibling::ead:physdescstructured/@physdescstructuredtype = 'materialtype'">
					<xsl:text> and consisting of </xsl:text>
					<xsl:apply-templates
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'materialtype']/ead:quantity"/>
					<xsl:text>  </xsl:text>
					<xsl:apply-templates
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'materialtype']/ead:unittype"
					/>
				</xsl:if>
			</xsl:when>

			<!-- Scenario 3 When the first physdescstructed element has the @physdescstructuredtype="materialtype", optionally followed by 
			other physdesstructured elements that have @physdescstructuredtype='carrier' and/or @physdescstructuredtype='spaceoccupied'-->
			<xsl:when test="position() = 1 and ./@physdescstructuredtype = 'materialtype'">
				<!-- Insert its quantity and type with a blank space between them-->
				<xsl:apply-templates select="ead:quantity"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="ead:unittype"/>
				<!-- If a subsequent physdescstructured element has the @physdescstructuredtype='carrier', insert the word "in" with blank spaces
					surrounding it,	then inset its quantity and type with a blank space between them.-->
				<xsl:if
					test="following-sibling::ead:physdescstructured[@physdescstructured = 'carrier']">
					<xsl:text> in </xsl:text>
					<xsl:apply-templates
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'carrier']/ead:quantity"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'carrier']/ead:unittype"/>
					<xsl:text> </xsl:text>
				</xsl:if>

				<!-- If a subsequent physdescstructured element has the @physdescstructuredtype='spaceoccupied', insert the word "occupying" with blank spaces
					surrounding it,	then inset its quantity and type with a blank space between them.-->
				<xsl:if
					test="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'spaceoccupied']">
					<xsl:text>  occupying </xsl:text>
					<xsl:apply-templates
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'spaceoccupied']/ead:quantity"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates
						select="following-sibling::ead:physdescstructured[@physdescstructuredtype = 'spaceoccupied']/ead:unittype"
					/>
				</xsl:if>
			</xsl:when>

			<xsl:otherwise>
				<!--By providing no transformation specifications, suppress additional physdescstructured elements in position 2 and 3 as they 
					have already been processed.-->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--********** Section 13f: Formats the dao element wherever it occurs. ******************************************************-->

	<xsl:template name="dao-generic">
		<img src="{@href}">
			<xsl:apply-templates select="self::ead:dao[not(child::ead:descriptivenote)]"/>
		</img>
	</xsl:template>

<!-- ********** Section 13g:.  Formats title and emph elemtents that have a @render attribute.************************************* -->
	<xsl:template match="ead:emph[@render = 'bold']">
		<b>
			<xsl:apply-templates/>
		</b>
	</xsl:template>
	<xsl:template match="ead:emph[@render = 'italic']">
		<i>
			<xsl:apply-templates/>
		</i>
	</xsl:template>
	<xsl:template match="ead:emph[@render = 'underline']">
		<u>
			<xsl:apply-templates/>
		</u>
	</xsl:template>
	<xsl:template match="ead:emph[@render = 'sub']">
		<sub>
			<xsl:apply-templates/>
		</sub>
	</xsl:template>
	<xsl:template match="ead:emph[@render = 'super']">
		<super>
			<xsl:apply-templates/>
		</super>
	</xsl:template>
	<xsl:template match="ead:emph[@render = 'quoted']">
		<xsl:text>"</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>"</xsl:text>
	</xsl:template>
	<xsl:template match="ead:emph[@render = 'doublequote']">
		<xsl:text>"</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>"</xsl:text>
	</xsl:template>
	<xsl:template match="ead:emph[@render = 'singlequote']">
		<xsl:text>'</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>'</xsl:text>
	</xsl:template>
	<xsl:template match="ead:emph[@render = 'bolddoublequote']">
		<b>
			<xsl:text>"</xsl:text>
			<xsl:apply-templates/>
			<xsl:text>"</xsl:text>
		</b>
	</xsl:template>
	<xsl:template match="ead:emph[@render = 'boldsinglequote']">
		<b>
			<xsl:text>'</xsl:text>
			<xsl:apply-templates/>
			<xsl:text>'</xsl:text>
		</b>
	</xsl:template>
	<xsl:template match="ead:emph[@render = 'boldunderline']">
		<b>
			<u>
				<xsl:apply-templates/>
			</u>
		</b>
	</xsl:template>
	<xsl:template match="ead:emph[@render = 'bolditalic']">
		<b>
			<i>
				<xsl:apply-templates/>
			</i>
		</b>
	</xsl:template>
	<xsl:template match="ead:emph[@render = 'boldsmcaps']">
		<b style="font-variant:small-caps">
			<xsl:apply-templates/>
		</b>
	</xsl:template>
	<xsl:template match="ead:emph[@render = 'smcaps']">
		<div style="font-variant:small-caps">
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	<xsl:template match="ead:title[@render = 'bold']">
		<b>
			<xsl:apply-templates/>
		</b>
	</xsl:template>
	<xsl:template match="ead:title[@render = 'italic']">
		<i>
			<xsl:apply-templates/>
		</i>
	</xsl:template>
	<xsl:template match="ead:title[@render = 'underline']">
		<u>
			<xsl:apply-templates/>
		</u>
	</xsl:template>
	<xsl:template match="ead:title[@render = 'sub']">
		<sub>
			<xsl:apply-templates/>
		</sub>
	</xsl:template>
	<xsl:template match="ead:title[@render = 'super']">
		<super>
			<xsl:apply-templates/>
		</super>
	</xsl:template>
	<xsl:template match="ead:title[@render = 'quoted']">
		<xsl:text>"</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>"</xsl:text>
	</xsl:template>
	<xsl:template match="ead:title[@render = 'doublequote']">
		<xsl:text>"</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>"</xsl:text>
	</xsl:template>
	<xsl:template match="ead:title[@render = 'singlequote']">
		<xsl:text>'</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>'</xsl:text>
	</xsl:template>
	<xsl:template match="ead:title[@render = 'bolddoublequote']">
		<b>
			<xsl:text>"</xsl:text>
			<xsl:apply-templates/>
			<xsl:text>"</xsl:text>
		</b>
	</xsl:template>
	<xsl:template match="ead:title[@render = 'boldsinglequote']">
		<b>
			<xsl:text>'</xsl:text>
			<xsl:apply-templates/>
			<xsl:text>'</xsl:text>
		</b>
	</xsl:template>
	<xsl:template match="ead:title[@render = 'boldunderline']">
		<b>
			<xsl:apply-templates/>
		</b>
	</xsl:template>
	<xsl:template match="ead:title[@render = 'bolditalic']">
		<b>
			<i>
				<xsl:apply-templates/>
			</i>
		</b>
	</xsl:template>

	<xsl:template match="ead:title[@render = 'boldsmcaps']">
		<b style="font-variant:small-caps">
			<xsl:apply-templates/>
		</b>
	</xsl:template>

	<xsl:template match="ead:title[@render = 'smcaps']">
		<div style="font-variant:small-caps">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<!-- ***********Section 13h:  Formats the ref element. -->
	<!-- This template converts a Ref element into an HTML anchor.-->

	<xsl:template match="ead:ref">
		<xsl:if test="self::ead:ref[@href]">
			<img src="#{@href}">
				<xsl:apply-templates/>
			</img>
		</xsl:if>
		<xsl:if test="self::ead:ref[@show = 'new']">
			<a href="{@href}">
				<xsl:apply-templates/>
			</a>
		</xsl:if>
		<xsl:if test="self::ead:ref[@target]">
			<a href="#{@target}">
				<xsl:apply-templates/>
			</a>
		</xsl:if>
	</xsl:template>


	<!--**********Section  13i:  Formats a list element everywhere except in arrangement.  List in <arrangement> 
		are handled in the template for <arrangement>.    ************************-->

	<!--The next two templates format the <head> and <p> of a list element wherever 
		it occurs.-->
	<xsl:template match="ead:list[parent::*[not(self::ead:arrangement)]]/ead:head">
		<div style="margin-left: 25pt">
			<b>
				<xsl:apply-templates/>
			</b>
		</div>
	</xsl:template>
	<xsl:template match="ead:list[parent::*[not(self::ead:arrangement)]]/ead:item">
		<div style="margin-left: 40pt">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<!--************Section 13j:  Formats a simple table.****-->
	<!--	The width of each column is defined by the colwidth attribute in a colspec element.-->
	<!--************Section 13j:  Formats a simple table.****-->


	<xsl:template match="ead:table">
		<table width="75%" style="margin-left: 25pt">
			<tr>
				<td coldiv="3">
					<h4>
						<xsl:apply-templates select="ead:head"/>
					</h4>
				</td>
			</tr>
			<xsl:for-each select="ead:tgroup">
				<tr>
					<xsl:for-each select="ead:colspec">
						<td width="{@colwidth}"/>
					</xsl:for-each>
				</tr>
				<xsl:for-each select="ead:thead">
					<xsl:for-each select="ead:row">
						<tr>
							<xsl:for-each select="ead:entry">
								<td valign="top">
									<b>
										<xsl:apply-templates/>
									</b>
								</td>
							</xsl:for-each>
						</tr>
					</xsl:for-each>
				</xsl:for-each>
				<xsl:for-each select="ead:tbody">
					<xsl:for-each select="ead:row">
						<tr>
							<xsl:for-each select="ead:entry">
								<td valign="top">
									<xsl:apply-templates/>
								</td>
							</xsl:for-each>
						</tr>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:for-each>
		</table>
	</xsl:template>

	<!-- ********** Section 13k:  Formats a chronlist element.   *********************************************************************-->

	<!-- ********** To accomodate the many variations that are possible in <chronlist>, this template has many 
	conditional if/then type statements.   They are heavily annotated both at the beginning of each conditional 
	statement but also at the end to mark the sections into logical segments.-->

	<xsl:template name="chronlist-generic">
		<table width="100%">
			<tr>
				<td width="20%"> </td>
				<td width="30%"> </td>
				<td width="50%"> </td>
			</tr>

			<xsl:for-each select="ead:head">
				<tr>
					<td colspan="3">
						<h4>
							<xsl:apply-templates/>
						</h4>
					</td>
				</tr>
			</xsl:for-each>
			<xsl:for-each select="ead:listhead">
				<tr>
					<td>
						<b>
							<xsl:apply-templates select="ead:head01"/>
						</b>
					</td>
					<td>
						<b>
							<xsl:apply-templates select="ead:head02"/>
						</b>
					</td>
					<td>
						<b>
							<xsl:apply-templates select="ead:head03"/>
						</b>
					</td>
				</tr>
			</xsl:for-each>

			<xsl:for-each select="ead:chronitem">

				<!-- Transform a chronitem that does not have a chronitemset child. -->
				<xsl:choose>
					<xsl:when test="not(child::ead:chronitemset)">
						<tr>
							<!-- Tests whether there is a single date or a daterange -->
							<xsl:choose>
								<!-- 	Transform single dates -->

								<xsl:when test="ead:datesingle">
									<td>
										<xsl:apply-templates select="ead:datesingle"/>
									</td>
								</xsl:when>
								<!-- Transform date ranges -->

								<xsl:when test="ead:daterange">
									<td>
										<xsl:apply-templates select="ead:daterange/ead:fromdate"/>
										<xsl:text>-</xsl:text>
										<xsl:apply-templates select="ead:daterange/ead:todate"/>
									</td>
								</xsl:when>
							</xsl:choose>
							<!-- Closes the test for single or range dates -->

							<!-- Adds the event and geogname children of this chronitem that has not chronitemsets -->
							<td>
								<xsl:apply-templates select="ead:event"/>
							</td>
							<td>
								<xsl:apply-templates select="ead:geogname"/>
							</td>
						</tr>
					</xsl:when>
					<!-- Closes the transformation of chronitems that have no chronitemset children -->

					<!-- Otherwise transform chronitems that have chronitemset children.   There are four possible 
					scenarios-->

					<!-- Begins the transformation of chronitems that have chronitemset children -->
					<xsl:when test="ead:chronitemset">


						<!-- Scenario 1: The chronitemset has one and only one event and one and only one geoganme, i.e. 
								the value of first and last event are the same and the value of the first and last geogname are the same. 
							This markup is used when a date is associated with more than one event and more than one geogname. -->

						<xsl:choose>
							<xsl:when test="ead:chronitemset[1] != ead:chronitemset[last()]">


								<tr>
									<xsl:choose>
										<!-- Tests for a single date or daterange -->

										<!-- 	Transform single dates -->
										<xsl:when test="ead:datesingle">
											<td>
												<xsl:apply-templates select="ead:datesingle"/>
											</td>
										</xsl:when>

										<!-- Transform date ranges -->
										<xsl:when test="ead:daterange">
											<td>
												<xsl:apply-templates
												select="ead:daterange/ead:fromdate"/>
												<xsl:text>-</xsl:text>
												<xsl:apply-templates
												select="ead:daterange/ead:todate"/>
											</td>
										</xsl:when>
									</xsl:choose>
									<!-- Closes the transformation of the date elements -->



									<!-- Transform the first chronitemset on one row. -->
									<td>
										<xsl:apply-templates select="ead:chronitemset[1]/ead:event"/>

									</td>
									<td>
										<xsl:apply-templates
											select="ead:chronitemset[1]/ead:geogname"/>
									</td>
								</tr>
								<!-- Closes the row with the first chronitemset -->

								<!-- Transform additional chronitemsets into additional rows -->
								<xsl:for-each select="ead:chronitemset[position() > 1]">
									<tr>
										<td/>
										<td>
											<xsl:apply-templates select="ead:event"/>
										</td>
										<td>
											<xsl:apply-templates select="ead:geogname"/>
										</td>
									</tr>
								</xsl:for-each>
								<!-- Ends the transformation of additional chronitemsets and ends Scenario 1 -->
							</xsl:when>


							<!-- Scenario 2 chronitemset has one and only one event and more than one geoganme, i.e.
								the value of the first and the value of the last event are the same (there is only one) and 
								the value of the first geogname is NOT the same as the value of the last geogname (there are more than one). -->

							<xsl:when
								test="ead:chronitemset/ead:event[1] = ead:chronitemset/ead:event[last()] and ead:chronitemset/ead:geogname[1] != ead:chronitemset/ead:geogname[last()]">
								<tr>
									<!-- Tests for a single date or daterange -->
									<xsl:choose>

										<!-- Transform single dates -->
										<xsl:when test="ead:datesingle">
											<td>
												<xsl:apply-templates select="ead:datesingle"/>
											</td>
										</xsl:when>

										<!-- Transform date ranges -->
										<xsl:when test="ead:daterange">
											<td>
												<xsl:apply-templates
												select="ead:daterange/ead:fromdate"/>
												<xsl:text>-</xsl:text>
												<xsl:apply-templates
												select="ead:daterange/ead:todate"/>
											</td>
										</xsl:when>
									</xsl:choose>
									<!-- Closes the transformation of dates -->

									<!-- Transforms the first event and first geogname children in the chronitemset  -->
									<td>
										<xsl:apply-templates select="ead:chronitemset/ead:event[1]"
										/>
									</td>
									<td>
										<xsl:apply-templates
											select="ead:chronitemset/ead:geogname[1]"/>
									</td>
								</tr>

								<!-- Transform each additional geogname element in the chronitemset into an additional row -->
								<xsl:for-each select="ead:chronitemset/ead:geogname[position() > 1]">
									<tr>
										<td/>
										<td/>
										<td>
											<xsl:apply-templates/>
										</td>
									</tr>
								</xsl:for-each>
								<!-- Ends the transformation of chronitemsets and ends Scenario 2. -->
							</xsl:when>

							<!-- Scenario 3: chronitem set has one and only one geogname and more than one event, i.e.
								the value of the first and the value of the last geogname are the same (there is only one) and 
								the value of the first event is NOT the same as the value of the last event (there are more than one).-->

							<xsl:when
								test="ead:chronitemset/ead:geogname[1] = ead:chronitemset/ead:geogname[last()] and ead:chronitemset/ead:event[1] != ead:chronitemset/ead:event[last()]">

								<!-- Opens a row -->
								<tr>

									<!-- Tests for a single date or daterange -->
									<xsl:choose>

										<!-- 	Transform single dates -->
										<xsl:when test="ead:datesingle">
											<td>
												<xsl:apply-templates select="ead:datesingle"/>
											</td>
										</xsl:when>

										<!-- Transform date ranges -->
										<xsl:when test="ead:daterange">
											<td>
												<xsl:apply-templates
												select="ead:daterange/ead:fromdate"/>
												<xsl:text>-</xsl:text>
												<xsl:apply-templates
												select="ead:daterange/ead:todate"/>
											</td>
										</xsl:when>

										<!-- Ends the transformation of date(s) -->
									</xsl:choose>

									<!-- Transforms the first event and first geogname in the chronitemset  -->
									<td>
										<xsl:apply-templates select="ead:chronitemset/ead:event[1]"
										/>
									</td>
									<td>
										<xsl:apply-templates select="ead:chronitemset/ead:geogname"
										/>
									</td>

									<!-- Closes the row -->
								</tr>
								<!-- Ends the transformation  of the first event and geogname element in this 
							 chronitemset.-->

								<!-- Transforms each additional event element in the chronitemset into an additional row -->
								<xsl:for-each select="ead:chronitemset/ead:event[position() > 1]">
									<tr>
										<td/>
										<td>
											<xsl:apply-templates/>
										</td>
										<td/>
									</tr>
								</xsl:for-each>

								<!--Ends scenario 3-->
							</xsl:when>

							<!-- Closes the transformation of chronitems with chronitemset children -->
						</xsl:choose>

						<!-- Ends for each chronitem -->
					</xsl:when>

					<!-- Closes the choice between chronitems that have chronitmset children and those that don't. -->
				</xsl:choose>

				<!-- Closes the transformation of each chronitem. -->
			</xsl:for-each>
		</table>
	</xsl:template>


	<!-- **** The following two named templates apply to all components.   This reduces the amount of code since manny of these elements display 
		the same at every level except for their horizontal position (indention) in the table created for each c01.  Positioning in the table is 
		controled by HTML table row and table data <td> elements. Empty <td> elements are used to position data horizontally on a given row.-->

	<!-- *Section 13l:  Formats basic did elements for all component levels.  **********************************************************	-->

	<!--This template formats the unitid, origination, unittitle,	unitdate, and physdesc elements of components at all levels.  It calls another named template 
		for physdescstructured which is included in this string if it appears in a component.  These elements are concatenated into a single text string and
		appear, along with any container elements,on a separate line from other did child elements in components.   This template is generic to all component levels.-->
	<xsl:template name="component-did">
		<!--Inserts unitid and a space if it exists in the markup.-->
		<xsl:if test="ead:unitid">
			<xsl:apply-templates select="ead:unitid"/>
			<xsl:text>&#x20;.</xsl:text>
		</xsl:if>
		<xsl:if test="ead:unittitle">
			<xsl:choose>
				<xsl:when
					test="ead:unittitle[following-sibling::ead:unitdate or following-sibling::ead:unitdatestructured]">
					<xsl:apply-templates select="ead:unittitle"/>
					<xsl:text>,&#x20;</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="ead:unittitle"/>
					<xsl:text>.&#x20;</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="ead:unitdate">
			<xsl:apply-templates select="ead:unitdate"/>
			<xsl:text>.&#x20;&#x20;</xsl:text>
		</xsl:if>
		<xsl:if test="ead:unitdatestructured">
			<xsl:call-template name="unitdatedstructured-common"/>
		</xsl:if>
	</xsl:template>

	<!-- ********* Section: 13m:    Shared formating of unitdatestructured in several contexts. **************************-->
	<!-- *******  This named template formats unitdatestructured in both archdesc/did and component/did elements.*********** 
				It is called by the immediately preceding named template "component-did" (Section 13l) which transforms 
				unitdatestructured in components and by the template (Section 3d) which transforms unitdatestructured 
				in archdesc/did.-->

	<xsl:template name="unitdatedstructured-common">
		<!--   	Some fancy footwork with punctuation around the presence or absence of dateset and the order of datesingle and daterange elements.
			Results may vary.  This template sorts datesingle and fromdate elements into a single chronological order if they 
			are not already and supplies separating puncuation.-->

		<!-- There are two possibilities in encoding with the unitdatestructured element: 
			1.  when dateset is used as a child of unitdatestructured, wrapping datesingle and/or daterange elements
				into a set.
			2.  when dateset is not used and there one or more datesingle elements OR one or 
				more daterange elements that are the direct children of unitdatestructured
						-->
		<!-- Scenario 1: When dateset is used as a wrapper.-->
		<xsl:choose>
			<xsl:when test="ead:dateset">

				<!-- Arranges the dates in chronological order if they are not already.-->
				<xsl:for-each
					select="ead:dateset/ead:datesingle | ead:dateset/ead:daterange/ead:fromdate">
					<xsl:sort select="." data-type="number"/>
					<xsl:value-of select="."/>

					<!-- Inserts a dash between fromdate and todate elements. -->
					<xsl:if test="self::ead:fromdate">
						<xsl:text>-</xsl:text>
						<xsl:value-of select="following-sibling::ead:todate"/>
					</xsl:if>

					<!--Inserts a comma between dates and dateranges and inserts a period following the last date.  -->
					<xsl:choose>
						<xsl:when test="position() != last()">
							<xsl:text>,&#x20;</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>.</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:when>

			<!-- Scenario 2:    When unitdatestructured does not have a dateset child. 
					Unitdatestructured may have either datesingle OR daterange
					elements as children but not a mixture of both.-->

			<xsl:otherwise>
				<!-- Arranges the dates in chronological order if they are not already. -->
				<xsl:for-each select="ead:datesingle | ead:daterange/ead:fromdate">
					<xsl:sort select="." data-type="number"/>
					<xsl:value-of select="."/>

					<!-- Inserts a dash between fromdate and todate elements. -->
					<xsl:if test="self::ead:fromdate">
						<xsl:text>-</xsl:text>
						<xsl:value-of select="following-sibling::ead:todate"/>
					</xsl:if>

					<!--Inserts a comma between dates and dateranges and inserts a period following the last date.  -->
					<xsl:choose>
						<xsl:when test="position() != last()">
							<xsl:text>,&#x20;</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>.</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--  *********Section 13n:   Transforms container elements and determines their display *********************************************************************-->
	<!--			This template determines whether column display heads like Box and Folder appear and whether unique first containers 
					are displayed or suppressed. For an alternative approach based the values of the 
					@localtype attribute rather than the position of the <container> elements, see 
					the "commented out" template that follows this one.-->

	<xsl:template name="container-display">
		<xsl:choose>
			<xsl:when test="ead:container[1] = ../parent/preceding::did[1]/ead:did/ead:container[1]">
				<tr>
					<td/>
					<td> </td>
					<td colspan="18">
						<xsl:call-template name="component-did"/>
					</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr>
					<td>
						<b>
							<xsl:text>Box</xsl:text>
						</b>
					</td>
					<td>
						<b>
							<xsl:text>Folder</xsl:text>
						</b>
					</td>
				</tr>
				<tr>
					<td>
						<xsl:value-of select="ead:container[1]"/>
					</td>
					<td>
						<xsl:value-of select="ead:container[2]"/>
					</td>
					<td colspan="18">
						<xsl:call-template name="component-did"/>
					</td>

				</tr>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


    

</xsl:stylesheet>

