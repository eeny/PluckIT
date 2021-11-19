<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<title>게시판</title>
<!-- CSS 파일 -->
<link rel="stylesheet" href="resources/css/board_main.css">
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

					<!--검색 box 추가-->

					<form action="SearchPostList.do">
						<input type="hidden" name="deptName" value="${empInfo.deptName }">
						<input type="hidden" name="empAuth" value="${empInfo.emp_auth }">
						<input type="hidden" name="pageName" value="${pageName }">
						<table class="search-box">
							<tr>
								<td>
									<select name="select" class="select-kind">
										<option value="bm_title">제목</option>
										<option value="bm_writer">작성자</option>
									</select>
									<input type="text" name="search" placeholder="검색어를 입력하세요">
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
							<col width="5%" />
							<col width="52%" />
							<col width="10%" />
							<col width="15%" />
							<col width="9%" />
							<col width="9%" />
						</colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>조회수</th>
								<th>파일</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="bdto" items="${boardList }" varStatus="vs">
							<tr>
								<td>${paging.totalCount - ((paging.pageNum - 1) * paging.pageSize + vs.index) }</td>
								<td>
									<c:if test="${bdto.bm_grpdepth > 0 }">
										<c:forEach var="i" begin="0" end="${bdto.bm_grpdepth }">
											&nbsp;&nbsp;&nbsp;&nbsp;
										</c:forEach>
										<img src="resources/img/answer.png" alt="answer" class="answer">&nbsp;&nbsp;
									</c:if>
									<a href="ReadPost.do?deptName=${empInfo.deptName }&empAuth=${empInfo.emp_auth }&pageName=${pageName}&bmNum=${bdto.bm_num}">${bdto.bm_title }</a>
								</td>
								<td>${bdto.bm_writer }</td>
								<td>${bdto.bm_regdate }</td>
								<td>${bdto.bm_hit }</td>
								<td>
									<c:choose>
										<c:when test="${fn:split(bdto.bm_file, '.')[1] eq  'jpg' || fn:split(bdto.bm_file, '.')[1] eq  'png' || fn:split(bdto.bm_file, '.')[1] eq  'gif'}">
											<i class="fas fa-file-image"></i>
										</c:when>
										<c:when test="${fn:split(bdto.bm_file, '.')[1] eq  'pptx'}">
											<i class="fas fa-file-powerpoint"></i>
										</c:when>
										<c:when test="${fn:split(bdto.bm_file, '.')[1] eq  'docx'}">
											<i class="fas fa-file-word"></i>
										</c:when>
										<c:when test="${fn:split(bdto.bm_file, '.')[1] eq  'xlsx'}">
											<i class="fas fa-file-excel"></i>
										</c:when>
										<c:when test="${fn:split(bdto.bm_file, '.')[1] eq  'pdf'}">
											<i class="fas fa-file-pdf"></i>
										</c:when>
										<c:when test="${fn:split(bdto.bm_file, '.')[1] eq  'hwp' || fn:split(bdto.bm_file, '.')[1] eq  'txt'}">
											<i class="fas fa-file-alt"></i>
										</c:when>
										<c:when test="${fn:split(bdto.bm_file, '.')[1] eq  'zip' || fn:split(bdto.bm_file, '.')[1] eq  'war'}">
											<i class="fas fa-file-archive"></i>
										</c:when>
										<c:when test="${fn:split(bdto.bm_file, '.')[1] eq  'exe' || fn:split(bdto.bm_file, '.')[1] eq  'html' || fn:split(bdto.bm_file, '.')[1] eq  'jar'}">
											<i class="fas fa-file"></i>
										</c:when>
										<c:otherwise>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
					<div class="paging">
						<!--페이징 시작-->
						<c:if test="${paging.pageNum > 1 }">
							<span><a href="Board.do?pageNum=1&deptName=${empInfo.deptName }&empAuth=${empInfo.emp_auth }&pageName=${pageName}">
									<i class="fas fa-angle-double-left"></i>
								</a></span>
							<span><a href="Board.do?pageNum=${paging.pageNum-1 }&deptName=${empInfo.deptName }&empAuth=${empInfo.emp_auth }&pageName=${pageName}">
									<i class="fas fa-angle-left"></i>
								</a></span>
						</c:if>
						
						<c:if test="${paging.totalCount < 1 }">
							<span class="nowPage"><a class="nowPage">1</a></span>
						</c:if>
						
						<c:if test="${paging.totalCount > 0 }">
							<c:forEach var="i" begin="${paging. startPage}" end="${paging.endPage }" step="1">
								<c:if test="${paging.pageNum eq i }">
									<span class="nowPage"><a href="Board.do?pageNum=${i }&deptName=${empInfo.deptName }&empAuth=${empInfo.emp_auth }&pageName=${pageName}" class="nowPage">${i }</a></span>
								</c:if>
								<c:if test="${paging.pageNum ne i }">
									<span><a href="Board.do?pageNum=${i }&deptName=${empInfo.deptName }&empAuth=${empInfo.emp_auth }&pageName=${pageName}">${i }</a></span>
								</c:if>
							</c:forEach>							
						</c:if>
						
						<c:if test="${paging.pageNum < paging.totalPage }">
							<span><a href="Board.do?pageNum=${paging.pageNum+1 }&deptName=${empInfo.deptName }&empAuth=${empInfo.emp_auth }&pageName=${pageName}">
									<i class="fas fa-angle-right"></i>
								</a></span>
							<span><a href="Board.do?pageNum=${paging.totalPage }&deptName=${empInfo.deptName }&empAuth=${empInfo.emp_auth }&pageName=${pageName}">
									<i class="fas fa-angle-double-right"></i>
								</a></span>
						</c:if>
					</div>
					<!--페이징 끝-->
					<div class="buttons">
						<!--글쓰기 버튼들 시작-->
						<a href="WritePost.do?deptName=${empInfo.deptName }&empAuth=${empInfo.emp_auth}&pageName=${pageName }" class="write">글쓰기</a>
					</div>
					<!--글쓰기 버튼들 끝-->
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

		function Alert(msg) {
			alert(msg, 'success');
		}
		function Confirm(msg) {
			confirm('', msg);
		}

		// 게시판 제목 길이 제한 (13자 넘으면 잘림)
		var titleArray = document.getElementsByClassName("maxTitle");
		for (var i = 0; i < titleArray.length; i++) {
			var shortTitle = titleArray[i].innerText.substr(0, 13);
			titleArray[i].innerText = shortTitle;
		}
	</script>

</body>
</html>