<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <h1>This page for admin only!!</h1>
    
    <c:if test = "${vo == null }">
     <h2>Access Denied</h2>
     </c:if>
     <a href="${pageContext.request.contextPath }/" class="home">[홈]</a>
</body>
</html>