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
    <p>관리자:${vo.username }님 어서오세요</p>
  
     <a href="${pageContext.request.contextPath }/" class="home">[홈]</a>
     <a href="${pageContext.request.contextPath }/memberList">멤버관리하기</a>
</body>
</html>