<%
	if(session.getAttribute("isMobile").toString().equalsIgnoreCase("true"))
	{
  		out.print("<br/><br/><br/><br/><br/><br/><br/>");
	}
%>

<!-- START OF footer div to make the footer fixed at bottom on any screen -->
<div id="footer">
<!-- START OF footer div to make the footer fixed at bottom on any screen -->

<!-- footer -->

<footer>

<%@ page import="java.io.*, java.util.Date, java.text.* "
	pageEncoding="ISO-8859-9"%>
	
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
		%>
    <div class="container">
        <div class="row">
            <aside class="col-md-6">

                <p class="lighter">Made with <i class="fa fa-heart-o"></i> by <a <% if(session.getAttribute("isMobile").toString().equalsIgnoreCase("true")) { out.print("href='aboutUs.jsp'"); } else { out.print("href='aboutUs.jsp#ETSTeamForWebApp'"); } %> title="About Us">ETS Engineers.</a></p>

                <p class="darker">Environment Tracking Software v1.3 <br/> Copyright © 2014-<% out.print(currentYear); %>. All rights reserved.</p>

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

<script src="assets/js/jquery.min.js"></script>
<script src="assets/bootstrap/js/bootstrap.min.js"></script>

<script src="assets/js/detectmobilebrowser.js"></script>
<script src="assets/js/gmap3.min.js"></script>
<script src="assets/js/jquery.appear.js"></script>
<script src="assets/js/jquery.ba-bbq.min.js"></script>
<script src="assets/js/jquery.fitvids.js"></script>
<script src="assets/js/jquery.flexslider-min.js"></script>
<script src="assets/js/jquery.placeholder.min.js"></script>
<script src="assets/js/retina-1.1.0.min.js"></script>
<script src="assets/js/snap.js"></script>
<script src="assets/js/jquery.stellar.min.js"></script>

<!-- Contact form validation -->
<script src="assets/form/js/contact-form.js"></script>
<!-- Twitter -->
<script src="assets/twitter/js/jquery.tweet.js"></script>

<script src="assets/js/jquery.easing.1.3.min.js"></script>
<script src="assets/js/main.js"></script>

<!-- init scripts -->
<script src="assets/js/scripts/flexslider.js"></script>
<script src="assets/js/scripts/google-map.js"></script>
<script src="assets/js/scripts/parallax-stellar-section.js"></script>
<script src="assets/js/scripts/onepager.js"></script>

<!-- </div> closure for <div id="boxedWrapper" class="snap-content"> -->
</div>

</body>

<%

	// If the viewing device is not mobile, then close the div's for fitting the content to any screen
	if(session.getAttribute("isMobile").toString().equalsIgnoreCase("false"))
	{
	%>
		<!-- </div> closure for <div id="body"> -->
		</div>

		<!-- </div> closure for <div id="container"> -->
		</div>
	<%
	}

%>

</html>