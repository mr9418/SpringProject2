<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>회원관리-로그인</title>
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
			var data = $("#userid").val();
			if(data==null || data.trim().length==0){
				alert('아이디는 반드시 입력해야 합니다.');
				$("#userid").val("");
	 			$("#userid").focus();
				return false;
			}
			if(!validateEmail(data)){
				alert('아이디는 이메일 사용합니다.');
				$("#userid").val("");
				$("#userid").focus();
				return false;
			}
			var data = $("#password").val();
			if(data==null || data.trim().length==0){
				alert('비밀번호는 반드시 입력해야 합니다.');
				$("#password").val("");
				$("#password").focus();
				return false;
			}
			return true; 
		}
    	function validateEmail(email) {
    		var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
    		return re.test(email);
    	}
	</script>
</head>
<body>
    
	
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-t-50 p-b-90">
				<form class="login100-form validate-form flex-sb flex-w" action="${pageContext.request.contextPath }/loginOk" method="POST" onsubmit="return formCheck()">
					<span class="login100-form-title p-b-51">
						Login
					</span>

					
					<div class="wrap-input100 validate-input m-b-16" data-validate = "UserID is required">
						<input class="input100" type="text" name="userid" placeholder="Email Address" id="userid" value="${userid }">
						<span class="focus-input100"></span>
					</div>
					
					
					<div class="wrap-input100 validate-input m-b-16" data-validate = "Password is required">
						<input class="input100" type="password" name="password" placeholder="Password" id="password">
						<span class="focus-input100"></span>
					</div>
					
					<div class="flex-sb-m w-full p-t-3 p-b-24">
						<div class="contact100-form-checkbox">
							<input class="input-checkbox100" id="ckb1" type="checkbox" name="remember" value="save" ${not empty userid ? "checked='checked'":"" } >
							<label class="label-checkbox100" for="ckb1" style="font-size: 10pt;">
								아이디저장
							</label>
						</div>

						<div>
							<a href="${pageContext.request.contextPath }/join" class="txt1">
								회원가입
							</a>
						</div>
					</div>
					<div class="flex-sb-m w-full p-t-3 p-b-24">
						<div>
							<a href="${pageContext.request.contextPath }/idSearch" class="txt1">
								아이디 찾기
							</a>
						</div>
						<div>
							<a href="${pageContext.request.contextPath }/passwordSearch" class="txt1">
								비밀번호 찾기
							</a>
						</div>
						<div>
						<a href="${pageContext.request.contextPath }/" class="txt1">돌아가기</a>
						</div>
					</div>

					<div class="container-login100-form-btn m-t-17">
						<button class="login100-form-btn">
							Login
						</button>
					</div>

				</form>
			</div>
		</div>
	</div>
	<div id="dropDownSelect1"></div>
</body>
</html>