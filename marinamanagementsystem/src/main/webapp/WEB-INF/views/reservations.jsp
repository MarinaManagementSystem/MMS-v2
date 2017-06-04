<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" import="java.io.*, java.util.*, java.util.Date" pageEncoding="UTF-8" %>
<%@include file="../includes/springTagLibraries.jsp"%>

<html>

<head>

    <title>Reservations - <fmt:message key="label.application.title"/></title>
    
	<%@include file="../includes/commonMeta.jsp"%>
	<%@include file="../includes/commonStyles.jsp"%>
	<%@include file="../includes/commonScripts.jsp"%>
	
<script type="text/javascript">

	$(document).ready(function(){
	
	<c:choose>
		<c:when test="${!empty reservationStatusChangeAlert && reservationStatusChangeAlert != null && reservationStatusChangeAlert == 1}">
			$('.savedChangesAlertDiv').show();
		</c:when>
		<c:otherwise>
			$('.savedChangesAlertDiv').hide();
		</c:otherwise>
	</c:choose>
	
	
	});
	
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
	
	function editReservationStatus(reservationId, reservationStatus){
		
		if (confirm("Are you sure you want to change reservation status?") == true) {
			location.href="editReservationStatus?reservationId="+reservationId+"&reservationStatus="+reservationStatus;
	    	return true;
	    } else 
	        return false;
		
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
			
			<div class="alert alert-success alert-dismissable savedChangesAlertDiv">
				<strong>You have saved your changes successfully</strong>
			</div>
			
			<h2>Reservations</h2>
			<p style="font-size: 15px;">In order to view the reservations, please specify a date range accordingly and submit. If you directly hit the sumit button, all data stored in the database from the beginning of this year will be retrieved.</p>
			<br/> 
					<form action="reservations" id="reservationsFilterForm" name="reservationsFilterForm" method="get" onsubmit="return checkDateAndTimeValues();">
						<table align="center" width="100%" style="table-layout: fixed;">
							<tr>
								<td align="right" style="vertical-align:top" width="300px;">
									<h4 class="hr-left uppercase">Date Range:</h4>
									<p><i>Please select the date range you want to filter. Reservations made or completed between these dates will be fetched from the database.</i></p>
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
					
					<c:if test="${submitCount > 0}">
				        <table class="table table-hover" style="overflow:scroll;height:80px;width:100%;overflow:auto">
				            <thead>
				            <tr style="background-color:#4A4744; table-layout:fixed">
			                	<sec:authorize access="hasAnyRole('ROLE_MARINA_OWNER') or hasAnyRole('ROLE_YACHT_OWNER')">
				                	<th><span style="color:white;">Options</span></th>
				                </sec:authorize>
				                <th><span style="color:white;">Reservation Status</span></th>
				                <th><span style="color:white;">Reservation ID</span></th>
				                <th><span style="color:white;">Reservation Start Date</span></th>
				                <th><span style="color:white;">Reservation End Date</span></th>
				                <th><span style="color:white;">Related Yacht Name</span></th>
				                <th><span style="color:white;">Related Berth Name</span></th>
				                <th><span style="color:white;">Related Marina Name</span></th>
				            </tr>
				            </thead>
				            
				            <tbody>
								<c:choose>
									<c:when test="${!empty foundReservations}">
										<c:forEach items="${foundReservations}" var="reservation">
				            	            <tr>
					            	            <td style="border: 2px solid #DDDDDD;">
				            	            	<c:if test="${reservation[8] == 1}">
				                					<sec:authorize access="hasAnyRole('ROLE_MARINA_OWNER') or hasAnyRole('ROLE_YACHT_OWNER')">
				                						<sec:authorize access="hasAnyRole('ROLE_YACHT_OWNER')">
						            	                	<c:if test="${reservation[7] == reservationStatsuAppliedInt}">
					                							<a title="Cancel" class="btn btn-sm btn-danger" href="javascript:void(0)" onclick="editReservationStatus('${reservation[0]}', '${reservationStatsuCanceledInt}')">
					                								<i title="Cancel" class="fa fa-fw fa-scissors"></i>
					                							</a>
						            	                	</c:if>
				                						</sec:authorize>
				                						<sec:authorize access="hasAnyRole('ROLE_MARINA_OWNER')">
				                							<c:choose>
							            	                	<c:when test="${reservation[7] == reservationStatsuAppliedInt}">
						                							<a title="Approve" class="btn btn-sm btn-success" href="javascript:void(0)" onclick="editReservationStatus('${reservation[0]}', '${reservationStatsuApprovedInt}')">
						                								<i title="Approve" class="fa fa-fw fa-chevron-right"></i>
						                							</a>
						                							<a title="Reject" class="btn btn-sm btn-danger" href="javascript:void(0)" onclick="editReservationStatus('${reservation[0]}', '${reservationStatsuRejectedInt}')">
						                								<i title="Reject" class="fa fa-fw fa-scissors"></i>
						                							</a>
							            	                	</c:when>
							            	                	<c:when test="${reservation[7] == reservationStatsuApprovedInt}">
						                							<a title="Reject" class="btn btn-sm btn-danger" href="javascript:void(0)" onclick="editReservationStatus('${reservation[0]}', '${reservationStatsuRejectedInt}')">
						                								<i title="Reject" class="fa fa-fw fa-scissors"></i>
						                							</a>
							            	                	</c:when>
							            	                	<c:when test="${reservation[7] == reservationStatsuRejectedInt}">
						                							<a title="Approve" class="btn btn-sm btn-success" href="javascript:void(0)" onclick="editReservationStatus('${reservation[0]}', '${reservationStatsuApprovedInt}')">
						                								<i title="Approve" class="fa fa-fw fa-chevron-right"></i>
						                							</a>
							            	                	</c:when>
				                							</c:choose>
				                						</sec:authorize>
						            				</sec:authorize>
					            				</c:if>
					            				</td>
				            	                <td style="border: 2px solid #DDDDDD;">
					            	                <c:choose>
					            	                	<c:when test="${reservation[1] == 1}">
															<c:set var="statusStr" value="Active" scope="request"/>
					            	                	</c:when>
					            	                	<c:otherwise>
															<c:set var="statusStr" value="Passive" scope="request"/>
					            	                	</c:otherwise>
					            	                </c:choose>
					            	                <c:choose>
					            	                	<c:when test="${reservation[7] == reservationStatsuAppliedInt}">
															<c:set var="reservationStatusStr" value="Applied" scope="request"/>
					            	                	</c:when>
					            	                	<c:when test="${reservation[7] == reservationStatsuApprovedInt}">
															<c:set var="reservationStatusStr" value="Approved" scope="request"/>
					            	                	</c:when>
					            	                	<c:when test="${reservation[7] == reservationStatsuCanceledInt}">
															<c:set var="reservationStatusStr" value="Canceled" scope="request"/>
					            	                	</c:when>
					            	                	<c:when test="${reservation[7] == reservationStatsuRejectedInt}">
															<c:set var="reservationStatusStr" value="Rejected" scope="request"/>
					            	                	</c:when>
					            	                </c:choose>
					            	                ${reservationStatusStr} - ${statusStr}
				            					</td>
				            	                <td style="border: 2px solid #DDDDDD;">
				            	                	${reservation[0]}
				            					</td>
				            	                <td style="border: 2px solid #DDDDDD;">
				            	                	${reservation[2]}
				            					</td>
				            	                <td style="border: 2px solid #DDDDDD;">
				            	                	${reservation[3]}
				            					</td>
				            	                <td style="border: 2px solid #DDDDDD;">
				            	                	${reservation[4]}
				            					</td>
				            	                <td style="border: 2px solid #DDDDDD;">
				            	                	${reservation[5]}
				            					</td>
				            	                <td style="border: 2px solid #DDDDDD;">
				            	                	${reservation[6]}
				            					</td>
				            				</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="7" style="border: 2px solid #DDDDDD; height:190px; vertical-align:middle">No data found!</td>
										</tr>
									</c:otherwise>
								</c:choose>
				            </tbody>
				        </table>
					</c:if>
			        
	    </div>
	</div>
	<!-- / section -->
	<%@include file="../includes/footer.jsp"%>
	
</body>

<%@include file="../includes/closingDivTagsForMobileViews.jsp"%>

</html>