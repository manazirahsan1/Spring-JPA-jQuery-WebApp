<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader ("Expires", -1);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<link type="text/css" href="/webjars/bootstrap/4.1.2/css/bootstrap.min.css" rel="stylesheet"/>
	<script src="/webjars/bootstrap/4.1.2/js/bootstrap.min.js"></script>
	<script src="/webjars/jquery/3.2.1/jquery.min.js"></script>
<title>Multi Level Authentication: New Profile</title>
</head>
<body>
<div class="container">
<div class="row">
	<div class="col-sm-2"></div>
	
	<div class="col-sm-8">
		<c:if test="${not empty message}">
			<div class="${css}">
				<a class="close" onclick="$('.alert').slideUp()">×</a>
				<p>${message} </p>
			</div>
		</c:if>
		<div class="jumbotron">
			<c:if test="${not empty LOGGED_IN_USER_ID}">
				<div style="text-align:right">
					<p style="display:inline">${LOGGED_IN_USER_NAME}</p>
					<spring:url value="/signout" var="userActionUrl" />
					<form method="POST" action="${userActionUrl}" style="display:inline" class="inline-form" >
						<input type="submit" class="btn btn-link" value="Logout" />
					</form>
				</div>
				
				<spring:url value="/profiles/create" var="userActionUrl" />
				<form:form class="form-horizontal" method="POST" 
	                modelAttribute="profile" action="${userActionUrl}">
	                
	                <h3 style="text-align:center">New Profile Form</h3><br/>
	                
	                <spring:bind path="name">
						<div class="form-group row">
							<label class="col-sm-2 control-label text-right">Name</label>
							<div class="col-sm-8">
								<form:input path="name" type="text" class="form-control" id="name" placeholder="Name" autofocus="autofocus" />
								<form:errors path="name" class="control-label">Profile name cannot be empty</form:errors>
								<span id="err_name" class="text-danger"></span>
							</div>
						</div>
					</spring:bind>
	                
	                <spring:bind path="password">
						<div class="form-group row">
							<label class="col-sm-2 control-label text-right">Password</label>
							<div class="col-sm-8">
								<form:password path="password" class="form-control" id="password" placeholder="Password" />
								<form:errors path="password" class="control-label" />
								<span id="err_password" class="text-danger"></span>
							</div>
						</div>
					</spring:bind>
	                
	                <spring:bind path="confirmPassword">
						<div class="form-group row">
							<label class="col-sm-2 control-label text-right">Confirm password</label>
							<div class="col-sm-8">
								<form:password path="confirmPassword" class="form-control" id="confirmPassword" placeholder="Confirm password" />
								<form:errors path="confirmPassword" class="control-label" />
								<span id="err_confirmPassword" class="text-danger"></span>
							</div>
						</div>
					</spring:bind>
	                
	                <spring:bind path="apps">
						<div class="form-group row">
							<label class="col-sm-2 control-label text-right">App list</label>
							<div class="col-sm-8">
								<form:select multiple="true" path="apps" size="15" id="apps" >
								    <form:options items="${apps}" itemValue="id" itemLabel="name" />
								</form:select>
								<form:errors path="apps" class="control-label" />
								<div id="err_apps" class="text-danger"></div>
							</div>
						</div>
					</spring:bind>
	
					<div class="form-group row">
						<label class="col-sm-2 control-label text-right"></label>
						<div class="col-sm-8">
							<input type="submit" class="btn btn-primary" id="submit_button" value="Submit" />
							<a href="/profiles" class="btn btn-secondary">Back</a>
						</div>
					</div>
	 				
	            </form:form>
            </c:if>
		</div>
	</div>
	<div class="col-sm-2"></div>
</div>
</div>
<script>
$(document).ready(function(){
	$("#err_name").hide();
	$("#err_password").hide();
	$("#err_confirmPassword").hide();
	$("#err_apps").hide();
	
	$("#submit_button").click(function() {
		$("#err_name").hide();
		$("#err_password").hide();
		$("#err_confirmPassword").hide();
		$("#err_apps").hide();

		var name=$("#name").val();
		var password=$("#password").val();
		var confirmPassword=$("#confirmPassword").val();
		var apps=$("#apps").val();
		
		var isAlright=true;

		if(name=="" || name==null){
			$("#err_name").html("Profile name cannot be empty");
			$("#err_name").show();
			isAlright=false;
		}

		if(password=="" || password==null){
			$("#err_password").html("Password cannot be empty");
			$("#err_password").show();
			isAlright=false;
		}

		if(password!=confirmPassword){
			$("#err_confirmPassword").html("Password did not match");
			$("#err_confirmPassword").show();
			isAlright=false;
		}

		if($("select#apps").val().length < 1) {
			$("#err_apps").html("Please select at least one app");
			$("#err_apps").show();
			isAlright=false;
		}
		
		return isAlright;	
	});

	$("#name").change(function(){
		var name=$("#name").val();
		if(name.length < 1){
			$("#err_name").html("Profile name cannot be empty");
			$("#err_name").show();
			return false;
		}else{
			$("#err_name").hide();
			return true;
		}
	});

	$("#password").change(function(){
		var password=$("#password").val();
		if(password=="" || password==null){
			$("#err_password").html("Password cannot be empty");
			$("#err_password").show();
			return false;
		}else{
			$("#err_password").hide();
			return true;
		}
	});

});
</script>
</body>
</html>