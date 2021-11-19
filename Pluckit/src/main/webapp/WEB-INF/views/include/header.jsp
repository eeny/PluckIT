<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- CKEditor -->
<script type="text/javascript" src="resources/js/ckeditor/ckeditor.js"></script>
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<!-- Google Font -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Lato:wght@900&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<!-- jQuery -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- Air Datepicker -->
<link href="resources/js/datepicker/css/datepicker.min.css" rel="stylesheet" type="text/css" media="all">
<script src="resources/js/datepicker/js/datepicker.js"></script>
<script src="resources/js/datepicker/js/datepicker.ko.js"></script>
<!-- toastr -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- Sweet Alert -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
<!-- 카카오 주소 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- FullCalendar -->
<link href='resources/js/fullcalendar/main.css' rel='stylesheet' />
<script src='resources/js/fullcalendar/main.js'></script>
<script src='resources/js/fullcalendar/locales/ko.js'></script>
<script src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.js"></script>
<script src="https://unpkg.com/tippy.js@6"></script>
</head>

<!-- FullCalendar 추가 CSS -->
<style>
th.fc-day-sun {
	color: white;
	background-color: #e53935;
}

th.fc-day-sat {
	color: white;
	background-color: #0288d1;
}

th.fc-day-mon, th.fc-day-tue, th.fc-day-wed, th.fc-day-thu, th.fc-day-fri
	{
	color: white;
	background-color: #8a959b;
}
</style>

<body>
	<div id="wrap">
		<!--전체 페이지 감싸는 div-->
		<nav>
			<!--사이드 바(gnbmenu) 시작-->
			<div class="gnb-align">
				<div class="logo">
					<a href="GroupWareMain.do">
						<img src="resources/img/logo_transparent.png" alt="사이드바_로고">
					</a>
				</div>
				<ul class="gnb-menu">
					<li>
						<a href="#">
							<i class="far fa-edit"></i> 전자결재
						</a>
					</li>
					<li>
						<a href="#">
							<i class="fas fa-cloud-download-alt"></i> 업무공유
						</a>
					</li>
					<li>
						<a href="Board.do?deptName=${empInfo.deptName }&empAuth=${empInfo.emp_auth }&pageName=notice">
							<i class="fas fa-table"></i> 게시판
						</a>
					</li>
					<li>
						<a href="Employee.do">
							<i class="far fa-building"></i> 오피스
						</a>
					</li>
					<li>
						<a href="#">
							<i class="far fa-id-badge"></i> 근태관리
						</a>
					</li>
					<li>
						<a href="#">
							<i class="fas fa-tasks"></i> 설문
						</a>
					</li>
					<li>
						<a href="GetSchedule.do">
							<i class="far fa-calendar-alt"></i> 일정관리
						</a>
					</li>
					<c:if test="${empInfo.emp_auth eq 5 }">
						<li>
							<a href="Admin.do">
								<i class="fas fa-cogs"></i> 관리자메뉴
							</a>
						</li>
					</c:if>
				</ul>
			</div>
		</nav>
		<!--사이드 바(gnbmenu) 끝-->

		<main>
			<div class="main-top">
				<!--상단 메뉴 시작-->
				<div class="user-name">
					<c:if test="${empInfo ne null }">
						<p>
							<i class="fas fa-user-circle"></i>&nbsp; ${empInfo.emp_name } ${empInfo.rankName }
						</p>
					</c:if>
					<c:if test="${empInfo eq null }">
						<p>
							<i class="fas fa-user-circle"></i>&nbsp;손님
						</p>
					</c:if>
				</div>

				<div class="main-top-icon">
					<div class="search">
						<form action="SearchProc.do" class="f">
							<input type="hidden" name="select" value="emp_name">
							<input type="search" placeholder="직원 검색" name="search">
							<button type="submit">
								<i class="fas fa-search"></i>
							</button>
						</form>
					</div>
					<i class="fas fa-bullhorn" title="공지사항" onclick="location.href='Board.do?deptName=${empInfo.deptName }&empAuth=${empInfo.emp_auth }&pageName=notice'"></i> <i class="fas fa-home" title="메인홈페이지" onclick="location.href='Home.do'"></i>
					<c:if test="${empInfo ne null }">
						<i class="fas fa-power-off" title="로그아웃" onclick="Confirm('로그아웃 하시겠습니까?')"></i>
					</c:if>
				</div>
			</div>
			<!--상단 메뉴 끝-->
    