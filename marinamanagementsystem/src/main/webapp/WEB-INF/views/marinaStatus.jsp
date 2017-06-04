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
	   	                var markerContent = '<b>Name</b>: ${listBerth.get(i).name} </br>' + 
	   	                '<b>Status:</b> ${listBerth.get(i).getStatus() } </br>' +
	   					'<b>Electricity Capacity</b>: ${listBerth.get(i).getElectricityCapacity() } </br>'+
	   					'<b>Water Capacity:</b> ${listBerth.get(i).getWaterCapacity() } </br>'+
	   					'<b>Fuel Capacity:</b> ${listBerth.get(i).getFuelCapacity() } </br>'+
	   					'<b>Length:</b> ${listBerth.get(i).getMinLength()} - ${listBerth.get(i).getMaxLength()} </br> '+
	   					'<b>Width:</b> ${listBerth.get(i).minWidth} - ${listBerth.get(i).maxWidth} </br>' +
	   					'<input type="button" class="btn btn-success" id="btnAdd" value="Reserve" onClick="openReservationPage(${listBerth.get(i).id})">';
	   	                infoWindow.setContent(markerContent);
	   	                infoWindow.open(map, this);
	   	            });
   			 	</c:when>
   			 	<c:otherwise>
	   	       		google.maps.event.addListener(markers[i], 'click', function () {
	   	                var markerContent = '<b>Name</b>: ${listBerth.get(i).name} </br>' + 
	   	                '<b>Status:</b> ${listBerth.get(i).getStatus() } </br>' +
	   					'<b>Electricity Capacity</b>: ${listBerth.get(i).getElectricityCapacity() } </br>'+
	   					'<b>Water Capacity:</b> ${listBerth.get(i).getWaterCapacity() } </br>'+
	   					'<b>Fuel Capacity:</b> ${listBerth.get(i).getFuelCapacity() } </br>'+
	   					'<b>Length:</b> ${listBerth.get(i).getMinLength()} - ${listBerth.get(i).getMaxLength()} </br> '+
	   					'<b>Width:</b> ${listBerth.get(i).minWidth} - ${listBerth.get(i).maxWidth} </br>' +
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
			<c:when test="${reservationInfoAlert != null && reservationInfoAlert == 1}">
				$('.reservationInfoAlertWaitingDiv').show();
			</c:when>
			<c:when test="${reservationInfoAlert != null && reservationInfoAlert == 0}">
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
				<button type="button" class="btn btn-primary btn-lg"
					data-toggle="modal" data-target="#myModal">Advanced Search
				</button>
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
										<b></b>Filtering Options</b>
									</h4>
								</div>
								<div class="modal-body">
									<table align="center" width="100%" style="table-layout: fixed;">
										<tr>
											<td>From Date:</td>
											<td><input type="text"
												value="<%if (request.getParameter("fromDate") != null) {
				out.print(request.getParameter("fromDate"));
			} else {
				out.print("01.01." + year);
			}%>"
												name="fromDate" id="fromDate" class="form-control input-sm"
												tabindex="1" required="required"/></td>
										</tr>
										<tr>
											<td>To Date:</td>
											<td><input type="text"
												value="<%if (request.getParameter("toDate") != null) {
				out.print(request.getParameter("toDate"));
			} else {
				out.print(decimalFormatter.format(day) + "." + decimalFormatter.format(month) + "." + year);
			}%>"
												name="toDate" id="toDate" class="form-control input-sm"
												tabindex="2" required="required"/></td>
										</tr>
										<tr>
											<td>Min Length:</td>
											<td><input type="text" value="" name="minLength"
												id="minLength" class="form-control input-sm" tabindex="3" /></td>
										</tr>
										<tr>
											<td><b>Length:</b></td>
											<td><input type="text" value="" name="maxLength"
												id="maxLength" class="form-control input-sm" tabindex="4" /></td>
										</tr>
										<tr>
											<td>Min Width:</td>
											<td><input type="text" value="" name="minWidth"
												id="minWidth" class="form-control input-sm" tabindex="5" /></td>
										</tr>
										<tr>
											<td><b>Width:</b></td>
											<td><input type="text" value="" name="maxWidth"
												id="maxWidth" class="form-control input-sm" tabindex="6" /></td>
										</tr>
										<tr>
											<td><b>Fuel Capacity:</b></td>
											<td><input type="text" value="" name="fuelCapacity"
												id="fuelCapacity" class="form-control input-sm" tabindex="7" /></td>
										</tr>
										<tr>
											<td><b>Water Capacity:</b></td>
											<td><input type="text" value="" name="waterCapacity"
												id="waterCapacity" class="form-control input-sm"
												tabindex="8" /></td>
										</tr>
										<tr>
											<td><b>Electricity Capacity:</b></td>
											<td><input type="text" value=""
												name="electricityCapacity" id="electricityCapacity"
												class="form-control input-sm" tabindex="9" /></td>
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
						<strong>There is a waiting reservation request. You can check again when evaluation is made.</strong>
					</div>
					<div class="alert alert-success alert-dismissable reservationInfoAlertDiv">
						<strong>Your reservation request is taken. You will be informed when evaluation is made.</strong>
					</div>
					<div class="col-sm-9">
						<div id="dvMap" style="height: 500px;"></div>
					</div>
					<div class="col-sm-3">
						<div>
							<table id="dynamicTable"
								style="max-height: 550px !important; overflow-y: scroll; display: -webkit-box;">
								<tbody>
									<c:forEach items="${listBerth}" var="berth">
										<%-- 										<tr class='clickableRow${berth.id}'> --%>
										<tr>
											<td>Name: ${berth.getName() } </br>Status:
												${berth.getStatus() } </br>Electricity Capacity:
												${berth.getElectricityCapacity() } </br>Water Capacity
												${berth.getWaterCapacity() } </br>Fuel Capacity:
												${berth.getFuelCapacity() } </br>Length: ${berth.getMinLength()}
												- ${berth.getMaxLength()} </br>Width: ${berth.minWidth} -
												${berth.maxWidth} <br></br>
											</td>
										</tr>
									</c:forEach>
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