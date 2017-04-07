<%@ page language="java" contentType="text/html; charset=ISO-8859-9" import="java.io.*, java.util.*, java.util.Date, java.sql.*, javax.servlet.*, java.text.* "
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js" lang="en"> <!--<![endif]-->
<head>
<jsp:include page="header.jsp" />

<title>Contact Us - Environment Tracking Software</title>

</head>


<%
	// If the viewing device is not mobile, then fit the content to any screen
	if(session.getAttribute("isMobile").toString().equalsIgnoreCase("false"))
	{
  		%>
			<!-- START OF Div's to make the footer fixed at bottom and page content fixed vertically on any screen -->
			<div id="container" style="display: table; height: 100%; width: 100%; #position: relative; overflow: hidden;">
			<div id="body" style="#position: absolute; #top: 50%;display: table-cell; vertical-align: middle;">
			<!-- END OF Div's -->
		<%
	}
%>



<body class="withAnimation">

<!-- FOR MOBILE DEVICES -->

<!-- left navbar -->
<div class="snap-drawers-button">
    <button type="button" class="navbar-toggle">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
    </button>
</div>
<div class="snap-drawers">
    <div class="snap-drawer snap-drawer-left">
        <div>
            <div class="navbar-collapse collapse">
            <%
            	if(session.getAttribute("userName") == null || session.getAttribute("password") == null)
            	{  
            		%>
	                <ul class="nav navbar-nav navbar-right">
	                    <li class="active">
	                        <a href="login.jsp">Login</a>
	                    </li>
	                    <li>
	                        <a href="aboutUs.jsp">About</a>
	                    </li>
	                </ul>
	                <a class="btn btn-border active" style="border-color: #FF9A00; background: #FF9A00; font-size: 14px; font-weight: normal;" href="contactUs.jsp">Contact us!</a>
	                <%
            	}
            	else
            	{
	                %>
	                <ul class="nav navbar-nav navbar-right">
	                    <li class="active">
	                        <a href="index.jsp">Home</a>
	                    </li>
	                    <li>
	                        <a href="aboutUs.jsp">About</a>
	                    </li>
	                    <li>
	                        <a href="#">Reports</a>
	                        <ul class="list-unstyled" role="menu">
	                            <li><a href="queryDatabase.jsp">Query&emsp;<span>Query the database</span></a></li>
	                            <li><a href="plotGraph.jsp">Graph&emsp;<span>Plot graph</span></a></li>
	                        </ul>
	                    </li>
	                    <li>
	                        <a href="#">Settings</a>
	                        <ul class="list-unstyled" role="menu">
	                            <li><a href="userSettings.jsp">User Settings&emsp;<span>Update your profile</span></a></li>
	                            <li><a href="serverSettings.jsp">Server Settings&nbsp;<span>Change mote settings</span></a></li>
		                       	<%
		                        	// If the browsing user is administrator, then show the related menu item
		                        	if(session.getAttribute("role").toString().equalsIgnoreCase("1") || session.getAttribute("role").toString().equalsIgnoreCase("3") || session.getAttribute("role").toString().equalsIgnoreCase("4"))
		                        	{
		                        		%>
		                        		<li><a href="systemUsers.jsp">System Users&nbsp;<span>Edit system users</span></a></li>
		                        		<%
		                        	}
		                        %>
	                        </ul>
	                    </li>
	
	                </ul>
	                <a class="btn btn-border active" style="border-color: #FF9A00; background: #FF9A00; font-size: 14px; font-weight: normal;" href="contactUs.jsp">Contact us!</a>
	                <a class="btn btn-border active" style="border-color: #DF2D1C; background: #DF2D1C; font-size: 14px; font-weight: normal;" href="#" onclick="return askForLogout();">Logout</a>	                
	                <%
	            }
            %>
            </div>
        </div>
    </div>
</div>
<!-- / left navbar -->

<!-- / FOR MOBILE DEVICES -->

<!-- snap content -->
<div id="boxedWrapper" class="snap-content">

