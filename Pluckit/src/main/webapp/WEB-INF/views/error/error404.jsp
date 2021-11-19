<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>404 Error</title>
<!-- CSS 파일 -->
<link rel="stylesheet" href="resources/css/error404.css">
<!-- Google Font -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Lato:wght@900&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

</head>
<body>
	<div id="wrap">
		<div class="errorImg">
			<img src="resources/img/error404.png" alt="">
		</div>
		<div class="errorNotice">
			<h1>페이지를 찾을 수 없습니다.</h1>
			<p>페이지가 존재하지 않거나, 사용할 수 없는 페이지입니다.</p>
			<p>입력하신 주소가 정확한지 다시 한번 확인해주세요.</p>
		</div>
		<div class="moveBtn">
			<button onclick="history.back()">이전 페이지</button>
			<button onclick="location.href='Home.do'">홈으로 이동</button>
		</div>
	</div>
</body>
</html>