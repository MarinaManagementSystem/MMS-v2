<%@ page language="java" contentType="text/html; charset=ISO-8859-9" import="java.io.*, java.util.*, java.util.Date, java.sql.*, javax.servlet.*, java.text.* "
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js" lang="en"> <!--<![endif]-->
<head>
<jsp:include page="header.jsp" />

<title>Query Database - Environment Tracking Software</title>

</head>

<%

	String userName;
	if(session.getAttribute( "userName") == null || session.getAttribute( "password") == null)
	{
		response.sendRedirect("login.jsp");
		return;
	}
	else
	{
		userName = session.getAttribute("userName").toString();
	}
	
%>

<script type="text/javascript">
	
	function setMoteIDList()
	{
		var currentCondition = document.getElementById('allMotesCondition');
		var elements = document.getElementById("moteIDList");
		
		if (currentCondition.checked)
		{
			for (var i = 0; i < elements.options.length; i++)
			{
				elements.options[i].disabled = true;
				elements.options[i].selected = false;
			}
		}
		else 
		{
			for (var i = 0; i < elements.options.length; i++)
			{
				elements.options[i].disabled = false;
			}
			elements.options[0].selected = true;
		}
	}
	
	function setPresence(receivedID)
	{
		if(receivedID.toLowerCase() == "presenceIsON".toLowerCase() && document.getElementById("presenceIsON").checked == false)
		{
			document.getElementById("presenceIsOFF").checked = true;		
		}
		else if(receivedID.toLowerCase() == "presenceIsOFF".toLowerCase() && document.getElementById("presenceIsON").checked == false)
		{
			document.getElementById("presenceIsON").checked = true;
		}
		else
		{
			// do nothing
		}
	}
	
	function setToListViaFromList(receivedID)
	{
		//alert(receivedID);
		
		if(receivedID.toLowerCase() == "fromTemperatureList".toLowerCase())
		{
			//var elementArrayOfToList = document.getElementById("toTemperatureList").getElementsByTagName("option");
			var elementArrayOfToList = document.getElementById("toTemperatureList");
		}
		else if (receivedID.toLowerCase() == "fromHumidityList".toLowerCase())
		{
			//var elementArrayOfToList = document.getElementById("toHumidityList").getElementsByTagName("option");
			var elementArrayOfToList = document.getElementById("toHumidityList");
		}
		else
		{
			var elementArrayOfToList = document.getElementById("toBatteryLevelList");
		}
		
		var elementsOfFromList = document.getElementById(receivedID);
		var selectedTextFromFromList = elementsOfFromList.options[elementsOfFromList.selectedIndex].text;
		
		var elementArrayOfFromList = document.getElementById(receivedID).getElementsByTagName("option");
		
		/*
			for (var i = 0; i < elementArrayOfFromList.length; i++) {
				
				if(parseInt(elementArrayOfFromList[i].text) >= parseInt(selectedTextFromFromList))
				{
					elementArrayOfToList[i].disabled = false;
					//elementArrayToTemp[counter].text = elementArrayFromTemp[i].text;
				}
				else
				{
					elementArrayOfToList[i].disabled = true;
				}
			}
			//elementArrayOfToList[elementsOfFromList.selectedIndex].selected = true;
			elementArrayOfToList[elementArrayOfToList.length-1].selected = true;
		*/
		
		elementArrayOfToList.options.length=0;
		
		
		for (var i = 0; i < elementArrayOfFromList.length; i++) {
			
			if(parseInt(elementArrayOfFromList[i].text) >= parseInt(selectedTextFromFromList))
			{
				/*
				var opt = document.createElement('option');
				opt.value = parseInt(elementArrayOfFromList[i].text);
				opt.innerHTML = parseInt(elementArrayOfFromList[i].text);
				elementArrayOfToList.appendChild(opt);
				*/
				
				var option = new Option(elementArrayOfFromList[i].text, elementArrayOfFromList[i].text);
				elementArrayOfToList.add(option);
				
				/*
				elementArrayOfToList.options[elementArrayOfToList.options.length] = new Option(
						elementArrayOfFromList[i].text,  // option itself on HTML
						elementArrayOfFromList[i].text); // value
				*/
				//elementArrayOfToList.options[elementArrayOfToList.options.length].value = parseInt(elementArrayOfFromList[i].text);
				//elementArrayOfToList.options[elementArrayOfToList.options.length-1].value;
			}
		}
		elementArrayOfToList.options[elementArrayOfToList.options.length-1].selected = true;

	}
	
	function setDateAndTimeSelect(receivedID)
	{
		//alert(receivedID);
		
		if (receivedID.toLowerCase() == "dateAndTimeTogether".toLowerCase() && document.getElementById(receivedID).checked == true)
		{
			document.getElementById('dateAndTimeSeparate').checked = false;
			document.getElementById('dateAndTimeSeparate').disabled = "";
			document.getElementById('fromDate').disabled = "disable";
			document.getElementById('toDate').disabled = "disable";
			document.getElementById('fromTime').disabled = "disable";
			document.getElementById('toTime').disabled = "disable";
			document.getElementById('startOfDateAndTime').disabled = "";
			document.getElementById('endOfDateAndTime').disabled = "";

		} else if (receivedID.toLowerCase() == "dateAndTimeTogether".toLowerCase() && document.getElementById(receivedID).checked == false) {
			document.getElementById('dateAndTimeSeparate').checked = true;
			document.getElementById('dateAndTimeSeparate').disabled = "";
			document.getElementById('fromDate').disabled = "";
			document.getElementById('toDate').disabled = "";
			document.getElementById('fromTime').disabled = "";
			document.getElementById('toTime').disabled = "";
			document.getElementById('dateAndTimeTogether').disabled = "";
			document.getElementById('startOfDateAndTime').disabled = "disable";
			document.getElementById('endOfDateAndTime').disabled = "disable";
		} else if (receivedID.toLowerCase() == "dateAndTimeSeparate"
				.toLowerCase()
				&& document.getElementById(receivedID).checked == true) {
			document.getElementById('dateAndTimeTogether').checked = false;
			document.getElementById('dateAndTimeTogether').disabled = "";
			document.getElementById('fromDate').disabled = "";
			document.getElementById('toDate').disabled = "";
			document.getElementById('fromTime').disabled = "";
			document.getElementById('toTime').disabled = "";
			document.getElementById('startOfDateAndTime').disabled = "disable";
			document.getElementById('endOfDateAndTime').disabled = "disable";
		} else {
			document.getElementById('dateAndTimeTogether').checked = true;
			document.getElementById('dateAndTimeSeparate').disabled = "";
			document.getElementById('dateAndTimeTogether').disabled = "";
			document.getElementById('startOfDateAndTime').disabled = "";
			document.getElementById('endOfDateAndTime').disabled = "";
			document.getElementById('fromDate').disabled = "disable";
			document.getElementById('toDate').disabled = "disable";
			document.getElementById('fromTime').disabled = "disable";
			document.getElementById('toTime').disabled = "disable";
		}

	}
	
	function checkDateAndTimeValues()
	{
		
		/*
		if(document.getElementById("dateAndTimeTogether").checked == true)
		{
			var startOfDateAndTime = new Date(document.getElementById('hiddenStartDate').value);
			var endOfDateAndTime = new Date(document.getElementById('hiddenEndDate').value);
			
			if(startOfDateAndTime > endOfDateAndTime)
			{
				
				alert("Start Date & Time should be less than or equal to End Date & Time!");
				return false;
			}
		}
		if(document.getElementById("dateAndTimeSeparate").checked == true)
		{
			var fromDate = new Date(document.getElementById('hiddenFromDate').value);
			var toDate = new Date(document.getElementById('hiddenToDate').value);
			
			if(formatDate(fromDate) > formatDate(toDate))
			{
				alert("From Date should be less than or equal to To Date!");
				return false;
			}
		}
		return true;
		*/
	}
	
	function formatDate(d)
	{
	    var month = d.getMonth();
	    var day = d.getDate();
	    month = month + 1;

	    month = month + "";

	    if (month.length == 1)
	    {
	        month = "0" + month;
	    }

	    day = day + "";

	    if (day.length == 1)
	    {
	        day = "0" + day;
	    }

	    return day + '.' + month + '.' + d.getFullYear();
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

<body class="withAnimation" onload="setMoteIDList(); setToListViaFromList('fromTemperatureList'); setToListViaFromList('fromHumidityList'); setToListViaFromList('fromBatteryLevelList'); setDateAndTimeSelect('dateAndTimeTogether');">

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
                <li class="active dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Reports</a>
                    <ul class="dropdown-menu" role="menu">
                        <li class="active"><a href="queryDatabase.jsp">Query<span>Query the database</span></a></li>
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

<%  
	String browser = request.getHeader("User-Agent");
	boolean isChrome = (browser != null && browser.indexOf("Chrome/") != -1);
    int year = Calendar.getInstance().get(Calendar.YEAR);
    int month = Calendar.getInstance().get(Calendar.MONTH);
    int day = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
    
    month++;
    
    int hour = Calendar.getInstance().get(Calendar.HOUR_OF_DAY);
    int minutes = Calendar.getInstance().get(Calendar.MINUTE);
    
    DecimalFormat decimalFormatter = new DecimalFormat("00");
    
	// Create a database object
	DatabaseSettings dbSettings = new DatabaseSettings();
	
	// Connect to the database
	Class.forName(dbSettings.getClassForName());
	Connection connection = DriverManager.getConnection(dbSettings.getDBName(), dbSettings.getDBUserName(), dbSettings.getDBPass());
    
    Statement statementForMoteIDs = connection
			.createStatement();
    
    Statement statementForTemperatureValues = connection
			.createStatement();
    
    Statement statementForHumidityValues = connection
			.createStatement();
    
    Statement statementForBatteryLevelValues = connection
			.createStatement();
    
    ResultSet resultSetForMoteIDs = statementForMoteIDs
    		.executeQuery("SELECT DISTINCT MOTE_ID FROM MOTE_INFORMATION ORDER BY MOTE_ID");
    
    ResultSet resultSetForTemperatureValues = statementForTemperatureValues
    		.executeQuery("SELECT DISTINCT TEMPERATURE FROM MOTE_INFORMATION ORDER BY TEMPERATURE");
    
    ResultSet resultSetForHumidityValues = statementForHumidityValues
    		.executeQuery("SELECT DISTINCT HUMIDITY FROM MOTE_INFORMATION ORDER BY HUMIDITY");
    
    ResultSet resultSetForBatteryLevelValues = statementForBatteryLevelValues
    		.executeQuery("SELECT DISTINCT BATTERY_LEVEL FROM MOTE_INFORMATION ORDER BY BATTERY_LEVEL");
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
		
		<h2>Query Database</h2>
		<p style="font-size: 15px;">In order to query the database, please fill the below query form accordingly and submit. If you directly hit the submit button, all data stored in the database from the beginning of this year will be retrieved.</p>
		<br/> 
				<form action="querySubmitted.jsp" id="querySubmitted" method="post" onsubmit="return checkDateAndTimeValues();">
					<table align="center" width="100%" style="table-layout: fixed;">
						<tr>
							<td align="right" width="25.8%" style="vertical-align:top">
								<h4 class="hr-left uppercase">Mote ID:</h4>
							</td>
							<td width="25px;">
								<!-- Empty column -->
							</td>
	
							<td align="left">
								<div class="checkbox">
	                            	<label>
	                                	<input type="checkbox" name="allMotesCondition" id="allMotesCondition" checked="checked" onclick="setMoteIDList();" tabindex="1"> All motes
	                            	</label>
	                            </div>
								<select class="form-control input-sm" multiple id="moteIDList" name="moteIDList" style="width: 65px; height: 67px;" tabindex="2">
								<%
									while(resultSetForMoteIDs.next())
									{
								%>
										<option value="<% out.print(resultSetForMoteIDs.getString("MOTE_ID")); %>"><% out.print(resultSetForMoteIDs.getString("MOTE_ID")); %></option>
								<%	}
								
								%>
								</select>
							</td>
						</tr>
						<tr>
							<td align="right">
								<h4 class="hr-left uppercase">Light Status / Presence:</h4>
							</td>
							<td width="25px;">
								<!-- Empty column -->
							</td>
							<td>
								<div class="checkbox">
	                            	<label>
	                                	<input type="checkbox" name="presenceIsON" id="presenceIsON" checked="checked" onclick="setPresence(this.id);" tabindex="3"> <font color="darkgreen">ON / YES</font>
	                            	</label>
	                            </div>
	                            <div class="checkbox">
									<label>
	                                	<input type="checkbox" name="presenceIsOFF" id="presenceIsOFF" checked="checked" onclick="setPresence(this.id);" tabindex="4"> <font color="red">OFF / NO</font>
	                            	</label>
	                            </div>
							</td>
						</tr>
						<tr>
							<td align="right">
								<h4 class="hr-left uppercase">Temperature:</h4>
							</td>
							<td width="25px;">
								<!-- Empty column -->
							</td>
							<td>
								<table>
									<tr>
										<td>
											From:
										</td>
										<td width="10px;">
											<!-- Empty column -->
										</td>
										<td>
											<select class="form-control input-sm" id="fromTemperatureList" name="fromTemperatureList" style="width:80px; height: 25px;" onchange="setToListViaFromList(this.id);" tabindex="5">
													<%
														while (resultSetForTemperatureValues.next()) {
													%>
													<option value="<% out.print(resultSetForTemperatureValues.getString("TEMPERATURE")); %>">
														<%
															out.print(resultSetForTemperatureValues.getString("TEMPERATURE"));
														%>
													</option>
													<%	} %>
											</select>
										</td>
										<td>
											°C
										</td>
									</tr>
									<tr>
										<td>
											To:
										</td>
										<td width="10px;">
											<!-- Empty column -->
										</td>
										<td>
											<select class="form-control input-sm" id="toTemperatureList" name="toTemperatureList" style="width:80px; height: 25px;" tabindex="6">
													<%	resultSetForTemperatureValues.beforeFirst();
														while (resultSetForTemperatureValues.next()) {
													%>
													<option value="<% out.print(resultSetForTemperatureValues.getString("TEMPERATURE")); %>">
														<%
															out.print(resultSetForTemperatureValues.getString("TEMPERATURE"));
														%>
													</option>
													<%	} %>
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
							</td>
							<td width="25px;">
								<!-- Empty column -->
							</td>
							<td>
								<table>
									<tr>
										<td>
											From:
										</td>
										<td width="10px;">
											<!-- Empty column -->
										</td>
										<td>
											<select class="form-control input-sm" id="fromHumidityList" name="fromHumidityList" style="width:80px; height: 25px;" onchange="setToListViaFromList(this.id);" tabindex="7">
													<%
														while (resultSetForHumidityValues.next()) {
													%>
													<option value="<% out.print(resultSetForHumidityValues.getString("HUMIDITY")); %>">
														<%
															out.print(resultSetForHumidityValues.getString("HUMIDITY"));
														%>
													</option>
													<%	} %>
											</select>
										</td>
										<td>
											%
										</td>
									</tr>
									<tr>
										<td>
											To:
										</td>
										<td width="10px;">
											<!-- Empty column -->
										</td>
										<td>
											<select class="form-control input-sm" id="toHumidityList" name="toHumidityList" style="width:80px; height: 25px;" tabindex="8">
													<%	resultSetForHumidityValues.beforeFirst();
														while (resultSetForHumidityValues.next()) {
													%>
													<option value="<% out.print(resultSetForHumidityValues.getString("HUMIDITY")); %>">
														<%
															out.print(resultSetForHumidityValues.getString("HUMIDITY"));
														%>
													</option>
													<%	} %>
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
								<h4 class="hr-left uppercase">Battery Level:</h4>
							</td>
							<td width="25px;">
								<!-- Empty column -->
							</td>
							<td>
								<table>
									<tr>
										<td>
											From:
										</td>
										<td width="10px;">
											<!-- Empty column -->
										</td>
										<td>
											<select class="form-control input-sm" id="fromBatteryLevelList" name="fromBatteryLevelList" style="width:80px; height: 25px;" onchange="setToListViaFromList(this.id);" tabindex="7">
													<%
														while (resultSetForBatteryLevelValues.next()) {
													%>
													<option value="<% out.print(resultSetForBatteryLevelValues.getString("BATTERY_LEVEL")); %>">
														<%
															out.print(resultSetForBatteryLevelValues.getString("BATTERY_LEVEL"));
														%>
													</option>
													<%	} %>
											</select>
										</td>
										<td>
											%
										</td>
									</tr>
									<tr>
										<td>
											To:
										</td>
										<td width="10px;">
											<!-- Empty column -->
										</td>
										<td>
											<select class="form-control input-sm" id="toBatteryLevelList" name="toBatteryLevelList" style="width:80px; height: 25px;" tabindex="8">
													<%	resultSetForBatteryLevelValues.beforeFirst();
														while (resultSetForBatteryLevelValues.next()) {
													%>
													<option value="<% out.print(resultSetForBatteryLevelValues.getString("BATTERY_LEVEL")); %>">
														<%
															out.print(resultSetForBatteryLevelValues.getString("BATTERY_LEVEL"));
														%>
													</option>
													<%	} %>
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
								<h4 class="hr-left uppercase">Date Range:</h4>
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
				                                	<input type="checkbox" name="dateAndTimeTogether" id="dateAndTimeTogether" checked="checked" onclick="setDateAndTimeSelect(this.id);" tabindex="9"> Pick a date and time interval
				                            	</label>
	                            			</div>
										</td>
										<td width="25px;">
											<!-- Empty column -->
										</td>
										<td>
											<table>
												<tr>
													<td>
														Start Date & Time:
													</td>
													<td width="10px;">
														<!-- Empty column -->
													</td>
													<td>
														<!-- Please check the footer.jsp by searching startOfDateAndTime to see the date picker details -->
														<input type="text" value="<% out.print("01.01."+year+" 00:00"); %>" name="startOfDateAndTime" id="startOfDateAndTime" class="form-control input-sm" tabindex="10" />
													</td>
												</tr>
												<tr>
													<td>
														End Date & Time:
													</td>
													<td width="10px;">
														<!-- Empty column -->
													</td>
													<td>
														<!-- Please check the footer.jsp by searching endOfDateAndTime to see the date picker details -->
														<input type="text" value="<% out.print(decimalFormatter.format(day)+"."+decimalFormatter.format(month)+"."+year+" "+decimalFormatter.format(hour)+":"+decimalFormatter.format(minutes)); %>" name="endOfDateAndTime" id="endOfDateAndTime" class="form-control input-sm" tabindex="11" />
													</td>
												</tr>
											</table>
									</tr>
									<tr>
										<td width="215px;">
											<div class="checkbox">
												<label>
													<input type="checkbox" name="dateAndTimeSeparate" id="dateAndTimeSeparate" onclick="setDateAndTimeSelect(this.id);" tabindex="12"> Pick a date and time separately
												</label>
											</div>
										</td>
										<td width="25px;">
											<!-- Empty column -->
										</td>
										<td>
														<table>
															<tr>
																<td>
																</td>
																<td width="10px;">
																	<!-- Empty column -->
																</td>
																<td>
																	From:
																</td>
																<td>
																	To:
																</td>
															</tr>
															<tr>
																<td>
																	Date:
																</td>
																<td width="10px;">
																	<!-- Empty column -->
																</td>
																<td>
																	<!-- Please check the footer.jsp by searching fromDate to see the date picker details -->
																	<input type="text" value="<% out.print("01.01."+year); %>" name="fromDate" id="fromDate" class="form-control input-sm" tabindex="13" />
																</td>
																<td>
																	<!-- Please check the footer.jsp by searching toDate to see the date picker details -->
																	<input type="text" value="<% out.print(decimalFormatter.format(day)+"."+decimalFormatter.format(month)+"."+year); %>" name="toDate" id="toDate" class="form-control input-sm" tabindex="14" />
																</td>
															</tr>
															<tr>
																<td>
																	Time:
																</td>
																<td width="10px;">
																	<!-- Empty column -->
																</td>
																<td>
																	<!-- Please check the footer.jsp by searching fromTime to see the date picker details -->
																	<input type="text" value="<% out.print("00:00"); %>" name="fromTime" id="fromTime" class="form-control input-sm" tabindex="15" />
																</td>
																<td>
																	<!-- Please check the footer.jsp by searching toTime to see the date picker details -->
																	<input type="text" value="<% out.print(decimalFormatter.format(hour)+":"+decimalFormatter.format(minutes)); %>" name="toTime" id="toTime" class="form-control input-sm" tabindex="16" />
																</td>
															</tr>
														</table>
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
								<input class="btn btn-sm btn-success" name="submit" id="submit" tabindex="522" value="Submit" type="submit" tabindex="17">
								<input type="hidden" name="hiddenStartDate" id="hiddenStartDate" value="" />
								<input type="hidden" name="hiddenFromDate" id="hiddenFromDate" value="" />
								<input type="hidden" name="hiddenStartTime" id=hiddenStartTime value="" />
								<input type="hidden" name="hiddenFromTime" id=hiddenFromTime value="" />
								<input type="hidden" name="hiddenEndDate" id="hiddenEndDate" value="" />
								<input type="hidden" name="hiddenToDate" id="hiddenToDate" value="" />
								<input type="hidden" name="hiddenEndTime" id="hiddenEndTime" value="" />
								<input type="hidden" name="hiddenToTime" id="hiddenToTime" value="" />
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