<%@ page language="java" contentType="text/html; charset=ISO-8859-9" import="java.io.*, java.util.*, java.util.Date, java.sql.*, javax.servlet.*, java.text.* "
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js" lang="en"> <!--<![endif]-->
<head>
<jsp:include page="header.jsp" />

<title>Plot Graph Results - Environment Tracking Software</title>

</head>

<%
	String userName;
	CharSequence referenceURL="plotGraph";

	if(session.getAttribute( "userName") == null || session.getAttribute( "password") == null)
	{
		response.sendRedirect("login.jsp");
		return;
	}
	else if (request.getHeader("Referer") == null || !request.getHeader("Referer").contains(referenceURL))
	{
		response.sendRedirect("plotGraph.jsp");
		return;
	}
	else
	{
		userName = session.getAttribute("userName").toString();
	}
	
	// Create a database object
	DatabaseSettings dbSettings = new DatabaseSettings();
	
	// Connect to the database
	Class.forName(dbSettings.getClassForName());
	Connection connection = DriverManager.getConnection(dbSettings.getDBName(), dbSettings.getDBUserName(), dbSettings.getDBPass());
	
	Statement statementForQueryResults = connection.createStatement();
	

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
	
    boolean resultSetIsEmpty = true;
	int graphCase = 0;
    String query = null, warningMessage = null;
	String fromDay = null, fromMonth = null, fromYear = null, toDay = null, toMonth = null, toYear = null, fromDate = null, toDate = null;
	String tempDay = null, tempMonth = null, tempYear = null, tempDate = null, graphTitle = null, graphSubtitle = null, batteryLevelGraphTitle = null, batteryLevelGraphSubtitle = null;
	String [] tempParts = new String[3];
	StringBuilder stringBuilderForQuery = new StringBuilder();
	StringBuilder stringBuilderForDateAndTime = new StringBuilder();
	StringBuilder stringBuilderForTemperature = new StringBuilder();
	StringBuilder stringBuilderForHumidity = new StringBuilder();
	StringBuilder stringBuilderForPresence = new StringBuilder();
	StringBuilder stringBuilderForBatteryLevel = new StringBuilder();
    
    stringBuilderForQuery.append("SELECT * FROM MOTE_INFORMATION WHERE");
    
    String moteID = request.getParameter("moteID");
    //out.println("MOTE ID: "+moteID);
    
    stringBuilderForQuery.append(" MOTE_ID="+moteID);
    
    // Date interval is selected
    if(request.getParameter("hiddenDateIntervalForPlot").equalsIgnoreCase("checked") && request.getParameter("hiddenDateAndTimeTogetherForPlot").equalsIgnoreCase("unchecked") && request.getParameter("hiddenTimeIntervalForPlot").equalsIgnoreCase("unchecked"))
    {
    	warningMessage = "Sorry, no data is found for <b>mote "+moteID+"</b> between <b>"+request.getParameter("hiddenStartDateForPlot")+" and "+request.getParameter("hiddenEndDateForPlot")+"!</b>";
    	graphCase = 1;
    	stringBuilderForQuery.append(" AND INFO_DATE BETWEEN '"+request.getParameter("hiddenStartDateForPlot")+"' AND '"+request.getParameter("hiddenEndDateForPlot")+"' ORDER BY INFO_DATE ASC, INFO_TIME ASC");
    	query = stringBuilderForQuery.toString();
    	
    	ResultSet resultSetForQueryResults = statementForQueryResults.executeQuery(query);
    	
    	while(resultSetForQueryResults.next())
    	{
    		resultSetIsEmpty = false;
    		tempParts = resultSetForQueryResults.getString("INFO_DATE").split("-");
    		tempYear = tempParts[0];
    		tempMonth = tempParts[1];
    		tempDay = tempParts[2];
    		tempDate = tempDay+"."+tempMonth+"."+tempYear;
    		
    		stringBuilderForDateAndTime.append("'"+tempDate+"<br>"+resultSetForQueryResults.getString("INFO_TIME")+"', ");
    		stringBuilderForTemperature.append(resultSetForQueryResults.getString("TEMPERATURE")+", ");
    		stringBuilderForHumidity.append(resultSetForQueryResults.getString("HUMIDITY")+", ");
    		stringBuilderForBatteryLevel.append(resultSetForQueryResults.getString("BATTERY_LEVEL")+", ");
    		if(resultSetForQueryResults.getString("PRESENCE").equalsIgnoreCase("ON"))
    		{
    			stringBuilderForPresence.append("10, ");
    		}
    		else
    		{
    			stringBuilderForPresence.append("1, ");
    		}
    	}
    	
    	// Delete the last two characters of all string builders -> ", "
    	if(resultSetIsEmpty == false)
    	{
        	for(int i=0; i<2; i++)
        	{
        		stringBuilderForDateAndTime.deleteCharAt(stringBuilderForDateAndTime.length()-1);
        		stringBuilderForTemperature.deleteCharAt(stringBuilderForTemperature.length()-1);
        		stringBuilderForHumidity.deleteCharAt(stringBuilderForHumidity.length()-1);
        		stringBuilderForPresence.deleteCharAt(stringBuilderForPresence.length()-1);
        		stringBuilderForBatteryLevel.deleteCharAt(stringBuilderForBatteryLevel.length()-1);
        	}
    	}
    	
    	String[] fromParts = request.getParameter("hiddenStartDateForPlot").split("-");
    	fromYear = fromParts[0];
    	fromMonth = fromParts[1];
    	fromDay = fromParts[2];
    	
    	String[] toParts = request.getParameter("hiddenEndDateForPlot").split("-");
    	toYear = toParts[0];
    	toMonth = toParts[1];
    	toDay = toParts[2];
    	
    	fromDate = fromDay+"."+fromMonth+"."+fromYear;
    	toDate = toDay+"."+toMonth+"."+toYear;
        
        graphTitle = "Change in temperature, humidity and presence for mote"+moteID;
        graphSubtitle = "Between "+fromDate+" and "+toDate;
        		
        batteryLevelGraphTitle = "Change in battery levels for mote "+moteID;
        batteryLevelGraphSubtitle = graphSubtitle;

    }
    // Date and time interval is selected
    else if(request.getParameter("hiddenDateIntervalForPlot").equalsIgnoreCase("unchecked") && request.getParameter("hiddenDateAndTimeTogetherForPlot").equalsIgnoreCase("checked") && request.getParameter("hiddenTimeIntervalForPlot").equalsIgnoreCase("unchecked"))
    {
    	warningMessage = "Sorry, no data is found  for <b>mote "+moteID+"</b> between <b>"+request.getParameter("hiddenFromTimeForPlot")+"-"+request.getParameter("hiddenToTimeForPlot")+"</b> on each day that fits in range <b>"+request.getParameter("hiddenFromDateForPlot")+" and "+request.getParameter("hiddenToDateForPlot")+"!</b>";
    	graphCase = 2;
    	stringBuilderForQuery.append(" AND INFO_DATE BETWEEN '"+request.getParameter("hiddenFromDateForPlot")+"' AND '"+request.getParameter("hiddenToDateForPlot")+"' AND INFO_TIME>='"+request.getParameter("hiddenFromTimeForPlot")+"' AND INFO_TIME<='"+request.getParameter("hiddenToTimeForPlot")+"' ORDER BY INFO_DATE ASC, INFO_TIME ASC");
    	query = stringBuilderForQuery.toString();
    	
    	ResultSet resultSetForQueryResults = statementForQueryResults.executeQuery(query);
    	
    	while(resultSetForQueryResults.next())
    	{
    		resultSetIsEmpty = false;
    		tempParts = resultSetForQueryResults.getString("INFO_DATE").split("-");
    		tempYear = tempParts[0];
    		tempMonth = tempParts[1];
    		tempDay = tempParts[2];
    		tempDate = tempDay+"."+tempMonth+"."+tempYear;
    		
    		stringBuilderForDateAndTime.append("'"+tempDate+"<br>"+resultSetForQueryResults.getString("INFO_TIME")+"', ");
    		stringBuilderForTemperature.append(resultSetForQueryResults.getString("TEMPERATURE")+", ");
    		stringBuilderForHumidity.append(resultSetForQueryResults.getString("HUMIDITY")+", ");
    		stringBuilderForBatteryLevel.append(resultSetForQueryResults.getString("BATTERY_LEVEL")+", ");
    		if(resultSetForQueryResults.getString("PRESENCE").equalsIgnoreCase("ON"))
    		{
    			stringBuilderForPresence.append("10, ");
    		}
    		else
    		{
    			stringBuilderForPresence.append("1, ");
    		}
    	}
    	
    	// Delete the last two characters of all string builders -> ", "
    	if(resultSetIsEmpty == false)
    	{
        	for(int i=0; i<2; i++)
        	{
        		stringBuilderForDateAndTime.deleteCharAt(stringBuilderForDateAndTime.length()-1);
        		stringBuilderForTemperature.deleteCharAt(stringBuilderForTemperature.length()-1);
        		stringBuilderForHumidity.deleteCharAt(stringBuilderForHumidity.length()-1);
        		stringBuilderForPresence.deleteCharAt(stringBuilderForPresence.length()-1);
        		stringBuilderForBatteryLevel.deleteCharAt(stringBuilderForBatteryLevel.length()-1);
        	}
    	}
    	
    	String[] fromParts = request.getParameter("hiddenFromDateForPlot").split("-");
    	fromYear = fromParts[0];
    	fromMonth = fromParts[1];
    	fromDay = fromParts[2];
    	
    	String[] toParts = request.getParameter("hiddenToDateForPlot").split("-");
    	toYear = toParts[0];
    	toMonth = toParts[1];
    	toDay = toParts[2];
    	
    	fromDate = fromDay+"."+fromMonth+"."+fromYear;
    	toDate = toDay+"."+toMonth+"."+toYear;
    	
        graphTitle = "Change in temperature, humidity and presence for mote"+moteID;
        graphSubtitle = "Between "+request.getParameter("hiddenFromTimeForPlot")+"-"+request.getParameter("hiddenToTimeForPlot")+" on each day that fits in range "+fromDate+" to "+toDate;

        batteryLevelGraphTitle = "Change in battery levels for mote "+moteID;
        batteryLevelGraphSubtitle = graphSubtitle;
    }
    // Time interval is selected
    else if(request.getParameter("hiddenDateIntervalForPlot").equalsIgnoreCase("unchecked") && request.getParameter("hiddenDateAndTimeTogetherForPlot").equalsIgnoreCase("unchecked") && request.getParameter("hiddenTimeIntervalForPlot").equalsIgnoreCase("checked"))
    {    	
    	warningMessage = "Sorry, no data is found for <b>mote "+moteID+"</b> between <b>"+request.getParameter("hiddenStartOfTimeForPlot")+"-"+request.getParameter("hiddenEndOfTimeForPlot")+"</b> since the first day of sensing!";
    	graphCase = 3;
    	stringBuilderForQuery.append(" AND INFO_TIME>='"+request.getParameter("hiddenStartOfTimeForPlot")+"' AND INFO_TIME<='"+request.getParameter("hiddenEndOfTimeForPlot")+"' ORDER BY INFO_DATE ASC, INFO_TIME ASC");
    	query = stringBuilderForQuery.toString();
    	
    	ResultSet resultSetForQueryResults = statementForQueryResults.executeQuery(query);
    	
    	ArrayList<LatestMoteInfo> uniqueTimeInfo = new ArrayList<LatestMoteInfo>();
    	
    	while(resultSetForQueryResults.next())
    	{
    		resultSetIsEmpty = false;
    		tempParts = resultSetForQueryResults.getString("INFO_DATE").split("-");
    		tempYear = tempParts[0];
    		tempMonth = tempParts[1];
    		tempDay = tempParts[2];
    		tempDate = tempDay+"."+tempMonth+"."+tempYear;
    		
    		String [] tempPartsOfTime = resultSetForQueryResults.getString("INFO_TIME").split(":");
    		String tempHour = tempPartsOfTime[0];
    		String tempMinutes = tempPartsOfTime[1];
    		
    		//out.println("\n----------\nQUERY TIME: "+resultSetForQueryResults.getString("INFO_TIME")+"\n----------\n");
    		
    		LatestMoteInfo tempInfo = new LatestMoteInfo();
    		
			if(timeAlreadyExists(tempHour, tempMinutes, uniqueTimeInfo))
			{
				//out.print("\n\n ANANANAN!! \n\n");
				for(int i=0; i<uniqueTimeInfo.size(); i++)
				{
					String [] tempPartsOfListTime = uniqueTimeInfo.get(i).getInfoTime().split(":");
					String tempHourForListTime = tempPartsOfListTime[0];
					String tempMinutesForListTime = tempPartsOfListTime[1];
					
					if(tempHour.equalsIgnoreCase(tempHourForListTime) && tempMinutes.equalsIgnoreCase(tempMinutesForListTime))
					{
						//out.print("\n\n HOLAAA!! \n\n");
						int tempCounter = uniqueTimeInfo.get(i).getCounter();
						int tempHumidity = Integer.parseInt(uniqueTimeInfo.get(i).getHumid());
						int tempTemperature = Integer.parseInt(uniqueTimeInfo.get(i).getTemp());
						int tempBatteryLevel = Integer.parseInt(uniqueTimeInfo.get(i).getBatteryLevel());
						
						tempCounter++;
						tempHumidity = tempHumidity + Integer.parseInt(resultSetForQueryResults.getString("HUMIDITY"));
						tempTemperature = tempTemperature + Integer.parseInt(resultSetForQueryResults.getString("TEMPERATURE"));
						tempBatteryLevel = tempBatteryLevel + Integer.parseInt(resultSetForQueryResults.getString("BATTERY_LEVEL"));
						
						uniqueTimeInfo.get(i).setCounter(tempCounter);
						uniqueTimeInfo.get(i).setHumid(Integer.toString(tempHumidity));
						uniqueTimeInfo.get(i).setTemp(Integer.toString(tempTemperature));
						uniqueTimeInfo.get(i).setBatteryLevel(Integer.toString(tempBatteryLevel));
						
					}
				}
			}
			else
			{
    			tempInfo.setMoteID(Integer.parseInt(moteID));
    			tempInfo.setInfoDate(tempDate);
    			tempInfo.setInfoTime(resultSetForQueryResults.getString("INFO_TIME"));
    			tempInfo.setTemp(resultSetForQueryResults.getString("TEMPERATURE"));
    			tempInfo.setHumid(resultSetForQueryResults.getString("HUMIDITY"));
    			tempInfo.setBatteryLevel(resultSetForQueryResults.getString("BATTERY_LEVEL"));
    			tempInfo.setCounter(1);
    			uniqueTimeInfo.add(tempInfo);
			}
    		
			/*
    		stringBuilderForDateAndTime.append("'"+tempDate+"<br>"+resultSetForQueryResults.getString("INFO_TIME")+"', ");
    		stringBuilderForTemperature.append(resultSetForQueryResults.getString("TEMPERATURE")+", ");
    		stringBuilderForHumidity.append(resultSetForQueryResults.getString("HUMIDITY")+", ");
    		if(resultSetForQueryResults.getString("PRESENCE").equalsIgnoreCase("ON"))
    		{
    			stringBuilderForPresence.append("10, ");
    		}
    		else
    		{
    			stringBuilderForPresence.append("1, ");
    		}
    		*/
    	}
    	
    	//Arrays.sort(uniqueTimeInfo, LatestMoteInfo.InfoTimeComparator);
    	
    	Collections.sort(uniqueTimeInfo, new Comparator<LatestMoteInfo>(){

    		  public int compare(LatestMoteInfo o1, LatestMoteInfo o2)
    		  {
    		     return o1.getInfoTime().compareTo(o2.getInfoTime());
    		     
    		  }
    		  
    		});
    	
		for(int i=0; i<uniqueTimeInfo.size(); i++)
		{
			String [] tempPartsOfListTime = uniqueTimeInfo.get(i).getInfoTime().split(":");
			String tempHourForListTime = tempPartsOfListTime[0];
			String tempMinutesForListTime = tempPartsOfListTime[1];
			
			int tempCounter = uniqueTimeInfo.get(i).getCounter();
			int tempHumidity = Integer.parseInt(uniqueTimeInfo.get(i).getHumid());
			int tempTemperature = Integer.parseInt(uniqueTimeInfo.get(i).getTemp());
			int tempBatteryLevel = Integer.parseInt(uniqueTimeInfo.get(i).getBatteryLevel());
			
			tempHumidity = tempHumidity / tempCounter;
			tempTemperature = tempTemperature / tempCounter;
			tempBatteryLevel = tempBatteryLevel / tempCounter;
			
    		stringBuilderForDateAndTime.append("'"+tempHourForListTime+":"+tempMinutesForListTime+"', ");
    		stringBuilderForTemperature.append(tempTemperature+", ");
    		stringBuilderForHumidity.append(tempHumidity+", ");
    		stringBuilderForBatteryLevel.append(tempBatteryLevel+", ");
    		
    		/*
			out.println("TIME: "+uniqueTimeInfo.get(i).getInfoTime());
			out.println("COUNTER: "+tempCounter);
			out.println("TEMPERATURE: "+tempTemperature);
			out.println("HUMIDITY: "+tempHumidity+"\n");
			*/
		}
    	
    	// Delete the last two characters of all string builders -> ", "
    	if(resultSetIsEmpty == false)
    	{
        	for(int i=0; i<2; i++)
        	{
        		stringBuilderForDateAndTime.deleteCharAt(stringBuilderForDateAndTime.length()-1);
        		stringBuilderForTemperature.deleteCharAt(stringBuilderForTemperature.length()-1);
        		stringBuilderForHumidity.deleteCharAt(stringBuilderForHumidity.length()-1);
        		stringBuilderForBatteryLevel.deleteCharAt(stringBuilderForBatteryLevel.length()-1);
        	}
    	}
    
	    graphTitle = "Average change in battery levels, humidity and presence for mote "+moteID;
	    graphSubtitle = "Between "+request.getParameter("hiddenStartOfTimeForPlot")+"-"+request.getParameter("hiddenEndOfTimeForPlot")+" since the first day of sensing";
    }
    else
    {
    	// Do nothing since something is wrong
    }
    
	String dateAndTimeString = stringBuilderForDateAndTime.toString();
	String temperatureString = stringBuilderForTemperature.toString();
	String humidityString = stringBuilderForHumidity.toString();
	String presenceString = stringBuilderForPresence.toString();
	String batteryLevelString = stringBuilderForBatteryLevel.toString();
    
    ResultSet resultSetForQueryResults = statementForQueryResults.executeQuery(query);
	
	//System.out.println(stringBuilderForQuery.toString());
                    		
