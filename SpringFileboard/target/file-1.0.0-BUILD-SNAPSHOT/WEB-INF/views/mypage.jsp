<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file="include/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 방명록</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
  table{width:800px; margin:auto; border:none;}
  th{border:1px solid gray; background-color:silver; text-align:center; padding:5px;}
  td{border:1px solid gray; text-align:center; padding:5px;}
  .title{font-size:18pt; text-align:center; border:noen;}
  .sub_title{font-size:10pt; text-align:right; border:noen;}
</style>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/common.js"></script>
<script type="text/javascript">
	$(function() {
	  $("#selectSize").change(function () {
		var size = $(this).val();
		location.href="selectSize?s="+size;
	});

	});
	//replaceAll prototype 선언
	// 기존객체.prototype.함수 = 함수 : 객체에 메서드 추가!!!!
	String.prototype.replaceAll = function(org, dest) {
		// 문자열.split(문자열) : 구분자로 구분하여 배열을 만든다. --> 원본글자 모두 사라진다.
		// 문자열.join(문자열) : 문자열을 구분자로 하여 배열을 합쳐준다. --> 원본글자 자리에 대상글자 들어간다.
	    return this.split(org).join(dest);
	}

	// 수정
	function memoUpdate(idx){
		// alert($("#name"+idx).html() + "\n" + $("#content"+idx).html());
		var name = $("#name"+idx).html();
		var content = $("#content"+idx).html();
		content = content.replaceAll("&lt;", "<");
		content = content.replaceAll("&gt;", ">");

		$("#memoForm").attr("action","guestupdateOk");
		$("#idx").val(idx);
		$("#name").val(name);
		$("#name").prop('readonly','readonly');
		$("#content").val(content);
		$("#content").prop('readonly','');
		$("#submitBtn").attr('value','수정');
		$("#cancelBtn").css('display','inline');
		$("#password").focus();
	}
	// 삭제
	function memoDelete(idx){
		//alert($("#name"+idx).html() + "\n" + $("#content"+idx).html());
		var name = $("#name"+idx).html();
		var content = $("#content"+idx).html();
	
		
		$("#memoForm").attr("action","guestdeleteOk");
		$("#idx").val(idx);
		$("#name").val(name);
		$("#name").prop('readonly','readonly');
		$("#content").val(content);
		$("#content").prop('readonly','readonly');
		$("#submitBtn").attr('value','삭제');
		$("#cancelBtn").css('display','inline');
		$("#password").focus();
	}
	// 취소
	function resetForm(){
		$("#memoForm").attr("action","guestinsertOk");
		$("#idx").val(0);
		$("#name").val("");
		$("#content").val("");
		$("#name").prop('readonly','');
		$("#content").prop('readonly','');
		$("#submitBtn").attr('value','저장');
		$("#cancelBtn").css('display','none');
	}
	</script>

</head>
<body>    
    <table>
       <tr>
       	<td class="title" colspan="5">만나서 반가워요</td>
       </tr>
       <tr>
       	<td class="sub_title" colspan="5">${pagingVO.pageInfo}</td>	
       </tr>
    	<tr>
    		<th>번호</th>
    		<th width="60%">내용 </th>
    		<th>작성자</th>
    		<th>작성일</th>
    		<th>수정/삭제</th>
    	</tr>
    	<c:if test ="${pagingVO.totalCount==0 }">
    	<tr>
    		<td class="title" colspan="5">등록된글이없다</td>
    	</tr>
      </c:if>	
      <c:if test ="${pagingVO.totalCount>0 }">
        <c:forEach var="vo" items="${pagingVO.list}" varStatus="vs">
    	<tr>
    		<td>${vo.idx }</td>
    		<td style="text-align:left">
    		 <span id="content${vo.idx }"><c:out value="${vo.content }"/></span> 
    		</td>
    		<td>
    		<span id="name${vo.idx }"><c:out value="${vo.name }"/></span>
    		</td>
    		<td>
    		 <fmt:formatDate value="${vo.regDate }" pattern="MM-dd"/>
    		</td>
    		<td>
    		  <button class="btn btn-outline-warning  btn-sm" title="수정" 
						        onclick="memoUpdate('${vo.idx}')">E</button>
						<button class="btn btn-outline-success  btn-sm" title="삭제" 
						        onclick="memoDelete('${vo.idx}')">D</button>
    		</td>
    	</tr>
        </c:forEach>
        <tr>
        <td colspan="5" style="border:none; text-align:center">
         ${pagingVO.pageListPost }
        </td>
        </tr>
      </c:if>
        <tr>
            <td colspan="5" style="border: none; text-align:left">
				<form action="guestinsertOk" method="post" id="memoForm">
					<input type="hidden" name="idx" value="0" id="idx">
					<input type="hidden" name="p" value="${commonVO.currentPage }" id="idx">
					<input type="hidden" name="s" value="${commonVO.pageSize}">
					<input type="hidden" name="b" value="${commonVO.blockSize }">
					<input type="text" name="name" id="name" style="width: 70px;" placeholder="이름" required="required">
					<input type="password" name="password" id="password" style="width: 70px;" placeholder="암호" required="required"><br>
					<input type="text" name="content" id="content" placeholder="내용" required="required" size="73"> <br /> 
					<input type="submit"  value="저장"  class="btn btn-outline-dark btn-sm" id="submitBtn"> 
                     <input type="button" value="돌아가기" class="btn btn-outline-dark btn-sm"
				       onclick='post_to_url("${pageContext.request.contextPath }/file",{"p":${commonVO.currentPage },"s":${commonVO.pageSize},"b":${commonVO.blockSize }})'>
					<input type="button" value="취소" id="cancelBtn" style="display: none;" onclick="resetForm()">			
				</form>      
          </td>
    </table>
</body>
</html>