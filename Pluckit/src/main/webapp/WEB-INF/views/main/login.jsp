<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <!-- CSS 파일 -->
    <link rel="stylesheet" href="resources/css/login.css">
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
    <!-- toastr -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<body>
    <div id="wrap">
        <div class="loginBox">
            <form action="LoginProc.do" name="loginForm" method="post">
                <!-- 로고이미지 & 회사명 -->
                <div class="logo" onclick="location.href='Home.do'">
                    <img src="resources/img/logo.png" alt="로고">
                    <p>PluckIT</p>
                </div>

                <!-- input태그들 -->
                <div class="inputboxes">
                    <div class="alert" id="alert">${msg }</div>
                    <input type="text" name="emp_num" class="id" placeholder="사원번호" onfocus="hideAlert()" onkeypress="enter()">
                    <input type="password" name="emp_pw" class="pw" placeholder="비밀번호" onfocus="hideAlert()" onkeypress="enter()">
                    <input type="button" class="submit" value="로그인" onclick="login()">
                </div>

                <!-- 체크박스 & 가입하기 링크 -->
                <div class="signup">
                    <div><input type="checkbox" id="chk">&nbsp;&nbsp;<label for="chk">계정 저장</label></div>
                    <div>계정이 없으신가요? <a href="Signup.do">가입하기</a></div>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        // toastr 설정
        toastr.options = {
            "closeButton": false,
            "debug": false,
            "newestOnTop": false,
            "progressBar": false,
            "positionClass": "toast-top-right",
            "preventDuplicates": false,
            "onclick": null,
            "showDuration": "300",
            "hideDuration": "1000",
            "timeOut": "5000",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
        }
        
        // 쿠키 저장 & 조회 & 삭제
        function setCookie(cookieName, value, exdays) { 
            var exdate = new Date(); exdate.setDate(exdate.getDate() + exdays); // 쿠키 저장 기간 
            var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString()); 
            document.cookie = cookieName + "=" + cookieValue; 
        }

        function getCookie(cookieName){
            var cookieValue = null;
            if(document.cookie){
                var array=document.cookie.split((escape(cookieName)+'='));
                if(array.length >= 2){
                    var arraySub=array[1].split(';');
                    cookieValue=unescape(arraySub[0]);
                }
            }
            return cookieValue;
        }

        function deleteCookie(cookieName){
            var expireDate = new Date();
            expireDate.setDate(expireDate.getDate() - 1);
            document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
        }
        
        // 저장된 사원번호 쿠키가 있다면 화면에 출력
        var id = document.getElementsByName("emp_num")[0];
        var cooId = getCookie("Cookie_empNum");
        var chk = document.getElementById("chk");

        if (cooId != "") {
            id.value = cooId;
            chk.setAttribute('checked', 'checked');
        }

        if (id.value == "") {
            chk.checked = false;
        }

        // 아이디 & 비밀번호 빈칸 확인 & 계정 저장
        function login() {
            var loginForm = document.loginForm;

            var id = document.getElementsByName("emp_num")[0];
            var pw = document.getElementsByName("emp_pw")[0];
            var chk = document.getElementById("chk").checked;
            
            if (id.value.trim().length <= 0 || id.value.search(/\s/) !== -1) {
                toastr.warning("사원번호를 잘못 입력했습니다");
                id.focus();
                return false;
            } else if (pw.value.trim().length <= 0 || pw.value.search(/\s/) !== -1) {
                toastr.warning("비밀번호를 잘못 입력했습니다");
                pw.focus();
                return false;
            } else {
            	if (chk) {
                    setCookie("Cookie_empNum", id.value, 1);
                } else {
                    deleteCookie("Cookie_empNum");
                }
            	
                loginForm.submit();
            }
        }
        
     	// 엔터키로 로그인하기
        function enter() {
            if (window.event.keyCode == 13) {
                login();
            }
        }
        
        // 알림div 표시 & 숨기기
        var msg = document.getElementById("alert");

        if (msg.innerHTML == "") {
            msg.style.display = "none";
        } else {
            msg.style.display = "block";
        }

        function hideAlert() {
            msg.style.display = "none";
        }
        
    </script>
</body>
</html>