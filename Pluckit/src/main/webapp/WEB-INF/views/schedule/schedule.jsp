<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>일정관리</title>
<!-- CSS 파일 -->
<link rel="stylesheet" href="resources/css/schedule.css">
<!-- include -->
<jsp:include page="../include/header.jsp"/>

			<div class="main-section">
				<!-- 메인 페이지 시작 -->

				<section class="main-right">
					<!--게시판 본문 시작-->
					<h1>
						<i class="far fa-file-alt"></i> 일정관리
					</h1>

					<form name="scheduleForm">
						<table class="scheduleTable">
							<colgroup>
								<!--테이블 컬럼 너비 조절하는 태그-->
								<col width="10%" />
								<col width="10%" />
								<col width="10%" />
								<col width="10%" />
								<col width="10%" />
								<col width="10%" />
								<col width="10%" />
								<col width="30%" />
							</colgroup>

							<tr>
								<th>시작일</th>
								<td>
									<input type="date" name="sc_start" id="scStart" oninput="setEndMin()">
								</td>
								<th>시간</th>
								<td>
									<input type="time" name="sc_time" class="timer">
								</td>
								<th>종료일</th>
								<td>
									<input type="date" name="sc_end" id="scEnd">
								</td>
								<th>일정내용</th>
								<td>
									<input type="text" name="sc_title" id="scTitle">
								</td>
							</tr>
						</table>
						<div class="buttons">
							<a onclick="whatTime('${empInfo.emp_id }')">등록</a>
							<input type="reset" value="취소">
						</div>
					</form>

					<!-- FullCalendar 시작 -->
					<div class="cal-container">
						<div id="calendar"></div>
					</div>
					<!-- FullCalendar 끝 -->

				</section>
				<!--게시판 본문 끝-->
			</div>
			<!-- 메인 페이지 끝 -->
		</main>
	</div>


	<script>
		// toastr 설정
		toastr.options = {
			"closeButton" : false,
			"debug" : false,
			"newestOnTop" : false,
			"progressBar" : false,
			"positionClass" : "toast-top-right",
			"preventDuplicates" : false,
			"onclick" : null,
			"showDuration" : "300",
			"hideDuration" : "1000",
			"timeOut" : "1000",
			"extendedTimeOut" : "1000",
			"showEasing" : "swing",
			"hideEasing" : "linear",
			"showMethod" : "fadeIn",
			"hideMethod" : "fadeOut"
		}

		// Sweet Alert 설정
		var alert = function(msg, type) {
			swal({
				title : '',
				text : msg,
				type : type,
				timer : 1500,
				customClass : 'sweet-size',
				showConfirmButton : false
			});
		}

		var confirm = function(msg, title, resvNum) {
			swal({
				title : title,
				text : msg,
				type : "warning",
				showCancelButton : true,
				confirmButtonClass : "btn-danger",
				confirmButtonText : "예",
				cancelButtonText : "아니오",
				closeOnConfirm : false,
				closeOnCancel : true
			}, function(isConfirm) {
				if (isConfirm) {
					location.href = "LogoutProc.do";
				}
			});
		}

		var cancelConfirm = function(msg, title, param) {
			swal(
					{
						title : title,
						text : msg,
						html : true,
						type : "warning",
						showCancelButton : true,
						confirmButtonClass : "btn-danger",
						confirmButtonText : "예",
						cancelButtonText : "아니오",
						closeOnConfirm : false,
						closeOnCancel : true
					}, function(isConfirm) {
						if (isConfirm) {
							deleteEvent(param);
						}
					});
		}

		function Alert(msg) {
			alert(msg, 'success');
		}
		function Confirm(msg) {
			confirm('', msg);
		}
		function CancelConfirm(msg, param) {
			cancelConfirm('', msg, param);
		}

		// 페이지 로딩과 동시에 함수 호출하기
		$(function() {
			getEventsList();
		});

		// 일정 데이터 가져오기
		function getEventsList() {
			$.ajax({
				type : "post",
				url : "GetScheduleList.do",
				success : function(data) {
					// 색상목록
					var colorArr = [ 'DodgerBlue', 'BlueViolet', 'Coral',
							'Crimson', 'DeepPink', 'DarkTurquoise', 'Gold',
							'Chartreuse', 'HotPink', 'MediumBlue', 'OrangeRed',
							'RoyalBlue', 'Tomato', 'LawnGreen' ];

					var list = data;
					//console.log(list);

					var events = list.map(function(item) {
						return {
							id : item.sc_id,
							title : item.sc_title,
							start : item.sc_start,
							end : item.sc_end,
							color : colorArr[Math.floor(Math.random()
									* colorArr.length)],
							description: "등록자 : " + item.deptName + "부서 " + item.empName 
						}
					});

					getCalendar(events);

				},
				error : function(data) {
					alert("시스템 에러 발생!");
				}

			});
		}

		// fullcalendar 불러오기
		function getCalendar(events) {
			var calendarEl = document.getElementById('calendar');
			var calendar = new FullCalendar.Calendar(calendarEl, {
				initialView : 'dayGridMonth',
				headerToolbar : {
					left : 'prev,next today',
					center : 'title',
					right : 'dayGridMonth,timeGridWeek,timeGridDay'
				},
				locale : 'ko',
				dayMaxEvents : true,
				height : 930,
				editable : true,
				dayMaxEventRows : true,
				eventDidMount: function(info) {
		            tippy(info.el, {
		                content:  info.event.extendedProps.description,//이벤트 디스크립션을 툴팁으로 가져온다 
		            });
		        },
				events : events,
				eventTimeFormat : { // '14:30:00' 형태로 만들기
					hour : '2-digit',
					minute : '2-digit',
					hour12 : false
				},
				eventClick : function(info) {
					CancelConfirm("일정을 삭제하시겠습니까?", info);
				}
			});

			calendar.render();
		}

		// 종료일 input 최소값(시작일) 속성 변경
		function setEndMin() {
			var startdate = $("#scStart").val();
			$("#scEnd").attr("min", startdate);
		}

		// 일정 등록하기
		function whatTime(empId) {
			// 시작일 + 시간 형태 설정
			var startTime = $("#scStart").val();
			if ($(".timer").val() != "" && $(".timer").val() != null) {
				startTime = $("#scStart").val() + "T" + $(".timer").val()
						+ ":00";
			}

			var schInfo = {
				sc_title : $("#scTitle").val(),
				sc_start : startTime,
				sc_end : $("#scEnd").val(),
				emp_id : empId
			}

			if (startTime == "" || startTime == null) {
				toastr.warning("시작일을 입력해주세요");
				$("#scStart").focus();
				return false;

			} else if ($("#scTitle").val() == "" || $("#scTitle").val() == null) {
				toastr.warning("일정내용을 입력해주세요");
				$("#scTitle").focus();
				return false;

			} else {
				$.ajax({
					type : "post",
					url : "InsertSchedule.do",
					data : JSON.stringify(schInfo),
					contentType : "application/json; charset=utf-8",
					dataType : "json",
					success : function(data) {
						if (data.result > 0) {
							window.location.reload();
						} else {
							toastr.warning("일정을 추가할 수 없습니다");
						}
					},
					error : function(data) {
						alert("시스템 에러 발생!");
					}
				});
			}
		}
		
		// 일정 삭제하기
		function deleteEvent(info) {
			info.event.remove(); // 캘린더상에서 이벤트 삭제하기
			
			var schInfo = {sc_id : info.event.id}
			
			$.ajax({
				type : "post",
				url : "DeleteSchedule.do",
				data : JSON.stringify(schInfo),
				contentType : "application/json; charset=utf-8",
				dataType : "json",
				success : function(data) {
					if (data.result > 0) {
						window.location.reload();
					} else {
						toastr.warning("일정을 삭제할 수 없습니다");
					}
				},
				error : function(data) {
					alert("시스템 에러 발생!");
				}
			});
		}

		
	</script>
</body>

</html>