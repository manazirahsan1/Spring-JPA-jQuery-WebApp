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
<title>Multi Level Authentication: Introducing App</title>
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
			<c:if test="${not empty app}">				
				<div class="row">
					<div class="col-sm-4"></div>
					<div class="col-sm-8">
						<h3>Detail of ${app.name}</h3><a></a>
					</div>
				</div>			
				<div class="form-group row">
					<label class="col-sm-4 control-label text-right">Image</label>
					<div class="col-sm-4">
						<img src="/img/${app.image}" class="img-thumbnail img-fluid" height="100" width="100" />
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-4 control-label text-right">Name</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="name" name="name" value="${app.name}" readonly />
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-4 control-label text-right">Description</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="description" name="description" value="${app.description}" readonly />
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-4 control-label text-right"></label>
					<div class="col-sm-4">
						<a href="/apps/" class="btn btn-sm btn-primary">Back</a>
						<a href="/apps/edit/${app.id}" class="btn btn-sm btn-warning">Edit</a>
						<form action="/apps/delete/${app.id}" method="POST" style="display:inline">
							<button type="submit" class="btn btn-sm btn-danger">Delete</button>
						</form>
					</div>
				</div>
			</c:if>
		</div>
	</div>
	<div class="col-sm-2"></div>
</div>
</div>
</body>
</html>