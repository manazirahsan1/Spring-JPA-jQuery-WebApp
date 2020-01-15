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
<title>Multi Level Authentication: Enter Email</title>
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
			<h2 align="center">Enter Email</h2>
			<spring:url value="/registration/resetpassword" var="userActionUrl" />	
			<form class="form-horizontal" method="POST" action="${userActionUrl}">
				<div class="form-group row">
					<label class="col-sm-4 control-label text-right">Email</label>
					<div class="col-sm-6">
						<input type="text" class="form-control" id="email" name="email" placeholder="Email" autofocus />
						<span id="err_email" class="text-danger"></span>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-4 control-label"></label>
					<div class="col-sm-4">
						<button id="submit_button" type="submit" class="btn btn-primary">Send link</button>
						<a class="btn btn-secondary" href="/signin">Back</a>
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
	$("#err_email").hide();

	$("#submit_button").click(function() {
		var email=$("#email").val();
		
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
	
});
</script>
</body>
</html>