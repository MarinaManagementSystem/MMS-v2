<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../includes/springTagLibraries.jsp"%>

<html>

<head>

    <title>Login - <fmt:message key="label.application.title"/></title>
    
	<%@include file="../includes/commonMeta.jsp"%>
	<%@include file="../includes/commonStyles.jsp"%>
	<%@include file="../includes/commonScripts.jsp"%>
	
	
	<script type="text/JavaScript">
      
 		$(document).ready(function(){

 			<c:if test="${1==1}">
 				//alert("Hosgeldin!");
 			</c:if>
 			<c:set var="kisi" scope="request" value="${kisiSessiondaBulunan.id}"/> 
 			
 		});
 		
 		function setFocus() {
 			var input = document.getElementById("username");
 			input.focus();
 		}

	</script>

</head>

<%@include file="../includes/openingDivTagsForMobileViews.jsp"%>

<body class="withAnimation" onload="setFocus()">

	<%@include file="../includes/header.jsp"%>
	
	<div id="boxedWrapper" class="snap-content">
	
		<div class="grey content-area" id="iconbuttons" style="background-color: #FBFBFB;">
	
			<div class="container">
				<div class="row">
				

					<%
					
					String warningType = "danger";
					String warningMessage = "";
					
					
					CharSequence referenceURL="logout";
					if(request.getHeader("Referer") == null)
					{
						warningMessage = "";
					}
					else
					{
						if(request.getHeader("Referer").contains(referenceURL))
						{
							warningType = "success";
							warningMessage = "You are successfully logged out!";
						}
					}
					
					// If the viewing device is not mobile, then browse the login form  for computers
					if(session.getAttribute("isMobile").toString().equalsIgnoreCase("false"))
					{
				  		%>
							<%-- ${kisiSessiondaBulunan.name} --%>
							<jsp:useBean id="conversionToMD5" class="com.marinamanagementsystem.conf.MD5" scope="session" />
							<jsp:setProperty name="conversionToMD5" property="*" />
			
							<link rel="stylesheet" type="text/css" href="../resources/assets/css/style_for_login.css" media="all" />
							<br/>
							<!-- <c:if test="${!empty kisi}"></c:if> -->
							
							<div id="loginContainer">
								<form action="../j_spring_security_check" id="loginForm" name="loginForm" method="post">
									<div class="login">
										<font style="text-shadow: 0 0 10px #ffffff;">LOGIN</font>
									</div>
									<div class="username-text">
										<font style="text-shadow: 0 0 10px #ffffff;">Username:</font>
									</div>
									<div class="password-text">
										<font style="text-shadow: 0 0 10px #ffffff;">Password:</font>
									</div>
									<div class="username-field">
										<input type="text" id="username" name="j_username" required="true" />
									</div>
									<div class="password-field">
										<input type="password" id="password" name="j_password" required="true" />
									</div>
					
									<div class="forgot-usr-pwd">
									
									    <%
									    if(warningMessage != null && !warningMessage.isEmpty())
									    {
									    	%>
												<font color=red style="text-shadow: 0 0 10px #c61a1a;">
													<% out.print(warningMessage); %>
												</font>
									    	<%
									    } else {
									    	%>
												<font color=white style="text-shadow: 0 0 10px #ffffff;">
												Don't you have an account yet? Click <a href="register">here</a> to register.
												</font>
											<%
										}
										%>
									</div>
									<input type="submit" name="submit" value="GO" />
								</form>
							</div>
				  		<%
					}
					// If the viewing device is mobile, then view a simple login form
			  		else
			  		{
			  			%>
						<div class="section-top" style="padding-left: 20px; padding-right: 20px;">
						    <h2 class="uppercase hr-mid text-center">Login</h2>
						    <p>Please enter your username and password to login to the MMS.</p>
						    
						    <%
						    if(warningMessage != null && !warningMessage.isEmpty())
						    {
						    	%>
								    <div class=" alert alert-<% out.print(warningType); %> alert-dismissable">
					            		<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
					            	<% out.print("<p style='font-size: 15px;'>"+warningMessage+"</p>"); %>
					       			</div>
						    	<%
						    }
						    else {
						    	%>
								    <div class=" alert alert-info alert-dismissable">
					            		<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
					            			<p style="font-size: 12px;">Don't you have an account yet? Click <a href="register">here</a> to register.</p>
					       			</div>
						    	<%
						    }
						    %>
						    
						    <div class="row">
						        <div class="col-sm-12">
						            <form action="../j_spring_security_check" class="form-horizontal" id="loginForm" name="loginForm" method="post">
						                <div class="form-group">
						                    <label class="col-sm-2 control-label" for="inputEmail3">Username:</label>
						                    <div class="col-sm-10">
						                        <input type="text" placeholder="Your username" id="username" name="j_username" class="form-control" required="">
						                    </div>
						                </div>
						                <div class="form-group">
						                    <label class="col-sm-2 control-label" for="inputPassword3">Password:</label>
						                    <div class="col-sm-10">
						                        <input type="password" placeholder="Your password" id="password" name="j_password" class="form-control" required="">
						                    </div>
						                </div>
						                <div class="form-group">
						                    <div class="col-sm-offset-2 col-sm-10">
						                        <button class="btn btn-default" type="submit">Login</button>
						                    </div>
						                </div>
						            </form>
						        </div>
						    </div>
						</div>
			  			<%
			  		}
			  		%>
					<br/>
				</div>
			</div>
		</div>
	</div>

	<%@include file="../includes/footer.jsp"%>
	
</body>

<%@include file="../includes/closingDivTagsForMobileViews.jsp"%>

</html>