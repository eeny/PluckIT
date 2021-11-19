<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자메뉴 - 인사관리</title>
<!-- CSS 파일 -->
<link rel="stylesheet" href="resources/css/admin_mngEmp_print.css">
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

</head>

<body>
	<div id="wrap">
		<!--전체 페이지 감싸는 div-->
		<section class="main-right">
			<!--게시판 본문 시작-->
			<h1>
				<i class="far fa-file-alt"></i> ${employeeInfo.emp_name } ${employeeInfo.rankName }의 입사 정보
			</h1>

			<table class="empListTable">
				<caption>[기본정보]</caption>
				<colgroup>
					<!--테이블 컬럼 너비 조절하는 태그-->
					<col width="16%" />
					<col width="21%" />
					<col width="21%" />
					<col width="21%" />
					<col width="21%" />
				</colgroup>

				<tr>
					<td rowspan="4">
						<div class="empPhoto">
							<img src="resources/upload/${employeeInfo.emp_photo }" alt="emplyee" id="ePhotoImg">
						</div>
					</td>
					<th>사원번호</th>
					<td>${employeeInfo.emp_num }</td>
					<th>입사일자</th>
					<td class="calendarTd">${employeeInfo.emp_hire }</td>
				</tr>

				<tr>
					<th>성명</th>
					<td>${employeeInfo.emp_name }</td>
					<th>영문성명</th>
					<td>${employeeInfo.emp_ename }</td>
				</tr>

				<tr>
					<th>부서</th>
					<td>${employeeInfo.deptName }</td>
					<th>직위</th>
					<td>${employeeInfo.rankName }</td>
				</tr>

				<tr>
					<th>성별</th>
					<td>
					<c:choose>
						<c:when test="${employeeInfo.emp_gender == 'm' }">
							남성
						</c:when>
						<c:when test="${employeeInfo.emp_gender == 'f' }">
							여성
						</c:when>
						<c:otherwise> </c:otherwise>
					</c:choose>
					</td>
					<th>생년월일</th>
					<td>${employeeInfo.emp_birth }</td>
				</tr>
			</table>

			<table class="empListTable">
				<caption>[상세정보]</caption>
				<colgroup>
					<!--테이블 컬럼 너비 조절하는 태그-->
					<col width="21%" />
					<col width="29%" />
					<col width="21%" />
					<col width="29%" />
				</colgroup>
				<tr>
					<th>연락처</th>
					<td>${employeeInfo.emp_tel }</td>
					<th>이메일</th>
					<td>${employeeInfo.emp_email }</td>
				</tr>

				<tr>
					<th>우편번호</th>
					<td colspan="3" class="addrspost">${employeeInfo.emp_postcode }</td>
				</tr>

				<tr>
					<th>주소</th>
					<td colspan="3">${employeeInfo.emp_addr }</td>
				</tr>

				<tr>
					<th>상세주소</th>
					<td colspan="3" class="addrsetc">${employeeInfo.emp_detailaddr } ${employeeInfo.emp_extraaddr }</td>
				</tr>

				<tr>
					<th>재직상태</th>
					<td>${employeeInfo.emp_status }</td>
					<th>퇴사일자</th>
					<td class="calendarTd">${employeeInfo.emp_quit }</td>
				</tr>
			</table>

			<h4>[추가사항]</h4>
			<div class="moreDetails">
				<textarea name="emp_remarks" id="empRemarks">${employeeInfo.emp_remarks }</textarea>
			</div>

		</section>
		<!--게시판 본문 끝-->
	</div>
	<!-- 메인 페이지 끝 -->
	</main>

	</div>


	<script>
		// 사원 정보 인쇄하기
		window.onload = function print() {
			window.print();
		}
	</script>
</body>

</html>