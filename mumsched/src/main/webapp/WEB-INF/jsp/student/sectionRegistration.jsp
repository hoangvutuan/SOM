<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>User Registration</title>
</head>
<body>
	<h3 id="announcement"></h3>
    <form:form method="POST" modelAttribute="regSections" action="register" id="regForm"> 
    	<input type="hidden" name="studentId" value="${studentId}">      
        <table>
        	<c:forEach items="${studentblocks}" var="block" varStatus="status"> 
        		<div class="form-group">
				<label for="sectionIds[${status.index}]">${block.name}</label>
        		<select name="sectionIds[${status.index}]" class="form-control">        	
        			<c:forEach items="${block.sections}" var="section" varStatus="selectStatus">
        				<option value="${section.id}">${section.name} - ${section.faculty.firstName}  ${section.faculty.lastName}</option>
        			</c:forEach>
        		</select>
        		</div>
        	</c:forEach>

            <tr>
                <td colspan="3">
                    <c:choose>
                        <c:when test="${edit}">
                            <input type="submit" value="Update" class="btn btn-info"/>
                        </c:when>
                        <c:otherwise>
                            <input type="submit" value="Register" class="btn btn-info"/>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </table>
    </form:form>
<script>
$(document).ready(function() { 
	var count = $('#regForm').find('select');
	if (count.length == 0)
	{
		$("#regForm").css("display","none");
		$("#announcement").text("There's no block to register at this moment");
	}
	
}); 
</script>

</body>
</html>