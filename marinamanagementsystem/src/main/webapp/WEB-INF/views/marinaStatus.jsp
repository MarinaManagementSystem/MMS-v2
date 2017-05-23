<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page session="true" %>
<%@page contentType="text/html; charset=UTF-8"%>
<%@include file="../includes/springTagLibraries.jsp"%>

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

<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDkK3LRevjeZz0nrdm5k6tKX0EBihlS5jo&sensor=false"></script>
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
                var markerContent = 'Name : ${listBerth.get(i).name} </br>' + 
                'Status: ${listBerth.get(i).getStatus() } </br>' +
				'Electricity Capacity: ${listBerth.get(i).getElectricityCapacity() } </br>'+
				'Water Capacity ${listBerth.get(i).getWaterCapacity() } </br>'+
				'Fuel Capacity: ${listBerth.get(i).getFuelCapacity() } </br>'+
				'Length: ${listBerth.get(i).getMinLength()} - ${listBerth.get(i).getMaxLength()} </br> '+
				'Width: ${listBerth.get(i).minWidth} - ${listBerth.get(i).maxWidth} </br>';
                infoWindow.setContent(markerContent);
                infoWindow.open(map, this);
            });
       	}

        

        $(function() {
            $(".clickableRow3").on("click", function() {
            	
            	google.maps.event.trigger(markers[3], "click", {});
            	map.setCenter(markers[3].getPosition());
            	map.setZoom(18);

            });

        });

        $(function() {
            $(".clickableRow1").on("click", function() {
            	
            	google.maps.event.trigger(markers[1], "click", {});
            	map.setCenter(markers[1].getPosition());
            	map.setZoom(18);

            });

        });
        

        $(function() {
            $(".clickableRow2").on("click", function() {
            	
            	google.maps.event.trigger(markers[2], "click", {});
            	map.setCenter(markers[2].getPosition());
            	map.setZoom(18);
            });

        });
        

        $(function() {
            $(".clickableRow4").on("click", function() {
            	
            	google.maps.event.trigger(markers[4], "click", {});
            	map.setCenter(markers[4].getPosition());
            	map.setZoom(18);
            });

        });
        

        $(function() {
            $(".clickableRow5").on("click", function() {
            	
            	google.maps.event.trigger(markers[0], "click", {});
            	map.setCenter(markers[0].getPosition());
            	map.setZoom(18);
            });

        });
        
        function cagir(id){

        	google.maps.event.trigger(markers[id], "click", {});
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


</script>
</head>

<body class="withAnimation">

	<%@include file="../includes/header.jsp"%>


	<br/><br/>
	<div id="boxedWrapper" class="snap-content">	
		<div class="grey content-area" id="iconbuttons" style="background-color: #FBFBFB;">	
			<div class="container">
				<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
			  		Advanced Search
				</button>
				<!-- Modal -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
				      </div>
				      <div class="modal-body">
							<form action="marinaStatus" id="marinaStatusFilterForm" name="marinaStatusFilterForm" method="get">
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
																	Min Length:
																</td>
																<td width="10px;">
																	<!-- Empty column -->
																</td>
																<td>
																	<input type="text" value="" name="minLength" id="minLength" class="form-control input-sm" tabindex="1" />
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
											<input class="btn btn-default" name="submit" id="submit" tabindex="522" value="Submit" type="submit" tabindex="2">
										</td>
									</tr>
								</table>
							</form>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				        <button type="button" class="btn btn-primary">Save changes</button>
				      </div>
				    </div>
				  </div>
				</div>
				
				
				
				
				
				
							<form action="marinaStatus" id="marinaStatusFilterForm" name="marinaStatusFilterForm" method="get">
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
																	Min Length:
																</td>
																<td width="10px;">
																	<!-- Empty column -->
																</td>
																<td>
																	<input type="text" value="" name="minLength" id="minLength" class="form-control input-sm" tabindex="1" />
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
											<input class="btn btn-default" name="submit" id="submit" tabindex="522" value="Submit" type="submit" tabindex="2">
										</td>
									</tr>
								</table>
							</form>
				
				
				
				<div class="row">
					<div class="col-sm-9">
						<div id="dvMap" style="height: 500px;"></div>
					</div>
					<div class="col-sm-3">
						<div>
							<table style="max-height: 550px !important;  overflow-y: scroll; display: -webkit-box;">
								<tbody>
        						<c:forEach items="${listBerth}" var="berth">
									<tr class='clickableRow${berth.id}' >
										<td> Name: ${berth.getName() }
<%-- 											Type: ${ berth.getBerthType()} --%>
											</br>Status: ${berth.getStatus() }
											</br>Electricity Capacity: ${berth.getElectricityCapacity() }
											</br>Water Capacity ${berth.getWaterCapacity() }
											</br>Fuel Capacity: ${berth.getFuelCapacity() }
											</br>Length: ${berth.getMinLength()} - ${berth.getMaxLength()} 
											</br>Width: ${berth.minWidth} - ${berth.maxWidth}
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
	<%@include file="../includes/footer.jsp"%>

</body>
</html>