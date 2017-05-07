<%

	// Detect the current URI so that the active menu headers can be set in the top-menu
	String currentPageURI = (String) request.getAttribute("javax.servlet.forward.request_uri"); 
	String[] partsOfTheURI = currentPageURI.split("/");
	String currentPage = partsOfTheURI[3];
	
	//out.print("Current page: "+currentPage);
%>

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
			            <% if (currentPage.contains("login") || currentPage.contains("register") || currentPage.contains("aboutUs") || currentPage.contains("contactUs")) { %>
				            <li <% if (currentPage.contains("login")) { out.print("class=\"active\""); } %>><a class="dropdown" href="login">Login</a></li>
				            <li <% if (currentPage.contains("register")) { out.print("class=\"active\""); } %>><a href="register">Register</a></li>
				            <li <% if (currentPage.contains("aboutUs")) { out.print("class=\"active\""); } %>><a class="dropdown" href="aboutUs">About</a></li>
			                <li><a class="btn btn-border <% if (currentPage.contains("contactUs")) { out.print("class=\" active\""); } %>" style="border-color: #FF9A00; background: #FF9A00; font-size: 14px; font-weight: normal;" href="contactUs">Contact us!</a></li>
			            <% } else { %>
				            <li <% if (currentPage.contains("home")) { out.print("class=\"active\""); } %>><a class="dropdown" href="home">Home</a></li>
				            
			                <li class="<% if (currentPage.contains("marinaStatus") || currentPage.contains("reservations") || currentPage.contains("procurementHistory")  || currentPage.contains("consumptions")) { out.print("active "); } %>dropdown">
			                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Browse</a>
			                    <ul class="list-unstyled" role="menu">
			                        <li <% if (currentPage.contains("marinaStatus")) { out.print("class=\"active\""); } %>><a href="marinaStatus">Marina Status&emsp;<span>Browse the marina status</span></a></li>
			                        <li <% if (currentPage.contains("reservations")) { out.print("class=\"active\""); } %>><a href="reservations">Reservations&emsp;<span>All individual reservations</span></a></li>
			                        <li <% if (currentPage.contains("procurementHistory") || currentPage.contains("consumptions")) { out.print("class=\"active\""); } %>><a href="procurementHistory">Procurement History&emsp;<span>All invoices & consumptions</span></a></li>
			                    </ul>
			                </li>
				            
			                <li><a class="btn btn-border <% if (currentPage.equalsIgnoreCase("logout")) { out.print("class=\" active\""); } %>" style="border-color: #DF2D1C; background: #DF2D1C; font-size: 14px; font-weight: normal;" href="#" onclick="return askForLogout();">Logout</a></li>
			                <br/>
			                <div align="right">Welcome, <a href="userSettings">${kisiSessiondaBulunan.name}.</a></div>
			                <br/>
			            <% } %>
	                </ul>
            </div>
        </div>
    </div>
</div>
<!-- / left navbar -->

<!-- / FOR MOBILE DEVICES -->


<nav class="navbar navbar-default navbar-transparent navbar-fixed-top" style="background-color: black;" role="navigation">
    <div class="container" style="position: relative; z-index: 100;">
        <div class="navbar-header">
            <button type="button" id="navbar-toggle" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="index.jsp" data-logo="../resources/images/mmslogo.jpeg"><img src="../resources/images/mmslogo.jpeg" alt="" title=""  style="height: 65px; width:75px"></a>
        </div>

        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
            
            <% if (currentPage.contains("login") || currentPage.contains("register") || currentPage.contains("aboutUs") || currentPage.contains("contactUs")) { %>
	            <li <% if (currentPage.contains("login")) { out.print("class=\"active\""); } %>><a class="dropdown" href="login">Login</a></li>
	            <li <% if (currentPage.contains("register")) { out.print("class=\"active\""); } %>><a href="register">Register</a></li>
	            <li <% if (currentPage.contains("aboutUs")) { out.print("class=\"active\""); } %>><a class="dropdown" href="aboutUs">About</a></li>
                <li><a class="btn btn-border <% if (currentPage.contains("contactUs")) { out.print("class=\" active\""); } %>" style="border-color: #FF9A00; background: #FF9A00; font-size: 14px; font-weight: normal;" href="contactUs">Contact us!</a></li>
            <% } else { %>
	            <li <% if (currentPage.contains("home")) { out.print("class=\"active\""); } %>><a class="dropdown" href="home">Home</a></li>
	            
                <li class="<% if (currentPage.contains("marinaStatus") || currentPage.contains("reservations") || currentPage.contains("procurementHistory")  || currentPage.contains("consumptions")) { out.print("active "); } %>dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Browse</a>
                    <ul class="dropdown-menu" role="menu">
                        <li <% if (currentPage.contains("marinaStatus")) { out.print("class=\"active\""); } %>><a href="marinaStatus">Marina Status<span>Browse the marina status</span></a></li>
                        <li <% if (currentPage.contains("reservations")) { out.print("class=\"active\""); } %>><a href="reservations">Reservations<span>All individual reservations</span></a></li>
                        <li <% if (currentPage.contains("procurementHistory") || currentPage.contains("consumptions")) { out.print("class=\"active\""); } %>><a href="procurementHistory">Procurement History<span>All invoices & consumptions</span></a></li>
                    </ul>
                </li>
	            
                <li><a class="btn btn-border <% if (currentPage.equalsIgnoreCase("logout")) { out.print("class=\" active\""); } %>" style="border-color: #DF2D1C; background: #DF2D1C; font-size: 14px; font-weight: normal;" href="#" onclick="return askForLogout();">Logout</a></li>
                <br/>
                <div align="right">Welcome, <a href="userSettings">${kisiSessiondaBulunan.name}.</a></div>
                <br/>
            <% } %>
            </ul>
        </div>
    </div>
</nav>
<!-- / navbar -->