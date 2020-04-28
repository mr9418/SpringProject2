<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <!-- Required meta tags-->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Colorlib Templates">
    <meta name="author" content="Colorlib">
    <meta name="keywords" content="Colorlib Templates">

    <!-- Title Page-->
    <title>회원관리-회원가입</title>
    <!-- Jquery JS-->
    <script src="${pageContext.request.contextPath }/resources/vendor/jquery/jquery.min.js"></script>
    <!-- Vendor JS-->
    <script src="${pageContext.request.contextPath }/resources/vendor/select2/select2.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/vendor/datepicker/moment.min.js"></script>
    <script src="${pageContext.request.contextPath }/resources/vendor/datepicker/daterangepicker.js"></script>

    <!-- Main JS-->
    <script src="${pageContext.request.contextPath }/resources/js/global.js"></script>

    <!-- Icons font CSS-->
    <link href="${pageContext.request.contextPath }/resources/vendor/mdi-font/css/material-design-iconic-font.min.css" rel="stylesheet" media="all">
    <link href="${pageContext.request.contextPath }/resources/vendor/font-awesome-4.7/css/font-awesome.min.css" rel="stylesheet" media="all">
    <!-- Font special for pages-->
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500,500i,700,700i,900,900i" rel="stylesheet">

    <!-- Vendor CSS-->
    <link href="${pageContext.request.contextPath }/resources/vendor/select2/select2.min.css" rel="stylesheet" media="all">
    <link href="${pageContext.request.contextPath }/resources/vendor/datepicker/daterangepicker.css" rel="stylesheet" media="all">

    <!-- Main CSS-->
    <link href="${pageContext.request.contextPath }/resources/css/main2.css" rel="stylesheet" media="all">
    
    <!-- 다음 우편번호 API -->
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    
    <script type="text/javascript">
    	$(function(){
    		// daterangepicker설정 변경
    		$('input[name="birth"]').daterangepicker({
    			singleDatePicker: true,
    			showDropdowns: true,
    			locale: {
    			      format: 'YYYY-MM-DD'
    			}
    		  });
    		
    	});
    	//-----------------------------------------------------------------------------------------
		function execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var roadAddr = data.roadAddress; // 도로명 주소 변수
	                var extraRoadAddr = ''; // 참고 항목 변수
	
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('zipcode').value = data.zonecode;
	                document.getElementById("addr1").value = roadAddr;// data.jibunAddress;
	                document.getElementById("addr2").focus();
	            }
	        }).open();
	    }
    	
    	// 폼 검증하는 함수
    	function formCheck(){
    		if($("#idCheck").css('color')=='rgb(255, 0, 0)'){
    			alert('가입 불가능한 아이디입니다.!!!!');
    			$("#userid").val("");
    			$("#userid").focus();
    			return false;
    		}
    		
    		var data = $("#userid").val();
    		if(!data || data.trim().length==0){
    			alert('아이디는 반드시 입력해야 돼!!!!');
    			$("#userid").val("");
    			$("#userid").focus();
    			return false;
    		}
    		if(!validateEmail(data)){
    			alert('아이디가 이메일 형식이 아닙니다.');
    			$("#userid").val("");
    			$("#idCheck").html("");
    			$("#userid").focus();
    			return false;
    		}
    		var data = $("#password").val();
    		if(!data || data.trim().length==0){
    			alert('비밀번호는 반드시 입력해야 돼!!!!');
    			$("#password").val("");
    			$("#password").focus();
    			return false;
    		}
    		var data = $("#password2").val();
    		if(!data || data.trim().length==0){
    			alert('비밀번호 확인는 반드시 입력해야 돼!!!!');
    			$("#password2").val("");
    			$("#password2").focus();
    			return false;
    		}
 			if($("#password").val() != $("#password2").val()){
 				alert('비밀번호가 일치하지 않습니다.');
    			$("#password").val("");
    			$("#password2").val("");
    			$("#password").focus();
    			return false;
 			}
    		var data = $("#username").val();
    		if(!data || data.trim().length==0){
    			alert('사용자 이름은 반드시 입력해야 돼!!!!');
    			$("#username").val("");
    			$("#username").focus();
    			return false;
    		}
    		var data = $("#nickname").val();
    		if(!data || data.trim().length==0){
    			alert('사용자 별명은 반드시 입력해야 돼!!!!');
    			$("#nickname").val("");
    			$("#nickname").focus();
    			return false;
    		}
    		var data = $("#birth").val();
    		if(!data || data.trim().length==0){
    			alert('생년월일은 반드시 입력해야 돼!!!!');
    			$("#birth").val("");
    			$("#birth").focus();
    			return false;
    		}
    		var data = $("#phone").val();
    		if(!data || data.trim().length==0){
    			alert('전화번호는 반드시 입력해야 돼!!!!');
    			$("#phone").val("");
    			$("#phone").focus();
    			return false;
    		}
    		if(!validatePhone(data)){
    			alert('전화번호 형식은 000-0000-0000입니다.');
    			$("#phone").val("");
    			$("#phone").focus();
    			return false;
    		}
    		var data = $("#zipcode").val();
    		if(!data || data.trim().length==0){
    			alert('우편번호는 반드시 입력해야 돼!!!!');
    			execDaumPostcode(); // 우편번호 검색창 띄우기
    			return false;
    		}
    		var data = $("#addr2").val();
    		if(!data || data.trim().length==0){
    			alert('상세주소는 반드시 입력해야 돼!!!!');
    			$("#addr2").val("");
    			$("#addr2").focus();
    			return false;
    		}   		
    		return true;
    	}
    	// 아이디 중복 확인
    	function idCheck(){
    		var value = $("#userid").val();
    		if(value.length>5){
    			$.ajax('idCheck',{
    				type:'GET',
    				data:{'userid': value},
    				dataType:'json',
    				error : function(){
    					alert('실패!!!');
    				},
    				success:function(data){
    					if(data==1)
    						$("#idCheck").css('color','red').html("사용 불가능한 아이디입니다.");
    					else 
    						$("#idCheck").css('color','green').html("사용 가능한 아이디입니다.");
    				}
    			});
    		}else{
    			$("#idCheck").html("");
    		}
    	}
    	
    	function validateEmail(email) {
    		var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
    		return re.test(email);
    	}
    	function validatePhone(phone) {
    		var re = /^\d{2,3}-\d{3,4}-\d{4}$/;
    		return re.test(phone);
    	}
    	//-----------------------------------------------------------------------------------------
    </script>
