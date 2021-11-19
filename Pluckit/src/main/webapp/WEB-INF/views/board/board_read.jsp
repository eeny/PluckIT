<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<title>게시판</title>
<!-- CSS 파일 -->
<link rel="stylesheet" href="resources/css/board_read.css">
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

					<form action="#" method="post" name="bdForm">
						<table class="noticeTable">
							<colgroup>
								<!--테이블 컬럼 너비 조절하는 태그-->
								<col width="15%" />
								<col width="35%" />
								<col width="15%" />
								<col width="35%" />
							</colgroup>
							<tr>
								<th>작성자</th>
								<td>${post.bm_writer }</td>
								<th>작성일</th>
								<td>${post.bm_regdate }</td>
							</tr>
							<tr>
								<th>제목</th>
								<td colspan="3">${post.bm_title }</td>
							</tr>
							<tr>
								<th>첨부파일</th>
								<td colspan="3">
									<a href="FileDownload.do?bmFile=${post.bm_file }&bmSFile=${post.bm_savedfile}" class="downFile" id="downFile">${post.bm_file }</a>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									${post.bm_content }
									<c:if test="${fn:split(post.bm_file, '.')[1] eq  'jpg' || fn:split(post.bm_file, '.')[1] eq  'png' || fn:split(post.bm_file, '.')[1] eq  'gif' }">
										<div class="fileImg">
											<img name="img" src="resources/upload/${post.bm_savedfile }" onclick="window.open('resources/upload/${post.bm_savedfile }', '_blank')">
										</div>
									</c:if>
								</td>
							</tr>
						</table>

						<div class="buttons">
							<!--글쓰기 버튼들 시작-->
							<a class="write" href="AnswerPost.do?deptName=${empInfo.deptName }&empAuth=${empInfo.emp_auth }&pageName=${pageName}&bmNum=${post.bm_num}&bmGrpnum=${post.bm_grpnum}&bmGrpord=${post.bm_grpord}&bmGrpdepth=${post.bm_grpdepth}">답글</a>
							<c:if test="${empInfo.emp_auth eq 5 || empInfo.emp_name eq post.bm_writer }">
								<a class="write" href="ModifyPost.do?deptName=${empInfo.deptName }&empAuth=${empInfo.emp_auth }&pageName=${pageName}&bmNum=${post.bm_num}">수정</a>
								<a class="write" onclick="DelConfirm('글을 삭제하시겠습니까?', '${empInfo.deptName }', '${empInfo.emp_auth }', '${pageName}', '${post.bm_num}')">삭제</a>
							</c:if>
							<a class="write cancel" onclick="history.back()">목록</a>
						</div>
						<!--글쓰기 버튼들 끝-->
					</form>

					<!-- 댓글 시작 -->
					<div class="replyWrap">
						<form id="replyForm" name="replyForm" method="post">
							<div class="replyBox">
								<input type="hidden" name="b_id" id="bId" value="${pageName }">
								<input type="hidden" name="bm_num" id="bmNum" value="${post.bm_num }">
								<input type="hidden" name="r_writer" id="rWriter" value="${empInfo.emp_name }">
								<textarea name="r_content" id="rContent"></textarea>
								<input type="button" value="댓글작성" onclick="writeReply()">
							</div>
						</form>

						<p class="replyCount"></p>

						<ul class="replyList">
						</ul>
					</div>
					<!-- 댓글 끝 -->
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
		
		var delConfirm = function(msg, title, deptName, empAuth, pageName, bmNum) {
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
							location.href = "DeletePostProc.do?deptName=" + deptName + "&empAuth=" + empAuth + "&pageName=" + pageName + "&bmNum=" + bmNum;
						}
					});
		}

		function Alert(msg) {
			alert(msg, 'success');
		}
		function Confirm(msg) {
			confirm('', msg);
		}
		function DelConfirm(msg, deptName, empAuth, pageName, bmNum) {
			delConfirm('', msg, deptName, empAuth, pageName, bmNum);	
		}

		// 게시판 제목 길이 제한 (13자 넘으면 잘림)
		var titleArray = document.getElementsByClassName("maxTitle");
		for (var i = 0; i < titleArray.length; i++) {
			var shortTitle = titleArray[i].innerText.substr(0, 13);
			titleArray[i].innerText = shortTitle;
		}
		
		// 첨부 이미지 크기 제한
		function resize(img){
            var imgWidth = img.width;
            var maxWidth = 600;
            
            if (imgWidth > maxWidth) {
                img.classList.add('resizeImg');
            } else {
            	img.cla
            }
        }
		
		// 페이지 로딩시 댓글목록 불러오기
		$(function() {
			getReplyList();
		});
		
		// 댓글 등록하기
		function writeReply() {
			//var rForm = document.replyForm;
			var rContent = document.getElementById("rContent");
			var bmNum = document.getElementById("bmNum");
			var rWriter = document.getElementById("rWriter");
			var bId = document.getElementById("bId");
			
			var rData = {
					bm_num : bmNum.value,
					r_writer : rWriter.value,
					r_content : rContent.value,
					b_id : bId.value
			}
			
			if (rWriter.value.trim().length <= 0) {
				toastr.error("로그인 후 이용가능합니다");
			} else if (rContent.value.trim().length <= 0) {
				toastr.warning("내용을 입력해주세요");
			} else {
				$.ajax({
					type: "POST",
					url: "WriteReplyProc.do",
					data: JSON.stringify(rData),
					contentType : "application/json; charset=utf-8",
					dataType : "json",
					success: function(data) {
						if (data.result == "success") {
							getReplyList();
							rContent.value = "";
						}
					},
					error: function(data) {
						alert("시스템 에러 발생!");
					}
				});				
			}
			
		}
		
		// 댓글 목록 가져오기
		function getReplyList() {
			var empName = "${empInfo.emp_name }"; // 세션 사용자와 댓글 작성자 비교용
			var bmNum = document.getElementById("bmNum");
			var bId = document.getElementById("bId");
			var param = {
					b_id : bId.value,
					bm_num : bmNum.value
			}
			
			$.ajax({
				type: "POST",
				url: "GetReplyProc.do",
				data: JSON.stringify(param),
				contentType : "application/json; charset=utf-8",
				dataType : "json",
				success: function(data) {
					var str = "";
					var rCnt = data.length;
					
					if (rCnt > 0) { // 댓글이 존재하는 경우
						for (var i = 0; i < rCnt; i++) {
							if (data[i].r_writer == empName) {
								str += "<li id='rId" + data[i].r_num + "'>";
								str += "<div>";
								str += "<img src='resources/img/user.png' alt='user'>";
								str += "</div>";
								str += "<div class='replyContent'>";
								str += "<p class='replyTop'>";
								str += "<span>" + data[i].r_writer + "</span> <span>" + data[i].r_regdate + "</span>";
								str += " <span><a onclick='modReplyForm(" + data[i].r_num + ")'>수정</a>";
								str += " <a onclick='delReply(" + data[i].r_num + ")'>삭제</a></span>";
								str += "</p>";
								str += "<p class='replyBottom'>" + data[i].r_content + "</p>";
								str += "</div>";
								str += "</li>";						
							} else {
								str += "<li id='rId" + data[i].r_num + "'>";
								str += "<div>";
								str += "<img src='resources/img/user.png' alt='user'>";
								str += "</div>";
								str += "<div class='replyContent'>";
								str += "<p class='replyTop'>";
								str += "<span>" + data[i].r_writer + "</span> <span>" + data[i].r_regdate + "</span>";
								str += " <span style='visibility: hidden;'><a onclick='modReplyForm(" + data[i].r_num + ")'>수정</a>";
								str += " <a onclick='delReply(" + data[i].r_num + ")'>삭제</a></span>";
								str += "</p>";
								str += "<p class='replyBottom'>" + data[i].r_content + "</p>";
								str += "</div>";
								str += "</li>";	
							}
						}
					} else {
						str += "<li><strong>";
                      	str += "등록된 댓글이 없습니다.";
                        str += "</strong></li>";
					}
					
					$(".replyCount").html("댓글 (" + rCnt + ")");
					$(".replyList").html(str);
				},
				error: function(data) {
					alert("시스템 에러 발생!");
				}
			});
		}
		
		// 댓글 수정하기
		function modReplyForm(rNum) {
			var bId = document.getElementById("bId");
			var bmNum = document.getElementById("bmNum");
			var param = {
					b_id : bId.value,
					bm_num : bmNum.value,
					r_num : rNum
			}
			
			$.ajax({
				type: "POST",
				url: "GetModReply.do",
				data: JSON.stringify(param),
				contentType : "application/json; charset=utf-8",
				dataType : "json",
				success: function(data) {
					var str = "";
					if (data != null) {
						str += "<li id='rId" + data.result.r_num + "'>";
						str += "<div><img src='resources/img/user.png' alt='user'></div>";
						str += "<div class='replyContent'>";
						str += "<p class='replyTop'>";
						str += "<span class='rWriter'>" + data.result.r_writer + "</span>";
						str += "<span>" + data.result.r_regdate + "</span>";
						str += "<span><a onclick='modReply(" + data.result.r_num + ")'>저장</a>";
						str += "<a onclick='getReplyList()'>취소</a></span>";
						str += "</p>";
						str += "<textarea name='r_content' id='modContent" + data.result.r_num + "'>" + data.result.r_content + "</textarea>";
						str += "</div></li>";
						
						$("#rId" + data.result.r_num).replaceWith(str);
						$("#rId" + data.result.r_num + " #modContent" + data.result.r_num).focus();
					}
				},
				error: function(data) {
					alert("시스템 에러 발생!");
				}
			});
		}
		
		// 댓글 수정하기
		function modReply(rNum) {
			var bId = $("#bId").val();
			var rContent = $("#modContent" + rNum).val();
			
			var param = {
					b_id : bId,
					r_content : rContent,
					r_num : rNum
			}
			
			$.ajax({
				type: "POST",
				url: "ModifyReplyProc.do",
				data: JSON.stringify(param),
				contentType : "application/json; charset=utf-8",
				dataType : "json",
				success: function(data) {
					if (data.result == "success") {
						getReplyList();
					}
				},
				error: function(data) {
					alert("시스템 에러 발생!");
				}
			});
		}
		
		// 댓글 삭제하기
		function delReply(rNum) {
			var bId = document.getElementById("bId");
			var param = {
					b_id : bId.value,
					r_num : rNum
			}
			
			$.ajax({
				type: "POST",
				url: "DeleteReplyProc.do",
				data: JSON.stringify(param),
				contentType : "application/json; charset=utf-8",
				dataType : "json",
				success: function(data) {
					if (data.result == "success") {
						getReplyList();
					}
				},
				error: function(data) {
					alert("시스템 에러 발생!");
				}
			});
		}
	</script>

</body>
</html>