<%@ page language="java" contentType="text/html; charset=ISO-8859-9" import="java.io.*, java.util.*, java.util.Date, java.sql.*, javax.servlet.*, java.text.* "
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js" lang="en"> <!--<![endif]-->
<head>
<jsp:include page="header.jsp" />

<title>Plot Graph - Environment Tracking Software</title>

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
	
	function setDateAndTimeSelect(receivedID)
	{
		//alert(receivedID);
		
		if (receivedID.toLowerCase() == "dateIntervalForPlot".toLowerCase() && document.getElementById(receivedID).checked == true)
		{
			document.getElementById('dateIntervalForPlot').disabled = "disable";
			document.getElementById('dateAndTimeTogetherForPlot').disabled = "";
			document.getElementById('timeIntervalForPlot').disabled = "";
			
			document.getElementById("hiddenDateIntervalForPlot").value = "checked";
			document.getElementById("hiddenDateAndTimeTogetherForPlot").value = "unchecked";
			document.getElementById("hiddenTimeIntervalForPlot").value = "unchecked";
			
			document.getElementById('dateAndTimeTogetherForPlot').checked = false;
			document.getElementById('timeIntervalForPlot').checked = false;
			
			document.getElementById('startOfDateForPlot').disabled = "";
			document.getElementById('endOfDateForPlot').disabled = "";
			
			document.getElementById('fromDateForPlot').disabled = "disable";
			document.getElementById('toDateForPlot').disabled = "disable";
			document.getElementById('fromTimeForPlot').disabled = "disable";
			document.getElementById('toTimeForPlot').disabled = "disable";
			document.getElementById('startOfTimeForPlot').disabled = "disable";
			document.getElementById('endOfTimeForPlot').disabled = "disable";

		}
		else if (receivedID.toLowerCase() == "dateAndTimeTogetherForPlot".toLowerCase() && document.getElementById(receivedID).checked == true)
		{
			document.getElementById('dateIntervalForPlot').disabled = "";
			document.getElementById('dateAndTimeTogetherForPlot').disabled = "disable";
			document.getElementById('timeIntervalForPlot').disabled = "";
			
			document.getElementById("hiddenDateIntervalForPlot").value = "unchecked";
			document.getElementById("hiddenDateAndTimeTogetherForPlot").value = "checked";
			document.getElementById("hiddenTimeIntervalForPlot").value = "unchecked";
			
			document.getElementById('dateIntervalForPlot').checked = false;
			document.getElementById('timeIntervalForPlot').checked = false;
			
			document.getElementById('fromDateForPlot').disabled = "";
			document.getElementById('toDateForPlot').disabled = "";
			document.getElementById('fromTimeForPlot').disabled = "";
			document.getElementById('toTimeForPlot').disabled = "";
			
			document.getElementById('startOfTimeForPlot').disabled = "disable";
			document.getElementById('endOfTimeForPlot').disabled = "disable";
			document.getElementById('startOfDateForPlot').disabled = "disable";
			document.getElementById('endOfDateForPlot').disabled = "disable";
		}
		else if ((receivedID.toLowerCase() == "timeIntervalForPlot".toLowerCase() && document.getElementById(receivedID).checked == true))
		{
			document.getElementById('dateIntervalForPlot').disabled = "";
			document.getElementById('dateAndTimeTogetherForPlot').disabled = "";
			document.getElementById('timeIntervalForPlot').disabled = "disable";
			
			document.getElementById("hiddenDateIntervalForPlot").value = "unchecked";
			document.getElementById("hiddenDateAndTimeTogetherForPlot").value = "unchecked";
			document.getElementById("hiddenTimeIntervalForPlot").value = "checked";
			
			document.getElementById('dateIntervalForPlot').checked = false;
			document.getElementById('dateAndTimeTogetherForPlot').checked = false;
			
			document.getElementById('startOfTimeForPlot').disabled = "";
			document.getElementById('endOfTimeForPlot').disabled = "";
			
			document.getElementById('fromDateForPlot').disabled = "disable";
			document.getElementById('toDateForPlot').disabled = "disable";
			document.getElementById('fromTimeForPlot').disabled = "disable";
			document.getElementById('toTimeForPlot').disabled = "disable";
			document.getElementById('startOfDateForPlot').disabled = "disable";
			document.getElementById('endOfDateForPlot').disabled = "disable";
		}

	}
	
	function checkDateAndTimeValues()
	{
		/*
		if(document.getElementById("hiddenDateIntervalForPlot").value == "checked")
		{
			alert(document.getElementById('startOfDateForPlot').value);
			alert(document.getElementById('endOfDateForPlot').value);
			var startOfDateForPlot = document.getElementById('hiddenStartOfDateForPlot').value;
			var endOfDateForPlot = document.getElementById('hiddenEndOfDateForPlot').value;
			
			alert(startOfDateForPlot);
			alert(endOfDateForPlot);
			
			if(startOfDateForPlot > endOfDateForPlot)
			{
				alert("Start Date should be less than or equal to End Date!");
				return false;
			}
		}
		if(document.getElementById("hiddenDateAndTimeTogetherForPlot").value == "checked")
		{
			
			var fromDateForPlot = new Date(document.getElementById('hiddenFromDateForPlot').value);
			var toDateForPlot = new Date(document.getElementById('hiddenToDateForPlot').value);
			
			if(fromDateForPlot > toDateForPlot)
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

<body class="withAnimation" onload="setDateAndTimeSelect('dateIntervalForPlot');">

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
                        <li><a href="queryDatabase.jsp">Query<span>Query the database</span></a></li>
                        <li class="active"><a href="plotGraph.jsp">Graph<span>Plot a graph</span></a></li>
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
    
    ResultSet resultSetForMoteIDs = statementForMoteIDs
    		.executeQuery("SELECT DISTINCT MOTE_ID FROM MOTE_INFORMATION ORDER BY MOTE_ID");

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
		
		<h2>Plot Graph</h2>
		<p style="font-size: 15px;">In order to plot a graph, please fill the below query form accordingly and submit. If you directly hit the plot button, all data stored in the database from the beginning of this year will be retrieved.</p>
		<br/> 
				<form action="plotGraphSubmitted.jsp" id="plotGraphSubmitted" method="post" onsubmit="return checkDateAndTimeValues();">
					<table align="center" width="100%" style="table-layout: fixed;">
						<tr>
							<td align="right" width="25.4%" style="vertical-align:top">
								<h4 class="hr-left uppercase">Mote ID:</h4>
							</td>
							<td width="25px;">
								<!-- Empty column -->
							</td>
	
							<td align="left">
								<select class="form-control input-sm" id="moteID" name="moteID" style="width: 55px; height: 25px;" tabindex="1">
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
							<td align="right" style="vertical-align:top">
								<h4 class="hr-left uppercase">Date and Time Range:</h4>
								<p><i>Please note that you are only allowed to choose one of the 3 options (on the right) at a time.</i></p>
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
				                                	<input type="checkbox" name="dateIntervalForPlot" id="dateIntervalForPlot" checked="checked" onclick="setDateAndTimeSelect(this.id);" tabindex="2"><p>Plot a graph of the change in temperature, humidity, presence and battery levels between two dates:</p>
				                                	<br><i>i.e. graph of change in measured values for each reported time for each day that fit in the specified date range.</i>
				                            	</label>
	                            			</div>
	                            			<hr>
										</td>
										<td width="25px;">
											<!-- Empty column -->
										</td>
										<td>
											<table>
												<tr>
													<td>
														Start Date:
													</td>
													<td width="10px;">
														<!-- Empty column -->
													</td>
													<td>
														<!-- Please check the footer.jsp by searching startOfDateAndTime to see the date picker details -->
														<input type="text" value="<% out.print("01.01."+year); %>" name="startOfDateForPlot" id="startOfDateForPlot" class="form-control input-sm" tabindex="3" />
													</td>
												</tr>
												<tr>
													<td>
														End Date:
													</td>
													<td width="10px;">
														<!-- Empty column -->
													</td>
													<td>
														<!-- Please check the footer.jsp by searching endOfDateAndTime to see the date picker details -->
														<input type="text" value="<% out.print(decimalFormatter.format(day)+"."+decimalFormatter.format(month)+"."+year); %>" name="endOfDateForPlot" id="endOfDateForPlot" class="form-control input-sm" tabindex="4" />
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td width="215px;">
											<div class="checkbox">
												<label>
													<input type="checkbox" name="dateAndTimeTogetherForPlot" id="dateAndTimeTogetherForPlot" onclick="setDateAndTimeSelect(this.id);" tabindex="5"><p>Plot a graph of the change in temperature, humidity, presence and battery levels between two dates with a specific time interval:</p>
													<br><i>i.e. graph of change in measured values between 08:00 AM and 09:00 PM on each day that fit in the specified date range.</i>
												</label>
											</div>
											<hr>
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
																	<input type="text" value="<% out.print("01.01."+year); %>" name="fromDateForPlot" id="fromDateForPlot" class="form-control input-sm" tabindex="6" />
																</td>
																<td>
																	<!-- Please check the footer.jsp by searching toDate to see the date picker details -->
																	<input type="text" value="<% out.print(decimalFormatter.format(day)+"."+decimalFormatter.format(month)+"."+year); %>" name="toDateForPlot" id="toDateForPlot" class="form-control input-sm" tabindex="7" />
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
																	<input type="text" value="<% out.print("00:00"); %>" name="fromTimeForPlot" id="fromTimeForPlot" class="form-control input-sm" tabindex="8" />
																</td>
																<td>
																	<!-- Please check the footer.jsp by searching toTime to see the date picker details -->
																	<input type="text" value="<% out.print(decimalFormatter.format(hour)+":"+decimalFormatter.format(minutes)); %>" name="toTimeForPlot" id="toTimeForPlot" class="form-control input-sm" tabindex="9" />
																</td>
															</tr>
														</table>
										</td>
									</tr>
									<tr>
										<td>
											<div class="checkbox">
				                            	<label>
				                                	<input type="checkbox" name="timeIntervalForPlot" id="timeIntervalForPlot" onclick="setDateAndTimeSelect(this.id);" tabindex="10"><p>Plot a graph of the change in temperature, humidity and battery levels between a time interval:</p>
				                                	<br><i>i.e. graph of change in mean average of measured values for each time that fit in the specified time range.</i>
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
														Start Time:
													</td>
													<td width="10px;">
														<!-- Empty column -->
													</td>
													<td>
														<!-- Please check the footer.jsp by searching startOfDateAndTime to see the date picker details -->
														<input type="text" value="<% out.print("00:00"); %>" name="startOfTimeForPlot" id="startOfTimeForPlot" class="form-control input-sm" tabindex="11" />
													</td>
												</tr>
												<tr>
													<td>
														End Time:
													</td>
													<td width="10px;">
														<!-- Empty column -->
													</td>
													<td>
														<!-- Please check the footer.jsp by searching endOfDateAndTime to see the date picker details -->
														<input type="text" value="<% out.print(decimalFormatter.format(hour)+":"+decimalFormatter.format(minutes)); %>" name="endOfTimeForPlot" id="endOfTimeForPlot" class="form-control input-sm" tabindex="12" />
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
								<input class="btn btn-success" name="submit" id="submit" tabindex="522" value="Plot" type="submit" tabindex="13">
								<input type="hidden" name="hiddenStartDateForPlot" id="hiddenStartDateForPlot" value="" />
								<input type="hidden" name="hiddenEndDateForPlot" id="hiddenEndDateForPlot" value="" />
								
								<input type="hidden" name="hiddenFromDateForPlot" id="hiddenFromDateForPlot" value="" />
								<input type="hidden" name="hiddenToDateForPlot" id="hiddenToDateForPlot" value="" />
								
								<input type="hidden" name="hiddenFromTimeForPlot" id="hiddenFromTimeForPlot" value="" />
								<input type="hidden" name="hiddenToTimeForPlot" id="hiddenToTimeForPlot" value="" />
								
								<input type="hidden" name="hiddenStartOfTimeForPlot" id="hiddenStartOfTimeForPlot" value="" />
								<input type="hidden" name="hiddenEndOfTimeForPlot" id="hiddenEndOfTimeForPlot" value="" />
								
								<input type="hidden" name="hiddenDateIntervalForPlot" id="hiddenDateIntervalForPlot" value="" />
								<input type="hidden" name="hiddenDateAndTimeTogetherForPlot" id="hiddenDateAndTimeTogetherForPlot" value="" />
								<input type="hidden" name="hiddenTimeIntervalForPlot" id="hiddenTimeIntervalForPlot" value="" />
	
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