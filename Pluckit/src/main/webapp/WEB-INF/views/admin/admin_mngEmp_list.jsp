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
<link rel="stylesheet" href="resources/css/admin_mngEmp_list.css">
<!-- include -->
<jsp:include page="../include/header.jsp"/>

			<div class="main-section">
				<!-- 메인 페이지 시작 -->
				<section class="main-left">
					<!--왼쪽 세부 메뉴 시작-->
					<ul class="paymentmenu">
						<li>
							<a href="Admin.do"">게시판관리</a>
						</li>
						<li>
							<a class="clickBtn">
								인사관리<i class="fas fa-angle-down"></i>
							</a>
							<ul class="submenu">
								<li>
									<a href="HumanResources.do" class="clickMenu">
										<i class="fas fa-angle-right"></i> 사원목록
									</a>
								</li>
								<li>
									<a href="InsertEmpInfo.do">
										<i class="fas fa-angle-right"></i> 입사처리
									</a>
								</li>
							</ul>
						</li>
						<li>
							<a href="#">회사정보관리</a>
						</li>
					</ul>
				</section>
				<!--왼쪽 세부 메뉴 끝-->

				<div></div>
				<!--왼쪽 세부 메뉴 가짜 공간-->

				<section class="main-right">
					<!--게시판 본문 시작-->
					<h1>
						<i class="far fa-file-alt"></i> 인사 관리 <i class="fas fa-angle-right"></i> 사원 목록
					</h1>

					<!--검색 box 추가-->
					<form action="SearchEmployeeList.do" method="get">
						<table class="search-box">
							<tr>
								<td>
									<select name="select" class="select-kind">
										<option value="e.emp_num">사번</option>
										<option value="e.emp_name">성명</option>
										<option value="r.rank_name">직위</option>
										<option value="d.dept_name">소속</option>
										<option value="e.emp_auth">접근권한</option>
										<option value="e.emp_status">재직상태</option>
									</select>
									<input type="text" name="search" placeholder="검색어를 입력하세요">
									<button type="submit">
										<i class="fas fa-search"></i>
									</button>
								</td>
							</tr>
						</table>
					</form>

					<table class="empListTable">
						<colgroup>
							<!--테이블 컬럼 너비 조절하는 태그-->
							<col width="5%" />
							<col width="15%" />
							<col width="10%" />
							<col width="11%" />
							<col width="11%" />
							<col width="11%" />
							<col width="11%" />
							<col width="11%" />
							<col width="15%" />
						</colgroup>

						<tr>
							<th>No.</th>
							<th>사번</th>
							<th>성명</th>
							<th>직위</th>
							<th>소속</th>
							<th>입사일</th>
							<th>접근권한</th>
							<th>재직상태</th>
							<th>비고</th>
						</tr>

						<c:forEach var="edto" items="${empList }" varStatus="vs">
							<tr>
								<td>${paging.totalCount - ((paging.pageNum - 1) * paging.pageSize + vs.index) }</td>
								<td>
									<a class="empNumber" onclick="getEmployeeInfo(${edto.emp_id})">${edto.emp_num }</a>
								</td>
								<td>
									<a class="empNumber" onclick="getEmployeeInfo(${edto.emp_id})">${edto.emp_name }</a>
								</td>
								<td>${edto.rankName }</td>
								<td>${edto.deptName }</td>
								<td>${edto.emp_hire }</td>
								<td>
									<select name="emp_auth" id="eAuth${edto.emp_id}">
										<option value="0" <c:if test="${edto.emp_auth eq 0 }">selected</c:if>>권한없음</option>
										<option value="1" <c:if test="${edto.emp_auth eq 1 }">selected</c:if>>사원</option>
										<option value="2" <c:if test="${edto.emp_auth eq 2 }">selected</c:if>>부서장</option>
										<option value="3" <c:if test="${edto.emp_auth eq 3 }">selected</c:if>>임원</option>
										<option value="4" <c:if test="${edto.emp_auth eq 4 }">selected</c:if>>협력업체</option>
										<option value="5" <c:if test="${edto.emp_auth eq 5 }">selected</c:if>>관리자</option>
									</select>
								</td>
								<td>
									<select name="emp_status" id="eStatus${edto.emp_id}">
										<option value="재직" <c:if test="${edto.emp_status eq '재직' }">selected</c:if>>재직</option>
										<option value="휴직" <c:if test="${edto.emp_status eq '휴직' }">selected</c:if>>휴직</option>
										<option value="퇴사" <c:if test="${edto.emp_status eq '퇴사' }">selected</c:if>>퇴사</option>
									</select>
								</td>
								<td>
									<button class="mod" onclick="modAuthNStatus(${edto.emp_id})">수정</button>
									&nbsp;&nbsp;
									<button class="del" onclick="DelConfirm('삭제하면 복구할 수 없습니다.<br>삭제하시겠습니까?', ${edto.emp_id})">삭제</button>
								</td>
							</tr>
						</c:forEach>
					</table>

					<div class="paging">
						<!--페이징 시작-->
						<c:if test="${paging.pageNum > 1 }">
							<span><a href="HumanResources.do?pageNum=1">
									<i class="fas fa-angle-double-left"></i>
								</a></span>
							<span><a href="HumanResources.do?pageNum=${paging.pageNum-1 }">
									<i class="fas fa-angle-left"></i>
								</a></span>
						</c:if>
						<c:forEach var="i" begin="${paging. startPage}" end="${paging.endPage }" step="1">
							<c:if test="${paging.pageNum eq i }">
								<span class="nowPage"><a href="HumanResources.do?pageNum=${i }" class="nowPage">${i }</a></span>
							</c:if>
							<c:if test="${paging.pageNum ne i }">
								<span><a href="HumanResources.do?pageNum=${i }">${i }</a></span>
							</c:if>
						</c:forEach>
						<c:if test="${paging.pageNum < paging.totalPage }">
							<span><a href="HumanResources.do?pageNum=${paging.pageNum+1 }">
									<i class="fas fa-angle-right"></i>
								</a></span>
							<span><a href="HumanResources.do?pageNum=${paging.totalPage }">
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

		<!-- 모달창 시작 -->
		<div class="pop">
			<h1>
				<i class="far fa-file-alt"></i> 사원 조회
			</h1>

			<form action="#" name="modForm">
				<table class="popEmpTable">
					<colgroup>
						<!--테이블 컬럼 너비 조절하는 태그-->
						<col width="24%" />
						<col width="15%" />
						<col width="23%" />
						<col width="15%" />
						<col width="23%" />
					</colgroup>

					<tr>
						<td rowspan="6">
							<div class="empPhoto" id="empPhoto"></div>
						</td>
						<th>사번</th>
						<td id="empNum"></td>
						<th>입사일자</th>
						<td id="empHire"></td>
					</tr>
					<tr>
						<th>성명</th>
						<td id="empName"></td>
						<th>영문성명</th>
						<td id="empEname"></td>
					</tr>
					<tr>
						<th>부서</th>
						<td id="empDept"></td>
						<th>직위</th>
						<td id="empRank"></td>
					</tr>
					<tr>
						<th>성별</th>
						<td id="empGender"></td>
						<th>생년월일</th>
						<td id="empBirth"></td>
					</tr>
					<tr>
						<th>연락처</th>
						<td id="empTel"></td>
						<th>이메일</th>
						<td id="empEmail"></td>
					</tr>
					<tr>
						<th>주소</th>
						<td colspan="3" id="empAddr"></td>
					</tr>

				</table>
				<div class="buttons">
					<a href="ModifyEmployeeAllInfo.do" id="modBtn">정보수정</a>
					<input type="reset" class="closePop" value="취소">
				</div>
			</form>
		</div>

		<div id="layer"></div>
		<!-- 모달 배경 레이어 -->
		<!-- 모달창 끝 -->
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

		$(function() {
			// 모달창 사라지기
			$("#layer").click(function() {
				$(".pop").css("display", "none");
				$("#layer").fadeOut(100);
			});

			$(".closePop").click(function() {
				$(".pop").css("display", "none");
				$("#layer").fadeOut(100);
			});

			// 왼쪽 세부메뉴 토글 (클릭하면 나타나거나 사라지기)
			$(".paymentmenu>li:nth-child(2)").click(
					function() {
						$(".submenu").slideToggle();
						if ($(".paymentmenu>li:nth-child(2)>a i").hasClass(
								"fa-angle-down")) {
							$(".paymentmenu>li:nth-child(2)>a i").removeClass(
									"fa-angle-down").addClass("fa-angle-up");
						} else {
							$(".paymentmenu>li:nth-child(2)>a i").removeClass(
									"fa-angle-up").addClass("fa-angle-down");
						}
					});
		});
		
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

		var delConfirm = function(msg, title, param) {
			swal(
					{
						title : title,
						text : "<span style='font-size:25px;font-weight:600;color:#575757;'>"
								+ msg + "</span>",
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
							// 사원 삭제하기
							var empId = {emp_id : param}
							
							$.ajax({
								type: "post",
								url: "DeleteEmployee.do",
								data: JSON.stringify(empId),
								contentType : "application/json; charset=utf-8",
								dataType : "json",
								success: function(data) {
									if (data.result > 0 ) {
										window.location.reload();
									} else {
										toastr.warning("사원 정보를 삭제할 수 없습니다");
									}
								},
								error: function(data) {
									alert("시스템 에러 발생!");
								}
							});
						}
					});
		}

		function Alert(msg) {
			alert(msg, 'success');
		}
		function Confirm(msg) {
			confirm('', msg);
		}
		function DelConfirm(msg, eCode) {
			delConfirm(msg, '', eCode);
		}
		
		// 모달창 나타나기 & 팝업창 데이터 가져오기
		function getEmployeeInfo(eId) {
			$("#layer").fadeIn(300, function() {
				$(".pop").fadeIn(200);
			});
			
			var empId = {
					emp_id : eId
			}
			
			// 정보수정 버튼 클릭시 이동하는 주소 변경
			$("#modBtn").attr("href", "ModifyEmployeeAllInfo.do?empId=" + eId);

			$.ajax({
				type : "post",
				url : "GetEmployeeInfo.do",
				data : JSON.stringify(empId),
				contentType : "application/json; charset=utf-8",
				dataType : "json",
				success : function(data) {
					// 증명사진 없을 때 기본 그림으로 엑박 처리
					var ePhoto = data.emp_photo;
					if (ePhoto == null) {
						ePhoto = "img/empPhoto.png";
					} else {
						ePhoto = "upload/" + data.emp_photo;
					}
					
					// 성별 구별하기
					var eGender = data.emp_gender;
					if (eGender == 'm') {
						$("#empGender").text("남성");
					} else if (eGender == 'f') {
						$("#empGender").text("여성");
					}
					
					// 주소 관련 변수
					var ePost = data.emp_postcode;
					var eAddr = data.emp_addr;
					var eDAddr = data.emp_detailaddr;
					var eEAddr = data.emp_extraaddr;
					
					$("#empPhoto").html("<img src='resources/" + ePhoto + "'>");
					$("#empNum").text(data.emp_num);
					$("#empHire").text(data.emp_hire);
					$("#empName").text(data.emp_name);
					$("#empEname").text(data.emp_ename);
					$("#empDept").text(data.deptName);
					$("#empRank").text(data.rankName);
					$("#empBirth").text(data.emp_birth);
					$("#empTel").text(data.emp_tel);
					$("#empEmail").text(data.emp_email);
					$("#empAddr").text("(" + ePost + ") " + eAddr + " " + eDAddr + eEAddr); 
					
					
				},
				error : function(data) {
					alert("시스템 에러 발생!");
				}
			}); 
		}
		
		// 사원 정보(접근권한, 재직상태) 수정하기
		function modAuthNStatus(eId) {
			var empInfo = {
					emp_auth : $("#eAuth" + eId).val(),
					emp_status : $("#eStatus" + eId).val(),
					emp_id : eId
			}
			
			$.ajax({
				type : "post",
				url : "ModifyEmpAuthNStatusProc.do",
				data : JSON.stringify(empInfo),
				contentType : "application/json; charset=utf-8",
				dataType : "json",
				success : function(data) {
					if (data.result > 0 ) {
						if (!toastr.success("사원 정보가 수정되었습니다")) {
							window.location.reload();
						}
					} else {
						toastr.warning("사원 정보를 수정할 수 없습니다");
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