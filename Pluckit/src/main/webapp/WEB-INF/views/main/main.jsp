<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>PluckIT 그룹웨어</title>
<!-- CSS 파일 -->
<link rel="stylesheet" href="resources/css/main.css">
<!-- include -->
<jsp:include page="../include/header.jsp"/>

			<div class="main-section">
				<!-- 메인 페이지 시작 -->
				<section class="section-left">
					<div class="myPage">
						<!-- 마이페이지 시작 -->
						<div class="myPhoto">
							<c:if test="${empInfo.emp_photo eq null || empInfo.emp_photo eq '' }">
								<img src="resources/img/main_user.png" alt="">
							</c:if>
							<c:if test="${empInfo.emp_photo ne null }">
								<img src="resources/upload/${empInfo.emp_photo }" alt="">								
							</c:if>
						</div>
						<div class="myInfo">
							<p>
								${empInfo.deptName }팀 <b>${empInfo.emp_name }</b> ${empInfo.rankName }
							</p>
							<p class="empNum">
								<span>사원번호</span> ${empInfo.emp_num }
							</p>
							<p class="empAuth">
								<span>권한</span> ${empInfo.emp_auth }
							</p>
						</div>
						<div class="tabBox">
							<div class="tabbtn1 tab">근태정보</div>
							<div class="tabbtn2">휴가정보</div>
						</div>
						<!--근태정보 메뉴 시작-->
						<div class="clock tab1">
							<p class="clockDate tab1"></p>
							<p class="clockTime tab1">
								<span class="ctHour"></span> :<span class="ctMinute"></span> :<span class="ctSecond"></span>
							</p>
						</div>
						<div class="commute tab1">
							<h5>출·퇴근시간</h5>
							<div>
								<a onclick="setTime('go')">출근</a>
								<p class="goToWork"></p>
								<a onclick="setTime('off')">퇴근</a>
								<p class="offWork"></p>
							</div>
						</div>
						<div class="condition tab1">
							<select name="" id="">
								<option hidden="" disabled="disabled" selected="selected" value="">근무상태변경</option>
								<option value="">근무중</option>
								<option value="">휴식</option>
								<option value="">외근</option>
								<option value="">휴가</option>
								<option value="">출장</option>
							</select>
						</div>
						<!--근태정보 메뉴 끝-->

						<!--휴가정보 메뉴 시작-->
						<div class="vacation tab2">
							<h5>내 휴가 정보</h5>
							<div>
								<b>입사일</b><span>2021-11-11</span>
							</div>
							<div>
								<b>연차휴가</b><span>18일 0시간</span>
							</div>
							<div>
								<b>사용연차</b><span>6일 6시간</span>
							</div>
							<div>
								<b>휴가 잔여일</b><span>11일 2시간</span>
							</div>
						</div>
						<!--휴가정보 메뉴 끝-->
					</div>
					<!-- 마이페이지 끝 -->
					<div class="btn-G">
						<!--바로가기 메뉴 시작-->
						<div class="gButtons">
							<a class="g1">전자결재</a>
							<a class="g2">업무공유</a>
							<a class="g3">설문등록</a>
							<a class="g4">일정등록</a>
						</div>
						<div class="gCounts">
							<p>
								<span></span> 전자결재
								<a href="">1</a>건
							</p>
							<p>
								<span></span> 업무공유
								<a href="">0</a>건
							</p>
							<p>
								<span></span> 설문
								<a href="">3</a>건
							</p>
							<p>
								<span></span> 일정
								<a href="">7</a>건
							</p>
						</div>
					</div>
					<!--바로가기 메뉴 끝-->
				</section>

				<section class="section-right">
					<div class="section-right-top">
						<div class="section-right-top-left">
							<!--업무공유 시작-->
							<div class="shareTitle">
								<h3>업무공유</h3>
								<i class="fas fa-plus-circle"></i>
							</div>
							<table class="shareTbl">
								<tr>
									<th>제목</th>
									<th>발신인</th>
									<th>등록일</th>
								</tr>
								<tr class="noData">
									<td colspan="3">
										<i class="fas fa-exclamation-circle"></i> 등록된 게시물이 없습니다.
									</td>
								</tr>
							</table>
						</div>
						<!--업무공유 끝-->
						<div class="section-right-top-right">
							<!--일정 시작-->
							<div class="eventsTitle">
								<h3>일정</h3>
								<i class="fas fa-plus-circle"></i>
							</div>
							<div class="events">
								<table class="calendarTbl" id="calendar">
									<colgroup>
										<!--테이블 컬럼 너비 조절하는 태그-->
										<col width="14%" />
										<col width="14%" />
										<col width="14%" />
										<col width="14%" />
										<col width="14%" />
										<col width="14%" />
										<col width="14%" />
									</colgroup>
									<thead>
										<tr>
											<th><button name="preMon">
													<i class="fas fa-angle-left"></i>
												</button></th>
											<th colspan="5" class="year_mon"></th>
											<th><button name="nextMon">
													<i class="fas fa-angle-right"></i>
												</button></th>
										</tr>
										<tr class="days">
											<th>일</th>
											<th>월</th>
											<th>화</th>
											<th>수</th>
											<th>목</th>
											<th>금</th>
											<th>토</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
						</div>
						<!--일정 끝-->
					</div>

					<div class="section-right-bottom">
						<!--전사공지 시작-->
						<div class="boardTitle">
							<h3>전사 공지</h3>
							<i class="fas fa-plus-circle"></i>
						</div>
						<table class="boardTbl">
							<colgroup>
								<!--테이블 컬럼 너비 조절하는 태그-->
								<col width="10%" />
								<col width="40%" />
								<col width="25%" />
								<col width="25%" />
							</colgroup>
							<thead>
								<tr>
									<th>No.</th>
									<th>제목</th>
									<th>작성자</th>
									<th>등록일자</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${boardList eq null }">
									<tr class="noDataBoard">
										<td colspan="3">
											<i class="fas fa-exclamation-circle"></i> 등록된 게시물이 없습니다.
										</td>
									</tr>
								</c:if>
								<c:if test="${boardList ne null }">
									<c:forEach var="list" items="${boardList }" varStatus="">
										<tr>
											<td>
												<img src="resources/img/megaphone.png" alt="">
											</td>
											<td><a href="ReadPost.do?deptName=${empInfo.deptName }&empAuth=${empInfo.emp_auth }&pageName=notice&bmNum=${list.bm_num}">${list.bm_title }</a></td>
											<td>${list.bm_writer }</td>
											<td>${fn:substring(list.bm_regdate, 0, 10) }</td>
										</tr>										
									</c:forEach>
								</c:if>
							</tbody>
						</table>
					</div>
					<!--전사공지 끝-->
				</section>
			</div>
			<!-- 메인 페이지 끝 -->
		</main>
	</div>

	<script>
        // Sweet Alert 설정
        var alert = function (msg, type) {
            swal({
                title: '',
                text: msg,
                type: type,
                timer: 1500,
                customClass: 'sweet-size',
                showConfirmButton: false
            });
        }

        var confirm = function (msg, title, resvNum) {
            swal({
                title: title,
                text: msg,
                type: "warning",
                showCancelButton: true,
                confirmButtonClass: "btn-danger",
                confirmButtonText: "예",
                cancelButtonText: "아니오",
                closeOnConfirm: false,
                closeOnCancel: true
            }, function (isConfirm) {
                if (isConfirm) {
                    //swal('', '로그아웃 하셨습니다', "success");
                    location.href = "LogoutProc.do";
                }
            });
        }

        function Alert(msg) {
            alert(msg, 'success');
        }
        function Confirm(msg) {
            confirm('', msg);
        }

        // 근태정보, 휴가정보 탭메뉴 클릭시 나타나는 화면 변경
        $(function () {
            $(".tabbtn1").click(function () {
                $(".tabbtn1").addClass("tab");
                $(".tabbtn2").removeClass("tab");
                $(".tab2").css("display", "none");
                $(".tab1").css("display", "block");
                $(".clock").css("display", "inline-table");
                $(".clockDate").css("display", "inline-block");
                $(".clockTime").css("display", "inline-block");
            });

            $(".tabbtn2").click(function () {
                $(".tabbtn2").addClass("tab");
                $(".tabbtn1").removeClass("tab");
                $(".tab1").css("display", "none");
                $(".tab2").css("display", "block");
            });

            // 일정관리 달력
            var today = new Date();
            var date = new Date();

            $("button[name=preMon]").click(function () { // 이전달
                $("#calendar > tbody > td").remove();
                $("#calendar > tbody > tr").remove();
                today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
                buildCalendar();
            })

            $("button[name=nextMon]").click(function () { //다음달
                $("#calendar > tbody > td").remove();
                $("#calendar > tbody > tr").remove();
                today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
                buildCalendar();
            })

            function buildCalendar() {
                nowYear = today.getFullYear();
                nowMonth = today.getMonth();
                firstDate = new Date(nowYear, nowMonth, 1).getDate();
                firstDay = new Date(nowYear, nowMonth, 1).getDay(); //1st의 요일
                lastDate = new Date(nowYear, nowMonth + 1, 0).getDate();

                if ((nowYear % 4 === 0 && nowYear % 100 !== 0) || nowYear % 400 === 0) { //윤년 적용
                    lastDate[1] = 29;
                }

                $(".year_mon").text(nowYear + "년 " + (nowMonth + 1) + "월");

                for (i = 0; i < firstDay; i++) { //첫번째 줄 빈칸
                    $("#calendar tbody:last").append("<td></td>");
                }
                for (i = 1; i <= lastDate; i++) { // 날짜 채우기
                    plusDate = new Date(nowYear, nowMonth, i).getDay();
                    if (plusDate == 0) {
                        $("#calendar tbody:last").append("<tr></tr>");
                    }
                    $("#calendar tbody:last").append("<td class='date'>" + i + "</td>");
                }
                if ($("#calendar > tbody > td").length % 7 != 0) { //마지막 줄 빈칸
                    for (i = 1; i <= $("#calendar > tbody > td").length % 7; i++) {
                        $("#calendar tbody:last").append("<td></td>");
                    }
                }
                $(".date").each(function (index) { // 오늘 날짜 표시
                    if (nowYear == date.getFullYear() && nowMonth == date.getMonth() && $(".date").eq(index).text() == date.getDate()) {
                        $(".date").eq(index).addClass('colToday');
                    }
                })
            }
            buildCalendar();
        });

        
        function Clock() {        
            // 날짜, 시계 만들기
            var date = new Date();
            var YYYY = String(date.getFullYear());
            var MM = String(date.getMonth() + 1);
            var DD = Zero(date.getDate());
            var hh = Zero(date.getHours());
            var mm = Zero(date.getMinutes());
            var ss = Zero(date.getSeconds());
            var Week = Weekday();
            
            //시계에 1의자리수가 나올때 0을 넣어주는 함수 (ex : 1초 -> 01초)
            function Zero(num) {
                return (num < 10 ? '0' + num : '' + num);
            }

            //요일을 추가해주는 함수
            function Weekday() {
                var Week = ['일', '월', '화', '수', '목', '금', '토'];
                var Weekday = date.getDay();
                return Week[Weekday];
            }
            
            //시계부분을 써주는 함수
            function Write(YYYY, MM, DD, hh, mm, ss, Week) {
                $(".clockDate").text(YYYY + "-" + MM + "-" + DD + " (" + Week + ")");
                $(".ctHour").text(hh);
                $(".ctMinute").text(mm);
                $(".ctSecond").text(ss);
            }
            
            Write(YYYY, MM, DD, hh, mm, ss, Week);
        }

        setInterval(Clock, 1000); //1초(1000)마다 Clock함수를 재실행 한다

        // 출퇴근시간 클릭시 시간띄우기
        function setTime(e) {
            var date = new Date();
            var hh = Zero(date.getHours());
            var mm = Zero(date.getMinutes());
            var ss = Zero(date.getSeconds());
            
            function Zero(num) {
                return (num < 10 ? '0' + num : '' + num);
            }

            if (e == 'go') {
                $(".goToWork").text(hh + ":" + mm + ":" + ss);
            }

            if (e == 'off') {
                $(".offWork").text(hh + ":" + mm + ":" + ss);
            }
        }
    </script>
</body>
</html>