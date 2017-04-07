<%@ page language="java" contentType="text/html; charset=ISO-8859-9" import="java.io.*, java.util.*, java.util.Date, java.sql.*, javax.servlet.*, java.text.* "
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js" lang="en"> <!--<![endif]-->
<head>
<jsp:include page="header.jsp" />

<title>Unauthorized Access - Environment Tracking Software</title>

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
	                    <li>
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
    <div class="container" style="position: relative; z-index: 100;">
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
            	if(session.getAttribute( "userName") == null || session.getAttribute( "password") == null)
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
                <li class="active dropdown">
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


	<%
		String referringPage = null;
		referringPage = request.getParameter("pageName");
		
		if(referringPage.equalsIgnoreCase("editSystemUser"))
		{
			referringPage = "<a href='editSystemUser.jsp'>Edit a System User</a>";
		}
		else if(referringPage.equalsIgnoreCase("systemUsers"))
		{
			referringPage = "<a href='systemUsers.jsp'>System Users</a>";
		}
		else if(referringPage.equalsIgnoreCase("newSystemUser"))
		{
			referringPage = "<a href='deleteSystemUsers.jsp'>Add a New System User</a>";
		}
		else if(referringPage.equalsIgnoreCase("serverSettings"))
		{
			referringPage = "<a href='serverSettings.jsp'>Server Settings</a>";
		}
	%>


    <div data-image-mobile="assets/images/content/13-404page-banner.jpg" data-image="assets/images/content/13-404page-banner.jpg" data-type="parallax" data-height="800" data-stellar-background-ratio="0" class="media-section">

        <div class="display-table">
            <div class="inner">

                <div class="flexslider std-slider center-controls" data-height="" data-loop="true" data-smooth="false" data-slideshow="true" data-speed="15000" data-animspeed="550" data-controls="false" data-dircontrols="true">
                    <ul class="slides">

                        <li>
                            <div class="container">
                                <div class="text-center width inner">
                                    <h2 class="page-title animated" data-fx="fadeInDown">UNAUTHORIZED ACCESS</h2>

                                    <h3 class="animated" data-fx="bounceIn">
                                        Ooops, you are not allowed to access <% if(referringPage != null) { out.print(referringPage); } else { out.print("this"); } %> page.
                                    </h3>
                                    <a href="index.jsp" class="btn btn-default btn-lg animated" data-fx="fadeInUp">Go Back To Home</a>
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

<!--  section icon box -->

<!-- / section -->

<br>
<!-- footer -->

<jsp:include page="footer.jsp" />