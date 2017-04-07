<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page session="true" %>
<%@page contentType="text/html; charset=UTF-8"%>
<%@include file="../includes/include.jsp"%>

<html>

<head>

    <title><fmt:message key="label.application.title"/></title>
    
	<%@include file="../includes/commonMeta.jsp"%>
	<%@include file="../includes/commonStyles.jsp"%>
	<%@include file="../includes/commonScripts.jsp"%>
	
	
	<script>
      
 		$(document).ready(function(){

 			<c:if test="${1==1}">
 				alert("hojgeldin");
 			</c:if>
 			<c:set var="kisi" scope="request" value="${kisiSessiondaBulunan.id}"/> 
 			
 		});

	</script>

</head>

<body class="withAnimation">

	<%@include file="../includes/header.jsp"%>
	
	<div id="boxedWrapper" class="snap-content">
	
		<div class="grey content-area" id="iconbuttons" style="background-color: #FBFBFB;">
	
			<div class="container">
				<div class="row">
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
								<font color=red style="text-shadow: 0 0 10px #c61a1a;">
								</font>
							</div>
							<input type="submit" name="submit" value="GO" />
						</form>
					</div>
					<br>
			
				</div>
			</div>
			
		</div>
		
	</div>

	<%@include file="../includes/footer.jsp"%>

</body>

</html>