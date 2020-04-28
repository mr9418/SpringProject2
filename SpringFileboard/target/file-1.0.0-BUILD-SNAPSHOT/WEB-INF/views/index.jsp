<%@page import="kr.manamana.file.service.FileBoardService"%>
<%@page import="kr.manamana.file.vo.FileBoardVO"%>
<%@page import="kr.manamana.file.vo.PagingVO"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file="include/header.jsp" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자료실 목록보기</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
 <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"> </script>
<style type="text/css">
	* {font-size: 10pt;}
	table { width: 800px;margin: auto;border: none;}
	th { border: 1px solid gray; background-color: silver; text-align: center;padding:5px; }
	td { border: 1px solid gray; text-align: center;padding:5px; }
	.title{font-size: 18pt; text-align: center; border: none;}
	.sub_title{font-size: 10pt; text-align: right; border: none;}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/common.js"></script>
<script type="text/javascript">
$(function() {
	  $("#selectSize").change(function () {
		var size = $(this).val();
		location.href="?s="+size;
	});

	});
	//replaceAll prototype 선언
	// 기존객체.prototype.함수 = 함수 : 객체에 메서드 추가!!!!
	String.prototype.replaceAll = function(org, dest) {
		// 문자열.split(문자열) : 구분자로 구분하여 배열을 만든다. --> 원본글자 모두 사라진다.
		// 문자열.join(문자열) : 문자열을 구분자로 하여 배열을 합쳐준다. --> 원본글자 자리에 대상글자 들어간다.
	    return this.split(org).join(dest);
	}
</script>
</head>
<body>

	<table>
		<tr>
			<td colspan="4" class="title">다같이 공유해요</td>
		</tr>
		<tr>
			<td colspan="5" class="sub_title">${pagingVO.pageInfo }
		     <select id="selectSize">
					<option value="5" ${commonVO.pageSize eq 5 ? " selected='selected' " : "" }> 5개씩 보기</option>
					<option value="10" ${commonVO.pageSize eq 10 ? " selected='selected' " : "" }>10개씩 보기</option>
					<option value="15" ${commonVO.pageSize eq 15 ? " selected='selected' " : "" }>15개씩 보기</option>
					<option value="20" ${commonVO.pageSize eq 20 ? " selected='selected' " : "" }>20개씩 보기</option>
					<option value="25" ${commonVO.pageSize eq 25 ? " selected='selected' " : "" }>25개씩 보기</option>
					<option value="30" ${commonVO.pageSize eq 30 ? " selected='selected' " : "" }>30개씩 보기</option>
			 </select>	
		   </td>
		</tr>
		<tr>
			<th>번호</th>
			<th width="70%">제목</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
		<c:if test="${pagingVO.totalCount<=0 }">
			<tr>
				<td colspan="4">등록된 글이 없습니다.</td>
			</tr>
		</c:if>
		<c:if test="${pagingVO.totalCount > 0 }">
			<c:set var="no" value="${pagingVO.totalCount - (pagingVO.currentPage-1)*pagingVO.pageSize }"/>
			<c:forEach var="vo" items="${pagingVO.list }" varStatus="vs">
				<tr align="center">
					<td>${no-vs.index }</td>
					<td style="text-align: left;">
					<span style="cursor: pointer;"  onclick='post_to_url("view",{"idx":${vo.idx },"p":${commonVO.currentPage},"s":${commonVO.pageSize},"b":${commonVO.blockSize}})'>
							<c:out value="${vo.subject }"/> 
							<c:if test="${vo.commentCount > 0 }">
							(${vo.commentCount })
						</c:if>
						</span>
						&nbsp;
					
						<%-- 첨부파일 개수만큼 디스크 이미지를 출력 --%>
						<c:if test="${vo.fileCount>0 }">
							<c:forEach var="fvo" items="${vo.fileList }">
								<c:url var="url" value="download.jsp">
									<c:param name="of" value="${fvo.oFile }"/>
									<c:param name="sf" value="${fvo.sFile }"/>
								</c:url>
								<a href="${pageContext.request.contextPath }" title="${fvo.oFile }"><img src="${pageContext.request.contextPath }/resources/images/save18.png"/></a>&nbsp;
							</c:forEach>
						</c:if>
					</td>
					<td>
						<c:out value="${vo.name }"/>
					</td>
					<td>
						<fmt:formatDate value="${vo.regDate }" pattern="yy-MM-dd"/>
					</td>
				</tr>
			</c:forEach>
			<%-- 페이지 번호 출력 --%>
			<tr>
				<td colspan="4" style="border: none;">
					${pagingVO.pageListPost }
				</td>
			</tr>
		</c:if>
		<%-- 쓰기버튼 출력 --%>
		<tr>
			<td colspan="4" style="border: none; text-align: right;">
				<button class="btn btn-success btn-sm" 
				onclick='post_to_url("${pageContext.request.contextPath }/insert",{"p":${commonVO.currentPage},"s":${commonVO.pageSize}, "b":${commonVO.blockSize}})'>쓰기</button>
			</td>
		</tr>
	</table>
</body>
</html>













