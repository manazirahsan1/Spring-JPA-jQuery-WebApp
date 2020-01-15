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
<title>Multi Level Authentication: Sign In</title>
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
		
			<div class="row">
				<label class="col-sm-4"></label>
				<div class="col-sm-8">
					<h2 align="center" style="display:inline">Sign in</h2>
					<a href="/registration/resetpassword">Forget password?</a><br/><br/>
				</div>
			</div>
			
			<spring:url value="/signin" var="userActionUrl" />	
			<form class="form-horizontal" method="post" action="${userActionUrl}">
				<div class="form-group row">
					<label class="col-sm-4 control-label text-right">Email</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="email" name="email" placeholder="Email" autofocus />
						<span id="err_email" class="text-danger"></span>
					</div>
				</div>
			
				<div class="form-group row">
					<label class="col-sm-4 control-label text-right">Password</label>
					<div class="col-sm-4">
						<input type="password" class="form-control" id="password" name="password" placeholder="Password" />
						<span id="err_password" class="text-danger"></span>
					</div>
				</div>
				
				<div class="form-group row">
					<label class="col-sm-4 control-label"></label>
					<div class="col-sm-4">
						<button id="submit_button" type="submit" class="btn btn-primary">Sign in</button>
						<a class="btn btn-secondary" href="/">Back</a>
					</div>	
				</div>
			
			</form>
		</div>
	</div>
	<div class="col-sm-2"></div>
</div>
</div>
<script>
$(document).ready(function(){
	$("#alertSuccess").hide();
	$("#err_email").hide();
	$("#err_password").hide();

	$("#submit_button").click(function() {
		var email=$("#email").val();
		var password=$("#password").val();
		
		var emailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
		var letters = /^[A-Za-z]+$/;

		var isAlright=true;

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

		return isAlright;	
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
			$("#err_password").html("Your password was larger than 6 character length");
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
		if(!(password==confirmPassword)){
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