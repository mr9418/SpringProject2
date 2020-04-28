<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
 <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"> </script>
</head>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/common.js"></script>
<body>
   <nav class="navbar navbar-expand-lg navbar-light bg-light">
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath }/">Home<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath }/file">게시판</a>
      </li>
       <li class="nav-item">
           <a class="nav-link" href="${pageContext.request.contextPath }/mypage">방명록</a>
      </li>
      
       <li class="nav-item">
           <a class="nav-link" href="${pageContext.request.contextPath }/Todolist">Todolist</a>
      </li>
      <c:if test="${vo==null }">
       <li class="nav-item">
           <a class="nav-link" href="${pageContext.request.contextPath }/login">로그인</a>
      </li>
      </c:if>
       <c:if test="${vo!=null}">
        <li class="nav-item">
       <p class="nav-link">아이디:${vo.username }님</p>
       </li>
       <li>
        <a class="nav-link" href="${pageContext.request.contextPath }/logout">로그아웃</a>
      </li>
    </c:if>
    </ul>
  </div>
</nav>
</body>
</html>