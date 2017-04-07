<%@ page language="java" contentType="text/html; charset=ISO-8859-9" import="java.io.*, java.util.*, java.util.Date, java.sql.*, javax.servlet.*, java.text.* "
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js" lang="en"> <!--<![endif]-->
<head>
<jsp:include page="header.jsp" />

<title>You are successfully logged out! - Environment Tracking Software</title>
<link rel="stylesheet" type="text/css" href="assets/css/style_for_login.css" media="all" />
<META http-equiv="refresh" content="7;URL=login.jsp">

</head>

<%
	// If the viewing device is not mobile, then fit the content to any screen
	if(session.getAttribute("isMobile").toString().equalsIgnoreCase("false"))
	{
  		%>
			<!-- START OF Div's to make the footer fixed at bottom and page content fixed vertically on any screen -->
			<div id="container" style="background: #FBFBFB; display: table; height: 100%; width: 100%; #position: relative; overflow: hidden;">
			<div id="body" style="#position: absolute; #top: 50%;display: table-cell; vertical-align: middle;">
			<!-- END OF Div's to make the footer fixed at bottom on any screen -->
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
	                <ul class="nav navbar-nav navbar-right">
	                    <li class="active">
	                        <a href="login.jsp">Login</a>
	                    </li>
	                    <li>
	                        <a href="login.jsp?username=demo&password=demo">Demo Login</a>
	                    </li>
	                    <li>
	                        <a href="aboutUs.jsp">About</a>
	                    </li>
	                </ul>
	                <a class="btn btn-border active" style="border-color: #FF9A00; background: #FF9A00; font-size: 14px; font-weight: normal;" href="contactUs.jsp">Contact us!</a>
            </div>
        </div>
    </div>
</div>
<!-- / left navbar -->

<!-- / FOR MOBILE DEVICES -->

<!-- snap content -->
<div id="boxedWrapper" class="snap-content">

<nav class="navbar navbar-default navbar-transparent navbar-fixed-top" style="background-color: black;" role="navigation">
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
            	<li><a class="dropdown" href="login.jsp">Login</a></li>
            	<li><a href="login.jsp?username=demo&password=demo">Demo Login</a></li>
	            <li><a class="dropdown" href="aboutUs.jsp">About</a></li>
                <li><a class="btn btn-border" style="border-color: #FF9A00; background: #FF9A00; font-size: 14px; font-weight: normal;" href="contactUs.jsp">Contact us!</a></li>
            </ul>
        </div>
    </div>
</nav>
<!-- / navbar -->


<%@ page import="com.marinamanagementsystem.conf.*" %>


<!-- header -->
<header class="height">

<!-- ANY HEADER CONTENT HERE -->

</header>
<!-- / header -->

<!--  section icon box -->
<div class="grey content-area" id="iconbuttons" style="background-color: #FBFBFB;">

	<%
		if (session.getAttribute("userName") == null
				|| session.getAttribute("password") == null) {
			response.sendRedirect("login.jsp");
			return;
		} else
		{
			
			// session.invalidate() is done in the footer since the <div>'s need it till the end of footer.jsp
		}
	
		
		// If the viewing device is a computer, print the message for computers
		if(session.getAttribute("isMobile").toString().equalsIgnoreCase("false"))
		{
	%>
			<br/><br/><br/><br/>
			<div id="loginContainer" style="width: 600px;">
				<center>
					<img src="images/successful.png"
						alt="Successful image" height="100" width="100">
					<br>
					<br>
					<p>
						<%
							String logoutMessage = "<font size='2.5px' color='black'><b>You are successfully logged out!</b><br>You will be redirected in <b><span id='container'>5</span></b> seconds.</font>";
							
							if(request.getParameter("passwordChanged") != null)
							{
								if(request.getParameter("passwordChanged").toString().equalsIgnoreCase("true"))
								{
									logoutMessage = "<font size='2.5px' color='black'><b>Your password is successfully changed!</b><br>To ensure the system security, you will be logged out to activate your new password.<br>You will be redirected in <b><span id='container'>5</span></b> seconds.</font>";
								}
							}
							else if(request.getParameter("userRoleOrEmailChanged") != null)
							{
								if(request.getParameter("userRoleOrEmailChanged").toString().equalsIgnoreCase("true"))
								{
									logoutMessage = "<font size='2.5px' color='black'><b>Your user role/e-mail is successfully changed!</b><br>To ensure the system security, you will be logged out to activate your new user role/e-mail.<br>You will be redirected in <b><span id='container'>5</span></b> seconds.</font>";
								}
							}
							
							out.print(logoutMessage);
						%>
					</p>
				</center>
			</div>
		<%
		}
		else
		{
			%>
		    <div class="container">
		        <div class="row">
		            <div class="col-md-6">
		                <header class="section-header">
		                    <img src="images/successful.png" alt="Successful image" height="100" width="100">
		                    <br><br>
		                    <p class="summary">You are successfully logged out!<br>You will be redirected in <b>5</b> seconds.</p>
		                </header>
		            </div>
		        </div>
		    </div>
			<%
		}
		%>
</div>
        
<!-- / section -->

<br>
<!-- footer -->

<script language='JavaScript'>
	
	/*
	var time = 6;
	var page = "index.jsp";

	function startCount() {
		time--;
		console.log(time);
		document.getElementById("container").innerHTML = time;
		startCounter();
	}

	function startCounter() {
		if (time !== 1) {
			setTimeout(function() {
				startCount();
			}, 1000);
		} else {
			location.href = page;
		}
	}

	if (window.addEventListener) {
		window.addEventListener("load", startCount, false);
	} else if (el.attachEvent) {
		window.attachEvent("load", startCount);
	}
	*/
</script>

<jsp:include page="footer.jsp" />