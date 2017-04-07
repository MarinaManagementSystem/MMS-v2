<%@ page language="java" contentType="text/html; charset=ISO-8859-9" import="java.io.*, java.util.*, java.util.Date, java.sql.*, javax.servlet.*, java.text.* "
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js" lang="en"> <!--<![endif]-->
<head>
<jsp:include page="header.jsp" />

<title>System Users - Environment Tracking Software</title>

</head>

<%
	
	//To set the encoding of the coming parameter from previous page's form
	request.setCharacterEncoding("ISO-8859-9");

	String userName, userID;
	gelenRole;
	if(session.getAttribute("userName") == null || session.getAttribute("password") == null)
	{
		response.sendRedirect("login.jsp");
		return;
	}
	// If the browsing user is not administrator, then do not let him access this page
	else if(!session.getAttribute("role").toString().equalsIgnoreCase("1") && !session.getAttribute("role").toString().equalsIgnoreCase("3") && !session.getAttribute("role").toString().equalsIgnoreCase("4"))
	{
		response.sendRedirect("notAllowed.jsp?pageName=systemUsers");
		return;
	}
	else
	{
		userName = session.getAttribute("userName").toString();
		userID = session.getAttribute("userID").toString();
	}
	
	// Create a database object
	DatabaseSettings dbSettings = new DatabaseSettings();
	
	// Connect to the database
	Class.forName(dbSettings.getClassForName());
	Connection connection = DriverManager.getConnection(dbSettings.getDBName(), dbSettings.getDBUserName(), dbSettings.getDBPass());
	
	Statement statementForQueryResults = connection.createStatement();
%>

