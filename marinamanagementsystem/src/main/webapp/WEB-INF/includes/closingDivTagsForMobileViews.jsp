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