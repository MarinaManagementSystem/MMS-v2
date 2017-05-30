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
 		
 		function openRegister(){
 			location.href="register";
 		}
 		
 		function openForgottenPassword(){
 			location.href="resetPassword";
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
										<font color=white style="text-shadow: 0 0 10px #ffffff;">
											Don't you have an account yet? Click <a href="javascript:;"" onclick="openRegister()">>here</a> to register.
										</font>
										</br>
										<font color=white style="text-shadow: 0 0 10px #ffffff;">
											Don't you remember your password? Click <a href="javascript:;"" onclick="openForgottenPassword()">here</a> to reset your password.
										</font>
									</div>
									<input type="submit" name="submit" value="GO" />
								</form>
							</div>
					<br/>
				</div>
			</div>
		</div>
	</div>

	<%@include file="../includes/footer.jsp"%>
	
</body>

<%@include file="../includes/closingDivTagsForMobileViews.jsp"%>

</html>