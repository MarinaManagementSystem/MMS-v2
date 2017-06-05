<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page session="true" %>
<%@page contentType="text/html; charset=UTF-8"%>
<%@include file="../includes/springTagLibraries.jsp"%>
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
                    
				<sec:authentication var="principal" property="principal" />
            	
            	<c:choose>
            		<c:when test="${empty kisiSessiondaBulunan}">
			            <li class="${loginPageActive }"><a class="dropdown" href="login">Login</a></li>
			            <li class="${registerPageActive }"><a href="register">Register</a></li>
			            <li class="${aboutUsPageActive }"><a class="dropdown" href="aboutUs">About</a></li>
		                <li class="${contactUsPageActive }"><a class="btn btn-border ${contactUsLinkPageActive }" style="border-color: #FF9A00; background: #FF9A00; font-size: 14px; font-weight: normal;" href="contactUs">Contact us!</a></li>
            		</c:when>
            		<c:when test="${!empty kisiSessiondaBulunan}">
                		<sec:authorize access="hasAnyRole('ROLE_MARINA_OWNER') or hasAnyRole('ROLE_YACHT_OWNER')">
            				<li class="${homePageActive }"><a class="dropdown" href="marinaStatus">Home</a></li>
            			</sec:authorize>
                		<sec:authorize access="hasAnyRole('ROLE_MARINA_OWNER') or hasAnyRole('ROLE_YACHT_OWNER')">
			                <li class="${marinaGeneralPageActive } dropdown">
			                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Browse</a>
			                    <ul class="dropdown-menu" role="menu">
			                        <li class="${marinaStatusPageActive }"><a href="marinaStatus">Marina Status<span>Browse the marina status</span></a></li>
			                        <li class="${reservationsPageActive }"><a href="reservations">Reservations<span>All individual reservations</span></a></li>
			                        <li class="${procurementHistoryPageActive }"><a href="procurementHistory">Procurement History<span>All invoices & consumptions</span></a></li>
			                    </ul>
			                </li>
            			</sec:authorize>
		                <sec:authorize access="hasAnyRole('ROLE_SYSTEM_ADMINISTRATOR')">
			            	<li class="${systemUsersPageActive }"><a class="dropdown" href="systemUsers">System Users</a></li>
			            </sec:authorize>
		                
						<c:set var="loopSize" scope="session" value="${fn:length(principal.listDigerRoller)}"/>
						<c:if test="${loopSize > 0}">
							<li class="${personGeneralPageActive } dropdown">
				            	<a href="#" class="dropdown-toggle" data-toggle="dropdown">Roles</a>
								<ul class="dropdown-menu" role="menu">
									<c:forEach items="${principal.listDigerRoller}" var="role"> 
										<li ><a href="listPersonRoleSelection.htm?role=${role.name}" >${role.displayName }<span>${role.displayName }</span></a></li>
									</c:forEach>
<%-- 									<c:if test="${loopSize > 0}"> --%>
<!-- 									<hr/> -->
<%-- 									</c:if> --%>
								</ul>
			                </li>
						</c:if>
			            
		                <li><a class="btn btn-border" style="border-color: #DF2D1C; background: #DF2D1C; font-size: 14px; font-weight: normal;" href="#" onclick="return askForLogout();">Logout</a></li>
		                <br/>
		                <div align="right">Welcome, <a href="editPersonInfo?id=${kisiSessiondaBulunan.id}">${kisiSessiondaBulunan.name}.</a></div>
		                <div align="right"><span style="font-style: italic">${activeRoleName}</span></div>
            		</c:when>
            	</c:choose>
	            
            </ul>
        </div>
    </div>
</nav>
<!-- / navbar -->