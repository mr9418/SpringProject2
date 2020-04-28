<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@include file="include/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MemberList</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/common.js"></script>
<style type="text/css">
 table{width:800px; margin:auto; border:none;}
</style>
<script type="text/javascript">

</script>

</head>
<body>   
  <div class="container">
   <h3 class="text-center">List of Members</h3>
  
  
   <div class="container text-left">
 
    </div>
	 <br>
   <table class="table table-bordered">
    <thead>
     <tr>
      <th>ID</th>
      <th>USERNAME</th>
      <th>NICKNAME</th>
      <th>자격</th>
     </tr>
     </thead>
     <c:if test = "${pagingVO.totalCount==0 }">
     <tr>
       <td class="title" colspan="4">등록된 글이 없다</td>
     </tr>
     </c:if>
     <c:if test = "${pagingVO.totalCount>0 }">
     	<c:set var="no" value="${pagingVO.totalCount - (pagingVO.currentPage-1)*pagingVO.pageSize }"/>
       <c:forEach var="vo" items="${pagingVO.list }" varStatus="vs">
       <tr>
         <td>
         	${vo.userid }
         </td>
         <td>
		  ${vo.username }
    	</td>
    	<td>
    	${vo.nickname}
    	</td>
    	<td>
        	<c:if test="${not empty vo.memberRoleList }">
        		<c:forEach var="roleVO" items="${vo.memberRoleList }">
        			${roleVO.role } &nbsp;
        		</c:forEach>
        	</c:if>
    	</td>
       </tr>
       </c:forEach>
      </c:if>
      <tr>
      <td colspan="4" style="border: none; text-align: right;">
				<button class="btn btn-success btn-sm" 
			  onclick='post_to_url("${pageContext.request.contextPath }/file",{"p":${commonVO.currentPage },"s":${commonVO.pageSize},"b":${commonVO.blockSize }})'>처음으로 돌아가기</button>
			</td>
      </tr>
  </table>
</body>
</html>