<nav class="navbar navbar-default navbar-transparent navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" id="navbar-toggle" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="index.jsp" data-logo="images/ETS-Logo.png"><img src="images/ETS-Logo.png" alt="" title=""></a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
            <%
            	if(session.getAttribute("userName") == null || session.getAttribute("password") == null)
            	{
            		%>
	            	<li><a class="dropdown" href="login.jsp">Login</a></li>
	            	<li><a class="dropdown" href="aboutUs.jsp">About</a></li>
	            	<li><a class="btn btn-border" style="border-color: #FF9A00; background: #FF9A00; font-size: 14px; font-weight: normal;" href="contactUs.jsp">Contact us!</a></li>
            		<% 
            	}
            	else
            	{
            	String userName = session.getAttribute("userName").toString();
            	%>
                <li class="dropdown">
                    <a href="index.jsp" class="dropdown-toggle" data-toggle="dropdown">Home</a>
                </li>
                <li class="dropdown">
                    <a href="aboutUs.jsp" class="dropdown-toggle" data-toggle="dropdown">About</a>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Reports</a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="queryDatabase.jsp">Query<span>Query the database</span></a></li>
                        <li><a href="plotGraph.jsp">Graph<span>Plot a graph</span></a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Settings</a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="userSettings.jsp">User Settings<span>Update your profile</span></a></li>
                        <li><a href="serverSettings.jsp">Server Settings<span>Change mote settings</span></a></li>
                        <%
                        	// If the browsing user is administrator, then show the related menu item
                        	if(session.getAttribute("role").toString().equalsIgnoreCase("1") || session.getAttribute("role").toString().equalsIgnoreCase("3") || session.getAttribute("role").toString().equalsIgnoreCase("4"))
                        	{
                        		%>
                        		<li><a href="systemUsers.jsp">System Users<span>Edit system users</span></a></li>
                        		<%
                        	}
                        %>
                    </ul>
                </li>
                <li><a class="btn btn-border" style="border-color: #FF9A00; background: #FF9A00; font-size: 14px; font-weight: normal;" href="contactUs.jsp">Contact us!</a></li>
                <li><a class="btn btn-border" style="border-color: #DF2D1C; background: #DF2D1C; font-size: 14px; font-weight: normal;" href="#" onclick="return askForLogout();">Logout</a></li>
                <br/>
                <div align="right">Welcome, <a href="userSettings.jsp"><% out.print(userName+"."); %></a></div>
                <br/>
            	<%
            	}
            %>
            </ul>
        </div>
    </div>
</nav>
<!-- / navbar -->





<!-- header -->
<header class="height">

    <div data-image-mobile="assets/images/content/12-contact-banner.jpg" data-image="assets/images/content/12-contact-banner.jpg" data-type="parallax" data-height="400" data-stellar-background-ratio="0" class="media-section">

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

<%@ page import="com.environmenttrackingsoftware.conf.* " %>

<%
	boolean	confirmationMessage = false;
	if(request.getParameter("fullName") != null)
	{
		SendMailSSL newMailObject = new SendMailSSL();
		newMailObject.sendEmailForContactForm(request.getParameter("fullName"), request.getParameter("eMailAddress"), request.getParameter("subject"), request.getParameter("message"), request.getParameter("phoneNo"));
		//SendMailSSL newMailObject1 = new SendMailSSL(request.getParameter("fullName"), request.getParameter("eMailAddress"), request.getParameter("subject"), request.getParameter("message"), request.getParameter("phoneNo"));
		confirmationMessage = true;
	}

%>



<!--  section icon box -->
        
        
        
        
        
<div class="content-area">
    <div class="container">
        <div class="row">

            <div class="col-md-6">
                <div class="mapOuter">

                    <div class="googleMap" data-location="Academic Block 1, Middle East Technical University, Northern Cyprus Campus" data-height="600" data-offset="0"></div>

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
				
				<% if(confirmationMessage == true)
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



<!-- / section -->

<br>
<!-- footer -->

<jsp:include page="footerForContactPage.jsp" />