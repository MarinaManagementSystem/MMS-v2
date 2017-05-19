<!-- START OF footer div to make the footer fixed at bottom on any screen -->
<div id="footer">
<!-- START OF footer div to make the footer fixed at bottom on any screen -->

	<!-- footer -->
	<footer>
	    <div class="container">
	        <div class="row">
	            <aside class="col-md-6">
	            
	            	<%@ page import="java.util.Date, java.text.* " %>
	            
					<%
						SimpleDateFormat hourFormat = new SimpleDateFormat("dd:MM:yyyy:hh:mm:a");
						Date dNow = new Date();
						String currentTime = hourFormat.format(dNow).toString();
						String[] parts = currentTime.split(":");
						String stringVersionOfDay = parts[0];
						String stringVersionOfMonth = parts[1];
						String stringVersionOfYear = parts[2];
			
						String stringVersionOfHour = parts[3];
						String stringVersionOfMinutes = parts[4];
						String amORpm = parts[5];
						int currentYear = Integer.parseInt(stringVersionOfYear);
						//out.println("HOUR: "+stringVersionOfHour+":"+stringVersionOfMinutes+":"+amORpm);
						//out.println("CURRENT TIME: "+currentTime);
					%>
	
	                <p class="lighter">Made with <i class="fa fa-heart-o"></i> by <a href="aboutUs" title="About Us">MMS Engineers.</a></p>
	
	                <p class="darker">Marina Management System v1.3 <br/> Copyright � 2016-<% out.print(currentYear); %>. All rights reserved.</p>
	
	            </aside>
	
	            <aside class="col-md-6">
	
	                <article class="table-content">
	                    <div class="table-row">
	                        <div class="table-cell">
	                            <h4 class="widget-title">Find us on these platforms:</h4>
	                        </div>
	                        <div class="table-cell">
	                            <ul class="socialIcons bigIcons list-inline">
	                                <li><a title="" data-toggle="tooltip" href="#" data-original-title="Facebook"><i class="fa fa-fw fa-facebook "></i></a></li>
	                                <li><a title="" data-toggle="tooltip" href="#" data-original-title="Twitter"><i class="fa fa-fw fa-twitter"></i></a></li>
	                                <li><a title="" data-toggle="tooltip" href="#" data-original-title="Forrst+"><i class="fa-fw icon icon-forrst"></i></a></li>
	                                <li><a title="" data-toggle="tooltip" href="#" data-original-title="Dribble"><i class="fa fa-fw fa-dribbble"></i></a></li>
	                            </ul>
	                        </div>
	                    </div>
	                </article>
	
	            </aside>
	        </div>
	    </div>
	</footer>
	<!-- / footer -->

</div>

<!-- / snap content -->

<a href="#" id="toTop"><i class="fa fa-angle-up"></i></a>


<!-- js -->

<script src="../resources/assets/js/jquery.min.js"></script>
<script src="../resources/assets/bootstrap/js/bootstrap.min.js"></script>

<script src="../resources/assets/js/detectmobilebrowser.js"></script>
<script src="../resources/assets/js/jquery.appear.js"></script>
<script src="../resources/assets/js/jquery.isotope.min.js"></script>
<script src="../resources/assets/js/jquery.ba-bbq.min.js"></script>
<script src="../resources/assets/js/jquery.fitvids.js"></script>
<script src="../resources/assets/js/jquery.flexslider-min.js"></script>
<script src="../resources/assets/js/jquery.placeholder.min.js"></script>
<script src="../resources/assets/js/retina-1.1.0.min.js"></script>
<script src="../resources/assets/js/snap.js"></script>
<script src="../resources/assets/js/jquery.stellar.min.js"></script>
<!-- Contact form validation -->
<script src="../resources/assets/form/js/contact-form.js"></script>
<!-- Twitter -->
<script src="../resources/assets/twitter/js/jquery.tweet.js"></script>

<script src="../resources/assets/js/jquery.easing.1.3.min.js"></script>
<script src="../resources/assets/js/main.js"></script>

<!-- init script -->
<script src="../resources/assets/js/magnificpopup/jquery.magnific-popup.min.js"></script>
<script src="../resources/assets/js/scripts/flexslider.js"></script>
<script src="../resources/assets/js/scripts/ajax-portfolio.js"></script>
<script src="../resources/assets/js/scripts/isotope.js"></script>
<script src="../resources/assets/js/scripts/onepager.js"></script>
<script src="../resources/assets/js/scripts/kenburns-section.js"></script>
<script src="../resources/assets/js/scripts/parallax-stellar-section.js"></script>


<script type="text/javascript" src="../resources/assets/js/autoLogoff.js"></script>

<script src="../resources/assets/js/datetimepicker/jquery.datetimepicker.js"></script>

<!-- Please check http://xdsoft.net/jqplugins/datetimepicker/ for the below datetimepicker settings and functions -->
<script src="../resources/assets/js/datetimepicker/datetimepickerForETS.js"></script>
<!-- /REQUIRED FILES FOR DATE TIME PICKER -->