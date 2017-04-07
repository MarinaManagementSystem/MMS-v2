<%@ page language="java" contentType="text/html; charset=ISO-8859-9" import="java.io.*, java.util.*, java.util.Date, java.sql.*, javax.servlet.*, java.text.* "
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js" lang="en"> <!--<![endif]-->
<head>
<jsp:include page="header.jsp" />

<title>Edit a System User - Environment Tracking Software</title>

</head>

<%
	String userName, role;
	boolean userBeingEditedIsETSDeveloper = false;
	
	// Create a database object
	DatabaseSettings dbSettings = new DatabaseSettings();
	
	// Connect to the database
	Class.forName(dbSettings.getClassForName());
	Connection connection = DriverManager.getConnection(dbSettings.getDBName(), dbSettings.getDBUserName(), dbSettings.getDBPass());
	
	ResultSet resultSetForETSDevelopers = connection.createStatement().executeQuery("SELECT * FROM USERS WHERE ROLE=1");
	
	while(resultSetForETSDevelopers.next())
	{
		if(request.getParameter("userID") != null)
		{
			if(request.getParameter("userID").equalsIgnoreCase(resultSetForETSDevelopers.getString("USER_ID")))
			{
				userBeingEditedIsETSDeveloper = true;
				break;
			}
		}
	}
	
	if(session.getAttribute( "userName") == null || session.getAttribute( "password") == null)
	{
		response.sendRedirect("login.jsp");
		return;
	}
	// If the browsing user is not administrator, then do not let him access this page
	else if((!session.getAttribute("role").toString().equalsIgnoreCase("1") && !session.getAttribute("role").toString().equalsIgnoreCase("3") && !session.getAttribute("role").toString().equalsIgnoreCase("4")) || (session.getAttribute("role").toString().equalsIgnoreCase("4") && userBeingEditedIsETSDeveloper == true))
	{
		response.sendRedirect("notAllowed.jsp?pageName=editSystemUser");
		return;
	}
	else
	{
		userName = session.getAttribute("userName").toString();
		role = session.getAttribute("role").toString();
	}
	
%>

