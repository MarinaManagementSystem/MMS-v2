<%@ page language="java" contentType="text/html; charset=ISO-8859-9" import="java.io.*, java.util.*, java.util.Date, java.sql.*, javax.servlet.*, java.text.* "
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js" lang="en"> <!--<![endif]-->
<head>
<jsp:include page="header.jsp" />

<title>Server Settings - Environment Tracking Software</title>

</head>

<%

	String userName, role;
	if(session.getAttribute( "userName") == null || session.getAttribute( "password") == null)
	{
		response.sendRedirect("login.jsp");
		return;
	}
	else
	{
		userName = session.getAttribute("userName").toString();
		role = session.getAttribute("role").toString();
	}
	
%>

<script type="text/javascript">

	//var 
	
	function setToListViaFromList(receivedID)
	{
		//alert(receivedID);
		
		if(receivedID.toLowerCase() == "temperatureDownLimit".toLowerCase())
		{
			//var elementArrayOfToList = document.getElementById("toTemperatureList").getElementsByTagName("option");
			var elementArrayOfToList = document.getElementById("temperatureUpLimit");
		}
		else if (receivedID.toLowerCase() == "humidityDownLimit".toLowerCase())
		{
			//var elementArrayOfToList = document.getElementById("toHumidityList").getElementsByTagName("option");
			var elementArrayOfToList = document.getElementById("humidityUpLimit");
		}
		else
		{
			// Do nothing, something is wrong
		}
		
		var elementsOfFromList = document.getElementById(receivedID);
		var selectedTextFromFromList = elementsOfFromList.options[elementsOfFromList.selectedIndex].text;
		var selectedTextFromToList = elementArrayOfToList.options[elementArrayOfToList.selectedIndex].text;
		
		var elementArrayOfFromList = document.getElementById(receivedID).getElementsByTagName("option");
		
		elementArrayOfToList.options.length=0;
		var selectedTexFromToListIsWithinTheNewRange = false;
		
		for (var i = 0; i < elementArrayOfFromList.length; i++) {
			
			if(parseInt(elementArrayOfFromList[i].text) >= parseInt(selectedTextFromFromList))
			{
				var option = new Option(elementArrayOfFromList[i].text, elementArrayOfFromList[i].text);
				elementArrayOfToList.add(option);
				
				if(parseInt(elementArrayOfFromList[i].text) == parseInt(selectedTextFromToList))
				{
					selectedTexFromToListIsWithinTheNewRange = true;
					elementArrayOfToList.options[elementArrayOfToList.options.length-1].selected = true;
				}
			}
		}
		if(!selectedTexFromToListIsWithinTheNewRange)
		{
			elementArrayOfToList.options[elementArrayOfToList.options.length-1].selected = true;
		}
	}
	
	function saveInitialValues()
	{
		document.getElementById("hiddenTempDownLimit").value = document.getElementById("temperatureDownLimit").value;
		document.getElementById("hiddenTempUpLimit").value = document.getElementById("temperatureUpLimit").value;
		document.getElementById("hiddenHumidDownLimit").value = document.getElementById("humidityDownLimit").value;
		document.getElementById("hiddenHumidUpLimit").value = document.getElementById("humidityUpLimit").value;
		document.getElementById("hiddenBatteryDownLimit").value = document.getElementById("batteryDownLimit").value;
		document.getElementById("hiddenNoOfMeasurementsPerDay").value = document.getElementById("numberOfMeasurementsPerDay").value;
		document.getElementById("hiddenLightSenseCondition").value = document.getElementById("lightStateCondition").checked;
		document.getElementById("hiddenLightSenseConditionNew").value = document.getElementById("lightStateCondition").checked;
		document.getElementById("hiddenTempThreshold").value = document.getElementById("temperatureThreshold").value;
		document.getElementById("hiddenHumidThreshold").value = document.getElementById("humidityThreshold").value;
	}
	
	function setNewLightContidion()
	{
		document.getElementById("hiddenLightSenseConditionNew").value = document.getElementById("lightStateCondition").checked;
	}
	
	function checkInitialValues()
	{
		if(document.getElementById("hiddenTempDownLimit").value == document.getElementById("temperatureDownLimit").value && document.getElementById("hiddenTempUpLimit").value == document.getElementById("temperatureUpLimit").value && document.getElementById("hiddenHumidDownLimit").value == document.getElementById("humidityDownLimit").value && document.getElementById("hiddenHumidUpLimit").value == document.getElementById("humidityUpLimit").value && document.getElementById("hiddenBatteryDownLimit").value == document.getElementById("batteryDownLimit").value && document.getElementById("hiddenNoOfMeasurementsPerDay").value == document.getElementById("numberOfMeasurementsPerDay").value && document.getElementById("hiddenLightSenseCondition").value == document.getElementById("hiddenLightSenseConditionNew").value && document.getElementById("hiddenTempThreshold").value == document.getElementById("temperatureThreshold").value && document.getElementById("hiddenHumidThreshold").value == document.getElementById("humidityThreshold").value)
		{
			alert("ERROR: You did not change any settings!");
			return false;
		}
		else
		{
			return true;
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

<body class="withAnimation" onload="setToListViaFromList('temperatureDownLimit'); setToListViaFromList('humidityDownLimit'); saveInitialValues();">

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
                        <li class="active"><a href="serverSettings.jsp">Server Settings<span>Change server settings</span></a></li>
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

<%  //To set the encoding of the coming parameter from previous page's form
	request.setCharacterEncoding("ISO-8859-9");
         
    String warningMessage = null, warningType = "success";

	// Create a database object
	DatabaseSettings dbSettings = new DatabaseSettings();
	
	// Connect to the database
	Class.forName(dbSettings.getClassForName());
	Connection connection = DriverManager.getConnection(dbSettings.getDBName(), dbSettings.getDBUserName(), dbSettings.getDBPass());
	
	SimpleDateFormat firstHourFormat = new SimpleDateFormat("dd:MM:yyyy:HH:mm:a");
	Date dateNow = new Date();
	String currentDate = firstHourFormat.format(dateNow).toString();
	String[] parts = currentDate.split(":");
	String currentDay = parts[0];
	String currentMonth = parts[1];
	String currentYear = parts[2];
	
	String currentHour = parts[3];
	String currentMinutes = parts[4];
	String currentAMOrPM = parts[5];
	String currentTime = currentHour+":"+currentMinutes;
	
	if (!role.equalsIgnoreCase("1")) 
	{
    	warningType = "danger";
    	warningMessage = "<b><font color='red'>ERROR:</font></b> It seems like you do not have appropriate privileges to make changes on server settings! However, you are authorized to view them.";
    	if(role.equalsIgnoreCase("3"))
    	{
    		warningType = "info";
        	warningMessage = "Since this is a demo user account, you are not allowed to make changes on server settings. However, you are authorized to view them.";
    	}
	}
    
    if(request.getParameter("temperatureDownLimit")!=null && request.getParameter("temperatureUpLimit")!=null && request.getParameter("humidityDownLimit")!=null && request.getParameter("humidityUpLimit")!=null && request.getParameter("batteryDownLimit")!= null && request.getParameter("numberOfMeasurementsPerDay")!=null && request.getParameter("temperatureThreshold")!=null && request.getParameter("humidityThreshold")!=null)
    {
    	String temperatureLowerBound = request.getParameter("temperatureDownLimit");
    	String temperatureUpperBound = request.getParameter("temperatureUpLimit");
    	String humidityLowerBound = request.getParameter("humidityDownLimit");
    	String humidityUpperBound = request.getParameter("humidityUpLimit");
    	String batteryLevelLowerBound = request.getParameter("batteryDownLimit");
    	String newNumberOfMeasurementsPerDay = request.getParameter("numberOfMeasurementsPerDay");
    	String lightStateCondition = null;
    	
    	if(request.getParameter("lightStateCondition") != null)
    	{
    		lightStateCondition = "YES";
    	}
    	else
    	{
    		lightStateCondition = "NO";
    	}
    	
    	String thresholdForTemperature = request.getParameter("temperatureThreshold");
    	String thresholdForHumidity = request.getParameter("humidityThreshold");
    	
    	connection.createStatement().executeUpdate("UPDATE SETTINGS SET BATTERY_DOWN_LIMIT="+batteryLevelLowerBound+", TEMP_DOWN_LIMIT="+temperatureLowerBound+", TEMP_UP_LIMIT="+temperatureUpperBound+", HUMID_DOWN_LIMIT="+humidityLowerBound+", HUMID_UP_LIMIT="+humidityUpperBound+", SENSE_LIGHT_ON_STATE_CHANGE='"+lightStateCondition+"', TEMP_THRESHOLD="+thresholdForTemperature+", HUMID_THRESHOLD="+thresholdForHumidity+", NO_OF_MEASUREMENTS_PER_DAY="+newNumberOfMeasurementsPerDay+" WHERE ID=1");
    	
    	// Find the nearest reprogram time
    	ResultSet resultSetForReprogrammingTimes = connection.createStatement().executeQuery("SELECT * FROM REPROGRAMMING_TIMES");
    	ArrayList<String> listOfReprogrammingTimes = new ArrayList<String>();
    	
    	while(resultSetForReprogrammingTimes.next())
    	{	
    		String tempTime = resultSetForReprogrammingTimes.getString("TIME");
    		// Remove seconds from the string
    		tempTime = tempTime.substring(0, tempTime.length()-3);
    		//if(!tempTime.equalsIgnoreCase("04:05"))
    		listOfReprogrammingTimes.add(tempTime);
    	}
    	listOfReprogrammingTimes.add(currentTime);
    	
    	String nearestTime = null;
    	
    	Collections.sort(listOfReprogrammingTimes);
    	
    	for(int i=0; i<listOfReprogrammingTimes.size(); i++)
    	{
    		if(currentTime.equalsIgnoreCase(listOfReprogrammingTimes.get(i)))
    		{
    			if(i+1 == listOfReprogrammingTimes.size())
    			{
    				nearestTime = listOfReprogrammingTimes.get(0);
    			}
    			else
    			{
    				nearestTime = listOfReprogrammingTimes.get(i+1);
    			}
    		}
    	}
    	
    	warningType = "success";
    	warningMessage = "<font color='darkgreen'><b>GREAT!</b> All settings were successfully updated!<br>Your settings will be applied at <b>"+nearestTime+".</b></font>";
    }
    /*
    else
    {
    	// Set this warning message only if the settings could not be saved, meaning the coming URL is serverSettings.jsp
		CharSequence referenceURL="serverSettings";
		if(request.getHeader("Referer").contains(referenceURL))
		{
			warningType = "danger";
			warningMessage = "<b><font color='red'>ERROR:</font></b> Try to change some settings first, please!";
		}
		else
		{
			// Do nothing :)
		}
    }
    */
    
    Statement statementForTemperatureValues = connection
			.createStatement();
    
    Statement statementForHumidityValues = connection
			.createStatement();
    
    Statement statementForBatteryLevelValues = connection
			.createStatement();
    
    ResultSet resultSetForTemperatureValues = statementForTemperatureValues
    		.executeQuery("SELECT DISTINCT TEMPERATURE FROM MOTE_INFORMATION ORDER BY TEMPERATURE");
    
    ResultSet resultSetForHumidityValues = statementForHumidityValues
    		.executeQuery("SELECT DISTINCT HUMIDITY FROM MOTE_INFORMATION ORDER BY HUMIDITY");
    
    ResultSet resultSetForBatteryLevelValues = statementForBatteryLevelValues
    		.executeQuery("SELECT DISTINCT BATTERY_LEVEL FROM MOTE_INFORMATION ORDER BY BATTERY_LEVEL");
    
    ResultSet resultSetForSettings = connection.createStatement()
    		.executeQuery("SELECT * FROM SETTINGS");
    
    int batteryDownLimit=0, humidDownLimit=0, humidUpLimit=0, tempDownLimit=0, tempUpLimit=0, tempThreshold=0, humidThreshold=0, numberOfMeasurementsPerDay=0;
    String senseLightOnStateChange = null;
    
    if(resultSetForSettings.next())
    {
    	batteryDownLimit = Integer.parseInt(resultSetForSettings.getString("BATTERY_DOWN_LIMIT"));
    	tempDownLimit = Integer.parseInt(resultSetForSettings.getString("TEMP_DOWN_LIMIT"));
    	tempUpLimit = Integer.parseInt(resultSetForSettings.getString("TEMP_UP_LIMIT"));
    	humidDownLimit = Integer.parseInt(resultSetForSettings.getString("HUMID_DOWN_LIMIT"));
    	humidUpLimit = Integer.parseInt(resultSetForSettings.getString("HUMID_UP_LIMIT"));
    	senseLightOnStateChange = resultSetForSettings.getString("SENSE_LIGHT_ON_STATE_CHANGE");
    	tempThreshold = Integer.parseInt(resultSetForSettings.getString("TEMP_THRESHOLD"));
    	humidThreshold = Integer.parseInt(resultSetForSettings.getString("HUMID_THRESHOLD"));
    	numberOfMeasurementsPerDay = resultSetForSettings.getInt("NO_OF_MEASUREMENTS_PER_DAY");
    }
    else
    {
    	warningType = "danger";
    	warningMessage = "<b><font color='red'>ERROR:</font></b> The connection to the database could not be established!";
    }
    
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
		
		<h2>Server Settings</h2>
		<p style="font-size: 15px;">You may change the settings of the server in two ways:</p>
		<ol>
			<li><p style="font-size: 15px;">By changing the settings of the web application</p></li>
			<li><p style="font-size: 15px;">By changing the settings of the motes</p></li>
		</ol>
		<p align="justify" style="font-size: 15px;">Please refer to the related section and read the tips provided for each section to change the settings as you desire. You may visit the <a href="contactUs.jsp" target="_blank">Contact us!</a> page to ask for changes on settings that are not yet provided on this page to be configured. We would like to remind you that all the editable fields below are your last saved and active settings.</p>
		<%
			if(warningMessage != null)
			{
		%>
		        <div class=" alert alert-<% out.print(warningType); %> alert-dismissable">
	            	<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
	            	<% out.print("<p style='font-size: 15px;'>"+warningMessage+"</p>"); %>
	       		</div>
	    <%
			}
		%>
		<br><br><hr><br><br>
		
		<h3>Web Application Settings</h3>
		<p style="font-size: 15px;">You can modify the settings of the web application by changing with the options below:</p>
		<br/> 
				<form action="serverSettings.jsp" id="serverSettingsSubmitted" method="post" onsubmit="return checkInitialValues();">
					<table align="center" width="100%" style="table-layout: fixed;">
						<tr>
							<td align="right" width="50%">
								<h4 class="hr-left uppercase">Temperature:</h4>
								<p><i>i.e. change the upper and lower bounds of error filtering for temperature values appearing on the Latest Warning Reports table on the home page.</i></p>
							</td>
							<td width="25px;">
								<!-- Empty column -->
							</td>
							<td>
								<table>
									<tr>
										<td>
											<font color="darkblue">Lower Bound:</font>
										</td>
										<td width="10px;">
											<!-- Empty column -->
										</td>
										<td>
											<select class="form-control input-sm" id="temperatureDownLimit" name="temperatureDownLimit" style="width:80px; height: 25px;" onchange="setToListViaFromList(this.id);" tabindex="1" <% if (!role.equalsIgnoreCase("1")) { out.print("disabled"); } %>>
													<%
														for(int i=-25; i<=125; i++)
														{
															if(i==tempDownLimit)
															{
													%>
																<option value="<% out.print(i); %>" selected>
																	<% out.print(i); %>
																</option>
													<%
															}
															else
															{
													%>
																<option value="<% out.print(i); %>">
																	<% out.print(i); %>
																</option>
													<%
															}
														}
													%>
											</select>
										</td>
										<td>
											°C
										</td>
									</tr>
									<tr>
										<td>
											<font color="red">Upper Bound:</font>
										</td>
										<td width="10px;">
											<!-- Empty column -->
										</td>
										<td>
											<select class="form-control input-sm" id="temperatureUpLimit" name="temperatureUpLimit" style="width:80px; height: 25px;" tabindex="2" <% if (!role.equalsIgnoreCase("1")) { out.print("disabled"); } %>>
													<%
														for(int i=-25; i<=125; i++)
														{
															if(i==tempUpLimit)
															{
													%>
																<option value="<% out.print(i); %>" selected>
																	<% out.print(i); %>
																</option>
													<%
															}
															else
															{
													%>
																<option value="<% out.print(i); %>">
																	<% out.print(i); %>
																</option>
													<%
															}
														}
													%>
											</select>
										</td>
										<td>
											°C
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td align="right">
								<h4 class="hr-left uppercase">Humidity:</h4>
								<p><i>i.e. change the upper and lower bounds of error filtering for humidity values appearing on the Latest Warning Reports table on the home page.</i></p>
							</td>
							<td width="25px;">
								<!-- Empty column -->
							</td>
							<td>
								<table>
									<tr>
										<td>
											<font color="darkblue">Lower Bound:</font>
										</td>
										<td width="10px;">
											<!-- Empty column -->
										</td>
										<td>
											<select class="form-control input-sm" id="humidityDownLimit" name="humidityDownLimit" style="width:80px; height: 25px;" onchange="setToListViaFromList(this.id);" tabindex="3" <% if (!role.equalsIgnoreCase("1")) { out.print("disabled"); } %>>
													<%
														for(int i=1; i<=100; i++)
														{
															if(i==humidDownLimit)
															{
													%>
																<option value="<% out.print(i); %>" selected>
																	<% out.print(i); %>
																</option>
													<%
															}
															else
															{
													%>
																<option value="<% out.print(i); %>">
																	<% out.print(i); %>
																</option>
													<%
															}
														}
													%>
											</select>
										</td>
										<td>
											%
										</td>
									</tr>
									<tr>
										<td>
											<font color="red">Upper Bound:</font>
										</td>
										<td width="10px;">
											<!-- Empty column -->
										</td>
										<td>
											<select class="form-control input-sm" id="humidityUpLimit" name="humidityUpLimit" style="width:80px; height: 25px;" tabindex="4" <% if (!role.equalsIgnoreCase("1")) { out.print("disabled"); } %>>
													<%
														for(int i=1; i<=100; i++)
														{
															if(i==humidUpLimit)
															{
													%>
																<option value="<% out.print(i); %>" selected>
																	<% out.print(i); %>
																</option>
													<%
															}
															else
															{
													%>
																<option value="<% out.print(i); %>">
																	<% out.print(i); %>
																</option>
													<%
															}
														}
													%>
											</select>
										</td>
										<td>
											%
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td align="right">
								<h4 class="hr-left uppercase">Battery Level:</h3>
								<p><i>i.e. change the lower bound of error filtering for battery level values appearing on the Latest Warning Reports table on the home page.</i></p>
							</td>
							<td width="25px;">
								<!-- Empty column -->
							</td>
							<td>
								<table>
									<tr>
										<td>
											<font color="darkblue">Lower Bound:</font>
										</td>
										<td width="10px;">
											<!-- Empty column -->
										</td>
										<td>
											<select class="form-control input-sm" id="batteryDownLimit" name="batteryDownLimit" style="width:80px; height: 25px;" tabindex="5" <% if (!role.equalsIgnoreCase("1")) { out.print("disabled"); } %>>
													<%
														for(int i=1; i<=100; i++)
														{
															if(i==batteryDownLimit)
															{
													%>
																<option value="<% out.print(i); %>" selected>
																	<% out.print(i); %>
																</option>
													<%
															}
															else
															{
													%>
																<option value="<% out.print(i); %>">
																	<% out.print(i); %>
																</option>
													<%
															}
														}
													%>
											</select>
										</td>
										<td>
											%
										</td>
									</tr>
								</table>
							</td>
						</tr>
						</table>
						<hr>
						<h3>Mote Settings</h3>
						<p style="font-size: 15px;">You can modify the settings of the motes by changing with the options below:</p>
						<table align="center" width="100%" style="table-layout: fixed;">
							<tr>
								<td align="right">
									<h4 class="hr-left uppercase">Number of Measurements per Day:</h3>
									<p><i>i.e. set the number of measurements per day to decide how many times a day you want the motes to do sensing without any conditions.</i></p>
								</td>
								<td width="25px;">
									<!-- Empty column -->
								</td>
								<td>
									<table>
										<tr>
											<td>
												<font color="darkblue">Number of measurements per day:</font>
											</td>
											<td width="10px;">
												<!-- Empty column -->
											</td>
											<td>
												<select class="form-control input-sm" id="numberOfMeasurementsPerDay" name="numberOfMeasurementsPerDay" style="width:80px; height: 25px;" tabindex="6" <% if (!role.equalsIgnoreCase("1")) { out.print("disabled"); } %>>
														<%
															for(int i=1; i<=8; i++)
															{
																if(i==numberOfMeasurementsPerDay)
																{
														%>
																	<option value="<% out.print(i); %>" selected>
																		<% out.print(i); %>
																	</option>
														<%
																}
																else
																{
																	if(i!=3 && i!=5 && i!=7)
																	{
														%>
																	<option value="<% out.print(i); %>">
																		<% out.print(i); %>
																	</option>
														<%
																	}
																}
															}
														%>
																	<option value="12">
																		12
																	</option>
																	<option value="24">
																		24
																	</option>
												</select>
											</td>
											<td>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td align="right">
									<h4 class="hr-left uppercase">Sensing when a Change on the State of Light Occurs:</h3>
									<p><i>i.e. sense the environment and send everyting to the server if the state of the light changes (goes from <font color='darkgreen'>ON</font> to <font color='red'>OFF</font> or vice versa)</i></p>
								</td>
								<td width="25px;">
									<!-- Empty column -->
								</td>
								<td>
									<table>
										<tr>
											<td>
												<div class="checkbox">
					                            	<label>
					                                	<input type="checkbox" name="lightStateCondition" id="lightStateCondition" <% if(senseLightOnStateChange.equalsIgnoreCase("YES")) out.print("checked=\"checked\""); %> onclick="setNewLightContidion();" tabindex="7" <% if (!role.equalsIgnoreCase("1")) { out.print("disabled"); } %>> Sense the environment and send everything to the server when the state of the light changes
					                            	</label>
					                            </div>
											</td>
											<td width="10px;">
												<!-- Empty column -->
											</td>
											<td>
											</td>
											<td>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td align="right">
									<h4 class="hr-left uppercase">Threshold Percentage for the Temperature:</h3>
									<p><i>i.e. if the temperature changes beyond the threshold percentage, sense and send everything to the server (e.g. threshold is 20% and temperature goes down to 10°C from 25°C. 20% of 25°C is 5°C and 10°C is < 25-5=20°C. Therefore, sense and send everything to the server).</i></p>
								</td>
								<td width="25px;">
									<!-- Empty column -->
								</td>
								<td>
									<table>
										<tr>
											<td>
												<font color="darkblue">Threshold percentage for the temperature:</font>
											</td>
											<td width="10px;">
												<!-- Empty column -->
											</td>
											<td>
												<select class="form-control input-sm" id="temperatureThreshold" name="temperatureThreshold" style="width:80px; height: 25px;" tabindex="8" <% if (!role.equalsIgnoreCase("1")) { out.print("disabled"); } %>>
														<%
															for(int i=1; i<=100; i++)
															{
																if(i==tempThreshold)
																{
														%>
																	<option value="<% out.print(i); %>" selected>
																		<% out.print(i); %>
																	</option>
														<%
																}
																else
																{
														%>
																	<option value="<% out.print(i); %>">
																		<% out.print(i); %>
																	</option>
														<%
																}
															}
														%>
												</select>
											</td>
											<td>
												%
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td align="right">
									<h4 class="hr-left uppercase">Threshold Percentage for the Humidity:</h3>
									<p><i>i.e. if the humidity changes beyond the threshold percentage, sense and send everything to the server (e.g. threshold is 10% and humidity goes down to 52% from 55%. 10% of 55% is 5.5% and 52% is > 55-5.5=49.5%. Therefore, do nothing).</i></p>
								</td>
								<td width="25px;">
									<!-- Empty column -->
								</td>
								<td>
									<table>
										<tr>
											<td>
												<font color="darkblue">Threshold percentage for the humidity:</font>
											</td>
											<td width="10px;">
												<!-- Empty column -->
											</td>
											<td>
												<select class="form-control input-sm" id="humidityThreshold" name="humidityThreshold" style="width:80px; height: 25px;" tabindex="9" <% if (!role.equalsIgnoreCase("1")) { out.print("disabled"); } %>>
														<%
															for(int i=1; i<=100; i++)
															{
																if(i==humidThreshold)
																{
														%>
																	<option value="<% out.print(i); %>" selected>
																		<% out.print(i); %>
																	</option>
														<%
																}
																else
																{
														%>
																	<option value="<% out.print(i); %>">
																		<% out.print(i); %>
																	</option>
														<%
																}
															}
														%>
												</select>
											</td>
											<td>
												%
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
									<input class="btn btn-sm btn-success" name="submit" id="submit" tabindex="522" value="Save" type="submit" tabindex="10" <% if (!role.equalsIgnoreCase("1")) { out.print("disabled"); } %>>
									<input type="hidden" name="hiddenTempDownLimit" id="hiddenTempDownLimit" value="" />
									<input type="hidden" name="hiddenTempUpLimit" id=hiddenTempUpLimit value="" />
									<input type="hidden" name="hiddenHumidDownLimit" id=hiddenHumidDownLimit value="" />
									<input type="hidden" name="hiddenHumidUpLimit" id="hiddenHumidUpLimit" value="" />
									<input type="hidden" name="hiddenBatteryDownLimit" id="hiddenBatteryDownLimit" value="" />
									<input type="hidden" name="hiddenTempThreshold" id="hiddenTempThreshold" value="" />
									<input type="hidden" name="hiddenHumidThreshold" id="hiddenHumidThreshold" value="" />
									<input type="hidden" name="hiddenLightSenseCondition" id="hiddenLightSenseCondition" value="" />
									<input type="hidden" name="hiddenLightSenseConditionNew" id="hiddenLightSenseConditionNew" value="" />
									<input type="hidden" name="hiddenNoOfMeasurementsPerDay" id="hiddenNoOfMeasurementsPerDay" value="" />
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