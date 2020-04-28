<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!-- jstl의 코어기능을 사용하기 위한 태그 라이브러리 설정 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Spring MVC Board</title>
<style>
	*{
		padding-left:5px;
		padding-right:5px;
	}
</style>

<!-- 화면 출력 크기 설정 -->
<!-- 너비는 화면에 가득 차게, 기본 비율은 1배, 최대 비율 1배, 확대나 축소는 X -->
<!-- 모바일 페이지에서 주로 설정한다 -->
<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>

<!-- 부트스트랩 적용을 위한 css 설정 -->
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

<!-- IE9 버전 이하의 브라우저에서 HTML5를 적용하기 위한 설정 -->
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.comrespond/1.4.2respond.min.js"></script>
<![endif ]-->
</head>

<!-- jquery 설정 -->
<script src="/resources/jquery/jquery.js"></script>

<!-- class 와 role 속성을 이용해서 부트스트랩 적용 -->
<body class="skin-blue sidebar-mini">
<div class="wrapper">
<header class="main-header">
<div class="page-header">
<h1>포트폴리오</h1>
</div>
</header>
</div>
<aside class="main-sidebar">
<section class="sidebar">
<ul class="nav nav-tabs">
<li role="presentation" class="active"><ahref="#">메인</a></li></ahref>
<li role="presentation"><a href="#">목록보기</a></li>
<li role="presentation"><a href="#">게시물 쓰기</a></li>
<li role="presentation"><a href="#">회원가입</a></li>
</ul>
</section>
</aside>	
<div>
