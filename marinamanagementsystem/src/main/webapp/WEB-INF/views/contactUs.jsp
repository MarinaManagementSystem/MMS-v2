<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../includes/springTagLibraries.jsp"%>

<html>

<head>

    <title>Contact Us - <fmt:message key="label.application.title"/></title>
    
	<%@include file="../includes/commonMeta.jsp"%>
	<%@include file="../includes/commonStyles.jsp"%>
	<%@include file="../includes/commonScripts.jsp"%>
	<script src="../resources/js/markerclusterer.js"></script>

</head>

<%@include file="../includes/openingDivTagsForMobileViews.jsp"%>


<!-- header -->
<header class="height">


    <div data-image-mobile="../resources/assets/images/content/12-contact-banner.jpg" data-image="../resources/assets/images/content/12-contact-banner.jpg" data-type="parallax" data-height="400" data-stellar-background-ratio="0" class="media-section">

        <div class="display-table">
            <div class="inner">

                <div class="flexslider std-slider center-controls" data-height="" data-loop="true" data-smooth="false" data-slideshow="true" data-speed="15000" data-animspeed="550" data-controls="false" data-dircontrols="true">
                    <ul class="slides">
                        <li>
                            <div class="container">
                                <div class="text-left width inner">
                                    <h2 class="page-title animated" data-fx="fadeInDown">CONTACT US</h2>

                                    <h3 class="animated" data-fx="bounceIn">
                                        Want to be a demo user or point out a problem you faced during your experience with ETS?<br/>
                                        Please fill in the contact form below and let us know!
                                    </h3>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

</header>
<!-- / header -->

<body class="withAnimation">

	<%@include file="../includes/header.jsp"%>

	<!--  section icon box -->
	
	<div class="content-area">
	    <div class="container">
	        <div class="row" style="padding-bottom: 20px;">
	
	            <div class="col-md-6">
	                <div class="mapOuter">
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
	                	<div id="dvMap" style="width: 450px; height: 500px;"></div>
	                    <!-- <div class="googleMap" data-location="Middle East Technical University" data-height="600" data-offset="0"></div>  -->
	                </div>
	
	                <dl>
	                    <dt>Here are some more information about us, you can get in touch with us any time you want.</dt>
	                    <dt><span>Address:</span></dt>
	                    <dd>Academic Block 1, Middle East Technical University, Northern Cyprus Campus</dd>
	
	                    <dt><span>E-mail:</span></dt>
	                    <dd><a href="mailto:info@etrackingsoftware.com">info@etrackingsoftware.com</a></dd>
	
	                    <dt><span>Phone:</span></dt>
	                    <dd>+90 392 661 24 61</dd>
	                </dl>
	            </div>
	
	            <div class="col-md-6">
	                <header class="section-header">
	                    <h2>Contact us</h2>
	
	                    <p class="summary">Our working hours are from 9:00
	                        AM until 5:30 PM. You may fill the contact form below to describe your problem.</p>
	                </header>
					
					<% if(/*confirmationMessage == true*/false)
						{
					%>		<p style='font-size: 15px;'><font color='darkgreen'><b>Your message is successfully sent.</b><br>We will get back to you as soon as possible, thank you for contacting us.</font></p>
	
	                <%
						}
						else
						{
					%>
							<form action="contactUs.jsp" class="contact-form" method="post" >
	
			                    <div class="form-group">
			                        <label class="control-label">Name, surname <span>*</span></label>
			                        <input required="" name="fullName" class="form-control" type="text" placeholder="Name SURNAME">
			                    </div>
			
			                    <div class="form-group">
			                        <label class="control-label">E-mail address <span>*</span></label>
			                        <input type="email" class="form-control" name="eMailAddress" required="" placeholder="mail@mail.com">
			                    </div>
			
			                    <div class="form-group">
			                        <label class="control-label">Phone number <span>*</span></label>
			                        <input type="text" class="form-control" name="phoneNo" required="" placeholder="xxx xxx xx xx">
			                    </div>
			                    
			                    <div class="form-group">
			                        <label class="control-label">Subject <span>*</span></label>
			                        <input type="text" class="form-control" name="subject" required="" placeholder="Subject">
			                    </div>
			
			                    <div class="form-group">
			                        <label class="control-label">Your message <span>*</span></label>
			                        <textarea rows="5" class="form-control" required="" name="message" placeholder="Your message"></textarea>
			                    </div>
			
			                    <input type="submit" value="Send" class="btn btn-lg btn-border">
		                    
		                    </form>
					<%
						}
	                %>
	
	            </div>
	        </div>
			<!-- / section -->
	    </div>
	</div>
	<%@include file="../includes/footer.jsp"%>
	
</body>

<%@include file="../includes/closingDivTagsForMobileViews.jsp"%>

</html>