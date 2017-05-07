<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page session="true" %>
<%@page contentType="text/html; charset=UTF-8"%>
<%@include file="../includes/springTagLibraries.jsp"%>

<html>

<head>

    <title><fmt:message key="label.application.title"/></title>
    
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
              label: "Berth_"+i
            });
          });
        
        var markerCluster = new MarkerClusterer(map, markers,
                {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
        

        for (i = 0; i < markers.length; i++)
       	{
       		google.maps.event.addListener(markers[i], 'click', function () {
                var markerContent = "marker <strong>content</strong> <span style=\"font-size: 30px;\">here</span>";
                infoWindow.setContent(markerContent);
                infoWindow.open(map, this);
            });
       	}
    }
</script>

</head>

<body class="withAnimation">

	<%@include file="../includes/header.jsp"%>

	
	<div id="boxedWrapper" class="snap-content">	
		<div class="grey content-area" id="iconbuttons" style="background-color: #FBFBFB;">	
			<div class="container">
				<div class="row">
					<div id="dvMap" style="width: 500px; height: 500px;"></div>
				</div>
			</div>			
		</div>
	</div>
	<br/><br/><br/><br/><br/><br/>
	<%@include file="../includes/footer.jsp"%>

</body>
</html>