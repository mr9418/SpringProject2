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
<title>자료실 글보기</title>
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
	td { border: 1px solid gray; text-align: left;padding:5px; }
	.title{font-size: 18pt; text-align: center; border: none;}
	.sub_title{font-size: 10pt; text-align: right; border: none;}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/common.js"></script>
<script type="text/javascript">
	$(function(){

	});
	// 댓글 수정
	function commentUpdate(idx){
		var name = $("#name"+idx).text();
		var content = $("#content"+idx).text();
		$("#commentForm").attr("action","CommentUpdateOk");
		$("#idx").val(idx);
		$("#name").val(name);
		$("#content").val(content);
		$("#cancelBtn").css("display","inline");
		$("#submitBtn").val("수정");
	}
	// 댓글 삭제
	function commentDelete(idx){
		var name = $("#name"+idx).text();
		var content = $("#content"+idx).text();
		$("#commentForm").attr("action","CommentDeleteOk");
		$("#idx").val(idx);
		$("#name").val(name);
		$("#content").val(content);
		$("#cancelBtn").css("display","inline");
		$("#submitBtn").val("삭제");
	}
	// 폼 리셑
	function commentReset(){
		$("#commentForm").attr("action","CommentInsertOk");
		$("#idx").val(-1);
		$("#name").val("");
		$("#content").val("");
		$("#cancelBtn").css("display","none");
		$("#submitBtn").val("저장");
	}
	
	
</script>
</head>
<body>
	<table style="border: 1px;text-align: center;">
		<tr>
			<td colspan="4" class="title">자료실 글보기</td>
		</tr>
		<tr>
			<td style="text-align: right;" width="10%">이름</td>
			<td width="40%" align="left">
				<c:out value="${vo.name }"></c:out>
			</td>
			<td  style="text-align: right;" width="10%">작성일(ip)</td>
			<td width="40%" align="left">
				<fmt:formatDate value="${vo.regDate }" pattern="yyyy-MM-dd hh:mm"/>
				(${vo.ip })
			</td>
		</tr>
		<tr>
			<td  style="text-align: right;" valign="top">제목</td>
			<td align="left" colspan="3">
				<c:out value="${vo.subject }"/>
			</td>
		</tr>
		<tr>
			<td style="text-align: right;" valign="top">내용</td>
			<td align="left" colspan="3">
				<c:set var="content" value="${vo.content }"/>
				<c:set var="content" value="${fn:replace(content,'<','&nbsp;') }"/>
				<c:set var="content" value="${fn:replace(content, newLine,br) }"/>
				${content }		
			</td>
		</tr>
		<tr>
			<td style="text-align: right;" valign="top">첨부파일</td>
			<td align="left" colspan="3" id="fileList">
				<%-- 첨부파일 개수만큼 디스크 이미지를 출력 --%>
				<c:if test="${vo.fileCount>0 }">
					<c:forEach var="fvo" items="${vo.fileList }">
						<c:url var="url" value="download.jsp">
							<c:param name="of" value="${fvo.oFile }"/>
							<c:param name="sf" value="${fvo.sFile }"/>
						</c:url>
						<a href="${url}" title="${fvo.oFile }">${fvo.oFile }</a><br>
					</c:forEach>
				</c:if>
			</td>
		</tr>
		<tr>
			<td colspan="4" align="right" style="text-align: center;border: none;">
				<input type="button" value="수정하기" class="btn btn-outline-primary btn-sm" 
					   onclick='post_to_url("update",{"idx":${commonVO.idx },"p":${commonVO.currentPage },"s":${commonVO.pageSize},"b":${commonVO.blockSize }})'>
				<input type="button" value="삭제하기" class="btn btn-outline-primary btn-sm" 
				       onclick='post_to_url("delete",{"idx":${commonVO.idx },"p":${commonVO.currentPage },"s":${commonVO.pageSize},"b":${commonVO.blockSize }})'>
				<input type="button" value="돌아가기" class="btn btn-outline-dark btn-sm"
				       onclick='post_to_url("${pageContext.request.contextPath }/file",{"p":${commonVO.currentPage },"s":${commonVO.pageSize},"b":${commonVO.blockSize }})'>
			</td>
		</tr>
		<tr>
			<td colspan="6"  style="background-color: skyblue;text-align: left;border: 5px solid gray">
				<%-- 댓글 폼 --%>
				<form action="CommentInsertOk" method="post" id="commentForm">
					<input type="hidden" name="idx" id="idx" value="-1">
					<input type="hidden" name="ref" id="ref" value="${vo.idx }">
					<input type="hidden" name="p" value="${commonVO.currentPage }">
					<input type="hidden" name="s" value="${commonVO.pageSize }">
					<input type="hidden" name="b" value="${commonVO.blockSize }">
					<input type="hidden" name="m" value="0">
					<input type="text" name="name" id="name" placeholder="이름" required="required">
					<input type="password" name="password" id="password" placeholder="비번" required="required">
					<br>
					<textarea rows="4" cols="90" name="content" id="content"></textarea>
					<br>
					<input type="submit" value="댓글저장" id="submitBtn">
					<input type="button" value="취소" id="cancelBtn" style="display: none;"  onclick="commentReset()">
				</form>
			</td>
		</tr>
		<tr>
			<td colspan="6">
			<c:if test="${empty vo.commentList }">
				등록된 댓글이 없습니다.
			</c:if>
			<c:if test="${not empty vo.commentList }">
				<div style="border-bottom: 2px dotted skyblue;text-align: left;">
				전체 ${fn:length(vo.commentList) }개의 댓글이 있습니다.
				</div>
				<c:forEach var="comment" items="${vo.commentList }">
					<div style="border-bottom: 1px dotted pink;text-align: left;">
						<strong>
						<span id="name${comment.idx }">${comment.name }</span>씨가 ${comment.ip }에서 
						<fmt:formatDate value="${comment.regDate }" pattern="yyyy-MM-dd hh:mm:ss"/>에 남긴글
						<button class="btn btn-success btn-sm" onclick="commentUpdate('${comment.idx }')">수정</button>
						<button class="btn btn-success btn-sm" onclick="commentDelete('${comment.idx }')">삭제</button>
						</strong>
						<div id="content${comment.idx }" style="display:none;">${comment.content }</div>
						<div>
							<c:set var="content2" value="${comment.content }"/>
							<c:set var="content2" value="${fn:replace(content2,'<','&nbsp;') }"/>
							<c:set var="content2" value="${fn:replace(content2, newLine,br) }"/>
							${content2 }	
						</div>
					</div>
				
				</c:forEach>
			</c:if>
			</td>
		</tr>
		
		
		
		
	</table>
</body>
</html>















