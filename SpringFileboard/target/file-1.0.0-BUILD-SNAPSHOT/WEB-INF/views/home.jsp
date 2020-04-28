<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<meta charset="UTF-8"/>
  <title>HomePage Intro</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/common.js"></script>
</head>
<style>
a{
 text-decoration: none;
 color:black;
}
a:hover{
  color:green;
}
.admin{
 color:orange;
}
.admin:hover{
 text-decoration:"none";
  color:red;
}

</style>
<body>

<div class="jumbotron text-center">
  <h1>Welcome to My Page</h1>
  <p>This is my first website! Enjoy you day!!</p> 
</div>
 
    <c:if test="${vo == null }">
     
     <a href="${pageContext.request.contextPath }/login" class="login">로그인창가기</a> <br /><br />
     <a href="${pageContext.request.contextPath }/join" class="join">회원가입</a> <br /><br />
     <a href="${pageContext.request.contextPath }/file" class="guest">비회원들어가기</a> <br /><br />
     <a href="${pageContext.request.contextPath }/admin" class="admin">[관리자로그인]</a>
     
 
    </c:if>
    <c:if test="${vo!=null}">
    <div>
       <p style="color:orange">${vo.username}님 환영합니다</p>
     	<a href="${pageContext.request.contextPath }/logout" class="logout">로그아웃</a>
      <a href="${pageContext.request.contextPath }/file" class="member">사이트입장</a>
    </div>
    </c:if>
    <c:if test="${msg == false}">
      <p style="color:red;">로그인실패! 아이디와 비밀번호를 확인해라 </p>
    </c:if>
   
    

</body>
</html>
