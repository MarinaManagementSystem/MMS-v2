<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page session="true" %>
<%@page contentType="text/html; charset=UTF-8"%>
<%@include file="../includes/springTagLibraries.jsp"%>

<html>

<head>

    <title>You are successfully logged out! - <fmt:message key="label.application.title"/></title>
    <META http-equiv="refresh" content="7;URL=login">
    
	<%@include file="../includes/commonMeta.jsp"%>
	<%@include file="../includes/commonStyles.jsp"%>
	<%@include file="../includes/commonScripts.jsp"%>

	</script>

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

<%@include file="../includes/header.jsp"%>

	<!--  section icon box -->
	<div class="grey content-area" id="iconbuttons" style="background-color: #FBFBFB; text-align: center;">
	
		<%	
			// If the viewing device is a computer, print the message for computers
			if(session.getAttribute("isMobile").toString().equalsIgnoreCase("false"))
			{
		%>
				<br/><br/><br/><br/>
				<div id="loginContainer" style="width: 600px; display: inline-block;">
						<img src="../resources/images/successful.png" alt="Successful image" height="100" width="100" />
						<br/>
						<br/>
						<p>
							<%
								String logoutMessage = "<span style='font-size:14px; color:black;'><b>You are successfully logged out!</b><br>You will be redirected in <b><span id='container'>5</span></b> seconds.</span>";
								
								if(request.getParameter("passwordChanged") != null)
								{
									if(request.getParameter("passwordChanged").toString().equalsIgnoreCase("true"))
									{
										logoutMessage = "<span style='font-size:14px; color:black;'><b>Your password is successfully changed!</b><br>To ensure the system security, you will be logged out to activate your new password.<br>You will be redirected in <b><span id='container'>5</span></b> seconds.</span>";
									}
								}
								else if(request.getParameter("userRoleOrEmailChanged") != null)
								{
									if(request.getParameter("userRoleOrEmailChanged").toString().equalsIgnoreCase("true"))
									{
										logoutMessage = "<span style='font-size:14px; color:black;'><b>Your user role/e-mail is successfully changed!</b><br>To ensure the system security, you will be logged out to activate your new user role/e-mail.<br>You will be redirected in <b><span id='container'>5</span></b> seconds.</span>";
									}
								}
								
								out.print(logoutMessage);
							%>
						</p>
				</div>
			<%
			}
			else
			{
				%>
			    <div class="container" style="text-align: center;">
			        <div class="row">
			            <div class="col-md-6">
			                <header class="section-header">
			                    <img src="../resources/images/successful.png" alt="You are successfully logged out!" height="100" width="100" />
			                    <br/><br/>
			                    <p class="summary">You are successfully logged out!<br/>You will be redirected in <b>5</b> seconds.</p>
			                </header>
			            </div>
			        </div>
			    </div>
				<%
			}
			%>
	</div>
	        
	<!-- / section -->

</body>

<%@include file="../includes/footer.jsp"%>

<% 

	String uri = request.getRequestURI();
	String pageName = uri.substring(uri.lastIndexOf("/")+1);
	
	// If the page is logout, then terminate the session
	if(pageName.equalsIgnoreCase("logout"))
	{
		session.invalidate();
	}

%>

</html>