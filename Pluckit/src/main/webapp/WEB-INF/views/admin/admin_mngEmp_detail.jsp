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
<link rel="stylesheet" href="resources/css/admin_mngEmp_detail.css">
<!-- include -->
<jsp:include page="../include/header.jsp"/>

			<div class="main-section">
				<!-- 메인 페이지 시작 -->
				<section class="main-left">
					<!--왼쪽 세부 메뉴 시작-->
					<ul class="paymentmenu">
						<li>
							<a href="Admin.do">게시판관리</a>
						</li>
						<li>
							<a class="clickBtn">
								인사관리<i class="fas fa-angle-down"></i>
							</a>
							<ul class="submenu">
								<li>
									<a href="HumanResources.do" class="${pageTitle eq '사원 정보 수정' ? 'clickMenu' : '' }">
										<i class="fas fa-angle-right"></i> 사원목록
									</a>
								</li>
								<li>
									<a href="InsertEmpInfo.do" class="${pageTitle eq '입사처리' ? 'clickMenu' : '' }">
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
						<i class="far fa-file-alt"></i> 인사 관리 <i class="fas fa-angle-right"></i> ${pageTitle }
					</h1>

					<form name="empForm" method="post" enctype="multipart/form-data">
						<input type="hidden" name="emp_id" id="eId" value="${employeeInfo.emp_id }">
						
						<table class="empListTable">
							<colgroup>
								<!--테이블 컬럼 너비 조절하는 태그-->
								<col width="16%" />
								<col width="16%" />
								<col width="26%" />
								<col width="16%" />
								<col width="26%" />
							</colgroup>

							<tr>
								<td rowspan="9">
									<div class="empPhoto">
										<c:if test="${employeeInfo.emp_photo eq null }">
											<img src="resources/img/empPhoto.png" alt="emplyee" id="ePhotoImg">											
										</c:if>
										<c:if test="${employeeInfo.emp_photo ne null }">
											<img src="resources/upload/${employeeInfo.emp_photo }" alt="emplyee" id="ePhotoImg">
										</c:if>
									</div>
									<label for="ePhoto"><i class="fas fa-paperclip"></i> 사진 선택</label>
									<input type="file" name="emp_photo" id="ePhoto">
								</td>
								<th>사원번호</th>
								<td>
									<input type="text" name="emp_num" id="empNum" value="${employeeInfo.emp_num }" placeholder="사원번호는 자동생성 됩니다" readonly>
								</td>
								<th>입사일자</th>
								<td class="calendarTd">
									<input type="date" name="emp_hire" id="empHire" value="${employeeInfo.emp_hire }">
								</td>
							</tr>

							<tr>
								<th>성명</th>
								<td>
									<input type="text" name="emp_name" id="empName" value="${employeeInfo.emp_name }">
								</td>
								<th>영문성명</th>
								<td>
									<input type="text" name="emp_ename" id="empEname" value="${employeeInfo.emp_ename }">
								</td>
							</tr>

							<tr>
								<th>부서</th>
								<td>
									<select name="dept_id" id="deptId">
										<option value="100" <c:if test="${employeeInfo.dept_id eq '100' }">selected</c:if>>인사</option>
										<option value="200" <c:if test="${employeeInfo.dept_id eq '200' }">selected</c:if>>영업</option>
										<option value="300" <c:if test="${employeeInfo.dept_id eq '300' }">selected</c:if>>마케팅</option>
										<option value="400" <c:if test="${employeeInfo.dept_id eq '400' }">selected</c:if>>총무회계</option>
										<option value="500" <c:if test="${employeeInfo.dept_id eq '500' }">selected</c:if>>기술지원</option>
										<option value="600" <c:if test="${employeeInfo.dept_id eq '600' }">selected</c:if>>전략기획</option>
									</select>
								</td>
								<th>직위</th>
								<td>
									<select name="rank_id" id="rankId">
										<option value="1" <c:if test="${employeeInfo.rank_id eq '1' }">selected</c:if>>사원</option>
										<option value="2" <c:if test="${employeeInfo.rank_id eq '2' }">selected</c:if>>대리</option>
										<option value="3" <c:if test="${employeeInfo.rank_id eq '3' }">selected</c:if>>과장</option>
										<option value="4" <c:if test="${employeeInfo.rank_id eq '4' }">selected</c:if>>차장</option>
										<option value="5" <c:if test="${employeeInfo.rank_id eq '5' }">selected</c:if>>부장</option>
										<option value="6" <c:if test="${employeeInfo.rank_id eq '6' }">selected</c:if>>이사</option>
										<option value="7" <c:if test="${employeeInfo.rank_id eq '7' }">selected</c:if>>전무</option>
										<option value="8" <c:if test="${employeeInfo.rank_id eq '8' }">selected</c:if>>사장</option>
									</select>
								</td>
							</tr>

							<tr>
								<th>성별</th>
								<td>
									<select name="emp_gender" id="gender">
										<option value="m" <c:if test="${employeeInfo.emp_gender eq 'm' }">selected</c:if>>남성</option>
										<option value="f" <c:if test="${employeeInfo.emp_gender eq 'f' }">selected</c:if>>여성</option>
									</select>
								</td>
								<th>생년월일</th>
								<td class="calendarTd">
									<input type="date" name="emp_birth" id="empBirth" value="${employeeInfo.emp_birth }">
								</td>
							</tr>

							<tr>
								<th>연락처</th>
								<td>
									<input type="text" name="emp_tel" id="empTel" value="${employeeInfo.emp_tel }" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" onkeyup="insertTel(this)" placeholder="(-)을 제외한 숫자 입력">
								</td>
								<th>이메일</th>
								<td>
									<input type="email" name="emp_email" id="empEmail" value="${employeeInfo.emp_email }">
								</td>
							</tr>

							<tr>
								<th>우편번호</th>
								<td colspan="3" class="addrspost">
									<input type="text" name="emp_postcode" id="sample6_postcode" value="${employeeInfo.emp_postcode }" placeholder="우편번호" readonly>
									<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
								</td>
							</tr>

							<tr>
								<th>주소</th>
								<td colspan="3">
									<input type="text" name="emp_addr" id="sample6_address" value="${employeeInfo.emp_addr }" placeholder="주소" readonly>
								</td>
							</tr>

							<tr>
								<th>상세주소</th>
								<td colspan="3" class="addrsetc">
									<input type="text" name="emp_detailaddr" id="sample6_detailAddress" value="${employeeInfo.emp_detailaddr }" placeholder="상세주소">
									<input type="text" name="emp_extraaddr" id="sample6_extraAddress" value="${employeeInfo.emp_extraaddr }" placeholder="참고항목" readonly>
								</td>
							</tr>

							<tr>
								<th>재직상태</th>
								<td>
									<select name="emp_status" id="empStatus">
										<option value="재직" <c:if test="${employeeInfo.emp_status eq '재직' }">selected</c:if>>재직</option>
										<option value="휴직" <c:if test="${employeeInfo.emp_status eq '휴직' }">selected</c:if>>휴직</option>
										<option value="퇴사" <c:if test="${employeeInfo.emp_status eq '퇴사' }">selected</c:if>>퇴사</option>
									</select>
								</td>
								<th>퇴사일자</th>
								<td class="calendarTd">
									<input type="date" name="emp_quit" id="empQuit" value="${employeeInfo.emp_quit }">
								</td>
							</tr>

						</table>

						<h4>추가 사항</h4>
						<div class="moreDetails">
							<textarea name="emp_remarks" id="empRemarks">${employeeInfo.emp_remarks }</textarea>
						</div>
						
						<div class="buttons">
							<c:if test="${employeeInfo.emp_id ne null }">
								<input type="button" value="수정" onclick="modForm()">							
								<input type="button" class="print" value="인쇄" onclick="printEmp(${employeeInfo.emp_id})">
							</c:if>
							<c:if test="${employeeInfo.emp_id eq null }">
								<input type="button" value="저장" onclick="saveForm()">							
							</c:if>
							<input type="button" class="close" value="취소" onclick="cancelBoard()">
						</div>
					</form>
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
						text : "<span style='font-size:23px;font-weight:600;color:#575757;'>"
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
							history.back();
						}
					});
		}

		function Alert(msg) {
			alert(msg, 'success');
		}
		function Confirm(msg) {
			confirm('', msg);
		}
		function CancelConfirm(msg) {
			cancelConfirm(msg, '', '');
		}

		// 카카오 주소 API
		function sample6_execDaumPostcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 각 주소의 노출 규칙에 따라 주소를 조합한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var addr = ''; // 주소 변수
							var extraAddr = ''; // 참고항목 변수

							//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
							if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
								addr = data.roadAddress;
							} else { // 사용자가 지번 주소를 선택했을 경우(J)
								addr = data.jibunAddress;
							}

							// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
							if (data.userSelectedType === 'R') {
								// 법정동명이 있을 경우 추가한다. (법정리는 제외)
								// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
								if (data.bname !== ''
										&& /[동|로|가]$/g.test(data.bname)) {
									extraAddr += data.bname;
								}
								// 건물명이 있고, 공동주택일 경우 추가한다.
								if (data.buildingName !== ''
										&& data.apartment === 'Y') {
									extraAddr += (extraAddr !== '' ? ', '
											+ data.buildingName
											: data.buildingName);
								}
								// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
								if (extraAddr !== '') {
									extraAddr = ' (' + extraAddr + ')';
								}
								// 조합된 참고항목을 해당 필드에 넣는다.
								document.getElementById("sample6_extraAddress").value = extraAddr;

							} else {
								document.getElementById("sample6_extraAddress").value = '';
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('sample6_postcode').value = data.zonecode;
							document.getElementById("sample6_address").value = addr;
							// 커서를 상세주소 필드로 이동한다.
							document.getElementById("sample6_detailAddress")
									.focus();
						}
					}).open();
		}
		
		// textarea를 ckeditor로 교체
		CKEDITOR.replace('empRemarks');

		$(function() {
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

		// 사진 선택시 증명 사진 미리보기도 바꾸기
		$("#ePhoto").change(function() {
			changeImg(this, '#ePhotoImg');
		});

		function changeImg(input, expression) {
			// input 태그에 파일이 있는 경우
			if (input.files && input.files[0]) {
				// FileReader 인스턴스 생성
				var reader = new FileReader();
				// 이미지가 로드된 경우
				reader.onload = function(e) {
					$(expression).attr('src', e.target.result);
				}
				// reader가 이미지를 읽는다
				reader.readAsDataURL(input.files[0]);
			}
		}

		// 사원 정보 작성 취소하기
		function cancelBoard() {
			CancelConfirm("화면 이동 시 작성 중인 내용은 사라집니다.<br>이동하시겠습니까?");
		}

		// 연락처 입력시 자동 하이픈(-) 추가
		function insertTel(e) {
			$(e).val($(e).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-"));
		}

		// 사원 정보 저장하기(수정, 입력)
		var empForm = document.empForm;
		var empName = document.getElementById("empName");
		var empTel = document.getElementById("empTel");
		var empEmail = document.getElementById("empEmail");
		var regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
		var regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;

		function modForm() { // 수정할 때
			if (!regPhone.test(empTel.value)) {
				toastr.warning("연락처의 형식이 올바르지 않습니다");
				empTel.focus();
				return false;
			} else if (!regEmail.test(empEmail.value)) {
				toastr.warning("이메일의 형식이 올바르지 않습니다");
				empEmail.focus();
				return false;
			} else {
				empForm.action = "UpdateEmpInfoProc.do";				
				empForm.submit();
			}
		}
		
		function saveForm() { // 신규 사원 입력할 때
			if (empName.value.trim().length <= 0) {
				toastr.warning("성명을 입력해주세요");
				empName.focus();
				return false;
			} else if (!regPhone.test(empTel.value)) {
				toastr.warning("연락처의 형식이 올바르지 않습니다");
				empTel.focus();
				return false;
			} else if (!regEmail.test(empEmail.value)) {
				toastr.warning("이메일의 형식이 올바르지 않습니다");
				empEmail.focus();
				return false;
			} else {
				empForm.action = "InsertEmpInfoProc.do";				
				empForm.submit();
			}
		}

		// 사원 정보 인쇄하기
		function printEmp(empId) {
			var url = "PrintEmployee.do?empId=" + empId;
			var name = "printPop";
			var size = "width=1050, height=900";
			window.open(url, name, size);
		}
	</script>
</body>

</html>