<script type="text/javascript">
	
	function newPasswordEquality()
	{
		var firstPassword = document.getElementById("newPassword").value;
		var secondPassword = document.getElementById("newPasswordAgain").value;
		
		if(firstPassword.localeCompare(secondPassword) != 0)
			{
				alert("ERROR: New password entries do not match!");
				return false;
			}
		else
			{
				return true;
			}
	}
	
	function setFocus() {
		var input = document.getElementById("userName");
		input.focus();
	}

	function setReceiveWarningEmails(fullNameOfUserBeingEdited)
	{
		var currentIndex = document.getElementById("moteIDsAndLocationsList").selectedIndex;
		
		if(currentIndex == 0)
		{	
			document.getElementById('receiveEmails').disabled = "disable";
			document.getElementById("receiveEmailsWarning").innerHTML = "<font color=\"red\">You cannot edit this option since no mote is associated with "+fullNameOfUserBeingEdited+".</font><br>Send warning e-mails if the mote that is associated with "+fullNameOfUserBeingEdited+" senses extreme conditions (i.e. high temperature or low humidity values)";
		}
		else
		{
			document.getElementById('receiveEmails').disabled = "";
			document.getElementById("receiveEmailsWarning").innerHTML = "Send warning e-mails if the mote that is associated with "+fullNameOfUserBeingEdited+" senses extreme conditions (i.e. high temperature or low humidity values)";			
		}
	}
	
	function askIfSureToDeleteUser(userID, fullNameOfUser, userRole)
	{
		if(userRole == 3)
		{
			alert("Sorry, you are only allowed to browse.");
			return false;
		}
		else if (confirm("Are you sure you want to delete "+fullNameOfUser+"?") == true) {
	    	window.location.href = "systemUsers.jsp?deleteUser="+userID+"&name="+fullNameOfUser;
	    	return true;
	    } else {
	        return false;
	    }
	}
	
	function checkUserName(enteredUserName, userRole)
	{
		$("#spaceBeforeLoaderImage").show();
		$("#loaderIcon").show();
		var username = enteredUserName; //or $("#userName").val();
		
		if(/\s/.test(username))
		{
			$("#userNameAvailabilityStatus").html('<img src="images/not-available.png" /> <span style="color:red;">Username should not contain white space.</span>');
			$("#spaceBeforeLoaderImage").hide();
			$("#loaderIcon").hide();
			$("#submit").attr("disabled", true);
			return;
		}
		else if(username.length < 3 || username.length > 15)
		{
			$("#userNameAvailabilityStatus").html('<img src="images/not-available.png" /> <span style="color:red;">Username must be 3 to 15 characters.</span>');
			$("#spaceBeforeLoaderImage").hide();
			$("#loaderIcon").hide();
			$("#submit").attr("disabled", true);
			return;
		}
		
		if(username.length >= 3 && username.length <= 15){
			//$("#userNameAvailabilityStatus").html('<img src="images/ajax-loader.gif" />');
			$.post('http://www.etrackingsoftware.com:8000/checkUserName/check_username.php', {'username':username}, function(data)
			{
			  	$("#userNameAvailabilityStatus").html(data);
			  	$("#spaceBeforeLoaderImage").hide();
			  	$("#loaderIcon").hide();
			  
			  	if(data.indexOf("registered") > -1)
				{
					$("#submit").attr("disabled", true);
				}
				else
				{
					if(userRole != 3)
					{
						$("#submit").attr("disabled", false);
					}
				}
			});
		}
	}
	
	function checkFirstPassword(password, userRole)
	{
		document.getElementById("firstPasswordCheck").innerHTML = "";
		document.getElementById("firstPasswordErrorCheck").value = "hasError";
		
		if (password.length < 3) {
			document.getElementById("firstPasswordCheck").innerHTML = "<img src='images/not-available.png' /> <span style='color:red;'>Your password should consist of at least 3 characters.</span>";
			document.getElementById('submit').disabled = "disable";
			document.getElementById("firstPasswordErrorCheck").value = "hasError";
	    } else if (password.length > 15) {
			document.getElementById("firstPasswordCheck").innerHTML = "<img src='images/not-available.png' /> <span style='color:red;'>Your password should consist of at most 15 characters.</span>";
			document.getElementById('submit').disabled = "disable";
			document.getElementById("firstPasswordErrorCheck").value = "hasError";
	    } else if (password.search(/\d/) == -1) {
			document.getElementById("firstPasswordCheck").innerHTML = "<img src='images/not-available.png' /> <span style='color:red;'>Your password should include at least one number.</span>";
			document.getElementById('submit').disabled = "disable";
			document.getElementById("firstPasswordErrorCheck").value = "hasError";
	    } else if (password.search(/[a-zA-Z]/) == -1) {
			document.getElementById("firstPasswordCheck").innerHTML = "<img src='images/not-available.png' /> <span style='color:red;'>Your password should include at least one letter.</span>";
			document.getElementById('submit').disabled = "disable";
			document.getElementById("firstPasswordErrorCheck").value = "hasError";
	    }
	    else if (password.search(/[A-Z]/) == -1) {
			document.getElementById("firstPasswordCheck").innerHTML = "<img src='images/not-available.png' /> <span style='color:red;'>Your password should include at least one capital letter.</span>";
			document.getElementById('submit').disabled = "disable";
			document.getElementById("firstPasswordErrorCheck").value = "hasError";
	    } else if (password.search(/[\?\_\.\,\~!@#$%^&*]/) == -1) {
			document.getElementById("firstPasswordCheck").innerHTML = "<img src='images/not-available.png' /> <span style='color:red;'>Your password should include at least one special character (i.e. @+./*).</span>";
			document.getElementById('submit').disabled = "disable";
			document.getElementById("firstPasswordErrorCheck").value = "hasError";
	    }
		else
		{
			document.getElementById("firstPasswordCheck").innerHTML = "<img src='images/available.png' /> <span style='color:darkgreen;'>Your password is secure enough!</span>";
			document.getElementById("firstPasswordErrorCheck").value = "hasNoError";
			if(userRole != 3)
			{
				document.getElementById('submit').disabled = "";
			}
		}
		
		document.getElementById("secondPasswordCheck").innerHTML = "disable";
		var valueOfTheSecondPassword = document.getElementById("newPasswordAgain").value;
		
		if(valueOfTheSecondPassword != password)
		{
			document.getElementById("secondPasswordCheck").innerHTML = "<img src='images/not-available.png' /> <span style='color:red;'>Passwords do not match!</span>";
			document.getElementById('submit').disabled = "disable";
		}
		else if(valueOfTheSecondPassword == "")
		{
			document.getElementById("secondPasswordCheck").innerHTML = "<img src='images/not-available.png' /> <span style='color:red;'>Your password cannot be an empty string!</span>";
			document.getElementById('submit').disabled = "disable";
		}
		else
		{
			document.getElementById("secondPasswordCheck").innerHTML = "<img src='images/available.png' /> <span style='color:darkgreen;'>Passwords match!</span>";
			if(userRole != 3 && document.getElementById("firstPasswordErrorCheck").value == "hasNoError")
			{
				document.getElementById('submit').disabled = "";
			}
			else
			{
				if(document.getElementById("firstPasswordErrorCheck").value == "hasError")
				{
					document.getElementById("secondPasswordCheck").innerHTML = "<img src='images/information.png' height='14px;' width='14px;' /> <span style='color:darkblue;'>Passwords match but you have not satisfied the security requirements!</span>";
				}
				else
				{
					document.getElementById("secondPasswordCheck").innerHTML = "<img src='images/information.png' height='14px;' width='14px;' /> <span style='color:darkblue;'>Passwords match but you do not have sufficient rights to change the password!</span>";
				}
			}
		}
	}
	
	function checkSecondPassword(password, userRole)
	{
		//document.getElementById("secondPasswordCheck").innerHTML = "";
		var valueOfTheFirstPassword = document.getElementById("newPassword").value;
		
		if(valueOfTheFirstPassword == password)
		{
			document.getElementById("secondPasswordCheck").innerHTML = "<img src='images/available.png' /> <span style='color:darkgreen;'>Passwords match!</span>";
			if(userRole != 3 && document.getElementById("firstPasswordErrorCheck").value == "hasNoError")
			{
				document.getElementById('submit').disabled = "";
			}
			else
			{
				if(document.getElementById("firstPasswordErrorCheck").value == "hasError")
				{
					document.getElementById("secondPasswordCheck").innerHTML = "<img src='images/information.png' height='14px;' width='14px;' /> <span style='color:darkblue;'>Passwords match but you have not satisfied the security requirements!</span>";
				}
				else
				{
					document.getElementById("secondPasswordCheck").innerHTML = "<img src='images/information.png' height='14px;' width='14px;' /> <span style='color:darkblue;'>Passwords match but you do not have sufficient rights to change the password!</span>";
				}
			}
		}
		else
		{
			document.getElementById("secondPasswordCheck").innerHTML = "<img src='images/not-available.png' /> <span style='color:red;'>Passwords do not match!</span>";
			document.getElementById('submit').disabled = "disable";
		}
	}
	
</script>
	
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

<body class="withAnimation" onload="setFocus();">

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
            </div>
        </div>
    </div>
</div>
<!-- / left navbar -->

<!-- / FOR MOBILE DEVICES -->

<!-- snap content -->
<div id="boxedWrapper" class="snap-content">

<nav class="navbar navbar-default navbar-transparent navbar-fixed-top" style="background-color: black;" role="navigation">
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
            <ul class="nav navbar-nav navbar-right" style="position: relative; z-index: 100;">
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
                <li class="active dropdown">
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
            </ul>
        </div>
    </div>
</nav>
<!-- / navbar -->





<!-- header -->
<header class="height">

<!-- ANY HEADER CONTENT HERE -->

</header>
<!-- / header -->

<!-- Import all java classes from the package -->
		
<%@ page import="com.environmenttrackingsoftware.conf.*" %>

<jsp:useBean id="conversionToMD5" class="com.environmenttrackingsoftware.conf.MD5" scope="session" />
<jsp:setProperty name="conversionToMD5" property="*" />

<%  
	//To set the encoding of the coming parameter from previous page's form
	request.setCharacterEncoding("ISO-8859-9");
	
	String warningMessageForPassword = "";
	String warningMessageForOtherSettings = "";
	String originalUserName = (String)session.getAttribute("userName");
	String originalPassword = (String)session.getAttribute("password");
	String fullName = session.getAttribute("fullName").toString();
	String userID = session.getAttribute("userID").toString();
	String userBeingEdited = request.getParameter("userID");
	
	String newPasswordFromUser = request.getParameter("newPassword");
	String newPasswordAgainFromUser = request.getParameter("newPasswordAgain");
	String receiveWarningEmails = request.getParameter("receiveEmails");
	
	if (newPasswordFromUser != null && !newPasswordFromUser.equalsIgnoreCase(""))
	{
		if (newPasswordFromUser.equals(newPasswordAgainFromUser))
		{	
			newPasswordFromUser = conversionToMD5.md5(newPasswordFromUser);
			connection.createStatement().executeUpdate("UPDATE USERS SET PASSWORD='"+newPasswordFromUser+"' WHERE USER_ID='"+userBeingEdited+"'");
			
			// If a user changes his own password, then log him out
			if(userID.equalsIgnoreCase(userBeingEdited))
			{
				response.sendRedirect("logout.jsp?passwordChanged=true");
				return;
			}
		}
		else
		{
			warningMessageForPassword = "New password entries do not match!";
		}
	}
	
	CharSequence referenceURL="editSystemUser";
	if(request.getHeader("Referer") == null)
	{
		warningMessageForOtherSettings = "";
	}
	else if(!request.getHeader("Referer").contains(referenceURL))
	{
		warningMessageForOtherSettings = "";
	}
	else
	{
		connection.createStatement().executeUpdate("UPDATE MOTES_AND_USERS SET MOTE_ID="+request.getParameter("moteIDsAndLocationsList")+" WHERE USER_ID="+userID+" AND MOTE_ID="+session.getAttribute("moteID").toString());
		
		if(receiveWarningEmails != null)
		{
			connection.createStatement().executeUpdate("UPDATE USERS SET RECEIVE_EMAILS='YES', USERNAME='"+request.getParameter("userName")+"', EMAIL='"+request.getParameter("eMailAddress")+"', ROLE="+request.getParameter("userCategoryList")+" WHERE USER_ID="+userBeingEdited+"");
			if(session.getAttribute("userID").toString().equalsIgnoreCase(userBeingEdited))
			{
				response.sendRedirect("logout.jsp?userRoleOrEmailChanged=true");
			}
		}
		else
		{
			connection.createStatement().executeUpdate("UPDATE USERS SET RECEIVE_EMAILS='NO', USERNAME='"+request.getParameter("userName")+"', EMAIL='"+request.getParameter("eMailAddress")+"', ROLE="+request.getParameter("userCategoryList")+" WHERE USER_ID="+userBeingEdited+"");
			if(session.getAttribute("userID").toString().equalsIgnoreCase(userBeingEdited))
			{
				response.sendRedirect("logout.jsp?userRoleOrEmailChanged=true");
			}
		}
		
		warningMessageForOtherSettings = "All changes are successfully saved!<br><font color=\"#9F9F9F\">Please click <a href=\"systemUsers.jsp\">here</a> to return to the <a href=\"systemUsers.jsp\">System Users</a> page.</font>";
	}
	
	ResultSet resultSetForUserInfo = connection.createStatement().executeQuery("SELECT u.USER_ID, ur.ROLE_NAME, u.USERNAME, u.FULL_NAME, u.EMAIL, u.PASSWORD, u.LAST_LOGIN, u.RECEIVE_EMAILS, mau.MOTE_ID, m.MOTE_LOCATION FROM USERS u, USER_ROLES ur, MOTES_AND_USERS mau, MOTES m WHERE u.ROLE = ur.ROLE_ID AND mau.USER_ID = u.USER_ID AND m.MOTE_ID = mau.MOTE_ID AND u.USER_ID='"+userBeingEdited+"'");
	
	ResultSet resultSetForUserCategories = connection.createStatement().executeQuery("SELECT ROLE_ID, ROLE_NAME FROM USER_ROLES ORDER BY ROLE_NAME");
	
	ResultSet resultSetForMoteIDsAndLocations = connection.createStatement().executeQuery("SELECT MOTE_ID, MOTE_LOCATION FROM MOTES ORDER BY MOTE_ID");
%>

<!--  section icon box -->
<div class="grey content-area" id="iconbuttons" style="background-color: white;">
    <div class="container">
    
	    <%
		// If the viewing device is not mobile, then put some line breaks
		if(session.getAttribute("isMobile").toString().equalsIgnoreCase("false"))
		{
	  		%>
	    		<br/><br/><br/>
	    	<%
		}
	    %>
		
		<h2>Edit a System User</h2>
	
		<p align="justify" style="font-size: 15px;">
		<% 
			String associatedMoteID = null;
			String associatedMoteLocation = null;
			String userCategory = null;
			String receiveEmails = null;
			String lastLogin = null;
			String userNameOfUserBeingEdited = null;
			String fullNameOfUserBeingEdited = null;
			String eMailOfUserBeingEdited = null;
		
			if(resultSetForUserInfo.next())
			{
				String lastLoginDateAndTime = null;
				try
				{
					lastLoginDateAndTime = resultSetForUserInfo.getString("LAST_LOGIN");
				}
				catch(SQLException e)
				{
					// Do nothing, do not print the exception trace
				}
				
				associatedMoteID = resultSetForUserInfo.getString("MOTE_ID");
				session.setAttribute("moteID", associatedMoteID);
				associatedMoteLocation = resultSetForUserInfo.getString("MOTE_LOCATION");
				userCategory = resultSetForUserInfo.getString("ROLE_NAME");
				receiveEmails = resultSetForUserInfo.getString("RECEIVE_EMAILS");
				userNameOfUserBeingEdited = resultSetForUserInfo.getString("USERNAME");
				fullNameOfUserBeingEdited = resultSetForUserInfo.getString("FULL_NAME");
				eMailOfUserBeingEdited = resultSetForUserInfo.getString("EMAIL");
				
				if(lastLoginDateAndTime != null)
				{
					String [] partsOfLastLogin = lastLoginDateAndTime.split(" ");
					String date = partsOfLastLogin[0];
					String time = partsOfLastLogin[1];
					
					// Remove the last two characters from the end of time string (remove milliseconds)
					time = time.substring(0, time.length()-5);
					
					String [] partsOfDate = date.split("-");
					String year = partsOfDate[0];
					String month = partsOfDate[1];
					String day = partsOfDate[2];
					lastLogin = day+"."+month+"."+year+" at "+time;
				}
				else
				{
					lastLogin = "Never logged in before";
				}
				
				if(associatedMoteID == null)
				{
					associatedMoteID = "None";
					associatedMoteLocation = "no location";
				}
	
			}
			
			if(request.getParameter("newUser") != null)
			{
				warningMessageForOtherSettings = userNameOfUserBeingEdited+" ("+fullNameOfUserBeingEdited+") is successfully added to the ETS!<br><font color=\"#9F9F9F\">Please click <a href=\"systemUsers.jsp\">here</a> to return to the <a href=\"systemUsers.jsp\">System Users</a> page.</font>";
			}
			
			// Remove the Turkish characters from the full name of the user before passing it for the delete operation
    		LatestMoteInfo textToConvert = new LatestMoteInfo();
    		String fullNameOfTheUser = textToConvert.convertToLatinFromTurkish(fullNameOfUserBeingEdited);
			
		 %>
		 You can change the settings of <% out.print(fullNameOfUserBeingEdited); %> by filling in the appropriate form elements below and hitting the 'Save' button:
		 </p>
		<br/>
		
		<a class="btn btn btn-warning" href="systemUsers.jsp">Go back</a>
		<a class="btn btn btn-danger <% if(userID.equalsIgnoreCase(userBeingEdited)) { out.print("disabled"); } %>" href="#" onclick="return askIfSureToDeleteUser(<% out.print(userBeingEdited+", '"+fullNameOfTheUser+"', "+session.getAttribute("role").toString()); %>);" >Remove <% out.print(userNameOfUserBeingEdited); %> from ETS</a>
		<%
			if(userID.equalsIgnoreCase(userBeingEdited))
			{
				%>
					<br>
					<font color="#E68F8D">Sorry, you cannot delete yourself.</font>
				<% 
			}
		%>
		<br><br>
		
				<form action="editSystemUser.jsp?userID=<% out.print(userBeingEdited); %>" id="editSystemUser" method="post" onsubmit="return newPasswordEquality();">
				<%
					if(!warningMessageForPassword.equalsIgnoreCase(""))
					{
				%>
				        <div class=" alert alert-danger alert-dismissable">
		            	<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
		            	<% out.print("<p style='font-size: 15px;'><b><font color='red'>ERROR:</font></b> "+warningMessageForPassword+"</p>"); %>
		       			</div>
		       	<%
						//out.println("<p style='font-size: 15px;'><b><font color='red'>ERROR:</font></b> "+warningMessage+"</p><br>");
					}
				%>
				<%
					if(!warningMessageForOtherSettings.equalsIgnoreCase(""))
					{
				%>
				        <div class=" alert alert-success alert-dismissable">
		            	<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
		            	<% out.print("<p style='font-size: 15px;'><font color='darkgreen'>"+warningMessageForOtherSettings+"</font></p>"); %>
		       			</div>
		       	<%
						//out.println("<p style='font-size: 15px;'><b><font color='red'>ERROR:</font></b> "+warningMessage+"</p><br>");
					}
				%>
					<table align="center" width="100%" style="table-layout: fixed;">
						<tr>
							<td align="right" width="22.4%" style="vertical-align:top">
								<h4 class="hr-left uppercase">Username:</h4>
							</td>
							<td width="25px;">
								<!-- Empty column -->
							</td>
							<td align="left">
								<table>
									<tr>
										<td>
											<input type="text" value="<% out.print(userNameOfUserBeingEdited); %>" class="form-control input-sm" style="width: 235px;" name="userName" id="userName" tabindex="1" onkeyup="checkUserName(this.value, <% out.print(session.getAttribute("role").toString()); %>)" required>
										</td>
										<td>
											<!-- checkUserName(this.value) function's PHP script is at /var/www/checkUserName/ -->
											<span id="spaceBeforeLoaderImage">&nbsp;&nbsp;&nbsp;</span>
											<img src="images/ajax-loader.gif" id="loaderIcon" style="display:none" />
											<span id="userNameAvailabilityStatus" style="padding-left:10px; ; vertical-align: middle;"></span>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td align="right" width="22.4%" style="vertical-align:top">
								<h4 class="hr-left uppercase">Full name:</h4>
							</td>
							<td width="25px;">
								<!-- Empty column -->
							</td>
							<td align="left">
								<input type="text" value="<% out.print(fullNameOfUserBeingEdited); %>" class="form-control input-sm" style="width: 235px;" name="fullName" id="fullName" tabindex="2" required>
							</td>
						</tr>
						<tr>
							<td align="right" width="22.4%" style="vertical-align:top">
								<h4 class="hr-left uppercase">E-mail address:</h4>
							</td>
							<td width="25px;">
								<!-- Empty column -->
							</td>
							<td align="left">
								<input type="email" value="<% if(session.getAttribute("role").toString().equalsIgnoreCase("3")) { out.print("HIDDEN"); } else { out.print(eMailOfUserBeingEdited); } %>" class="form-control input-sm" style="width: 235px;" name="eMailAddress" id="eMailAddress" tabindex="3" required>
							</td>
						</tr>
						<tr>
							<td align="right" width="22.4%" style="vertical-align:top">
								<h4 class="hr-left uppercase">User category:</h4>
							</td>
							<td width="25px;">
								<!-- Empty column -->
							</td>
							<td align="left">
								<select class="form-control" id="userCategoryList" name="userCategoryList" style="width: 235px; height: 33px;" tabindex="4">
										<%
											while (resultSetForUserCategories.next())
											{
												if(session.getAttribute("role").toString().equalsIgnoreCase("4") && (resultSetForUserCategories.getString("ROLE_NAME").toString().toLowerCase().contains("developer") || resultSetForUserCategories.getString("ROLE_NAME").toString().toLowerCase().contains("demo")))
												{
													// Do nothing
												}
												else
												{
										%>
													<option value="<% out.print(resultSetForUserCategories.getString("ROLE_ID"));%>" <% if(resultSetForUserCategories.getString("ROLE_NAME").equalsIgnoreCase(userCategory)) { out.print("selected"); } %>>
														<%
															out.print(resultSetForUserCategories.getString("ROLE_NAME"));
														%>
													</option>
										<%		}
											} %>
								</select>
							</td>
						</tr>
						<tr>
							<td align="right" width="22.4%" style="vertical-align:top">
								<h4 class="hr-left uppercase">Associated mote ID:</h4>
							</td>
							<td width="25px;">
								<!-- Empty column -->
							</td>
							<td align="left">
								<select class="form-control" id="moteIDsAndLocationsList" name="moteIDsAndLocationsList" style="width: 235px; height: 33px;" onchange="setReceiveWarningEmails('<% out.print(fullNameOfUserBeingEdited); %>');" tabindex="5">
										<%
											while (resultSetForMoteIDsAndLocations.next())
											{
										%>
												<option value="<% out.print(resultSetForMoteIDsAndLocations.getString("MOTE_ID"));%>" <% if(resultSetForMoteIDsAndLocations.getString("MOTE_ID").equalsIgnoreCase(associatedMoteID)) { out.print("selected"); } %>>
													<%
														if(resultSetForMoteIDsAndLocations.getString("MOTE_ID").equalsIgnoreCase("0"))
														{
															out.print("None");
														}
														else
														{
															out.print(resultSetForMoteIDsAndLocations.getString("MOTE_ID")+" ("+resultSetForMoteIDsAndLocations.getString("MOTE_LOCATION")+")");
														}
													%>
												</option>
										<%	} %>
								</select>
							</td>
						</tr>
						<tr>
							<td align="right" width="22.4%" style="vertical-align:top">
								<h4 class="hr-left uppercase">Send e-mails:</h4>
								
							</td>
							<td width="25px;">
								<!-- Empty column -->
							</td>
							<td align="left">
								<div class="checkbox">
			                      	<label>
			                      	<%
			                      		if(associatedMoteID.equalsIgnoreCase("0"))
			                      		{
			                      			%>
			                      				<input type="checkbox" name="receiveEmails" id="receiveEmails" tabindex="6" disabled="disabled"><p style="font-size: 15px;" id="receiveEmailsWarning"><font color="red">You cannot edit this option since no mote is associated with <% out.print(fullNameOfUserBeingEdited); %>.</font><br>Send warning e-mails if the mote that is associated with <% out.print(fullNameOfUserBeingEdited); %> senses extreme conditions (i.e. high temperature or low humidity values)</p>
			                      			<%
			                      		}
			                      		else
			                      		{
			                      			%>
		                      					<input type="checkbox" name="receiveEmails" id="receiveEmails" <% if(receiveEmails.equalsIgnoreCase("YES")) { out.print("checked=\"checked\""); } %> tabindex="6"><p style="font-size: 15px;" id="receiveEmailsWarning">Send warning e-mails if the mote that is associated with <% out.print(fullNameOfUserBeingEdited); %> senses extreme conditions (i.e. high temperature or low humidity values)</p>
		                      				<%
			                      		}
			                      	%>
			                      	</label>
	                   			</div>
							</td>
						</tr>
						<tr>
							<td align="right" width="22.4%" style="vertical-align:top">
								<h4 class="hr-left uppercase">Last Login:</h4>
							</td>
							<td width="25px;">
								<!-- Empty column -->
							</td>
							<td align="left">
								<input type="text" value="<% out.print(lastLogin); %>" class="form-control input-sm" style="width: 235px;" name="lastLogin" id="lastLogin" tabindex="7" readonly>
							</td>
						</tr>
						<tr>
							<td align="right" width="22.4%" style="vertical-align:top">
								<h4 class="hr-left uppercase">New password:</h4>
							</td>
							<td width="25px;">
								<!-- Empty column -->
							</td>
	
							<td align="left">
								<table>
									<tr>
										<td>
											<input type="password" class="form-control input-sm" style="width: 235px;" name="newPassword" id="newPassword" onkeyup="checkFirstPassword(this.value, <% out.print(session.getAttribute("role").toString()); %>);" tabindex="8">
										</td>
										<td>
											<span id="firstPasswordCheck" style="padding-left:10px; ; vertical-align: middle;"></span>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td align="right" width="22.4%" style="vertical-align:top">
								<h4 class="hr-left uppercase">Re-enter new password:</h4>
							</td>
							<td width="25px;">
								<!-- Empty column -->
							</td>
	
							<td align="left">
								<table>
									<tr>
										<td>
											<input type="password" class="form-control input-sm" style="width: 235px;" name="newPasswordAgain" id="newPasswordAgain" onkeyup="checkSecondPassword(this.value, <% out.print(session.getAttribute("role").toString()); %>);" tabindex="9">
										</td>
										<td>
											<span id="secondPasswordCheck" style="padding-left:10px; ; vertical-align: middle;"></span>
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
								<input class="btn btn-sm btn-success" name="submit" id="submit" tabindex="10" value="Save" type="submit" tabindex="10" <% if (role.equalsIgnoreCase("3")) { out.print("disabled"); } %>>
								<input name="firstPasswordErrorCheck" id="firstPasswordErrorCheck" type="hidden">
							</td>
						</tr>
					</table>
				</form>

    </div>
</div>

<!-- / section -->

<br>
<!-- footer -->

<jsp:include page="footer.jsp" />