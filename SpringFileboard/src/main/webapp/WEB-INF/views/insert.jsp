<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자료실 글쓰기</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
	* {font-size: 10pt;}
	table { width: 800px;margin: auto;border: none;}
	th { border: 1px solid gray; background-color: silver; text-align: center;padding:5px; }
	td { border: 0px solid gray; text-align: left;padding:5px; }
	.title{font-size: 18pt; text-align: center; border: none;}
	.sub_title{font-size: 10pt; text-align: right; border: none;}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/common.js"></script>
<script type="text/javascript">
	$(function(){
		var fileCount = 1; // 최소
		var maxCount = 10; // 최대 첨부 파일 개수
		$("#plusBtn").click(function(){
			if(fileCount==maxCount){
				alert('최대 ' + fileCount + '개까지만 첨부 가능 합니다.');
				return;
			}
			fileCount++;
			var tag = $("<div id='file"+fileCount+"'><input type='file' name='files'></div>");
			$("#fileList").append(tag);
		});

		$("#minusBtn").click(function(){
			if(fileCount==1){
				alert('최소 ' + fileCount + '개는 반드시 첨부해야 합니다.');
				return;
			}
			$("#file" + fileCount).remove();
			fileCount--;
		});
	});
</script>
</head>
<body>
	<form action="insertOk" method="post" enctype="multipart/form-data">
	<%-- 몇가지는 숨겨서 가자!!! --%>
	<input type="hidden" name="p" value="1">
	<input type="hidden" name="s" value="${commonVO.pageSize }">
	<input type="hidden" name="b" value="${commonVO.blockSize }">
	<input type="hidden" name="ip" value="${pageContext.request.remoteAddr }">
	<table style="border: 1px;text-align: center;">
		<tr>
			<td colspan="4" class="title">자료실 글쓰기</td>
		</tr>
		<tr>
			<td style="text-align: right;" width="10%">이름</td>
			<td width="40%" align="left">
				<input type="text" name="name" required="required" placeholder="이름입력" id="name">
			</td>
			<td  style="text-align: right;" width="10%">비번</td>
			<td width="40%" align="left">
				<input type="password" name="password" required="required" placeholder="비번입력" id="password">
			</td>
		</tr>
		<tr>
			<td  style="text-align: right;" valign="top">제목</td>
			<td align="left" colspan="3">
				<input type="text" name="subject" id="subject" required="required" placeholder="제목입력" size="78">
			</td>
		</tr>
		<tr>
			<td style="text-align: right;" valign="top">내용</td>
			<td align="left" colspan="3">
				<textarea rows="10" cols="80" name="content" required="required" id="content"></textarea>
			</td>
		</tr>
		<tr>
			<td style="text-align: right;" valign="top">첨부파일</td>
			<td align="left" colspan="3" id="fileList">
				<input type="button" id="plusBtn" value=" + " class="btn btn-primary btn-sm">
				<input type="button" id="minusBtn" value=" - " class="btn btn-primary btn-sm"><br>
				<div id="file1"><input type="file" name="files"></div>
			</td>
		</tr>
		<tr>
			<td colspan="4" align="right" style="text-align: center;border: none;">
				<input type="submit" value="저장하기" class="btn btn-outline-primary btn-sm" >
				<input type="button" value="취소하기" class="btn btn-outline-dark btn-sm"
				        onclick='post_to_url("${pageContext.request.contextPath }/file",{"p":${commonVO.currentPage },"s":${commonVO.pageSize},"b":${commonVO.blockSize }})'>
			</td>
		</tr>
	</table>
	</form>
</body>
</html>
