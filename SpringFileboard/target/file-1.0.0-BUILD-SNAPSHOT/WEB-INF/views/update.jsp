<%@page import="kr.manamana.file.service.FileBoardService"%>
<%@page import="kr.manamana.file.vo.FileBoardVO"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자료실 글수정</title>
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
			var tag = $("<div id='file"+fileCount+"'><input type='file' name='file'></div>");
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
	<form action="updateOk" method="post" enctype="multipart/form-data">
	<%-- 몇가지는 숨겨서 가자!!! --%>
	<input type="hidden" name="p" value="${commonVO.currentPage }">
	<input type="hidden" name="s" value="${commonVO.pageSize }">
	<input type="hidden" name="b" value="${commonVO.blockSize }">
	<input type="hidden" name="ip" value="${pageContext.request.remoteAddr }">
	<input type="hidden" name="idx" value="${vo.idx}">
	<table style="border: 1px;text-align: center;">
		<tr>
			<td colspan="4" class="title">자료실 글수정</td>
		</tr>
		<tr>
			<td style="text-align: right;" width="10%">이름</td>
			<td width="40%" align="left">
				<input type="text" name="name" readonly="readonly" value="${vo.name }" id="name">
			</td>
			<td  style="text-align: right;" width="10%">비번</td>
			<td width="40%" align="left">
				<input type="password" name="password" required="required" placeholder="비번입력" id="password">
			</td>
		</tr>
		<tr>
			<td  style="text-align: right;" valign="top">제목</td>
			<td align="left" colspan="3">
				<input type="text" name="subject" id="subject" required="required" value="${vo.subject }" size="78">
			</td>
		</tr>
		<tr>
			<td style="text-align: right;" valign="top">내용</td>
			<td align="left" colspan="3">
				<textarea rows="10" cols="80" name="content" required="required" id="content">${vo.content }</textarea>
			</td>
		</tr>
		<tr>
			<td style="text-align: right;" valign="top">첨부파일</td>
			<td align="left" colspan="3" id="fileList">
				<%-- 첨부파일 개수만큼 디스크 이미지를 출력 --%>
				<c:if test="${vo.fileCount>0 }">
					<c:forEach var="fvo" items="${vo.fileList }">
						<div>
							${fvo.oFile }
							<a href="#" onclick="deleteToggle(${fvo.idx})"><img src="${pageContext.request.contextPath }/resources/images/save18.png"/></a>
							<span id="fvo${fvo.idx }" style="display: none;color: red;">삭제</span>
						</div>
					</c:forEach>
				</c:if>
				<input type="hidden" name="deleteFiles" id="deleteFiles"><br>
				<script type="text/javascript">
					function  deleteToggle(idx){
						if($("#fvo"+idx).css('display')=='none'){
							$("#fvo"+idx).css('display','inline');	
							var files = $("#deleteFiles").val();
							$("#deleteFiles").val(files + ' ' + idx);
						}else{
							$("#fvo"+idx).css('display','none');	
							var files = $("#deleteFiles").val().split(' ');
							var str = "";
							for(var i in files){
								if(files[i]==idx) continue;
								str += files[i] + ' ';
							} 
							$("#deleteFiles").val(str.trim());
						}
					}
				</script>
				<input type="button" id="plusBtn" value=" + " class="btn btn-primary btn-sm">
				<input type="button" id="minusBtn" value=" - " class="btn btn-primary btn-sm"><br>
				<div id="file1"><input type="file" name="files"></div>
			</td>
		</tr>
		<tr>
			<td colspan="4" align="right" style="text-align: center;border: none;">
				<input type="submit" value="수정하기" class="btn btn-outline-primary btn-sm" >
				<input type="button" value="취소하기" class="btn btn-outline-dark btn-sm"
				       onclick='post_to_url("${pageContext.request.contextPath }/file",{"p":${commonVO.currentPage },"s":${commonVO.pageSize},"b":${commonVO.blockSize }})'>
			</td>
		</tr>
	</table>
	</form>
</body>
</html>
