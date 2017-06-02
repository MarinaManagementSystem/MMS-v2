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

 			<c:set var="kisi" scope="request" value="${kisiSessiondaBulunan.id}"/> 
 			
 			<c:choose>
 				<c:when test="${kisiNotFoundError != null && kisiNotFoundError == true}">
 					$('.kisiNotFoundErrorDiv').show();
 				</c:when>
 				<c:otherwise>
					$('.kisiNotFoundErrorDiv').hide();
 				</c:otherwise>
 			</c:choose>
 			
 			<c:choose>
 				<c:when test="${passwordSentMessage != null && passwordSentMessage == true}">
 					$('.passwordSentMessageDiv').show();
 				</c:when>
 				<c:otherwise>
					$('.passwordSentMessageDiv').hide();
 				</c:otherwise>
 			</c:choose>
 			
 			
 		});
 		
 		function setFocus() {
 			var input = document.getElementById("email");
 			input.focus();
 		}
 		
 		function openRegister(){
 			location.href="register.htm";
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
					
					<div class="alert alert-success alert-dismissable passwordSentMessageDiv" style="margin-top: 55px;">
						<strong>Your new password is sent to your e-mail address. Please check your inbox.</strong>
					</div>
					<div class=" alert alert-danger alert-dismissable kisiNotFoundErrorDiv" style="margin-top: 55px;">
						<strong>Your e-mail address could not be found. Please make sure that your e-mail address is typed correctly.</strong>
					</div>
			
							<link rel="stylesheet" type="text/css" href="../resources/assets/css/style_for_login.css" media="all" />
							<br/>
							<!-- <c:if test="${!empty kisi}"></c:if> -->
							
							<div id="loginContainer">
								<form action="resetPassword" id="resetPasswordForm" name="resetPasswordForm" method="post">
									<div class="login">
										<span style="color: white; text-shadow: 0 0 10px #ffffff;">RESET PASSWORD</span>
									</div>
									<div class="username-text">
										<span style="color: white; text-shadow: 0 0 10px #ffffff;">E-mail:</span>
										<span class="username-field" style="margin-left: -1px;">
											<input type="text" id="email" name="email" required="true" />
										</span>
									</div>
					
									<div class="forgot-usr-pwd">
										<font color=white style="text-shadow: 0 0 10px #ffffff;">
											Don't you have an account yet? Click <a href="javascript:void(0)" onclick="openRegister()">here</a> to register.
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