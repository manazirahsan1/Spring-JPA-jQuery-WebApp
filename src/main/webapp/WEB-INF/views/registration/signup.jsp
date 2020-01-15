<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<link type="text/css" href="/webjars/bootstrap/4.1.2/css/bootstrap.min.css" rel="stylesheet"/>
	<script src="/webjars/bootstrap/4.1.2/js/bootstrap.min.js"></script>
	<script src="/webjars/jquery/3.2.1/jquery.min.js"></script>
<title>Multi Level Authentication: Registration</title>
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
			<h2 align="center">Registration</h2>
			<spring:url value="/registration/create" var="userActionUrl" />	
			<form:form class="form-horizontal" method="post" autocomplete="off"
								modelAttribute="user" action="${userActionUrl}">
				<spring:bind path="name">
					<div class="form-group ${status.error ? 'has-error' : ''} row">
						<label class="col-sm-4 control-label text-right">Name</label>
						<div class="col-sm-4">
							<form:input path="name" type="text" class="form-control" id="name" placeholder="Name" />
							<form:errors path="name" class="control-label" />
							<span id="err_name" class="text-danger">Name is too short</span>
						</div>
					</div>
				</spring:bind>
				<spring:bind path="email">
					<div class="form-group ${status.error ? 'has-error' : ''} row">
						<label class="col-sm-4 control-label text-right">Email</label>
						<div class="col-sm-4">
							<form:input path="email" type="text" class="form-control" id="email" placeholder="Email" />
							<form:errors path="email" class="control-label" />
							<span id="err_email" class="text-danger">Incorrect email format</span>
						</div>
					</div>
				</spring:bind>
				<spring:bind path="password">
					<div class="form-group ${status.error ? 'has-error' : ''} row">
						<label class="col-sm-4 control-label text-right">Password</label>
						<div class="col-sm-4">
							<form:password path="password" class="form-control" id="password" placeholder="Password" />
							<form:errors path="password" class="control-label" />
							<span id="err_password" class="text-danger">Password should be 6 or more character long</span>
						</div>
					</div>
				</spring:bind>
				<spring:bind path="confirmPassword">
					<div class="form-group ${status.error ? 'has-error' : ''} row">
						<label class="col-sm-4 control-label text-right">Confirm password</label>
						<div class="col-sm-4">
							<form:password path="confirmPassword" class="form-control" id="confirmPassword" placeholder="Confirm password" />
							<form:errors path="confirmPassword" class="control-label" />
							<span id="err_confirmPassword" class="text-danger">Password did not match</span>
						</div>
					</div>
				</spring:bind>
				<div class="form-group row">
					<label class="col-sm-4 control-label"></label>
					<div class="col-sm-4">
						<button id="submit_button" type="submit" class="btn btn-primary">Submit</button>
						<a class="btn btn-secondary" href="/">Back</a>
					</div>	
				</div>
			</form:form>
		</div>
	</div>
	<div class="col-sm-2"></div>
</div>
</div>
<script>
$(document).ready(function(){
	$("#alertSuccess").hide();
	$("#errid").hide();
	$("#err_name").hide();
	$("#err_email").hide();  //Initially hiding the error spans
	$("#err_password").hide();
	$("#err_confirmPassword").hide();

	$("#submit_button").click(function() {
		var name=$("#name").val();
		var email=$("#email").val();
		var password=$("#password").val();
		var confirmPassword=$("#confirmPassword").val();
		
		var emailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
		var letters = /^[A-Za-z]+$/;

		var isAlright=true;

		if(name==null || name==""){
			$("#err_name").html("Name cannot be Empty");
			$("#err_name").show();
			isAlright=false;
		}else if(name.length < 4){
			$("#err_name").html("Name is too short");
			$("#err_name").show();
			isAlright=false;
		}

		if(email=="" || email==null){
			$("#err_email").html("Email cannot be empty");
			$("#err_email").show();
			isAlright=false;
		}else if(!(email.match(emailformat))){
			$("#err_email").html("Incorrect email format");
			$("#err_email").show();
			isAlright=false;
		}

		if(password=="" || password==null){
			$("#err_password").html("Password cannot be empty");
			$("#err_password").show();
			isAlright=false;
		}else if(password=="" || password==null){
			$("#err_password").html("Password should be 6 or more character long");
			$("#err_password").show();
			isAlright=false;
		}

		if(password != confirmPassword){
			$("#err_confirmPassword").html("Password did not match");
			$("#err_confirmPassword").show();
			isAlright=false;
		}

		return isAlright;	
	});


	$("#name").change(function(){
		var name=$("#name").val();
		if(name.length < 4){
			$("#err_name").html("Name is too short");
			$("#err_name").show();
			return false;
		}else{
			$("#err_name").hide();
			return true;
		}
	});

	$("#email").change(function(){
		var email=$("#email").val();
		var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
		if(!(email.match(mailformat))){
			$("#err_email").html("Incorrect email format");
			$("#err_email").show();
			return false;
		}else{
			$("#err_email").hide();
			return true;
		}
	});
	
	$("#password").change(function(){
		var password=$("#password").val();
		if(password.length < 6){
			$("#err_password").html("Password should be 6 or more character long");
			$("#err_password").show();
			return false;
		}else{
			$("#err_password").hide();
			return true;
		}	
	});
	
	$("#confirmPassword").change(function(){
		var password=$("#password").val();
		var confirmPassword=$("#confirmPassword").val();
		if(password != confirmPassword){
			$("#err_confirmPassword").html("Password did not match");
			$("#err_confirmPassword").show();
			return false;
		}else{
			$("#err_confirmPassword").hide();
			return true;
		}		
	});
});
</script>
</body>
</html>