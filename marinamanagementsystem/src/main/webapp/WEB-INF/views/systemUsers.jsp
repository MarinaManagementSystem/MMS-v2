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
	
	function askIfSureToDeleteUser(userID, fullNameOfUser, userRole)
	{
		if(userRole == 3)
		{
			alert("Sorry, you are only allowed to browse.");
			return false;
		}
		else if (confirm("Are you sure you want to delete "+fullNameOfUser+"?") == true) {
	    	window.location.href = "systemUsers.jsp?deleteUser="+userID+"&name="+fullNameOfUser;
	    	return true;
	    } else {
	        return false;
	    }
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
	
</script>

</head>

<%@include file="../includes/openingDivTagsForMobileViews.jsp"%>

<body class="withAnimation">

	<%@include file="../includes/header.jsp"%>

	<!--  section icon box -->
	<div class="grey content-area" id="iconbuttons" style="background-color: white;">
	    <div class="container">
	    
		    <%
			// If the viewing device is not mobile, then put some line breaks
			if(session.getAttribute("isMobile").toString().equalsIgnoreCase("false"))
			{
		  		%>
		    		<br/><br/><br/>
		    	<%
			}
		    %>
	        
	        <h2>System Users</h2>
			<p style="font-size: 15px;">All users under your supervision are listed below.</p>
			<br/>
			
			<div id="addAndRemoveButtons" align="right">
				<a class="btn btn btn-success" href="newSystemUser.jsp">Add a new user</a>
				<input class="btn btn btn-danger" name="deleteUsersButton" id="deleteUsersButton" value="Delete selected users" type="submit" tabindex="10" disabled="disable" >
			</div>
			<br/>
			
	        <table class="table table-hover" style="overflow:scroll;height:80px;width:100%;overflow:auto">
	            <thead>
	            <tr style="background-color:#4A4744; table-layout:fixed">
	                <th><span style="color:white;">Options</span></th>
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
	            	            	<td style="border: 2px solid #DDDDDD;">
					                    <input type="checkbox" name="selectedUsers" value="${person.id}" onChange="enableOrDisableDeleteUsersButton();" tabindex="1">
			                   			&nbsp;&nbsp;&nbsp;
	            	                	<a href="editSystemUser.jsp?userID=${person.id}%>">
	            	                		<img src="../resources/images/edit.png" alt="Edit" height="16" width="16">
	            	                	</a>&nbsp;&nbsp;&nbsp;
	            	                	<c:choose>
		            	                	<c:when test="${person.id == kisiSessiondaBulunan.id}">
		        	                			<a href="#" onclick="return askIfSureToDeleteUser(${person.id}, '${person.name} ${person.surname}', ${person.roller});" >
		        	                				<img src="../resources/images/deleteDisabled.png" alt="Delete" height="16" width="16">
		        	                			</a>
		            	                	</c:when>
		            	                	<c:otherwise>
												<img src="../resources/images/delete.png" alt="Delete" height="16" width="16">
		            	                	</c:otherwise>
	            	                	</c:choose>
	            					</td>
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
	            	                	${person.roller}
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