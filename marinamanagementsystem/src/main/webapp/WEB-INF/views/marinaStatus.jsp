<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page session="true" %>
<%@page contentType="text/html; charset=UTF-8"%>
<%@include file="../includes/include.jsp"%>

<html>

<head>

    <title><fmt:message key="label.application.title"/></title>
    <link rel="stylesheet" href="../resources/assets/css/AdvanceSearchDropDownMenu.css"></link>
	<%@include file="../includes/commonMeta.jsp"%>
	<%@include file="../includes/commonStyles.jsp"%>
	<%@include file="../includes/commonScripts.jsp"%>
	<script src="../resources/js/markerclusterer.js"></script>
	
	<script>    
 		$(document).ready(function(){
 			
 		});
	</script>

<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyDkK3LRevjeZz0nrdm5k6tKX0EBihlS5jo&sensor=false"></script>
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
              label: "" + i
            });
          });
        
        var markerCluster = new MarkerClusterer(map, markers,
                {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
        
//         "marker <strong>content</strong> <span style=\"font-size: 30px;\">here</span>";
        for (i = 0; i < markers.length; i++)
       	{
       		google.maps.event.addListener(markers[i], 'click', function () {
                var markerContent = '${listBerth.get(i).name}';
                infoWindow.setContent(markerContent);
                infoWindow.open(map, this);
            });
       	}
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

$(function() {
    $(".clickableRow").on("click", function() {
        location.href="http://google.com";

    });

});

</script>
</head>

<body class="withAnimation">

	<%@include file="../includes/header.jsp"%>

	<br/><br/>
	<div id="boxedWrapper" class="snap-content">	
		<div class="grey content-area" id="iconbuttons" style="background-color: #FBFBFB;">	
			<div class="container">
				<div class="row">
					<div class="col-sm-9">
						<div id="dvMap" style="height: 500px;"></div>
					</div>
					<div class="col-sm-3">
						<div>
							<table>
								<tbody>
        						<c:forEach items="${listBerth}" var="berth">
									<tr class='clickableRow'>
										<td> Name: ${berth.getName() }
											Type: ${ berth.getBerthType()}
											Status: ${berth.getStatus() }
											Electricity Capacity: ${berth.getElectricityCapacity() }
											Water Capacity ${berth.getWaterCapacity() }
											Fuel Capacity: ${berth.getFuelCapacity() }
											Length: ${berth.getMinLength()} - ${berth.getMaxLength()} 
											Width: $ {berth.minWidth} - $ {berth.maxWidth}
											<br></br>
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
<%-- 	<%@include file="../includes/footer.jsp"%> --%>

</body>
</html>