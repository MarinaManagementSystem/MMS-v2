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
					    
			<%  
				String browser = request.getHeader("User-Agent");
				boolean isChrome = (browser != null && browser.indexOf("Chrome/") != -1);
			    int year = Calendar.getInstance().get(Calendar.YEAR);
			    int month = Calendar.getInstance().get(Calendar.MONTH);
			    int day = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
			    
			    month++;
			    
			    int hour = Calendar.getInstance().get(Calendar.HOUR_OF_DAY);
			    int minutes = Calendar.getInstance().get(Calendar.MINUTE);
			    
			    DecimalFormat decimalFormatter = new DecimalFormat("00");
			    
			    if(request.getParameter("fromDate") != null && request.getParameter("toDate") != null) {
			    	
			    }
			
			%>
			
			<h2>Consumptions</h2>
			<p style="font-size: 15px;">Consumption details for the invoce id # ... are listed below.</p>
			<br/> 
				
					<br/><br/>
					
					<% if (request.getParameter("submitCount") != null && Integer.parseInt(request.getParameter("submitCount")) >= 1) { %>

			        <table class="table table-hover" style="overflow:scroll;height:80px;width:100%;overflow:auto">
			            <thead>
			            <tr style="background-color:#4A4744; table-layout:fixed">
			                <th><span style="color:white;">Invoice ID</span></th>
			                <th><span style="color:white;">Related Yacht ID</span></th>
			                <th><span style="color:white;">Invoice Total</span></th>
			                <th><span style="color:white;">Consumptions</span></th>
			            </tr>
			            </thead>
			            
			            <tbody>
							<c:choose>
								<c:when test="${!empty foundInvoices}">
									<c:forEach items="${foundInvoices}" var="invoice">
			            	            <tr>
			            	                <td style="border: 2px solid #DDDDDD;">
			            	                	${invoice.id}
			            					</td>
			            	                <td style="border: 2px solid #DDDDDD;">
			            	                	${invoice.yacht_id}
			            					</td>
			            	                <td style="border: 2px solid #DDDDDD;">
			            	                	${invoice.consumption}
			            					</td>
			            	                <td style="border: 2px solid #DDDDDD;">
			            	                	<a class="btn btn-sm btn-border" href="consumptions?yacht_id=${invoice.yacht_id}" target="_blank">Consumptions</a>
			            					</td>
			            				</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="4" style="border: 2px solid #DDDDDD; height:190px; vertical-align:middle">No data found!</td>
									</tr>
								</c:otherwise>
							</c:choose>
			            </tbody>
			        </table>
			        
			        <% } %>
	    </div>
	</div>
	<!-- / section -->
	<%@include file="../includes/footer.jsp"%>
	
</body>

<%@include file="../includes/closingDivTagsForMobileViews.jsp"%>

</html>