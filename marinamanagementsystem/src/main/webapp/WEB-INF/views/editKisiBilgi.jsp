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
			$('.datepick').datepicker();
			
			<c:if test="${dosyaTurHataFoto != null && dosyaTurHataFoto == true}">
 				alert("<fmt:message key='label.uyari.dosya.foto.degil'/>");
			</c:if>
 		});
 		
 		function duzenleSosyalMedya(id){
		   location.href='editSosyalMedya.htm?duzenle=1&id='+id;
		}

	</script>
	
	
	
	<style>
		p5    {color:red}
		
		p4    {color:green}
	</style>

  </head>

<body>

<%@include file="../includes/header.jsp"%>
<%@include file="../includes/tab.jsp"%>

    
	<div class="main">
		
		<div class="main-inner">
	
		    <div class="container">
		
		      <div class="row">
		      	
		      	<div class="span12">      		
		      		
		      		<div class="widget ">
		      			
		      			<div class="widget-header">
		      				<i class="icon-cog"></i>
		      				<h3><fmt:message key="label.editkisibilgi.form.title"/></h3>
		  				</div> 
						
						
						<div class="widget-content">
							<div class="tabbable">
								<ul class="nav nav-tabs">
								  <li class="${giris}"><a  href="#kisiBilgiForm" data-toggle="tab"><fmt:message key="label.denetci.title.aday.bilgileri"/></a></li>
								  <li class="${kaydet}"><a  href="#ekleSosyalMedyaTab" data-toggle="tab"><fmt:message key="label.eklesosyalmedya.form.hesapadi"/></a></li>
								  
	
								</ul>
								
								
								
								
								<div class="tab-content">
									<div class="tab-pane ${giris}" id="kisiBilgiForm">
										<%@include file="../includes/kisiBilgiForm.jsp"%>	
									</div>
									<div class="tab-pane ${kaydet}" id="ekleSosyalMedyaTab">
							            <%@include file="../includes/ekleSosyalMedya.jsp"%>											
									</div>									
								</div>
								
				
					   </div>
						
						
					
						
						
						 <!-- widget-content -->
					</div><!-- widget-->
				</div><!-- span12 -->
				</div> <!-- row -->
			 </div> <!-- container -->
	  	 	</div> <!-- main-inner -->
		</div> <!-- main -->
	

<%@include file="../includes/footer.jsp"%>    
    


  </body>

</html>
