<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>500 Error</title>
<!-- CSS 파일 -->
<link rel="stylesheet" href="resources/css/error500.css">
<!-- Google Font -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Lato:wght@900&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

</head>
<body>
	<div id="wrap">
		<div class="errorImg">
			<img src="resources/img/error500.png" alt="">
		</div>
		<div class="errorNotice">
			<h1>서비스에 접속할 수 없습니다.</h1>
            <p>요청하신 페이지를 처리하는 도중 예기치 못한 에러가 발생했습니다.</p>
            <p>최대한 빠른 시간안에 문제를 해결하도록 최선을 다하겠습니다.</p>
		</div>
		<div class="moveBtn">
			<button onclick="history.back()">이전 페이지</button>
			<button onclick="location.href='Home.do'">홈으로 이동</button>
		</div>
	</div>
</body>
</html>