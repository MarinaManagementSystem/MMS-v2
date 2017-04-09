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

			<sec:authentication var="principal" property="principal" scope="request"/>
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
							$('.epostaKullaniciAdiKontrolKurulusDiv').hide();
							$('.epostaKontrolKurulusDiv').hide();
						}else{
							$('.epostaKullaniciAdiKontrolKurulusDiv').show();
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

<body class="withAnimation">

	<%@include file="../includes/header.jsp"%>
	
	<div id="boxedWrapper" class="snap-content">
	
	

<!-- <div class="container content-area"> -->
<div class="grey content-area" id="iconbuttons" style="background-color: #FBFBFB;">

    <div class="container">
    
    
<div class="section-top">
    <h3 class="uppercase hr-mid text-center">REGISTER TO MARINA MANAGEMENT SYSTEM</h3>
<!--     <p>Use Bootstrap's predefined grid classes to align labels and groups of form controls in a horizontal layout by adding <code>.form-horizontal</code> to the form. Doing so changes <code>.form-group</code>s to behave as grid rows, so no need for <code>.row</code>00.</p> -->

    <div class="row">
    
      <jsp:useBean id="conversionToMD5" class="com.marinamanagementsystem.conf.MD5" scope="session" />
	  <jsp:setProperty name="conversionToMD5" property="*" />
    
        <div class="col-sm-12">
        

            
            <form:form commandName="personRegister" role="form" class="form-horizontal" method="post" id="personInfoForm" enctype="multipart/form-data" name="personInfoForm" action="register.htm" onsubmit="return checkforNewInfo(this);">
							<form:hidden path="id" />
							<form:errors path="*" cssStyle="color : red;"></form:errors>
							<fieldset>
            
				                <div class="form-group">
				                    <label class="col-sm-2 control-label" for="Name">Name</label>
				                    <div class="col-sm-10">
				                        <form:input type="text" class="form-control" placeholder="Please Enter Your Name" path="name" id="name" required="required"/>
				                    </div>
				                </div>
				                
				                <div class="form-group">
				                    <label class="col-sm-2 control-label" for="Surname">Surname</label>
				                    <div class="col-sm-10">
				                        <form:input type="text" class="form-control" placeholder="Please Enter Your Surname" path="surname" id="surname" required="required"/>
				                    </div>
				                </div>
				                
				                <div class="form-group">
				                    <label class="col-sm-2 control-label" for="phoneNumber">Phone Number</label>
				                    <div class="col-sm-10">
				                        <form:input type="text" class="form-control" placeholder="Please Enter Your Phone Number" path="phoneNumber" id="phoneNumber" required="required"/>
				                    </div>
				                </div>
				                
				                <div class="form-group">
				                    <label class="col-sm-2 control-label" for="email">E-Mail</label>
				                    <div class="col-sm-10">
				                        <form:input class="form-control" placeholder="Please Enter Valid E-Mail Adress" path="email" id="email" maxlength="150" onchange="this.value=ePostaKontrolKisi(this.value); kullaniciAdiniKontrolEt(this.value);" required="required" />
				                    </div>
				                </div>
				                
				                <div class="form-group">
				                    <div class="col-sm-offset-2 col-sm-10">
				                        <button class="btn btn-border" type="submit">Sign Up</button>
				                    </div>
				                </div>
				                
				          </fieldset>
            </form:form>
        </div>
    </div>
</div>
	</div>
	</div>
		

	<%@include file="../includes/footer.jsp"%>

</body>

</html>