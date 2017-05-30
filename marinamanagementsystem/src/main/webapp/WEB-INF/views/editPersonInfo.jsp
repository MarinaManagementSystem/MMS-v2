<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page session="true" %>
<%@page contentType="text/html; charset=UTF-8"%>
<%@include file="../includes/springTagLibraries.jsp"%>

<html>

<head>

    <title>Register - <fmt:message key="label.application.title"/></title>
    
	<%@include file="../includes/commonMeta.jsp"%>
	<%@include file="../includes/commonStyles.jsp"%>
	<%@include file="../includes/commonScripts.jsp"%>
	
	
	<script>
      
 		$(document).ready(function(){

			<sec:authentication var="principal" property="principal" scope="request"/>
			
			<c:choose>
				<c:when test="${!empty savedPerson && savedPerson != null && savedPerson == 1}">
					$('.savedPersonInfoDiv').show();
				</c:when>
				<c:otherwise>
					$('.savedPersonInfoDiv').hide();
				</c:otherwise>
			</c:choose>
			
			
 		});
 		

 		function ePostaKontrolKisi(eposta){
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
							$('.emailDiv').hide();
						}else{
							$('.emailDiv').show();
							$('#email').val('');
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

<%@include file="../includes/openingDivTagsForMobileViews.jsp"%>

<body class="withAnimation">

<%-- 	<sec:authentication var="principal" property="principal"/>${principal.kisi.ad} ${principal.kisi.soyad} --%>

	<%@include file="../includes/header.jsp"%>
	<div class="alert alert-success alert-dismissable savedPersonInfoDiv">
<!-- 		<button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button> -->
		<strong>You successfully save your changes</strong>
	</div>
	<div class="grey content-area" id="iconbuttons" style="background-color: #FBFBFB;">
	    <div class="container">
			<div class="section-top">
			    <h3 class="uppercase hr-mid text-center">Create/Update an Account @ Marina Management System (MMS)</h3>
			
			    <div class="row">
			    
			        <div class="col-sm-12">
						<%@include file="../includes/personInfoForm.jsp"%>	
			        </div>
			        
			    </div>
			</div>
		</div>
	</div>
	<%@include file="../includes/footer.jsp"%>
	
</body>

<%@include file="../includes/closingDivTagsForMobileViews.jsp"%>

</html>