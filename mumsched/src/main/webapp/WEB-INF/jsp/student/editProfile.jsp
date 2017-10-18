<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- <link href="css/course.css" rel="stylesheet" type="text/css"> -->


	<form:form id="editStudentForm" method="POST" modelAttribute="student"
		action="/mumsched/updatestudentprofile">
		<form:input type="hidden" path="id" id="id" />
		<form:input type="hidden" path="entry" id="entry" />
		<form:input type="hidden" path="kind" id="kind" />
		<form:input type="hidden" path="user" id="username" />
		<%-- <form:input type="hidden" path="targetBlock" id="targetBlock" class="form-control" /> --%>
			<div class="form-group">
				<label for="firstName"><spring:message code="student.firstname" /></label>
				<form:input path="firstName" id="firstName" class="form-control" />
				<form:errors path="firstName" cssClass="error" />
			</div>
			<div class="form-group">
				<label for="lastName"><spring:message code="student.lastname" /></label>
				<form:input path="lastName" id="lastName" class="form-control" />
				<form:errors path="lastName" cssClass="error" />
			</div>
			<div class="form-group">
				<label for="dob"><spring:message code="student.dob" /></label>
				<form:input type="date" path="dob" id="dob" class="form-control" />
				<form:errors path="dob" cssClass="error" />
			</div>
			<div class="form-group">
				<label for="email"><spring:message code="student.email" /></label>
				<form:input path="email" id="email" class="form-control" />
				<form:errors path="email" cssClass="error" />
			</div>	
			<div class="form-group">
				<input type="submit" value="Register" class="btn btn-info" />
			</div>
		
	</form:form>


<script>
	$('#editStudentForm').submit(function(event) {
		event.preventDefault(); // Prevent the form from submitting via the browser
		var form = $(this);
		$.ajax({
			type : form.attr('method'),
			url : form.attr('action'),
			data : form.serialize(),
			success : function(data) {
				$("#editStudentDialog").dialog("close");
				viewStudentProfile(document.getElementById('id').value);
			},
			error : function(e) {
				alert('Error: ' + e);
			}
		});
	});
</script>



