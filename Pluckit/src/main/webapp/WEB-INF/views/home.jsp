<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PluckIT</title>
<!-- CSS 파일 -->
<link href="resources/css/home.css" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<!-- Google Font -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Lato:wght@900&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
</head>
<body>
	<div id="wrap">
		<header>
			<p>
				<c:if test="${empInfo eq null }">
					<a href="Login.do">Login</a>
				</c:if>
				<c:if test="${empInfo ne null }">
					<a href="GroupWareMain.do">GroupWare</a>&nbsp;&nbsp;&nbsp;
					<a href="LogoutProc.do">Logout</a>
				</c:if>
			</p>
		</header>
		<nav>
			<div class="logo">
				<div class="logo-img">
					<img src="resources/img/logo.png" alt="">
				</div>
				<div class="logo-title">
					<p>PluckIT</p>
				</div>
			</div>
			<ul class="nav-ul">
				<li>
					<a href="#">회사소개</a>
				</li>
				<li>
					<a href="#">사업분야</a>
				</li>
				<li>
					<a href="#">프로젝트</a>
				</li>
				<li>
					<a href="#">고객문의</a>
				</li>
				<li>
					<a href="#">인재채용</a>
				</li>
			</ul>
		</nav>
		<section class="sec-main">
			<article class="bg-img">
				<blockquote>
					<p>
						더 나은<br>&nbsp;&nbsp;&nbsp;내일을 위해<br>&nbsp;&nbsp;&nbsp;우리는 나아갑니다.
					</p>
				</blockquote>
			</article>
		</section>
		<section class="sec-icons">
			<article>
				<div class="icon-wrap">
					<div class="icon-img">
						<img src="resources/img/sec-icons1.png" alt="">
					</div>
					<p>
						Business<br>With PluckIT
					</p>
					<p>
						지속가능한 가치를<br>함께 만드는 PluckIT
					</p>
				</div>
			</article>
			<article>
				<div class="icon-wrap">
					<div class="icon-img">
						<img src="resources/img/sec-icons2.png" alt="">
					</div>
					<p>
						Society<br>With PluckIT
					</p>
					<p>
						사회에 공헌하는 인재를<br>함께 만드는 PluckIT
					</p>
				</div>
			</article>
			<article>
				<div class="icon-wrap">
					<div class="icon-img">
						<img src="resources/img/sec-icons3.png" alt="">
					</div>
					<p>
						People<br>With PluckIT
					</p>
					<p>
						고객과 파트너의 신뢰를<br>함께 만드는 PluckIT
					</p>
				</div>
			</article>
		</section>
		<section class="sec-imgs">
			<article>
				<div class="imgs-img">
					<img src="resources/img/sec-imgs1.jpg" alt="">
				</div>
			</article>
			<article>
				<div class="imgs-contents">
					<h3>고객 맞춤 서비스</h3>
					<p>
						다양한 시장 경험을 토대로 고객고유의 환경에 대한<br> 단 하나의 카운셀링 서비스를 제공합니다.<br> PluckIT의 궁극적인 목적은 원활한 서비스의 유지입니다.<br> 진단부터 장애대응, 운영/관리까지<br> PluckIT이 One-Stop으로 케어합니다.
					</p>
					<a href="#">더 알아보기</a>
				</div>
			</article>
			<article>
				<div class="imgs-contents">
					<h3>사람과 환경</h3>
					<p>
						PluckIT은 환경과 사람을 생각하는 기술로<br> 끊임없는 기술개발을 통해 안전하고 깨끗한 환경을 만듭니다.<br> 고객님들의 환경이 곧 건강이라는 생각으로<br> 차근차근 세상을 바꿔갑니다.
					</p>
					<a href="#">더 알아보기</a>
				</div>
			</article>
			<article>
				<div class="imgs-img">
					<img src="resources/img/sec-imgs2.jpg" alt="">
				</div>
			</article>
		</section>
		<section class="sec-info">
			<ul class="info-ul">
				<li>
					<a href="#">회사소개</a>
				</li>
				<li>
					<a href="#">오시는길</a>
				</li>
				<li>
					<a href="#">이용약관</a>
				</li>
				<li>
					<a href="#">개인정보처리방침</a>
				</li>
				<li>
					<a href="#">
						<i class="fab fa-instagram"></i>
					</a>
					&nbsp;&nbsp;
					<a href="#">
						<i class="fab fa-twitter-square"></i>
					</a>
					&nbsp;&nbsp;
					<a href="#">
						<i class="fab fa-facebook-square"></i>
					</a>
				</li>
			</ul>
		</section>
		<footer>
			<p>(주)PluckIT 부산광역시 부산진구 중앙대로 749 스카이빌딩 4층 (45050) Tel.051-912-1000</p>
			<p>
				<i class="far fa-copyright"></i> 2021 All rights reserverd.
			</p>
		</footer>
	</div>
</body>
</html>