<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page session="true"%>
<%@ page contentType="text/html; charset=UTF-8"
	import="java.io.*, java.util.*, java.util.Date, java.text.*"
	pageEncoding="UTF-8"%>
<%@include file="../includes/springTagLibraries.jsp"%>

<html>

<head>

<title><fmt:message key="label.application.title" /></title>
<link rel="stylesheet"
	href="../resources/assets/css/AdvanceSearchDropDownMenu.css"></link>
<%@include file="../includes/commonMeta.jsp"%>
<%@include file="../includes/commonStyles.jsp"%>
<%@include file="../includes/commonScripts.jsp"%>
<script src="../resources/js/markerclusterer.js"></script>


<script type="text/javascript"
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDkK3LRevjeZz0nrdm5k6tKX0EBihlS5jo&sensor=false"></script>
<script type="text/javascript">
    window.onload = function () {
        var mapOptions = {
            //give latitude and long
            //40.977206, 29.036826
            center: new google.maps.LatLng("40.974262", "29.036456"),
            zoom: 15,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };

        var infoWindow = new google.maps.InfoWindow();
        var map = new google.maps.Map(document.getElementById("dvMap"), mapOptions);

        var locations = [];
        <c:forEach items="${listBerth}" var="berth">
        		locations.push({lat: ${berth.latitude}, lng: ${berth.longitude}});
        </c:forEach>
        
        
        var markers = locations.map(function(location, i) {
        	
            return new google.maps.Marker({
              position: location,
              //label: "" + i,
              icon: 'http://maps.google.com/mapfiles/ms/icons/green-dot.png' 
            });
          });
        
        var markerCluster = new MarkerClusterer(map, markers,
                {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
        
//         "marker <strong>content</strong> <span style=\"font-size: 30px;\">here</span>";
        for (i = 0; i < markers.length; i++)
       	{
        	<c:forEach items="${listBerth}" var="berth">
    		   if(${berth.status} == false && ${berth.id} == (i+1))
    			   {
    			   		markers[i].setIcon('http://maps.google.com/mapfiles/ms/icons/red-dot.png');
    			   }
   			 </c:forEach>

   			 <c:choose>
   			 	<c:when test="${!empty hFromDate && !empty hToDate}">
	   	       		google.maps.event.addListener(markers[i], 'click', function () {
	   	                var markerContent = '<b>Name</b>: <span style=\"font-style: italic\">${listBerth.get(i).name}</span></br>' + 
	   	                '<b>Status: </b>';
						<c:choose>
							<c:when test="${listBerth.get(i).getStatus() == true}">
								markerContent += '<span style=\"color: darkgreen\">Berth is operationable</span>';
							</c:when>
							<c:otherwise>
								markerContent += '<span style=\"color: darkgreen\">Berth is non-operationable</span>';
							</c:otherwise>
						</c:choose>
	   	                markerContent += '</br>' +
	   					'<b>Electricity Capacity</b>: ${listBerth.get(i).getElectricityCapacity() } kW/h</br>'+
	   					'<b>Water Capacity:</b> ${listBerth.get(i).getWaterCapacity() } gallons/h</br>'+
	   					'<b>Fuel Capacity:</b> ${listBerth.get(i).getFuelCapacity() } gallons/h</br>'+
	   					'<b>Length:</b> ${listBerth.get(i).getMinLength()}m - ${listBerth.get(i).getMaxLength()}m </br> '+
	   					'<b>Width:</b> ${listBerth.get(i).minWidth}m - ${listBerth.get(i).maxWidth}m </br>' +
	   					'<input type="button" class="btn btn-success" id="btnAdd" value="Reserve" onClick="openReservationPage(${listBerth.get(i).id})">';
	   	                infoWindow.setContent(markerContent);
	   	                infoWindow.open(map, this);
	   	            });
   			 	</c:when>
   			 	<c:otherwise>
	   	       		google.maps.event.addListener(markers[i], 'click', function () {
	   	                var markerContent = '<b>Name</b>: <span style=\"font-style: italic\">${listBerth.get(i).name}</span></br>' + 
	   	                '<b>Status: </b>';
						<c:choose>
							<c:when test="${listBerth.get(i).getStatus() == true}">
								markerContent += '<span style=\"color: darkgreen\">Berth is operationable</span>';
							</c:when>
							<c:otherwise>
								markerContent += '<span style=\"color: darkgreen\">Berth is non-operationable</span>';
							</c:otherwise>
						</c:choose>
	   	                markerContent += '</br>' +
	   					'<b>Electricity Capacity</b>: ${listBerth.get(i).getElectricityCapacity() } kW/h</br>'+
	   					'<b>Water Capacity:</b> ${listBerth.get(i).getWaterCapacity() } gallons/h</br>'+
	   					'<b>Fuel Capacity:</b> ${listBerth.get(i).getFuelCapacity() } gallons/h</br>'+
	   					'<b>Length:</b> ${listBerth.get(i).getMinLength()}m - ${listBerth.get(i).getMaxLength()}m </br> '+
	   					'<b>Width:</b> ${listBerth.get(i).minWidth}m - ${listBerth.get(i).maxWidth}m </br>' +
	   					' ';
	   	                infoWindow.setContent(markerContent);
	   	                infoWindow.open(map, this);
	   	            });
   			 	</c:otherwise>
   			 </c:choose>
       	}
        
        $(function(){
        	$("table tr").click(function(){
        	    //alert (this.rowIndex);
        	    var index = this.rowIndex;
        	    
        	    google.maps.event.trigger(markers[index], "click", {});
            	map.setCenter(markers[index].getPosition());
            	map.setZoom(18);
        	});
        	});
        
        
        
		var x = 1;
		
		<c:choose>
			<c:when test="${reservationInfoAlert != null && reservationInfoAlert == 0}">
				$('.reservationInfoAlertWaitingDiv').show();
				$('.reservationInfoAlertDiv').hide();
			</c:when>
			<c:when test="${reservationInfoAlert != null && reservationInfoAlert == 1}">
			$('.reservationInfoAlertWaitingDiv').hide();
				$('.reservationInfoAlertDiv').show();
			</c:when>
			<c:otherwise>
				$('.reservationInfoAlertWaitingDiv').hide();
				$('.reservationInfoAlertDiv').hide();
			</c:otherwise>
		</c:choose>
    }
</script>

<script>
function openReservationPage(berthId) {
	
	var fromDate = '${hFromDate}';
	var toDate = '${hToDate}';
	
	if(fromDate != null && fromDate != '' && toDate != null && toDate != '')
		location.href = "makeReservation?berthId="+berthId+"&fromDate="+fromDate+"&toDate="+toDate;
	else
		location.href = "makeReservation?berthId="+berthId;
	}

</script>


<script type="text/javascript">
// When the user clicks on the button, 
// toggle between hiding and showing the dropdown content
function myFunction() {
    document.getElementById("myDropdown").classList.toggle("show");
}

// Close the dropdown menu if the user clicks outside of it
window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {

    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}
</script>

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

	<%
		String browser = request.getHeader("User-Agent");
		boolean isChrome = (browser != null && browser.indexOf("Chrome/") != -1);
		int year = Calendar.getInstance().get(Calendar.YEAR);
		int month = Calendar.getInstance().get(Calendar.MONTH);
		int day = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
		
		Calendar twoMonthsLater = Calendar.getInstance();
		twoMonthsLater.add(Calendar.MONTH, 3);
		
		int twoMonthsLaterYear = twoMonthsLater.get(Calendar.YEAR);
		int twoMonthsLaterMonth = twoMonthsLater.get(Calendar.MONTH);
		int twoMonthsLaterDay = twoMonthsLater.get(Calendar.DAY_OF_MONTH);

		month++;

		int hour = Calendar.getInstance().get(Calendar.HOUR_OF_DAY);
		int minutes = Calendar.getInstance().get(Calendar.MINUTE);

		DecimalFormat decimalFormatter = new DecimalFormat("00");

		if (request.getParameter("fromDate") != null && request.getParameter("toDate") != null) {

		}
	%>

	<br />
	<br />
	<div id="boxedWrapper" class="snap-content">
		<div class="grey content-area" id="iconbuttons"
			style="background-color: #FBFBFB;">
			<div class="container">
				<br/><br/>
				<button type="button" class="btn btn-primary btn-lg"
					data-toggle="modal" data-target="#myModal">Advanced Search
				</button>
				<br/><br/>
				<!-- Modal -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<form action="marinaStatus" id="marinaStatusFilterForm"
								name="marinaStatusFilterForm" method="get">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
									<h4 class="modal-title" id="myModalLabel">
										<strong>Search for Available Berths to Make a Reservation</strong>
									</h4>
								</div>
								<div class="modal-body">
									<table align="center" width="100%" style="table-layout: fixed;">
										<tr>
											<td>From Date:</td>
											<td><input type="text"
												value="<%if (request.getParameter("fromDateWithMinDayLimit") != null) {
				out.print(request.getParameter("fromDateWithMinDayLimit"));
			} else {
				out.print(decimalFormatter.format(day) + "." + decimalFormatter.format(month) + "." + year);
			}%>"
												name="fromDateWithMinDayLimit" id="fromDateWithMinDayLimit" class="form-control input-sm"
												tabindex="1" required="required"/></td>
										</tr>
										<tr>
											<td>To Date:</td>
											<td><input type="text"
												value="<%if (request.getParameter("toDateWithoutTodayLimit") != null) {
				out.print(request.getParameter("toDateWithoutTodayLimit"));
			} else {
				out.print(decimalFormatter.format(twoMonthsLaterDay) + "." + decimalFormatter.format(twoMonthsLaterMonth) + "." + twoMonthsLaterYear);
			}%>"
												name="toDateWithoutTodayLimit" id="toDateWithoutTodayLimit" class="form-control input-sm"
												tabindex="2" required="required"/></td>
										</tr>
										<tr>
											<td><b>Min Length:</b></td>
											<td><input type="text" value="" name="minLength"
												id="minLength" class="form-control input-sm" value="${minLength}" tabindex="3" /></td>
										</tr>
										<tr>
											<td><b>Max Length:</b></td>
											<td><input type="text" value="" name="maxLength"
												id="maxLength" class="form-control input-sm" value="${maxLength}" tabindex="4" /></td>
										</tr>
										<tr>
											<td><b>Min Width:</b></td>
											<td><input type="text" value="" name="minWidth"
												id="minWidth" class="form-control input-sm" value="${minWidth}" tabindex="5" /></td>
										</tr>
										<tr>
											<td><b>Max Width:</b></td>
											<td><input type="text" value="" name="maxWidth"
												id="maxWidth" class="form-control input-sm" value="${maxWidth}" tabindex="6" /></td>
										</tr>
										<tr>
											<td><b>Fuel Capacity:</b></td>
											<td><input type="text" value="" name="fuelCapacity"
												id="fuelCapacity" class="form-control input-sm" value="${fuelCapacity}" tabindex="7" /></td>
										</tr>
										<tr>
											<td><b>Water Capacity:</b></td>
											<td><input type="text" value="" name="waterCapacity"
												id="waterCapacity" class="form-control input-sm"
												value="${waterCapacity}" tabindex="8" /></td>
										</tr>
										<tr>
											<td><b>Electricity Capacity:</b></td>
											<td><input type="text" value=""
												name="electricityCapacity" id="electricityCapacity"
												class="form-control input-sm" value="${electricityCapacity}" tabindex="9" /></td>
										</tr>
										<tr>
											<input type="hidden" name="hiddenFromDate"
												id="hiddenFromDate" value="" />
											<input type="hidden" name="hiddenToDate" id="hiddenToDate"
												value="" />
										</tr>
									</table>
								</div>
								<div class="modal-footer">
									<input class="btn btn-primary" name="submit" id="submit"
										value="Submit" type="submit" tabindex="10">
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="alert alert-danger alert-dismissable reservationInfoAlertWaitingDiv">
						<strong>There is a pending reservation request for the berth you are interested in. Please check again later.</strong>
					</div>
					<div class="alert alert-success alert-dismissable reservationInfoAlertDiv">
						<strong>Your enquiry is successfully received! You will be informed when the evaluation of your enquiry is completed.</strong>
					</div>
					<div class="col-sm-9">
						<div id="dvMap" style="height: 500px;"></div>
					</div>
					<div class="col-sm-3">
						<div>
							<table id="dynamicTable"
								style="max-height: 550px !important; overflow-y: scroll; display: -webkit-box;">
								<tbody>
									<c:choose>
										<c:when test="${!empty listBerth}">
											<c:forEach items="${listBerth}" var="berth">
												<%-- 										<tr class='clickableRow${berth.id}'> --%>
												<tr>
													<td><strong>Name: </strong><span style="font-style: italic">${berth.getName() }</span>
													</br><strong></strong>Status: </strong>
														<c:choose>
															<c:when test="${berth.getStatus() == true}">
																<span style="color: darkgreen">Berth is operationable</span>
															</c:when>
															<c:otherwise>
																<span style="color: darkgreen">Berth is non-operationable</span>
															</c:otherwise>
														</c:choose>
														</br><strong>Electricity Capacity: </strong>${berth.getElectricityCapacity() } kW/h
														</br><strong>Water Capacity: </strong>${berth.getWaterCapacity() } gallons/h
														</br><strong>Fuel Capacity: </strong>${berth.getFuelCapacity() } gallons/h
														</br><strong>Length: </strong>${berth.getMinLength()}m - ${berth.getMaxLength()}m
														</br><strong>Width: </strong>${berth.minWidth}m - ${berth.maxWidth}m </br></br>
													</td>
												</tr>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<tr>
												<td style="vertical-align:middle">Sorry, no available berths found according to your search criteria!</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div>
	<%@include file="../includes/footer.jsp"%>
	
</body>

<%@include file="../includes/closingDivTagsForMobileViews.jsp"%>
</html>