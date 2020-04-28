<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>회원관리-아이디 찾기</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" type="image/png" href="${pageContext.request.contextPath }/resources/images/icons/favicon.ico"/>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/vendor/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/vendor/animate/animate.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/vendor/css-hamburgers/hamburgers.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/vendor/animsition/css/animsition.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/vendor/select2/select2.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/vendor/daterangepicker/daterangepicker.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/util.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/main.css">
	<script src="${pageContext.request.contextPath }/resources/vendor/jquery/jquery-3.2.1.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/vendor/animsition/js/animsition.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/vendor/bootstrap/js/popper.js"></script>
	<script src="${pageContext.request.contextPath }/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/vendor/select2/select2.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/vendor/daterangepicker/moment.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/vendor/daterangepicker/daterangepicker.js"></script>
	<script src="${pageContext.request.contextPath }/resources/vendor/countdowntime/countdowntime.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
	<script type="text/javascript">
		function formCheck(){
			var data = $("#username").val();
			if(data==null || data.trim().length==0){
				alert('사용자 이름은 반드시 입력해야 합니다.');
				$("#username").val("");
				$("#username").focus();
				return false;
			}
			var data = $("#phone").val();
			if(data==null || data.trim().length==0){
				alert('전화번호는 반드시 입력해야 합니다.');
				$("#phone").val("");
				$("#phone").focus();
				return false;
			}
			return true; 
		}
	</script>
</head>
<body>
	
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-t-50 p-b-90">
				<form class="login100-form validate-form flex-sb flex-w" action="${pageContext.request.contextPath }/idSearchOk" method="post" onsubmit="return formCheck()">
					<span class="login100-form-title p-b-51">
						아이디 찾기
					</span>

					
					<div class="wrap-input100 validate-input m-b-16" data-validate = "이름 입력 필수">
						<input class="input100" type="text" name="username" placeholder="사용자 이름" id="username">
						<span class="focus-input100"></span>
					</div>
					
					
					<div class="wrap-input100 validate-input m-b-16" data-validate = "전화번호 입력 필수">
						<input class="input100" type="text" name="phone" placeholder="전화번호" id="phone">
						<span class="focus-input100"></span>
					</div>

					<div class="container-login100-form-btn m-t-17">
						<button class="login100-form-btn">
							아이디 찾기
						</button>
					</div>

				</form>
			</div>
		</div>
	</div>
</body>
</html>