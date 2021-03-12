<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<%-- include shared head links --%>
	<jsp:include page="\headLinks.jsp" />	
	<meta charset="UTF-8">
	<title>Home</title>
</head>
<body>
	<%-- include shared nav bar --%>
	<jsp:include page="\navBar.jsp" />

	<h1>Hello World! test 2</h1>
	<a href="addPatient.jsp">add patient</a>
	<a href="lookUpPatient.jsp">look up patient</a>
	<c:if test="${not empty param.name}">
		<p>Name: ${param.name}</p>
	</c:if>
</body>
</html>
