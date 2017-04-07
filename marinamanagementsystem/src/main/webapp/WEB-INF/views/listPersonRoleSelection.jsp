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
	
	<script type="text/javascript">
      
 		$(document).ready(function(){
			$('.date-pick').datepicker();

			<c:if test="${1 == 1}">
				alert(1);
			</c:if>
		
 		});
 		
 		function kullaniciRolSec(rol){
 			location.href = 'listKisiRollerGiris.htm?rol='+rol;	
 		}
 		
	</script>
		
  </head>

<body>
		<div class="account-container">
			
			<div class="content clearfix">
				
					<h1><fmt:message key="label.gorev.listesi"/></h1>		
					
					<div class="login-fields">
						
						<p><fmt:message key="label.kullanici.rol.belirler"/></p>
						
						<c:forEach items="${listRoller}" var="roller">
							<c:forEach items="${listTumRoller}" var="tumRoller">
								<c:if test="${tumRoller.name == roller}">
									<div class="field" style="margin-bottom: -1.75em">
										<button class="button btn btn-success btn-large" style="display:block; float:none; width: 100%;" onclick="kullaniciRolSec('${roller}')">${tumRoller.name}</button><br/>
			                    	</div> <!-- /field -->
								</c:if>
							</c:forEach>
						</c:forEach>
						
					</div> <!-- /login-fields -->
				
			</div> <!-- /content -->
			
		</div> <!-- /account-container -->
	

<%@include file="../includes/footer.jsp"%>    
    


  </body>

</html>