</head>

<body>
    <div class="page-wrapper bg-red p-t-180 p-b-100 font-robo" style="background-color: silver;">
        <div class="wrapper wrapper--w960">
            <div class="card card-2">
                <div class="card-heading"></div>
                <div class="card-body">
                    <h2 class="title">회원 가입 하기</h2>
                    <form method="POST" action="${pageContext.request.contextPath }/joinOk" onsubmit="return formCheck();">
                    	<div class="row row-space">
    	                	<div class="col-2">
	    	                	<div class="input-group">
            	                 	<input class="input--style-2" type="text" placeholder="사용자아이디" name="userid" id="userid" onkeyup="idCheck();">
            	                </div>
            	            </div>
            	            <div class="col-2">
                                <div class="input-group" style="border: none;">
                                    <span id="idCheck"></span> 
                                </div>
                            </div>
                        </div>
                        <div class="row row-space">
                            <div class="col-2">
                                <div class="input-group">
                                   <input class="input--style-2" type="password" placeholder="비번입력" name="password" id="password"> 
                                </div>
                            </div>
                            <div class="col-2">
                                <div class="input-group">
                                    <input class="input--style-2" type="password" placeholder="비번확인" name="password2" id="password2">
                                </div>
                            </div>
                        </div>
                        <div class="row row-space">
                            <div class="col-2">
                                <div class="input-group">
                                   <input class="input--style-2" type="text" placeholder="이름입력" name="username" id="username"> 
                                </div>
                            </div>
                            <div class="col-2">
                                <div class="input-group">
                                    <input class="input--style-2" type="text" placeholder="별명입력" name="nickname" id="nickname">
                                </div>
                            </div>
                        </div>

                        <div class="row row-space">
                            <div class="col-2">
                                <div class="input-group">
                                    <input class="input--style-2 js-datepicker" type="text" placeholder="생년월일" name="birth" id="birth">
                                    <i class="zmdi zmdi-calendar-note input-icon js-btn-calendar"></i>
                                </div>
                            </div>
                            <div class="col-2">
                                <div class="input-group">
                                    <input class="input--style-2" type="text" placeholder="전화번호" name="phone" id="phone">
                                </div>
                            </div>
                        </div>
                        <div class="row row-space">
                            <div class="col-2">
                                <div class="input-group">
                                   <input class="input--style-2" type="text" placeholder="우편번호" readonly="readonly" name="zipcode" id="zipcode" onclick="execDaumPostcode();">
                                </div>
                            </div>
                            <div class="col-2">
                                <div class="input-group" style="border: none;">
                                    <input class="input--style-2" type="hidden" value="우편번호찾기" onclick="execDaumPostcode();">
                                </div>
                            </div>
                        </div>
                        <div class="input-group">
                            <input class="input--style-2" type="text" placeholder="주소" name="addr1" id="addr1" readonly="readonly">
                        </div>
                        <div class="input-group">
                            <input class="input--style-2" type="text" placeholder="상세주소" name="addr2" id="addr2">
                        </div>
                        <div>
                            <button class="btn btn--radius btn--green" type="submit">회원가입</button>
                          <button class="btn btn--radius btn--green" type="button" onclick="location.href='/file'">돌아가기</button>
                       
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body><!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>
<!-- end document-->