<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page session="true" %>
<%@page contentType="text/html; charset=UTF-8"%>
<%@include file="../includes/springTagLibraries.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


			            <form:form commandName="editPersonInformation" class="form-horizontal" method="post" id="editPersonInfo" name="editPersonInfo" onsubmit="return checkforNewInfo(this);">
										<form:hidden path="id" />
										<form:errors path="*" cssStyle="color : red;"></form:errors>
										<input type="hidden" name="newPerson" value="${newPerson}"/>
										<fieldset>
			            
							                <div class="form-group">
							                    <label class="col-sm-2 control-label" for="Name">Name</label>
							                    <div class="col-sm-10">
							                        <form:input type="text" class="form-control" placeholder="Please enter your first name" path="name" id="name" required="required"/>
							                    </div>
							                </div>
							                
							                <div class="form-group">
							                    <label class="col-sm-2 control-label" for="Surname">Surname</label>
							                    <div class="col-sm-10">
							                        <form:input type="text" class="form-control" placeholder="Please enter your surname" path="surname" id="surname" required="required"/>
							                    </div>
							                </div>
							                
							                <div class="form-group">
							                    <label class="col-sm-2 control-label" for="phoneNumber">Phone Number</label>
							                    <div class="col-sm-10">
							                        <form:input type="text" class="form-control" placeholder="Please enter your cell-phone number" path="phoneNumber" id="phoneNumber" required="required"/>
							                    </div>
							                </div>
							                
							                <div class="form-group">
							                    <label class="col-sm-2 control-label" for="email">E-mail Address</label>
							                    <div class="col-sm-10">
							                        <form:input class="form-control" placeholder="Please enter a valid e-mail address" path="email" id="email" maxlength="150" onchange="this.value=ePostaKontrolKisi(this.value); kullaniciAdiniKontrolEt(this.value);" required="required" />
							                    </div>
							                    <div class=" alert alert-danger alert-dismissable emailDiv">
										            <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
										            <strong>Please enter your e-mail address again</strong>!!
										        </div>
							                </div>
							                
							                <div class="form-group">
							                    <label class="col-sm-2 control-label" for="role">Role</label>
							                    <div class="col-sm-10">
													<form:select path="roller" id="roller" required="required">
														<form:options items="${listRole}" itemLabel="displayNmae" itemValue="id"/>
													</form:select>
							                    </div>
							                </div>
							                
							                <div class="form-group">
							                    <div class="col-sm-offset-2 col-sm-10">
													<button type="submit" class="btn btn-default">Update</button>
							                    </div>
							                </div>
							                
							          </fieldset>
			            </form:form>