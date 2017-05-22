<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" import="java.io.*, java.util.*, java.util.Date" pageEncoding="UTF-8" %>
<%@include file="../includes/springTagLibraries.jsp"%>

<html>

<head>

    <title>Consumptions - <fmt:message key="label.application.title"/></title>
    
	<%@include file="../includes/commonMeta.jsp"%>
	<%@include file="../includes/commonStyles.jsp"%>
	<%@include file="../includes/commonScripts.jsp"%>

</head>

<%@include file="../includes/openingDivTagsForMobileViews.jsp"%>

<body class="withAnimation">

	<%@include file="../includes/header.jsp"%>

	<!--  section icon box -->
	<div class="grey content-area" id="iconbuttons" style="background-color: white;">
	    <div class="container">
	    
		    <%
			// If the viewing device is not mobile, then put some line breaks
			if(session.getAttribute("isMobile").toString().equalsIgnoreCase("false"))
			{
		  		%>
		    		<br/><br/><br/>
		    	<%
			}
		    %>
			
			<h2>Consumptions</h2>
			<p style="font-size: 15px;">Consumption details for the invoce ID #${invoiceId} are listed below.</p>
			<br/> 
				
					<br/><br/>
					
					<% /* Check if the page is supplied with the invoceId parameter */ 
					if (request.getParameter("invoiceId") != null) { %>

			        <table class="table table-hover" style="overflow:scroll;height:80px;width:100%;overflow:auto">
			            <thead>
			            <tr style="background-color:#4A4744; table-layout:fixed">
			                <th><span style="color:white;">Invoice ID</span></th>
			                <th><span style="color:white;">Related Yacht Name</span></th>
			                <th><span style="color:white;">Service Name</span></th>
			                <th><span style="color:white;">Service Cost</span></th>
			                <th><span style="color:white;">Date of the Bill</span></th>
			            </tr>
			            </thead>
			            
			            <tbody>
							<c:choose>
								<c:when test="${!empty foundConsumptions}">
									<c:forEach items="${foundConsumptions}" var="consumption">
			            	            <tr>
			            	                <td style="border: 2px solid #DDDDDD;">
			            	                	${consumption[0]}
			            					</td>
			            	                <td style="border: 2px solid #DDDDDD;">
			            	                	${consumption[2]}
			            					</td>
			            	                <td style="border: 2px solid #DDDDDD;">
			            	                	${consumption[5]}
			            					</td>
			            	                <td style="border: 2px solid #DDDDDD;">
			            	                	${consumption[7]}
			            					</td>
			            	                <td style="border: 2px solid #DDDDDD;">
			            	                	${consumption[6]}
			            					</td>
			            				</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="5" style="border: 2px solid #DDDDDD; height:190px; vertical-align:middle">No data found!</td>
									</tr>
								</c:otherwise>
							</c:choose>
			            </tbody>
			            <tfoot>
			            	<c:forEach items="${listService }" var="service">
			            	<tr>
			            		<td>${service.name }</td>
			            	</tr>
			            	<tr>
			            		<td>${service.status }</td>
			            	</tr>
			            	<tr>
			            		<td>${service.id }</td>
			            	</tr>
			            	</c:forEach>
			            </tfoot>
			        </table>
			        
					<% } %>
			        
	    </div>
	</div>
	<!-- / section -->
	<%@include file="../includes/footer.jsp"%>
	
</body>

<%@include file="../includes/closingDivTagsForMobileViews.jsp"%>

</html>