<script type="text/javascript">
	
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
	
	function askIfSureToDeleteUsers(userRole)
	{
		if(userRole == 3)
		{
			alert("Sorry, you are only allowed to browse.");
			return false;
		}
		else if (confirm("Are you sure you want to delete the selected users?") == true) {
	    	return true;
	    } else {
	        return false;
	    }
	}
	
	function enableOrDisableDeleteUsersButton()
	{
		  var checkboxes = document.getElementsByName("selectedUsers");
		  var thereIsACheckedCheckBox = false;
		  
		  // loop over them all
		  for (var i=0; i<checkboxes.length; i++) {
		     // And stick the checked ones onto an array...
		     if (checkboxes[i].checked)
		     {
		    	 document.getElementById('deleteUsersButton').disabled = "";
		    	 thereIsACheckedCheckBox = true;
		    	 break;
		     }
		  }
		  
		  if(thereIsACheckedCheckBox == false)
		  {
			  document.getElementById('deleteUsersButton').disabled = "disable";
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
                        		<li class="active"><a href="systemUsers.jsp">System Users<span>Edit system users</span></a></li>
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


<%
	String warningMessage = "";
	StringBuilder stringBuilderForTheUserDeletion = new StringBuilder();
	if(request.getParameter("selectedUsers") != null)
	{
		String[] IDsOfUsersToBeDeleted = request.getParameterValues("selectedUsers");
		
		stringBuilderForTheUserDeletion.append("DELETE FROM USERS WHERE");
		
		for(int i=0; i<IDsOfUsersToBeDeleted.length; i++)
		{
			if(i==0)
			{
				stringBuilderForTheUserDeletion.append(" USER_ID="+IDsOfUsersToBeDeleted[i]);
			}
			else
			{
				stringBuilderForTheUserDeletion.append(" OR USER_ID="+IDsOfUsersToBeDeleted[i]);
			}
		}
		
		connection.createStatement().executeUpdate(stringBuilderForTheUserDeletion.toString());
		warningMessage = "Selected users are successfully deleted from ETS!";
	}
	
	System.out.print(stringBuilderForTheUserDeletion);
	//System.out.println(stringBuilderForTheUserDeletion);



%>


<!-- header -->
<header class="height">

<!-- ANY HEADER CONTENT HERE -->

</header>
<!-- / header -->

<!-- Import all java classes from the package -->
		
<%@ page import="com.environmenttrackingsoftware.conf.*" %>


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
        
        <h2>System Users</h2>
		<p style="font-size: 15px;">All users under your supervision are listed below.</p>
		<br/>
		
		<%
			if(request.getParameter("deleteUser") != null)
			{
				String userToBeDeleted = request.getParameter("deleteUser");
				String fullNameOfUser = request.getParameter("name");
				connection.createStatement().executeUpdate("DELETE FROM USERS WHERE USER_ID="+userToBeDeleted);
				
				warningMessage = fullNameOfUser+" is successfully removed from the ETS.";
			}
			
			ResultSet resultSetForQueryResults = statementForQueryResults.executeQuery("SELECT u.USER_ID, ur.ROLE_NAME, u.FULL_NAME, u.EMAIL, u.PASSWORD, u.LAST_LOGIN, mau.MOTE_ID, m.MOTE_LOCATION FROM USERS u, USER_ROLES ur, MOTES_AND_USERS mau, MOTES m WHERE u.ROLE = ur.ROLE_ID AND mau.USER_ID = u.USER_ID AND m.MOTE_ID = mau.MOTE_ID ORDER BY ROLE_NAME, FULL_NAME");
			
			if(!warningMessage.equalsIgnoreCase(""))
			{
		%>
		        <div class=" alert alert-success alert-dismissable">
            	<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
            	<% out.print("<p style='font-size: 15px;'><font color='darkgreen'>"+warningMessage+"</font></p>"); %>
       			</div>
       			
       	<%
				//out.println("<p style='font-size: 15px;'><b><font color='red'>ERROR:</font></b> "+warningMessage+"</p><br>");
			}
			if(session.getAttribute("role").toString().equalsIgnoreCase("3"))
			{
				%>
			        <div class=" alert alert-info alert-dismissable">
	            	<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
	            	<% out.print("<p style='font-size: 15px; color:darkyellow;'>Since this is a demo user account, you are only allowed to surf between pages on ETS. Please contact us via the <a href='contactUs.jsp'>Contact us</a> page to experience the ETS with administrator privileges.</p>"); %>
	       			</div>
				<%
			}
		%>
		
		<form action="systemUsers.jsp" id="systemUsers" onsubmit="return askIfSureToDeleteUsers(<%  out.print(session.getAttribute("role").toString()); %>);" method="post" >
		
		
		
		
		<div id="addAndRemoveButtons" align="right">
			<a class="btn btn btn-success" href="newSystemUser.jsp">Add a new user</a>
			<input class="btn btn btn-danger" name="deleteUsersButton" id="deleteUsersButton" value="Delete selected users" type="submit" tabindex="10" disabled="disable" >
		</div>
		<br/>
		
        <table class="table table-hover" style="overflow:scroll;">
            <thead>
            <tr style="background-color:#4A4744; table-layout:fixed">
                <th><font color="white">Options</font></th>
                <th><font color="white">User Role</font></th>
                <th><font color="white">Full Name</font></th>
                <th><font color="white">E-mail</font></th>
                <th><font color="white">Associated Mote ID</font></th>
                <th><font color="white">Last Login</font></th>
            </tr>
            </thead>
            	<%
            		if(!resultSetForQueryResults.next())
            		{
            	%>
				<tr>
					<td colspan="6" style="border: 2px solid #DDDDDD; height:190px; vertical-align:middle">No data found!</td>
				</tr>
				<tbody>
				<%
            		}
            		else
            		{
            			do
            			{
            				// Remove the Turkish characters from the full name of the user before passing it for the delete operation
            	    		LatestMoteInfo textToConvert = new LatestMoteInfo();
            	    		String fullNameOfTheUser = textToConvert.convertToLatinFromTurkish(resultSetForQueryResults.getString("FULL_NAME"));
            						
            	    		if(session.getAttribute("role").toString().equalsIgnoreCase("4") && (resultSetForQueryResults.getString("ROLE_NAME").toLowerCase().contains("developer") || resultSetForQueryResults.getString("ROLE_NAME").toLowerCase().contains("demo")))
            	    		{
            	    			// Do nothing since Head Field Engineers are not allowed to browse ETS Developers or Demo Users
            	    		}
            	    		else
            	    		{
            	%>
	            	            <tr>
	            	            	<td style="border: 2px solid #DDDDDD;">
					                    <input type="checkbox" name="selectedUsers" value="<%out.print(resultSetForQueryResults.getString("USER_ID"));%>" onChange="enableOrDisableDeleteUsersButton();" tabindex="1" <% if(userID.equals(resultSetForQueryResults.getString("USER_ID"))) { out.print("disabled='disabled'"); } %>>
			                   			&nbsp;&nbsp;&nbsp;
	            	                	<a href="editSystemUser.jsp?userID=<%out.println(resultSetForQueryResults.getString("USER_ID"));%>">
	            	                		<img src="images/edit.png" alt="Edit" height="16" width="16">
	            	                	</a>&nbsp;&nbsp;&nbsp;
	            	                	<%
	               	                		if(userID.equals(resultSetForQueryResults.getString("USER_ID")))
	               	                		{
	               	                			%>
	               	                				<img src="images/deleteDisabled.png" alt="Delete" height="16" width="16">
	               	                			<% 
	               	                		}
	               	                		else
	               	                		{
	               	                			%>
	               	                				<a href="#" onclick="return askIfSureToDeleteUser(<% out.print(resultSetForQueryResults.getString("USER_ID")+", '"+fullNameOfTheUser+"', "+session.getAttribute("role").toString()); %>);" >
	               	                					<img src="images/delete.png" alt="Delete" height="16" width="16">
	               	                				</a>
	               	                			<%
	               	                		}
	            	                	%>
	            					</td>
	            	                <td style="border: 2px solid #DDDDDD;">	
	            	                		<%
	            	                			if(resultSetForQueryResults.getString("ROLE_NAME").toLowerCase().contains("developer"))
	            	                			{
	            	                				out.println("<font color=red>"+resultSetForQueryResults.getString("ROLE_NAME")+"</font>");
	            	                			}
	            	                			else if(resultSetForQueryResults.getString("ROLE_NAME").toLowerCase().contains("demo"))
		        	                			{
		        	                				out.println("<font color=black>"+resultSetForQueryResults.getString("ROLE_NAME")+"</font>");
		        	                			}
	            	                			else
	            	                			{
	            	                				out.println("<font color=darkblue>"+resultSetForQueryResults.getString("ROLE_NAME")+"</font>");
	            	                			}
	            							%>
	            					</td>
	            	                <td style="border: 2px solid #DDDDDD;">	
	            	                		<%
		            	                		out.println(resultSetForQueryResults.getString("FULL_NAME"));
	            							%>
	            					</td>
	            	                <td style="border: 2px solid #DDDDDD;">	
	            	                		<%
		            	                		if(session.getAttribute("role").toString().equalsIgnoreCase("3"))
		        	                			{
		        	                				out.println("HIDDEN");
		        	                			}
		            	                		else
		            	                		{
		            	                			out.println(resultSetForQueryResults.getString("EMAIL"));
		            	                		}
	            							%>
	            					</td>
					                <td style="border: 2px solid #DDDDDD;">
					                   		<%
					                   			if(resultSetForQueryResults.getString("MOTE_ID").equalsIgnoreCase("0"))
					                   			{
					                   				out.println("None (no location)");
					                   			}
					                   			else
					                   			{
					                   				out.println(resultSetForQueryResults.getString("MOTE_ID")+" ("+resultSetForQueryResults.getString("MOTE_LOCATION")+")");
					                   			}
											%>
					                </td>
					                <td style="border: 2px solid #DDDDDD;">
					                		<%
						        				String lastLoginDateAndTime = null;
						        				try
						        				{
						        					lastLoginDateAndTime = resultSetForQueryResults.getString("LAST_LOGIN");
						        				}
						        				catch(SQLException e)
						        				{
						        					// Do nothing, do not print the exception trace
						        				}
						        				
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
						        					out.println(day+"."+month+"."+year+", "+time);
						        				}
						        				else
						        				{
						        					out.println("Never logged in before");
						        				}
											%>
					                </td>
	            				</tr>
            	<%
            	    		}
            			}while(resultSetForQueryResults.next());
            		}
				%>
            	</tbody>
        </table>
        
        </form>
        
    </div>
</div>
<!-- / section -->

<br>
<!-- footer -->

<jsp:include page="footer.jsp" />