<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<!-- CSS 파일 -->
<link rel="stylesheet" href="resources/css/signup.css">
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
<!-- Air datepicker css -->
<script src="resources/js/datepicker/js/datepicker.js"></script>
<!-- Air datepicker js -->
<script src="resources/js/datepicker/js/datepicker.ko.js"></script>
<!-- 달력 한글 추가를 위해 커스텀 -->
<!-- toastr -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<body>
	<div id="wrap">
		<div class="signupBox">
			<form action="SignupProc.do" method="post" name="signupForm">
				<p>Sign Up</p>
				<!-- 정보 입력 table -->
				<table>
					<tr>
						<th>소속</th>
						<td>
							<select name="dept_id" id="dept">
								<option value="100">인사</option>
								<option value="200">영업</option>
								<option value="300">마케팅</option>
								<option value="400">총무회계</option>
								<option value="500">기술지원</option>
								<option value="600">전략기획</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>직급</th>
						<td>
							<select name="rank_id" id="rank">
								<option value="8">사장</option>
								<option value="7">전무</option>
								<option value="6">이사</option>
								<option value="5">부장</option>
								<option value="4">차장</option>
								<option value="3">과장</option>
								<option value="2">대리</option>
								<option value="1" selected>사원</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td class="birthTd">
							<input type="text" name="emp_birth" id="datepicker" placeholder="YYYY-MM-DD" readonly="readonly">
							<i class="far fa-calendar-alt"></i>
						</td>
					</tr>
					<tr>
						<th>사원명</th>
						<td>
							<input type="text" name="emp_name" id="empName">
						</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td>
							<input type="password" name="emp_pw" id="empPw" placeholder="영문대소문자/숫자/특수문자 포함, 8자 이상">
						</td>
					</tr>
					<tr>
						<th>비밀번호 확인</th>
						<td>
							<input type="password" id="empPwChk">
						</td>
					</tr>
				</table>

				<input type="button" class="submit" value="가입하기" onclick="signup()">

				<div class="login">
					이미 계정이 있으신가요?
					<a href="Login.do">로그인</a>
				</div>
			</form>
		</div>
	</div>

	<script type="text/javascript">
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
			"timeOut" : "5000",
			"extendedTimeOut" : "1000",
			"showEasing" : "swing",
			"hideEasing" : "linear",
			"showMethod" : "fadeIn",
			"hideMethod" : "fadeOut"
		}

		// Datepicker 설정	
		$("#datepicker").datepicker({
			language : 'ko',
			maxDate: new Date('1999-12-31')
		});

		// 회원가입폼 유효성 검사 후 submit
		function signup() {
			var signupForm = document.signupForm;

			var dept = document.getElementById("dept").value;
			var rank = document.getElementById("rank").value;
			var birth = document.getElementById("datepicker").value;
			var empName = document.getElementById("empName").value;
			var empPw = document.getElementById("empPw").value;
			var empPwChk = document.getElementById("empPwChk").value;

			var reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;

			if (birth.length <= 0) {
				toastr.warning("생년월일을 입력해주세요");
				return false;
			} else if (empName.trim().length <= 0
					|| empName.search(/\s/) !== -1) {
				toastr.warning("이름을 입력해주세요");
				return false;
			} else if (reg.test(empPw) === false) {
				toastr.warning("비밀번호는 영문대소문자/숫자/특수문자포함 8자리이상입니다");
				return false;
			} else if (empPwChk != empPw) {
				toastr.warning("비밀번호가 일치하지 않습니다");
				return false;
			}

			signupForm.submit();
		}
	</script>
</body>
</html>