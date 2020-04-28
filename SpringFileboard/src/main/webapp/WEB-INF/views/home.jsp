<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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

#hero {
    /* Flexbox stuff */
    display: flex;
    justify-content: center;
    align-items: center;
    /* Text styles */
    text-align: center;
}

a{
 font-size:1.2em;
 margin:15px; 
 text-decoration:none;
 color:black;
}
a:hover{
 color:skyblue;
 text-decoration:none;
}
#admin{
color:orange;
}
</style>
<body>

<div class="jumbotron text-center">
  <h1>Welcome to My Page</h1>
  <p>This is my first website! Enjoy you day!!</p> 
</div>

  <section id="hero">
    <c:if test="${vo == null }">
	     <a href="${pageContext.request.contextPath }/login" class="login">로그인창가기</a> <br />
	     <a href="${pageContext.request.contextPath }/join" class="join">회원가입</a> <br /><br />
	     <a href="${pageContext.request.contextPath }/file" class="guest">비회원들어가기</a> <br /><br />
    </c:if>
    <sec:authorize access="hasRole('USER')">
    <div>
       <p style="color:orange">${vo.username}님 환영합니다</p>
     	<a href="${pageContext.request.contextPath }/logout" class="logout">로그아웃</a>
      	<a href="${pageContext.request.contextPath }/file" class="member">사이트입장</a>
      	<sec:authorize access="hasRole('ADMIN')">
      		<a href="${pageContext.request.contextPath }/admin/" class="admin">[관리자페이지]</a>
      	</sec:authorize>
     </sec:authorize> 	
    </div>
   
    <c:if test="${msg == false}">
      <p style="color:red;">로그인실패! 아이디와 비밀번호를 확인해라 </p>
    </c:if>
  </section> 
    

</body>
</html>
