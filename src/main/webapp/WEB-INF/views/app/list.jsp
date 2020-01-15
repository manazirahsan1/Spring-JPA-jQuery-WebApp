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
<title>Multi Level Authentication: All Apps</title>
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
			<c:if test="${not empty apps}">
				<h3 style="text-align:center">All Apps Together</h3>
				<a href="/apps/new" class="btn btn-primary">New app</a><br/><br/>
				<table class="table table-striped table-bordered table-sm">
					<thead>
						<tr>
							<th scope="col" style="width: 12%">Image</th>
							<th scope="col" style="width: 13%">Name</th>
							<th scope="col" style="width: 45%">Description</th>
							<th scope="col" style="width: 30%">Action</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${apps}" var="app">
							<tr>
								<td scope="col"><img src="/img/${app.image}" class="img-thumbnail img-fluid" height="100" width="100" /></td>
								<td scope="col">${app.name}</td>
								<td scope="col">${app.description }</td>
								<td scope="col">
									<a class="btn btn-sm btn-info" href="/apps/${app.id}">Show</a>
									<a class="btn btn-sm btn-warning" href="/apps/edit/${app.id}">Edit</a>
									<form action="/apps/delete/${app.id}" method="POST" style="display:inline">
										<button type="submit" class="btn btn-sm btn-danger">Delete</button>
									</form>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</c:if>
		</div>
	</div>
	<div class="col-sm-2"></div>
</div>
</div>
</body>
</html>