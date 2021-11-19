<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<title>게시판</title>
<!-- CSS 파일 -->
<link rel="stylesheet" href="resources/css/board_write.css">
<!-- include -->
<jsp:include page="../include/header.jsp"/>

			<div class="main-section">
				<!-- 메인 페이지 시작 -->
				<section class="main-left">
					<!--왼쪽 세부 메뉴 시작-->
					<ul>
						<li>
							<a href="Board.do?deptName=${empInfo.deptName }&empAuth=${empInfo.emp_auth }&pageName=notice" class="maxTitle ${pageName eq 'notice' ? 'clickBtn' : '' }">공지사항</a>
						</li>
						<c:forEach var="bdto" items="${menuList }">
							<li>
								<a href="Board.do?deptName=${empInfo.deptName }&empAuth=${empInfo.emp_auth }&pageName=${bdto.b_id}" class="maxTitle ${pageName eq bdto.b_id ? 'clickBtn' : '' }">${bdto.b_title }</a>
							</li>
						</c:forEach>
					</ul>
				</section>
				<!--왼쪽 세부 메뉴 끝-->

				<div></div>
				<!--왼쪽 세부 메뉴 가짜 공간-->

				<section class="main-right">
					<!--게시판 본문 시작-->
					<h1>
						<i class="far fa-file-alt"></i> ${pageTitle }
					</h1>

					<form name="bdForm" method="post" enctype="multipart/form-data">
						<input type="hidden" name="b_id" id="bId">
						<input type="hidden" name="bm_writer" value="${empInfo.emp_name }">
						<table class="noticeTable">
							<colgroup>
								<!--테이블 컬럼 너비 조절하는 태그-->
								<col width="15%" />
								<col width="85%" />
							</colgroup>
							<tr>
								<th>제목</th>
								<td>
									<input type="text" name="bm_title" id="bmTitle" value="${post.bm_title }">
								</td>
							</tr>
							<tr>
								<th>첨부파일</th>
								<td>
									<c:if test="${post ne null && post.bm_file ne '' }">
										기존 파일 - ${post.bm_file }
									</c:if>
									<label for="bmFile"><i class="fas fa-paperclip"></i> 업로드할 파일 선택 (파일은 1개만 업로드 가능)</label>
									<input type="file" name="bm_file" id="bmFile">
								</td>
							</tr>
							<tr>
								<td colspan="2" class="textAreaTd">
									<textarea name="bm_content" id="bm_content" rows="10">${post.bm_content }</textarea>
								</td>
							</tr>
						</table>

						<div class="buttons">
							<!--글쓰기 버튼들 시작-->
							<c:choose>
								<c:when test="${post eq null && answer eq null }">
									<a class="write" onclick="writeBoard()">저장</a>									
								</c:when>
								<c:when test="${post ne null }">
									<a class="write" onclick="modifyBoard()">수정</a>								
								</c:when>
								<c:when test="${post eq null && answer ne null }">
									<a class="write" onclick="writeAnswer()">답글저장</a>									
								</c:when>
							</c:choose>
							<a class="write cancel" onclick="cancelBoard()">취소</a>
						</div>
						<!--글쓰기 버튼들 끝-->
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

		// textarea를 ckeditor로 교체
		CKEDITOR.replace('bm_content');

		// 게시판 제목 길이 제한 (13자 넘으면 잘림)
		var titleArray = document.getElementsByClassName("maxTitle");
		for (var i = 0; i < titleArray.length; i++) {
			var shortTitle = titleArray[i].innerText.substr(0, 13);
			titleArray[i].innerText = shortTitle;
		}

		// 주소줄 파라미터 추출하기 - form에서 게시판코드 넘길 때 사용
		function getParam(name) {
			name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
			var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"), results = regex
					.exec(location.search);
			return results == null ? "" : decodeURIComponent(results[1]
					.replace(/\+/g, " "));
		}

		// 게시글 저장하기
		var bdForm = document.bdForm;
		var title = document.getElementById("bmTitle");
		//var content = document.getElementById("bmContent");
		//var content = CKEDITOR.instances.bm_content.getData();
		var bId = document.getElementById("bId");

		function writeBoard() {
			if (title.value.trim().length <= 0) {
				toastr.warning("제목을 입력해주세요");
				title.focus();
				return false;
			} else if (CKEDITOR.instances.bm_content.getData().length <= 0) {
				toastr.warning("내용을 입력해주세요");
				CKEDITOR.instances.bm_content.focus();
				return false;
			} else {
				bId.value = getParam("pageName");
				bdForm.action = "WritePostProc.do?deptName="
						+ getParam("deptName") + "&empAuth="
						+ getParam("empAuth") + "&pageName="
						+ getParam("pageName");
				bdForm.submit();
			}
		}

		// 게시글 작성 취소하기
		function cancelBoard() {
			CancelConfirm("화면 이동 시 작성 중인 내용은 사라집니다.<br>이동하시겠습니까?");
		}

		// 파일 첨부시 label을 파일명으로 교체
		$(function() {
			var realFile = $("#bmFile");
			var fileLabel = $(".noticeTable label");

			realFile.on('change', function() {
				if (window.FileReader) {
					var fileName = $(this)[0].files[0].name;
				}

				fileLabel.text(fileName + " (파일을 변경하려면 클릭)");
			});
		});
		
		// 게시글 수정하기
		function modifyBoard() {
			if (title.value.trim().length <= 0) {
				toastr.warning("제목을 입력해주세요");
				title.focus();
				return false;
			} else if (CKEDITOR.instances.bm_content.getData().length <= 0) {
				toastr.warning("내용을 입력해주세요");
				CKEDITOR.instances.bm_content.focus();
				return false;
			} else {
				bId.value = getParam("pageName");
				bdForm.action = "ModifyPostProc.do?deptName="
						+ getParam("deptName") + "&empAuth="
						+ getParam("empAuth") + "&pageName="
						+ getParam("pageName") + "&bmNum="
						+ getParam("bmNum");
				bdForm.submit();
			}
		}
		
		// 게시글 답글 달기
		function writeAnswer() {
			if (title.value.trim().length <= 0) {
				toastr.warning("제목을 입력해주세요");
				title.focus();
				return false;
			} else if (CKEDITOR.instances.bm_content.getData().length <= 0) {
				toastr.warning("내용을 입력해주세요");
				CKEDITOR.instances.bm_content.focus();
				return false;
			} else {
				bId.value = getParam("pageName");
				bdForm.action = "AnswerPostProc.do?deptName="
					+ getParam("deptName") + "&empAuth="
					+ getParam("empAuth") + "&pageName="
					+ getParam("pageName") + "&bmNum="
					+ getParam("bmNum") + "&bmGrpnum="
					+ getParam("bmGrpnum") + "&bmGrpord="
					+ getParam("bmGrpord") + "&bmGrpdepth="
					+ getParam("bmGrpdepth");
				bdForm.submit();
			}
		}
	</script>

</body>
</html>