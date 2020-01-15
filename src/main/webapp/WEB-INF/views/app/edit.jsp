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
<title>Multi Level Authentication: Edit App</title>
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
			<spring:url value="/apps/update/${app.id}" var="userActionUrl" />	
			<form class="form-horizontal" method="POST" action="${userActionUrl}" enctype="multipart/form-data">
				<h3 style="text-align:center">Edit App</h3>
				<div class="form-group row">
					<label class="col-sm-4 control-label text-right">Name</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="name" name="name" value="${app.name}" />
						<span id="err_name" class="text-danger"></span>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-4 control-label text-right">Description</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="description" name="description" value="${app.description}" />
						<span id="err_description" class="text-danger"></span>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-4 control-label text-right">Existing image</label>
					<div class="col-sm-4">
						<img src="/img/${app.image}" class="img-thumbnail img-fluid" height="100" width="100" />
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-4 control-label text-right">Keep this image</label>
					<div class="col-sm-4">
						<div class="form-check">
							<input type="checkbox" id="checkbox_keep_this_image" name="check" checked> <span class="label-text">Keep this image</span>
						</div>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-4 control-label text-right">Change image</label>
					<div class="col-sm-4">
						<input type="file" class="form-control" id="file" name="file" />
						<span id="err_file" class="text-danger"></span>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-4 control-label"></label>
					<div class="col-sm-4">
						<button id="submit_button" type="submit" class="btn btn-primary">Submit</button>
						<a class="btn btn-secondary" href="/apps">Cancel</a>
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
	$("#err_name").hide();
	$("#err_description").hide();
	$("#err_file").hide();

	$("#submit_button").click(function() {
		var name=$("#name").val();
		var description=$("#description").val();
		
		var isAlright=true;

		if(name=="" || name==null){
			$("#err_name").html("Name cannot be empty");
			$("#err_name").show();
			isAlright=false;
		}

		if(description=="" || description==null){
			$("#err_description").html("Please write a short note");
			$("#err_description").show();
			isAlright=false;
		}

		if($('#file').get(0).files.length === 0 && $("#checkbox_keep_this_image").prop("checked") == false) {
			$("#err_file").html("Please choose an image of the app");
			$("#err_file").show();
			isAlright=false;
		}
		
		return isAlright;	
	});

	$("#name").change(function(){
		var name=$("#name").val();
		if(name.length < 3){
			$("#err_name").html("Please choose a large name");
			$("#err_name").show();
			return false;
		}else{
			$("#err_name").hide();
			return true;
		}
	});

	$("#name").change(function(){
		var name=$("#name").val();
		if(name=="" || name==null){
			$("#err_name").html("Name cannot be empty");
			$("#err_name").show();
			return false;
		}else{
			$("#err_name").hide();
			return true;
		}
	});

	$("#description").change(function(){
		var description=$("#description").val();
		if(description=="" || description==null){
			$("#err_description").html("Please write a short note");
			$("#err_description").show();
			return false;
		}else{
			$("#err_description").hide();
			return true;
		}
	});

	$("#file").change(function(){
		if($('#file').get(0).files.length === 0) {
			$("#err_file").html("Please choose an image of the app");
			$("#err_file").show();
			return false;
		}else{
			$("#err_file").hide();
			return true;
		}
	});
});
</script>
</body>
</html>