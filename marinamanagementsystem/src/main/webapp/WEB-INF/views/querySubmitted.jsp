<%@ page language="java" contentType="text/html; charset=ISO-8859-9" import="java.io.*, java.util.*, java.util.Date, java.sql.*, javax.servlet.*, java.text.* "
	pageEncoding="ISO-8859-9"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js" lang="en"> <!--<![endif]-->
<head>
<jsp:include page="header.jsp" />

<title>Query Results - Environment Tracking Software</title>

<style type="text/css">
 	table.table {
        display: table;
        width: 100%;
    }
    table.table thead, table.table tbody {
        float: left;
        width: 100%;
    }
    table.table tbody {
        overflow: auto;
        height: 190px;
    }
    table.table tr {
        width: 100%;
        display: table;
        //text-align: left;
    }
    table.table th, table.table td {
        width: 10%;
    }
</style>

</head>

<%
	String userName;
	CharSequence referenceURL="queryDatabase";

	if(session.getAttribute( "userName") == null || session.getAttribute( "password") == null)
	{
		response.sendRedirect("login.jsp");
		return;
	}
	else if (request.getHeader("Referer") == null || !request.getHeader("Referer").contains(referenceURL))
	{
		response.sendRedirect("queryDatabase.jsp");
		return;
	}
	else
	{
		userName = session.getAttribute("userName").toString();
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
	
	boolean needAndFlag = false;
	StringBuilder stringBuilderForQuery = new StringBuilder();
    
    stringBuilderForQuery.append("SELECT MOTE_ID, DATE_FORMAT(INFO_DATE, '%d.%m.%Y') AS INFO_DATE_FORMATTED, INFO_TIME, PRESENCE, TEMPERATURE, HUMIDITY, BATTERY_LEVEL FROM MOTE_INFORMATION WHERE");
                    		
    // MOTE ID checker
	if(request.getParameter("allMotesCondition") == null)
	{
		needAndFlag = true;	
		String [] moteIDList = request.getParameterValues("moteIDList");
		for(int i=0; i<moteIDList.length; i++)
		{
			if(i==0)
			{
				stringBuilderForQuery.append(" (MOTE_ID="+moteIDList[i]);
			}
			else
			{
				stringBuilderForQuery.append(" OR MOTE_ID="+moteIDList[i]);
			}			
		}
		stringBuilderForQuery.append(")");
	}
	
    // Presence Checker
	if(request.getParameter("presenceIsON") != null && request.getParameter("presenceIsOFF") == null)
	{
		if(needAndFlag == true)
		{
			stringBuilderForQuery.append(" AND PRESENCE='ON'");
		}
		else
		{
			stringBuilderForQuery.append(" PRESENCE='ON'");
		}
	}
	else if(request.getParameter("presenceIsON") == null && request.getParameter("presenceIsOFF") != null)
	{
		if(needAndFlag == true)
		{
			stringBuilderForQuery.append(" AND PRESENCE='OFF'");
		}
		else
		{
			stringBuilderForQuery.append(" PRESENCE='OFF'");
		}
	}
	else
	{
		// do nothing
	}
	
    // Temperature Checker
	if(needAndFlag == true)
	{
		stringBuilderForQuery.append(" AND (TEMPERATURE>="+request.getParameter("fromTemperatureList")+" AND TEMPERATURE<="+request.getParameter("toTemperatureList")+")");
	}
	else
	{
		stringBuilderForQuery.append(" (TEMPERATURE>="+request.getParameter("fromTemperatureList")+" AND TEMPERATURE<="+request.getParameter("toTemperatureList")+")");
	}
    
    // Humidity Checker
	stringBuilderForQuery.append(" AND (HUMIDITY>="+request.getParameter("fromHumidityList")+" AND HUMIDITY<="+request.getParameter("toHumidityList")+")");
    
    // Battery Level Checker
	stringBuilderForQuery.append(" AND (BATTERY_LEVEL>="+request.getParameter("fromBatteryLevelList")+" AND BATTERY_LEVEL<="+request.getParameter("toBatteryLevelList")+")");
    
    // Date and Time Checker
    if(request.getParameter("dateAndTimeTogether") != null)
    {
    	//stringBuilderForQuery.append(" AND INFO_DATE BETWEEN '"+request.getParameter("hiddenStartDate")+"' AND '"+request.getParameter("hiddenEndDate")+"' AND INFO_TIME>='"+request.getParameter("hiddenStartTime")+"' AND INFO_TIME<='"+request.getParameter("hiddenEndTime")+"'");
    	
    	String[] partsOfStartDate = request.getParameter("hiddenStartDate").split("-");
    	String[] partsOfEndDate = request.getParameter("hiddenEndDate").split("-");
    	
    	String startDateYear = partsOfStartDate[0];
    	String startDateMonth = partsOfStartDate[1];
    	String startDateDay = partsOfStartDate[2];
    	
    	String endDateYear = partsOfEndDate[0];
    	String endDateMonth = partsOfEndDate[1];
    	String endDateDay = partsOfEndDate[2];
    	
    	// Set the previous date of end date
    	Calendar previousDateOfEndDate = GregorianCalendar.getInstance();
    	if(Integer.parseInt(endDateMonth)==1)
    	{
    		previousDateOfEndDate.set(Integer.parseInt(endDateYear)-1, 11, Integer.parseInt(endDateDay));
    	}
    	else 
    	{
    		previousDateOfEndDate.set(Integer.parseInt(endDateYear), Integer.parseInt(endDateMonth)-2, Integer.parseInt(endDateDay)); 
    	}
    	
    	previousDateOfEndDate.set(Calendar.DATE, previousDateOfEndDate.getActualMaximum(Calendar.DAY_OF_MONTH));
    	Date previousDate = previousDateOfEndDate.getTime();
    	
    	String dateOfLastMonth = new SimpleDateFormat("dd.MM.yyyy").format(previousDate);
    	String[] partsOfDateOfLastMonth = dateOfLastMonth.split("\\.");
    	
    	String dateOfLastMonth_day = partsOfDateOfLastMonth[0];
    	String dateOfLastMonth_month = partsOfDateOfLastMonth[1];
    	String dateOfLastMonth_year = partsOfDateOfLastMonth[2];
    	
    	// Set the last date of start date
    	Calendar cal_maxDateOfStartDate = GregorianCalendar.getInstance();
    	cal_maxDateOfStartDate.set(Integer.parseInt(startDateYear), Integer.parseInt(startDateMonth)-1, Integer.parseInt(startDateDay));
    	
    	cal_maxDateOfStartDate.set(Calendar.DATE, cal_maxDateOfStartDate.getActualMaximum(Calendar.DAY_OF_MONTH));
    	Date maxDateOfStartDate = cal_maxDateOfStartDate.getTime();
    	
    	String dateForMaxDayOfStartDate = new SimpleDateFormat("dd.MM.yyyy").format(maxDateOfStartDate);
    	String[] partsOfDateForMaxDayOfStartDate = dateForMaxDayOfStartDate.split("\\.");
    	
    	String newStartDate_day = partsOfDateForMaxDayOfStartDate[0];
    	String newStartDate_month = partsOfDateForMaxDayOfStartDate[1];
    	String newStartDate_year = partsOfDateForMaxDayOfStartDate[2];
    	
    	// Set the next date of start date
    	Calendar cal_nextDateOfStartDate = GregorianCalendar.getInstance();
    	cal_nextDateOfStartDate.set(Integer.parseInt(startDateYear), Integer.parseInt(startDateMonth), Integer.parseInt(startDateDay));
    	
    	cal_nextDateOfStartDate.set(Calendar.DATE, cal_nextDateOfStartDate.getActualMinimum(Calendar.DAY_OF_MONTH));
    	
    	Date nextDateOfStartDate = cal_nextDateOfStartDate.getTime();
    	
    	String dateForNextDayOfStartDate = new SimpleDateFormat("dd.MM.yyyy").format(nextDateOfStartDate);
    	String[] partsOfDateForNextDayOfStartDate = dateForNextDayOfStartDate.split("\\.");
    	
    	String nextStartDate_day = partsOfDateForNextDayOfStartDate[0];
    	String nextStartDate_month = partsOfDateForNextDayOfStartDate[1];
    	String nextStartDate_year = partsOfDateForNextDayOfStartDate[2];
    	
    	if(endDateDay.equals("01") && startDateMonth.equalsIgnoreCase(dateOfLastMonth_month) && startDateDay.equalsIgnoreCase(dateOfLastMonth_day))
    	{
			stringBuilderForQuery.append(" AND ((INFO_DATE = '"+request.getParameter("hiddenStartDate")+"' AND INFO_TIME <= CAST('23:59:59' AS time) AND INFO_TIME >= '"+request.getParameter("hiddenStartTime")+"') OR (INFO_DATE = '"+request.getParameter("hiddenEndDate")+"' AND INFO_TIME >= CAST('00:00:00' AS time) AND INFO_TIME <= '"+request.getParameter("hiddenEndTime")+"'))");
    	}
    	else if(startDateMonth.equalsIgnoreCase(endDateMonth) && startDateYear.equalsIgnoreCase(endDateYear) && Integer.parseInt(endDateDay) - Integer.parseInt(startDateDay) == 1)
    	{
			stringBuilderForQuery.append(" AND ((INFO_DATE = '"+request.getParameter("hiddenStartDate")+"' AND INFO_TIME <= CAST('23:59:59' AS time) AND INFO_TIME >= '"+request.getParameter("hiddenStartTime")+"') OR (INFO_DATE = '"+request.getParameter("hiddenEndDate")+"' AND INFO_TIME >= CAST('00:00:00' AS time) AND INFO_TIME <= '"+request.getParameter("hiddenEndTime")+"'))");
    	}
    	else if(startDateDay.equalsIgnoreCase(endDateDay) && startDateMonth.equalsIgnoreCase(endDateMonth) && startDateYear.equalsIgnoreCase(endDateYear))
    	{
        	stringBuilderForQuery.append(" AND (INFO_DATE = '"+request.getParameter("hiddenStartDate")+"' AND INFO_TIME>='"+request.getParameter("hiddenStartTime")+"' AND INFO_TIME<='"+request.getParameter("hiddenEndTime")+"')");
    	}
    	else if(endDateDay.equals("01") || startDateDay.equalsIgnoreCase(newStartDate_day))
    	{
    		if(endDateDay.equals("01") && startDateDay.equalsIgnoreCase(newStartDate_day))
    		{
    			stringBuilderForQuery.append(" AND ((INFO_DATE = '"+request.getParameter("hiddenStartDate")+"' AND INFO_TIME <= CAST('23:59:59' AS time) AND INFO_TIME >= '"+request.getParameter("hiddenStartTime")+"') OR (INFO_DATE = '"+request.getParameter("hiddenEndDate")+"' AND INFO_TIME >= CAST('00:00:00' AS time) AND INFO_TIME <= '"+request.getParameter("hiddenEndTime")+"') OR (INFO_DATE>='"+nextStartDate_year+"-"+nextStartDate_month+"-"+nextStartDate_day+"' AND INFO_DATE <= '"+dateOfLastMonth_year+"-"+dateOfLastMonth_month+"-"+dateOfLastMonth_day+"'))");
    		}
    		else if(endDateDay.equals("01"))
    		{
    			stringBuilderForQuery.append(" AND ((INFO_DATE = '"+request.getParameter("hiddenStartDate")+"' AND INFO_TIME <= CAST('23:59:59' AS time) AND INFO_TIME >= '"+request.getParameter("hiddenStartTime")+"') OR (INFO_DATE = '"+request.getParameter("hiddenEndDate")+"' AND INFO_TIME >= CAST('00:00:00' AS time) AND INFO_TIME <= '"+request.getParameter("hiddenEndTime")+"') OR (INFO_DATE>='"+Integer.parseInt(startDateYear)+"-"+Integer.parseInt(startDateMonth)+"-"+(Integer.parseInt(startDateDay)+1)+"' AND INFO_DATE <= '"+dateOfLastMonth_year+"-"+dateOfLastMonth_month+"-"+dateOfLastMonth_day+"'))");
    		}
    		else if(startDateDay.equalsIgnoreCase(newStartDate_day))
    		{
    			stringBuilderForQuery.append(" AND ((INFO_DATE = '"+request.getParameter("hiddenStartDate")+"' AND INFO_TIME <= CAST('23:59:59' AS time) AND INFO_TIME >= '"+request.getParameter("hiddenStartTime")+"') OR (INFO_DATE = '"+request.getParameter("hiddenEndDate")+"' AND INFO_TIME >= CAST('00:00:00' AS time) AND INFO_TIME <= '"+request.getParameter("hiddenEndTime")+"') OR (INFO_DATE>='"+nextStartDate_year+"-"+nextStartDate_month+"-"+nextStartDate_day+"' AND INFO_DATE <= '"+endDateYear+"-"+endDateMonth+"-"+(Integer.parseInt(endDateDay)-1)+"'))");
    		}
    	}
    	else
    	{
    		stringBuilderForQuery.append(" AND ((INFO_DATE = '"+request.getParameter("hiddenStartDate")+"' AND INFO_TIME <= CAST('23:59:59' AS time) AND INFO_TIME >= '"+request.getParameter("hiddenStartTime")+"') OR (INFO_DATE = '"+request.getParameter("hiddenEndDate")+"' AND INFO_TIME >= CAST('00:00:00' AS time) AND INFO_TIME <= '"+request.getParameter("hiddenEndTime")+"') OR (INFO_DATE>='"+Integer.parseInt(startDateYear)+"-"+Integer.parseInt(startDateMonth)+"-"+(Integer.parseInt(startDateDay)+1)+"' AND INFO_DATE <= '"+endDateYear+"-"+endDateMonth+"-"+(Integer.parseInt(endDateDay)-1)+"'))");
    	}
    }
    else
    {
    	stringBuilderForQuery.append(" AND (INFO_DATE BETWEEN '"+request.getParameter("hiddenFromDate")+"' AND '"+request.getParameter("hiddenToDate")+"' AND INFO_TIME >= '"+request.getParameter("hiddenFromTime")+"' AND INFO_TIME <= '"+request.getParameter("hiddenToTime")+"')");
    }
    
    /*
    out.println("\n\n DATE AND TIME \n\n");
    out.println("Start Date: "+request.getParameter("hiddenStartDate"));
    out.println("Start Time: "+request.getParameter("hiddenStartTime"));

    out.println("\nEnd Date: "+request.getParameter("hiddenEndDate"));
    out.println("End Time: "+request.getParameter("hiddenEndTime"));
    
    out.println("\nFrom Date: "+request.getParameter("hiddenFromDate"));
    out.println("From Time: "+request.getParameter("hiddenFromTime"));

    out.println("\nTo Date: "+request.getParameter("hiddenToDate"));
    out.println("To Time: "+request.getParameter("hiddenToTime"));
    out.println("\n\n");
    */
    
    stringBuilderForQuery.append(" ORDER BY INFO_DATE DESC, INFO_TIME DESC");
    
    String query = stringBuilderForQuery.toString();
    
    ResultSet resultSetForQueryResults = statementForQueryResults.executeQuery(query);
	
	//System.out.println(stringBuilderForQuery.toString());
                    		
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
        
        <h2>Query Results</h2>
		<p style="font-size: 15px;">The database is queried with your inputs successfully. You may visit the <a href="plotGraph.jsp" target="_blank">Plot Graph</a> page and query the database from there to have some graphical results.</p>
		<br/>
        <table class="table table-hover" style="overflow:scroll;height:80px;width:100%;overflow:auto">
            <thead>
            <tr style="background-color:#4A4744; table-layout:fixed">
                <th><font color="white">Info Date</font></th>
                <th><font color="white">Info Time</font></th>
                <th><font color="white">Mote ID</font></th>
                <th><font color="white">Light Status / Presence</font></th>
                <th><font color="white">Temperature</font></th>
                <th><font color="white">Humidity</font></th>
                <th><font color="white">Battery Level</font></th>
            </tr>
            </thead>
            	<%
            		if(!resultSetForQueryResults.next())
            		{
            	%>
				<tr>
					<td colspan="7" style="border: 2px solid #DDDDDD; height:190px; vertical-align:middle">No data found!</td>
				</tr>
				<tbody>
				<%
            		}
            		else
            		{
            			do
            			{
            	%>
            	            <tr>
            	                <td style="border: 2px solid #DDDDDD;">	
            	                		<%
            								out.println(resultSetForQueryResults.getString("INFO_DATE_FORMATTED"));
            							%>
            					</td>
            	                <td style="border: 2px solid #DDDDDD;">	
            	                		<%
            								out.println(resultSetForQueryResults.getString("INFO_TIME"));
            							%>
            					</td>
            	                <td style="border: 2px solid #DDDDDD;">	
            	                		<%
            								out.println(resultSetForQueryResults.getString("MOTE_ID"));
            							%>
            					</td>
				                <td style="border: 2px solid #DDDDDD;">
				                   		<%
											if(resultSetForQueryResults.getString("PRESENCE").equalsIgnoreCase("ON"))
											{
												out.println("<font color=\"darkgreen\">ON / YES</font>");
											}
											else
											{
												out.println("<font color=\"red\">OFF / NO</font>");
											}
										%>
				                </td>
				                <td style="border: 2px solid #DDDDDD;">
				                		<%
											out.println(resultSetForQueryResults.getString("TEMPERATURE")+" °C");
										%>
				                </td>
				                <td style="border: 2px solid #DDDDDD;">
				                		<%
											out.println(resultSetForQueryResults.getString("HUMIDITY")+"%");
										%>
				                </td>
				                <td style="border: 2px solid #DDDDDD;">
				                		<%
											out.println(resultSetForQueryResults.getString("BATTERY_LEVEL")+"%");
										%>
				                </td>
            				</tr>
            	<%
            			}while(resultSetForQueryResults.next());
            		}
				%>
            	</tbody>
        </table>
        
    </div>
</div>
<!-- / section -->

<br>
<!-- footer -->

<jsp:include page="footer.jsp" />