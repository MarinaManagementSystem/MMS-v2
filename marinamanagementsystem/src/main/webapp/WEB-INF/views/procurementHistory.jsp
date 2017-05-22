<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" import="java.io.*, java.util.*, java.util.Date" pageEncoding="UTF-8" %>
<%@include file="../includes/springTagLibraries.jsp"%>

<html>

<head>

    <title>Procurement History - <fmt:message key="label.application.title"/></title>
    
	<%@include file="../includes/commonMeta.jsp"%>
	<%@include file="../includes/commonStyles.jsp"%>
	<%@include file="../includes/commonScripts.jsp"%>
	
<script type="text/javascript">
	
	function checkDateAndTimeValues()
	{
		/*
		if(document.getElementById("hiddenDateIntervalForPlot").value == "checked")
		{
			alert(document.getElementById('startOfDateForPlot').value);
			alert(document.getElementById('endOfDateForPlot').value);
			var startOfDateForPlot = document.getElementById('hiddenStartOfDateForPlot').value;
			var endOfDateForPlot = document.getElementById('hiddenEndOfDateForPlot').value;
			
			alert(startOfDateForPlot);
			alert(endOfDateForPlot);
			
			if(startOfDateForPlot > endOfDateForPlot)
			{
				alert("Start Date should be less than or equal to End Date!");
				return false;
			}
		}
		if(document.getElementById("hiddenDateAndTimeTogetherForPlot").value == "checked")
		{
			
			var fromDateForPlot = new Date(document.getElementById('hiddenFromDateForPlot').value);
			var toDateForPlot = new Date(document.getElementById('hiddenToDateForPlot').value);
			
			if(fromDateForPlot > toDateForPlot)
			{
				alert("From Date should be less than or equal to To Date!");
				return false;
			}
		}
		return true;
		*/
		return true;
	}
	
	function formatDate(d)
	{
	    var month = d.getMonth();
	    var day = d.getDate();
	    month = month + 1;

	    month = month + "";

	    if (month.length == 1)
	    {
	        month = "0" + month;
	    }

	    day = day + "";

	    if (day.length == 1)
	    {
	        day = "0" + day;
	    }

	    return day + '.' + month + '.' + d.getFullYear();
	}
	
</script>

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
			
			<h2>Procurement History</h2>
			<p style="font-size: 15px;">In order to view the procurement history, please specifcy a date range accordingly and submit. If you directly hit the sumit button, all data stored in the database from the beginning of this year will be retrieved.</p>
			<br/> 
					<form action="procurementHistory" id="procurementHistoryFilterForm" name="procurementHistoryFilterForm" method="get" onsubmit="return checkDateAndTimeValues();">
						<table align="center" width="100%" style="table-layout: fixed;">
							<tr>
								<td align="right" style="vertical-align:top" width="300px;">
									<h4 class="hr-left uppercase">Date Range:</h4>
									<p><i>Please select the date range you want to filter. Invoices generated between these dates will be fetched from the database.</i></p>
								</td>
								<td width="25px;">
									<!-- Empty column -->
								</td>
								<td>
									<table>
										<tr>
											<td>
												<table>
													<tr>
														<td>
															Start Date:
														</td>
														<td width="10px;">
															<!-- Empty column -->
														</td>
														<td>
															<!-- Please check the resources/assets/datetimepicker/dateTimePickerForETS.js by searching fromDate to see the date picker details -->
															<input type="text" value="<% if(request.getParameter("fromDate") != null) { out.print(request.getParameter("fromDate")); } else { out.print("01.01."+year); } %>" name="fromDate" id="fromDate" class="form-control input-sm" tabindex="1" />
														</td>
													</tr>
													<tr>
														<td>
															End Date:
														</td>
														<td width="10px;">
															<!-- Empty column -->
														</td>
														<td>
															<!-- Please check the resources/assets/datetimepicker/dateTimePickerForETS.js by searching toDate to see the date picker details -->
															<input type="text" value="<% if(request.getParameter("toDate") != null) { out.print(request.getParameter("toDate")); } else { out.print(decimalFormatter.format(day)+"."+decimalFormatter.format(month)+"."+year); } %>" name="toDate" id="toDate" class="form-control input-sm" tabindex="2" />
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td align="right">
									<!-- Empty column -->
								</td>
								<td width="25px;">
									<!-- Empty column -->
								</td>
								<td align="left">
									<input class="btn btn-default" name="submit" id="submit" tabindex="522" value="Submit" type="submit" tabindex="13">
									<input type="hidden" name="hiddenFromDate" id="hiddenFromDate" value="" />
									<input type="hidden" name="hiddenToDate" id="hiddenToDate" value="" />
									<input type="hidden" name="submitCount" id="submitCount" value="<% if(request.getParameter("submitCount") != null) { out.print(request.getParameter("submitCount")); } else { out.print("0"); } %>" />
								</td>
							</tr>
						</table>
					</form>
				
					<br/><br/>
					

			        <table class="table table-hover" style="overflow:scroll;height:80px;width:100%;overflow:auto">
			            <thead>
			            <tr style="background-color:#4A4744; table-layout:fixed">
			                <th><span style="color:white;">Invoice ID</span></th>
			                <th><span style="color:white;">Invoice Date</span></th>
			                <th><span style="color:white;">Related Yacht Name</span></th>
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
			            	                <fmt:formatDate pattern = "dd-MM-yyyy" value = "${invoice.cutOffDate.time}" />
			            	                	
			            					</td>
			            	                <td style="border: 2px solid #DDDDDD;">
			            	                	${invoice.yacht.name}
			            					</td>
			            	                <td style="border: 2px solid #DDDDDD;">
			            	                	${invoice.consumption}
			            					</td>
			            	                <td style="border: 2px solid #DDDDDD;">
			            	                	<a class="btn btn-sm btn-border" href="consumptions?yacht_id=${invoice.yacht.id}" target="_blank">Consumptions</a>
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
			        
	    </div>
	</div>
	<!-- / section -->
	<%@include file="../includes/footer.jsp"%>
	
</body>

<%@include file="../includes/closingDivTagsForMobileViews.jsp"%>

</html>