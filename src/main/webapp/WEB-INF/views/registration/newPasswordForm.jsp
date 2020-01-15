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
<title>Multi Level Authentication: Reset Password</title>
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
			<h2 align="center">New Password</h2>
			<spring:url value="/registration/doResetPassword" var="userActionUrl" />
			<form class="form-horizontal" method="POST" action="${userActionUrl}">
				<input name="email" type="hidden" value="${email}" />
				<div class="form-group row">
					<label class="col-sm-4 control-label text-right">Password</label>
					<div class="col-sm-4">
						<input type="password" name="password" class="form-control" id="password" placeholder="Password" />
						<span id="err_password" class="text-danger">Password should be 6 or more character long</span>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-4 control-label text-right">Confirm password</label>
					<div class="col-sm-4">
						<input type="password" name="confirmPassword" class="form-control" id="confirmPassword" placeholder="Confirm password" />
						<span id="err_confirmPassword" class="text-danger">Password did not match</span>
					</div>
					</div>
				<div class="form-group row">
					<label class="col-sm-4 control-label"></label>
					<div class="col-sm-4">
						<input id="submit_button" type="submit" value="Submit" class="btn btn-primary" />
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
	$("#err_email").hide();  //Initially hiding the error spans
	$("#err_password").hide();
	$("#err_confirmPassword").hide();

	$("#submit_button").click(function() {
		var password=$("#password").val();
		var confirmPassword=$("#confirmPassword").val();

		var isAlright=true;

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