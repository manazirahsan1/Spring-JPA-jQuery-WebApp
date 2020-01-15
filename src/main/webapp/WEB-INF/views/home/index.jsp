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
<title>Multi Level Authentication</title>
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
			<h2 align="center">Welcome to Multi Level Authentication</h2>
			<p>Check it out if you like it or not!!</p>
			<a class="btn btn-primary" href="/signin">Already user? Sign in</a>
			<a class="btn btn-success" href="/registration/new">New user? Sign up</a>
		</div>
	</div>
	<div class="col-sm-2"></div>
</div>
</div>
</body>
</html>