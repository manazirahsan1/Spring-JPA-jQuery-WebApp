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
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<title>Multi Level Authentication: All Profiles</title>
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
			<c:choose>
				<c:when test="${not empty LOGGED_IN_USER_ID}">
					<div style="text-align:right">
						<p style="display:inline">${LOGGED_IN_USER_NAME}</p>
						<spring:url value="/signout" var="userActionUrl" />
						<form method="POST" action="${userActionUrl}" style="display:inline" class="inline-form" >
							<input type="submit" class="btn btn-link" value="Logout" />
						</form>
					</div>
					<h3 style="text-align:center">Profile List</h3>
					<a class="btn btn-primary" href="/profiles/new">New profile</a><br/><br/>
					<c:if test="${not empty profiles}">
						<div id="my_accordion" class="accordion">
							<c:forEach items="${profiles}" var="profile">
								<div class="card">
									<div class="card-header">
										<a class="card-link" data-toggle="collapse" href="#collapse${profile.id}">
											${profile.name}
										</a>						
										<div style="text-align:right">
											<spring:url value="/profiles/${profile.id}" var="userActionUrl" />
											<a href="${userActionUrl}" class="btn btn-sm btn-info">Show</a>
											
											<spring:url value="/profiles/edit/${profile.id}" var="userActionUrl" />
											<a href="${userActionUrl}" class="btn btn-sm btn-warning">Edit</a>
											
											<spring:url value="/profiles/delete/${profile.id}" var="userActionUrl" />
											<form method="POST" action="${userActionUrl}" style="display:inline;">
												<input type="submit" class="btn btn-sm btn-danger" value="Delete" />
											</form>
										</div>
									</div>
									<div id="collapse${profile.id}" class="collapse" data-parent="#my_accordion">
										<div class="card-body">
											<c:forEach items="${profile.apps}" var="app">
												<img src="/img/${app.image}" class="img-thumbnail img-fluid" height="100" width="100" alt="${app.name}"/>
											</c:forEach>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</c:if>
				</c:when>
				<c:otherwise>
					<div class="alert alert-danger">
						<a class="close" onclick="$('.alert').slideUp()">×</a>
						<p><strong>Access denied!!</strong> You have no permission to view the profiles.</p>
					</div>
					<p>Please <a href="/signin" class="btn btn-link">Sign in</a> to view your profile(s).</p>
				</c:otherwise>
			</c:choose>
			
		
		
		
		</div>
	</div>
	<div class="col-sm-2"></div>
</div>
</div>
</body>
</html>