<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js">
	
</script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/resources/js/common.js"></script>
<style type="text/css">
table {
	width: 800px;
	margin: auto;
	border: none;
}
</style>
<script type="text/javascript">

</script>
</head>
<body>
	<form action="tododeleteOk" method="post">
		<%-- 몇가지는 숨겨서 가자!!! --%>
		<input type="hidden" name="idx" value="${vo.idx }"> <input
			type="hidden" name="p" value="${commonVO.currentPage }"> <input
			type="hidden" name="s" value="${commonVO.pageSize }"> <input
			type="hidden" name="b" value="${commonVO.blockSize }">
		<table style="border: 1px; text-align: center;">
			<h1>Delete Todo</h1>

			<tr>
				<td><label>Todo title</label></td>
				<td><input type="text" class="form-control" name="title"
					readonly="readonly" value="${vo.title}" id="title"></td>
			</tr>

			<tr>
				<td><label>Todo contents</label></td>
				<td><input type="text" class="form-control" name="contents"
					readonly="readonly" value="${vo.contents}" id="contents"></td>
			</tr>


			<tr>
				<td><label>Todo Status</label></td>
				<td><select class="form-control" name="status"
					readonly="readonly">
						<option value="0">진행중</option>
						<option value="1">Done</option>
				</select></td>
			</tr>

            <tr>
				<td><label>Todo Date</label></td>
				<td readonly="readonly" class="form-control">
				<fmt:formatDate value="${vo.regDate }" pattern="yyyy-MM-dd"/>
				
				
				</td>
			</tr>
      
            <tr> 
            <td colspan="4" align="right" style="text-align: center;border: none;">
             <input type="submit" value="remove" class="btn btn-outline-primary btn-sm">
             <input type="button" value="return" class="btn btn-outline-dark btn-sm"
				    onclick='post_to_url("${pageContext.request.contextPath }/Todolist",{"p":${commonVO.currentPage },"s":${commonVO.pageSize},"b":${commonVO.blockSize }})'>
            </td>
           </tr>  
		</table>
	</form>
</body>
</html>