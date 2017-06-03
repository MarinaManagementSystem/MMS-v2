<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" import="java.io.*, java.util.*, java.util.Date" pageEncoding="UTF-8" %>
<%@include file="../includes/springTagLibraries.jsp"%>

<html>

<head>

    <title>System Users - <fmt:message key="label.application.title"/></title>
    
	<%@include file="../includes/commonMeta.jsp"%>
	<%@include file="../includes/commonStyles.jsp"%>
	<%@include file="../includes/commonScripts.jsp"%>
	
<script type="text/javascript">

	$(document).ready(function(){
		
		<c:choose>
			<c:when test="${updatedStatus != null && updatedStatus == 1}">
				$('.updatedStatusDiv').show();
			</c:when>
			<c:otherwise>
				$('.updatedStatusDiv').hide();
			</c:otherwise>
		</c:choose>
		
		
	});
	
	function askIfSureToDeleteUser(userID, fullNameOfUser)
	{
		if (confirm("Are you sure you want to delete "+fullNameOfUser+"?") == true) {
	    	window.location.href = "deletePerson.htm?id="+userID;
	    	return true;
	    } else 
	        return false;
	}
	
	function askIfSureToDeleteUsers(userRole)
	{
		if(userRole == 3)
		{
			alert("Sorry, you are only allowed to browse.");
			return false;
		}
		else if (confirm("Are you sure you want to delete the selected users?") == true) {
	    	return true;
	    } else {
	        return false;
	    }
	}
	
	function enableOrDisableDeleteUsersButton()
	{
		  var checkboxes = document.getElementsByName("selectedUsers");
		  var thereIsACheckedCheckBox = false;
		  
		  // loop over them all
		  for (var i=0; i<checkboxes.length; i++) {
		     // And stick the checked ones onto an array...
		     if (checkboxes[i].checked)
		     {
		    	 document.getElementById('deleteUsersButton').disabled = "";
		    	 thereIsACheckedCheckBox = true;
		    	 break;
		     }
		  }
		  
		  if(thereIsACheckedCheckBox == false)
		  {
			  document.getElementById('deleteUsersButton').disabled = "disable";
		  }
	}
	
	function editPerson(id){
		location.href="editPersonInfo?id="+id;
	}
	
	function addPerson(){
		location.href="editPersonInfo";
	}
	
</script>

</head>

<%@include file="../includes/openingDivTagsForMobileViews.jsp"%>

<body class="withAnimation">

	<%@include file="../includes/header.jsp"%>

	<!--  section icon box -->
	<div class="grey content-area" id="iconbuttons" style="background-color: white;">
	    <div class="container">
	    
	        
	        <h2>System Users</h2>
			<p style="font-size: 15px;">All users under your supervision are listed below.</p>
			<br/>
			<div class="alert alert-success alert-dismissable updatedStatusDiv">
				<strong>Your change was successfuly saved.</strong>
			</div>
			
			<sec:authorize access="hasAnyRole('ROLE_SYSTEM_ADMINISTRATOR')">
				<div id="addAndRemoveButtons" align="right">
					<a href="javascript:void(0)" class="btn btn btn-success" onclick="addPerson()">Add a new user</a>
					<input class="btn btn btn-danger" name="deleteUsersButton" id="deleteUsersButton" value="Delete selected users" type="submit" tabindex="10" disabled="disable" />
				</div>
			</sec:authorize>
			<br/>
			
	        <table class="table table-hover" style="overflow:scroll;height:80px;width:100%;overflow:auto">
	            <thead>
	            <tr style="background-color:#4A4744; table-layout:fixed">
                	<sec:authorize access="hasAnyRole('ROLE_SYSTEM_ADMINISTRATOR')">
	                	<th><span style="color:white;">Options</span></th>
	                </sec:authorize>
	                <th><span style="color:white;">Full Name</span></th>
	                <th><span style="color:white;">E-mail</span></th>
					<th><span style="color:white;">Phone Number</span></th>
	                <th><span style="color:white;">Associated Roles</span></th>
	            </tr>
	            </thead>
	            
	            <tbody>
					<c:choose>
						<c:when test="${!empty listPerson}">
							<c:forEach items="${listPerson}" var="person">
	            	            <tr>
                					<sec:authorize access="hasAnyRole('ROLE_SYSTEM_ADMINISTRATOR')">
		            	            	<td style="border: 2px solid #DDDDDD;">
						                    <input type="checkbox" name="selectedUsers" value="${person.id}" onChange="enableOrDisableDeleteUsersButton();" tabindex="1"/>
				                   			&nbsp;&nbsp;&nbsp;
		            	                	<a href="javascript:void(0)" onclick="editPerson('${person.id}')">
		            	                		<img src="../resources/images/edit.png" alt="Edit" height="16" width="16"/>
		            	                	</a>&nbsp;&nbsp;&nbsp;
		            	                	<c:choose>
			            	                	<c:when test="${person.id == kisiSessiondaBulunan.id}">
			        	                				<img src="../resources/images/deleteDisabled.png" alt="Delete" height="16" width="16"/>
			            	                	</c:when>
			            	                	<c:otherwise>
			        	                			<a href="javascript:void(0)" onclick="return askIfSureToDeleteUser(${person.id}, '${person.nameSurname}');" >
														<img src="../resources/images/delete.png" alt="Delete" height="16" width="16"/>
			        	                			</a>
			            	                	</c:otherwise>
		            	                	</c:choose>
		            					</td>
		            				</sec:authorize>
	            	                <td style="border: 2px solid #DDDDDD;">
	            	                	${person.name} ${person.surname}
	            					</td>
	            	                <td style="border: 2px solid #DDDDDD;">
	            	                	${person.email}
	            					</td>
	            	                <td style="border: 2px solid #DDDDDD;">
	            	                	${person.phoneNumber}
	            					</td>
	            	                <td style="border: 2px solid #DDDDDD;">
										<c:forEach items="${person.roller}" var="role" varStatus="index">
	            	                		${role.displayName}
	            	                		<c:if test="${index.last == false}">
	            	                			</br>
	            	                		</c:if>
										</c:forEach>
	            					</td>
	            				</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="3" style="border: 2px solid #DDDDDD; height:190px; vertical-align:middle">No data found!</td>
							</tr>
						</c:otherwise>
					</c:choose>
	            </tbody>
	        </table>
	        
	    </div>
	</div>
	<!-- / section -->
	<%@include file="../includes/footer.jsp"%>
	
</body>

<%@include file="../includes/closingDivTagsForMobileViews.jsp"%>

</html>