%>

<%!

	public boolean timeAlreadyExists(String hour, String minutes, ArrayList<LatestMoteInfo> listToBeSearched)
	{
	
		for(int i=0; i<listToBeSearched.size(); i++)
		{	
			String [] tempTimeOfListParts = listToBeSearched.get(i).getInfoTime().split(":");
			String tempTimeOfListHour = tempTimeOfListParts[0];
			String tempTimeOfListMinutes = tempTimeOfListParts[1];
			
			if(hour.equalsIgnoreCase(tempTimeOfListHour) && minutes.equalsIgnoreCase(tempTimeOfListMinutes))
			{
				return true;
			}
		}
		return false;
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
        
        <h2>Plot Graph Results</h2>
		
		<% 
		   if(resultSetIsEmpty) 
		   { 
			   out.println("<p style=\"font-size: 15px;\"><b><font color=red>ERROR:</font></b> "+warningMessage+"</p>");
		   }
		   else
		   {
		%>
		      <p style="font-size: 15px;">The database is queried with your inputs successfully and your graph is created respectively. You may visit the <a href="queryDatabase.jsp" target="_blank">Query Database</a> page and query the database from there to have more detailed tabular results.</p>
		      <br>
		      <div id="<% if (graphCase==1 || graphCase==2) { out.print("containerForDateAndDate-TimeIntervalGraph"); } else if (graphCase==3) { out.print("containerForTimeIntervalGraph"); } else { out.print("originalContainer"); } %>" style="min-width: 400px; height: 400px; margin: 0 auto"></div>
		<%	  
			  // If the graph is date interval OR date and time interval, plot the battery graph separately
			  if (graphCase==1 || graphCase==2)
			  {
				  out.print("<br><br><br><div id='containerForBatteryLevelGraph' style='min-width: 400px; height: 400px; margin: 0 auto'></div>");
			  }
		   }
		%>
        
    </div>
</div>
<!-- / section -->

<br>
<!-- footer -->

<jsp:include page="footer.jsp" />

<!-- REQUIRED FILES FOR Highchart -->

<!-- JQuery.min.js is required but it already exists in assets/js. 
	 Importing it again causes a crash and the chart doest not load.

	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
	
-->
<script src="http://code.highcharts.com/highcharts.js"></script>
<!-- <script src="assets/js/highcharts.js"></script>   -->
<script src="http://code.highcharts.com/modules/exporting.js"></script>

<script>

$(function () {
	
	// Date interval
    $('#containerForDateAndDate-TimeIntervalGraph').highcharts({
    	
        credits: {
            text: 'Provided by Environment Tracking System',
            href: 'http://www.etsoftware.com'
        },
    	
        chart: {
            zoomType: 'xy'
        },
        title: {
            text: '<% out.print(graphTitle); %>'
        },
        subtitle: {
            text: '<% out.print(graphSubtitle); %>'
        },
        xAxis: [{
            categories: [<% out.print(dateAndTimeString); %>],
            crosshair: true
        }],
        yAxis: [{ // Primary yAxis
            labels: {
                format: '{value} °C',
                style: {
                    color: '#FF0000'
                }
            },
            title: {
                text: 'Temperature',
                style: {
                    color: '#FF0000'
                }
            },
            opposite: true

        }, { // Secondary yAxis
            gridLineWidth: 0,
            title: {
                text: 'Motion / Presence<br>(0 is NO and 10 is YES)',
                style: {
                    color: Highcharts.getOptions().colors[0]
                }
            },
            labels: {
                format: '{value}',
                style: {
                    color: Highcharts.getOptions().colors[0]
                }
            }

        }, { // Tertiary yAxis
            gridLineWidth: 0,
            title: {
                text: 'Humidity',
                style: {
                    color: Highcharts.getOptions().colors[1]
                }
            },
            labels: {
                format: '{value} %',
                style: {
                    color: Highcharts.getOptions().colors[1]
                }
            },
            opposite: true
        }],
        tooltip: {
            shared: true
        },
        legend: {
            layout: 'vertical',
            align: 'left',
            x: 80,
            verticalAlign: 'top',
            y: 55,
            floating: true,
            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
        },
        series: [{
            name: 'Motion / Presence',
            type: 'column',
            yAxis: 1,
            data: [<% out.print(presenceString); %>],
            tooltip: {
                valueSuffix: ' (1 is NO and 10 is YES)'
            }

        }, {
            name: 'Humidity',
            type: 'spline',
            yAxis: 2,
            data: [<% out.print(humidityString); %>],
            marker: {
                enabled: false
            },
            dashStyle: 'shortdot',
            tooltip: {
                valueSuffix: ' %'
            }

        }, {
            name: 'Temperature',
            color: '#FF0000',
            type: 'spline',
            data: [<% out.print(temperatureString); %>],
            tooltip: {
                valueSuffix: ' °C'
            }
        }]
    });
	
	
    $('#containerForBatteryLevelGraph').highcharts({
    	
        credits: {
            text: 'Provided by Environment Tracking System',
            href: 'http://www.etsoftware.com'
        },
        
        chart: {
            zoomType: 'xy'
        },
        title: {
            text: '<% out.print(batteryLevelGraphTitle); %>'
        },
        subtitle: {
            text: '<% out.print(batteryLevelGraphSubtitle); %>'
        },
        xAxis: [{
            categories: [<% out.print(dateAndTimeString); %>],
            crosshair: true
        }],
        yAxis: [
		{ // Secondary yAxis
            gridLineWidth: 0,
            title: {
                text: 'Battery Level',
                style: {
                    color: Highcharts.getOptions().colors[0]
                }
            },
            labels: {
                format: '{value} %',
                style: {
                    color: Highcharts.getOptions().colors[0]
                }
            }

        }],
        tooltip: {
            shared: true
        },
        legend: {
            layout: 'vertical',
            align: 'left',
            x: 80,
            verticalAlign: 'top',
            y: 55,
            floating: true,
            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
        },
        series: [{
            name: 'Battery Level',
            type: 'column',
            yAxis: 0,
            data: [<% out.print(batteryLevelString); %>],
            tooltip: {
                valueSuffix: ' %'
            }

        }]
    });
    
    
	// Time interval
    $('#containerForTimeIntervalGraph').highcharts({
    	
        credits: {
            text: 'Provided by Environment Tracking System',
            href: 'http://www.etsoftware.com'
        },
    	
        chart: {
            zoomType: 'xy'
        },
        title: {
            text: '<% out.print(graphTitle); %>'
        },
        subtitle: {
            text: '<% out.print(graphSubtitle); %>'
        },
        xAxis: [{
            categories: [<% out.print(dateAndTimeString); %>],
            crosshair: true
        }],
        yAxis: [{ // Primary yAxis
            labels: {
                format: '{value} °C',
                style: {
                    color: '#FF0000'
                }
            },
            title: {
                text: 'Temperature',
                style: {
                    color: '#FF0000'
                }
            },
            opposite: true

        }, { // Secondary yAxis
            gridLineWidth: 0,
            title: {
                text: 'Battery Level',
                style: {
                    color: Highcharts.getOptions().colors[0]
                }
            },
            labels: {
                format: '{value} %',
                style: {
                    color: Highcharts.getOptions().colors[0]
                }
            }

        }, { // Tertiary yAxis
            gridLineWidth: 0,
            title: {
                text: 'Humidity',
                style: {
                    color: Highcharts.getOptions().colors[1]
                }
            },
            labels: {
                format: '{value} %',
                style: {
                    color: Highcharts.getOptions().colors[1]
                }
            },
            opposite: true
        }],
        tooltip: {
            shared: true
        },
        legend: {
            layout: 'vertical',
            align: 'left',
            x: 80,
            verticalAlign: 'top',
            y: 55,
            floating: true,
            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
        },
        series: [{
            name: 'Battery Level',
            type: 'column',
            yAxis: 1,
            data: [<% out.print(batteryLevelString); %>],
            tooltip: {
                valueSuffix: ' %'
            }

        }, {
            name: 'Humidity',
            type: 'spline',
            yAxis: 2,
            data: [<% out.print(humidityString); %>],
            marker: {
                enabled: false
            },
            dashStyle: 'shortdot',
            tooltip: {
                valueSuffix: ' %'
            }

        }, {
            name: 'Temperature',
            color: '#FF0000',
            type: 'spline',
            data: [<% out.print(temperatureString); %>],
            tooltip: {
                valueSuffix: ' °C'
            }
        }]
    });
    
    
    // Original container
    $('#originalContainer').highcharts({
        chart: {
            zoomType: 'xy'
        },
        title: {
            text: 'Average Monthly Weather Data for Tokyo'
        },
        subtitle: {
            text: 'Source: WorldClimate.com'
        },
        xAxis: [{
            categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            crosshair: true
        }],
        yAxis: [{ // Primary yAxis
            labels: {
                format: '{value}°C',
                style: {
                    color: Highcharts.getOptions().colors[2]
                }
            },
            title: {
                text: 'Temperature',
                style: {
                    color: Highcharts.getOptions().colors[2]
                }
            },
            opposite: true

        }, { // Secondary yAxis
            gridLineWidth: 0,
            title: {
                text: 'Rainfall',
                style: {
                    color: Highcharts.getOptions().colors[0]
                }
            },
            labels: {
                format: '{value} mm',
                style: {
                    color: Highcharts.getOptions().colors[0]
                }
            }

        }, { // Tertiary yAxis
            gridLineWidth: 0,
            title: {
                text: 'Sea-Level Pressure',
                style: {
                    color: Highcharts.getOptions().colors[1]
                }
            },
            labels: {
                format: '{value} mb',
                style: {
                    color: Highcharts.getOptions().colors[1]
                }
            },
            opposite: true
        }],
        tooltip: {
            shared: true
        },
        legend: {
            layout: 'vertical',
            align: 'left',
            x: 80,
            verticalAlign: 'top',
            y: 55,
            floating: true,
            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
        },
        series: [{
            name: 'Rainfall',
            type: 'column',
            yAxis: 1,
            data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4],
            tooltip: {
                valueSuffix: ' mm'
            }

        }, {
            name: 'Sea-Level Pressure',
            type: 'spline',
            yAxis: 2,
            data: [1016, 1016, 1015.9, 1015.5, 1012.3, 1009.5, 1009.6, 1010.2, 1013.1, 1016.9, 1018.2, 1016.7],
            marker: {
                enabled: false
            },
            dashStyle: 'shortdot',
            tooltip: {
                valueSuffix: ' mb'
            }

        }, {
            name: 'Temperature',
            type: 'spline',
            data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6],
            tooltip: {
                valueSuffix: ' °C'
            }
        }]
    });
    
});

</script>

<!-- /REQUIRED FILES FOR Highchart -->