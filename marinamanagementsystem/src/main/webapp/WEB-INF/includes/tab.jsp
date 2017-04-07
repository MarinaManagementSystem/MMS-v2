<%@ page session="true" %>
<%@page contentType="text/html; charset=UTF-8"%>

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


<nav class="navbar navbar-default navbar-transparent navbar-fixed-top" style="background-color: black;" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" id="navbar-toggle" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="index.jsp" data-logo="../resources/images/ETS-Logo.png"><img src="../resources/images/ETS-Logo.png" alt="" title=""></a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
	            <li class="active"><a class="dropdown" href="login.jsp">Login</a></li>
	            <li><a href="login.jsp?username=demo&password=demo">Demo Login</a></li>
	            <li><a class="dropdown" href="aboutUs.jsp">About</a></li>
                <li><a class="btn btn-border" style="border-color: #FF9A00; background: #FF9A00; font-size: 14px; font-weight: normal;" href="contactUs.jsp">Contact us!</a></li>
            </ul>
        </div>
    </div>
</nav>
<!-- / navbar -->