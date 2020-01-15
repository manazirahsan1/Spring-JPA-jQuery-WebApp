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
<title>Multi Level Authentication: Introducing Profile</title>
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
						
						<c:if test="${not empty profile}">
	
							<spring:url value="#" var="userActionUrl" />
							<form:form class="form-horizontal" method="GET" 
				                modelAttribute="profile" action="${userActionUrl}">
				                
				                <h3 style="text-align:center">Profile: ${profile.name}</h3><br/>
				                
				                <spring:bind path="name">
									<div class="form-group row">
										<label class="col-sm-2 control-label text-right">Name</label>
										<div class="col-sm-8">
											<form:input path="name" type="text" class="form-control" id="name" placeholder="Name" readonly="true" />
											<form:errors path="name" class="control-label">Profile name cannot be empty</form:errors>
											<span id="err_name" class="text-danger"></span>
										</div>
									</div>
								</spring:bind>		                
				                
				                <spring:bind path="apps">
									<div class="form-group row">
										<label class="col-sm-2 control-label text-right">App list</label>
										<div class="col-sm-8">
											<form:select multiple="true" path="apps" size="15" id="apps" readonly="true" disabled="true" >
											    <form:options items="${profile.apps}" itemValue="id" itemLabel="name" />
											</form:select>
											<form:errors path="apps" class="control-label" />
											<div id="err_apps" class="text-danger"></div>
										</div>
									</div>
								</spring:bind>
				 				
				            </form:form>
				            
				            <div class="form-group row">
								<label class="col-sm-2 control-label text-right"></label>
								<div class="col-sm-8">
									<spring:url value="/profiles" var="userActionUrl" />
									<a href="${userActionUrl}" class="btn btn-sm btn-primary">Back</a>
								
									<spring:url value="/profiles/edit/${profile.id}" var="userActionUrl" />
									<a href="${userActionUrl}" class="btn btn-sm btn-warning">Edit</a>
									
									<spring:url value="/profiles/delete/${profile.id}" var="userActionUrl" />
									<form method="POST" action="${userActionUrl}" style="display:inline">
										<input type="submit" class="btn btn-sm btn-danger" value="Delete" />
									</form>
								</div>
							</div>
			            </c:if>
			            <c:if test="${empty profile}">
				            <div class="alert alert-danger">
							<a class="close" onclick="$('.alert').slideUp()">×</a>
								<p><strong>Access denied!!</strong> You have no permission to view the profile.</p>
							</div>
							<p>You can access only your own <a href="/profiles" class="btn btn-link">Profile(s)</a>.</p>
			            </c:if>		            
					</c:when>
					<c:otherwise>
						<div class="alert alert-danger">
						<a class="close" onclick="$('.alert').slideUp()">×</a>
							<p><strong>Access denied!!</strong> You have no permission to view the profile.</p>
						</div>
						<p>Please <a href="/signin" class="btn btn-link">Sign in</a> to view your profile(s).</p>
					</c:otherwise>
	            </c:choose>
			</div>
		</div>
	</div>
	<div class="col-sm-2"></div>
</div>
</div>
</body>
</html>