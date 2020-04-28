<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
 href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
 <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
 <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"> </script>
 <script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/common.js"></script>
<style type="text/css">
 table{width:800px; margin:auto; border:none;}
</style>
</head>
<body>

<form action="addinsertOk" method="post">
		<%-- 몇가지는 숨겨서 가자!!! --%>
	<input type="hidden" name="p" value="${commonVO.currentPage }">
	<input type="hidden" name="s" value="${commonVO.pageSize }">
	<input type="hidden" name="b" value="${commonVO.blockSize }">
    <input type="hidden" name="p" value="1">
		<table style="border: 1px; text-align: center;">
			<h1>Add New Todo</h1>
    <table>
     <!-- <input type="text" class="form-control" name="title" required="required" minlength="5"/>-->
     <tr>
     <td>
     <label>Todo Title</label>
     <input type="hidden" class="form-control" name="name" value="조희정"/>
     <input type="text" class="form-control" name="title"/>
     
      </td>
     </tr>
     
     <tr>
     <td>
     <label>Todo contents</label> 
     <input type="text" class="form-control" name="contents" minlength="5"/>
     </td>
     </tr>
     
      <tr>
     <td>
      <label>Todo Status</label> 
      <select class="form-control" name="status">
      <option value="0">진행중</option>
      <option value="1">Done</option>
     </select>
      </td>
     </tr>
     
     <tr>
		<td>
		<label>Todo Date</label>
		<input type="Date" class="form-control" name="regDate" readonly="readonly"
		value="${regDate}" id="regDate">
		</td>
		</tr>
      
     
     
    
     <tr>
     <td>
     <input type="submit" value="저장하기" class="btn btn-outline-primary btn-sm" >
	  <input type="button" value="취소하기" class="btn btn-outline-dark btn-sm"
	  onclick='post_to_url("${pageContext.request.contextPath }/Todolist",{"p":${commonVO.currentPage },"s":${commonVO.pageSize},"b":${commonVO.blockSize }})'>
     </td>
     </tr>
     </table>
	</form>

</body>
</html>