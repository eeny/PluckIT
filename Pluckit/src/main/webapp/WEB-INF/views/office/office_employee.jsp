<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<title>오피스 - 직원목록</title>
<!-- CSS 파일 -->
<link rel="stylesheet" href="resources/css/office_employee.css">
<!-- include -->
<jsp:include page="../include/header.jsp"/>

			<div class="main-section">
				<!-- 메인 페이지 시작 -->
				<section class="main-left">
					<!--왼쪽 세부 메뉴 시작-->
					<ul>
						<li>
							<a href="#">직원목록</a>
						</li>
						<li>
							<a href="#">거래처관리</a>
						</li>
						<li>
							<a href="#">주소록</a>
						</li>
					</ul>
				</section>
				<!--왼쪽 세부 메뉴 끝-->

				<div></div>
				<!--왼쪽 세부 메뉴 가짜 공간-->

				<section class="main-right">
					<!--게시판 본문 시작-->
					<h1>
						<i class="far fa-file-alt"></i> 직원목록
					</h1>

					<!--검색 box 추가-->

					<form action="SearchProc.do">
						<table class="search-box">
							<tr>
								<td>
									<select name="select" class="select-kind">
										<option value="emp_name">이름</option>
										<option value="emp_num">사번</option>
										<option value="dept_id">소속</option>
										<option value="rank_id">직위</option>
									</select>
									<input type="text" placeholder="검색어를 입력하세요" name="search">
									<button type="submit">
										<i class="fas fa-search"></i>
									</button>
								</td>
							</tr>
						</table>
					</form>

					<table class="noticeTable">
						<colgroup>
							<!--테이블 컬럼 너비 조절하는 태그-->
							<col width="15%" />
							<col width="15%" />
							<col width="20%" />
							<col width="20%" />
							<col width="15%" />
							<col width="15%" />
						</colgroup>

						<tr>
							<th>사번</th>
							<th>이름</th>
							<th>전화번호</th>
							<th>이메일</th>
							<th>소속</th>
							<th>직위</th>
						</tr>

						<c:forEach var="employee" items="${employeeList}">
							<tr>
								<td>${employee.emp_num}</td>
								<td>${employee.emp_name}</td>
								<td>${employee.emp_tel}</td>
								<td>${employee.emp_email}</td>
								<td>${employee.deptName}</td>
								<td>${employee.rankName}</td>
							</tr>
						</c:forEach>

					</table>

					<div class="paging">
						<!--페이징 시작-->
						<c:if test="${paging.pageNum > 1 }">
							<span><a href="Employee.do?pageNum=1">
									<i class="fas fa-angle-double-left"></i>
								</a></span>
							<span><a href="Employee.do?pageNum=${paging.pageNum-1 }">
									<i class="fas fa-angle-left"></i>
								</a></span>
						</c:if>
						<c:forEach var="i" begin="${paging. startPage}" end="${paging.endPage }" step="1">
							<c:if test="${paging.pageNum eq i }">
								<span class="nowPage"><a href="Employee.do?pageNum=${i }" class="nowPage">${i }</a></span>
							</c:if>
							<c:if test="${paging.pageNum ne i }">
								<span><a href="Employee.do?pageNum=${i }">${i }</a></span>
							</c:if>
						</c:forEach>
						<c:if test="${paging.pageNum < paging.totalPage }">
							<span><a href="Employee.do?pageNum=${paging.pageNum+1 }">
									<i class="fas fa-angle-right"></i>
								</a></span>
							<span><a href="Employee.do?pageNum=${paging.totalPage }">
									<i class="fas fa-angle-double-right"></i>
								</a></span>
						</c:if>
					</div>
					<!--페이징 끝-->

				</section>
				<!--게시판 본문 끝-->
			</div>
			<!-- 메인 페이지 끝 -->
		</main>
	</div>

	<script type="text/javascript">
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
	</script>
</body>

</html>