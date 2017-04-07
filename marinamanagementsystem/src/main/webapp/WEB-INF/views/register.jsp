<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page session="true" %>
<%@page contentType="text/html; charset=UTF-8"%>
<%@include file="../includes/include.jsp"%>

<html>

<head>

    <title><fmt:message key="label.application.title"/></title>
    
	<%@include file="../includes/ortakMeta.jsp"%>
	<%@include file="../includes/ortakStyle.jsp"%>
	<%@include file="../includes/ortakScript.jsp"%>
	
	
	<script>
      
 		$(document).ready(function(){

			<sec:authentication var="principal" property="principal" scope="request"/>
 		});
 		

 		function ePostaKontrolKurulus(eposta){
 			var epostatest=(/^[a-z]{1}[\d\w\.-]+@[\d\w-]{3,}\.[\w]{2,3}(\.\w{2})?$/);
 		
 			if(!epostatest.test(eposta)){
 				$('.epostaKontrolKurulusDiv').show();
 		    	return null;
 		    }else {
 				$('.epostaKontrolKurulusDiv').hide();
 		    	return eposta;
 		    }
 		}
 		
		function kullaniciAdiniKontrolEt(){
			var kullaniciAdi = $('#email').val();
			if(kullaniciAdi != ''){
				$.ajax({
					url:'ajaxKullaniciAdiUygunMu',
					data: {kullaniciAdi: kullaniciAdi},
					async:false,
					success:function(data){
						if(data){
							$('.epostaKullaniciAdiKontrolKurulusDiv').hide();
							$('.epostaKontrolKurulusDiv').hide();
						}else{
							$('.epostaKullaniciAdiKontrolKurulusDiv').show();
							$('#eposta').val('');
						}
					}
				});
			}
		}
 		
		function checkforNewInfo(form){
			
			var harftest=/^[A-Za-z]+$/;
			var epostatest=(/^[a-z]{1}[\d\w\.-]+@[\d\w-]{3,}\.[\w]{2,3}(\.\w{2})?$/);
			var gsmtest = /^\(?([0]{1})([^1]{1})([0-9]{2})\)?[-. ]?([^1]{1})([0-9]{2})[-. ]?([0-9]{2})[-. ]?([0-9]{2})$/;
			
			return true;
			
		}

	</script>

</head>

<body class="withAnimation">

	<%@include file="../includes/tab.jsp"%>
	
	<div id="boxedWrapper" class="snap-content">
	
		<div class="grey content-area" id="iconbuttons" style="background-color: #FBFBFB;">
	
			<div class="container">
				<div class="row">
			    
					<jsp:useBean id="conversionToMD5" class="com.marinamanagementsystem.conf.MD5" scope="session" />
					<jsp:setProperty name="conversionToMD5" property="*" />
	
					<link rel="stylesheet" type="text/css" href="../resources/assets/css/style_for_login.css" media="all" />
					<br/>
					
					<div id="loginContainer">
						
						
						
						<form:form commandName="personRegister" class="form-horizontal" method="post" id="personInfoForm" enctype="multipart/form-data" name="personInfoForm" action="register.htm" onsubmit="return checkforNewInfo(this);">
							<form:hidden path="id" />
							<form:errors path="*" cssStyle="color : red;"></form:errors>
							<fieldset>
								<div class="control-group" style="width:100px;">
									<label class="control-label" for="name">
										Name
									</label>
									<div class="controls">
										<form:input type="text" class="span3" path="name" id="name" required="required"/>
									</div>
								</div>
								
								<div class="control-group" style="width:100px;">
									<label class="control-label" for="surname">
										Surname
									</label>
									<div class="controls">
										<form:input type="text" class="span3" path="surname" id="surname" required="required"/>
									</div>
								</div>
								
								<div class="control-group" style="width:100px;">
									<label class="control-label" for="phoneNumber">
										Phone Number
									</label>
									<div class="controls">
										<form:input type="text" class="span3" path="phoneNumber" id="phoneNumber" required="required"/>
									</div>
								</div>
								
								<div class="control-group" style="width:100px;">
									<label class="control-label" for="email">
										E-mail
									</label>
									<div class="controls">
										<form:input class="span3" path="email" id="email" maxlength="150" onchange="this.value=ePostaKontrolKurulus(this.value); kullaniciAdiniKontrolEt(this.value);" required="required" />
									</div>
								</div>
								
						<%-- 		<sec:authorize access="hasAnyRole('ROL_KURULUS_YETKILISI')"> --%>
						<!-- 			<div class="control-group"> -->
						<!-- 				<label class="control-label" for="role"> -->
						<!-- 					Role -->
						<!-- 				</label> -->
						<!-- 				<div class="controls"> -->
						<%-- 					<form:select path="sektor" id="sektor" required="required" class="disable"> --%>
						<%-- 						<form:options items="${listRole}" itemLabel="displayName" itemValue="id"/> --%>
						<%-- 					</form:select> --%>
						<!-- 				</div> -->
						<!-- 			</div> -->
						<%-- 		</sec:authorize> --%>
								
								<c:if test="${empty principal.kisi}">
									LOLO
								</c:if>
								
								<div class="form-actions">
									<button type="submit" class="btn btn-success">
										<fmt:message key="buton.kaydet" />
									</button>
								</div>
							</fieldset>
						</form:form>
					</div>
					<br>
			
				</div>
			</div>
			
		</div>
		
	</div>

	<%@include file="../includes/footerDiger.jsp"%>

</body>

</html>