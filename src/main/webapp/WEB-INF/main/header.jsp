<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메인 페이지</title>
    <link rel="stylesheet" type="text/css" href="../css/header.css">
	<!-- Bootstrap CSS 추가 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <!-- 최상단 고정 메뉴 바  -->
	<div id="topMenu">
	    <div id="logo">
	        <img alt="로고" src="../image/booboobooklogo-remove.jpeg" id="logo_image" onclick="location='/BooBooBookProject/'" style="width:60px; height:60px; cursor: pointer;">
	    </div>
	    <ul id="menu">
	        <li><a href="/BooBooBookProject/bookboard/bookList">Book</a></li>
	        <li><a href="/BooBooBookProject/qna/qnaList">Q&A</a></li>
	        <li><a href="${pageContext.request.contextPath}/mypage/myPage">My Page</a></li>
	        <c:if test="${sessionScope.userId eq 'admin'}">
			    <li><a href="/BooBooBookProject/bookboard/bookListForm">admin upload book</a></li>
			</c:if>
	    </ul>
	    <ul id="authMenu">
		    <c:choose>
		        <c:when test="${empty sessionScope.loginUser}">
		            <li><a href="#" id="loginBtn">로그인</a></li>
		            <li><a href="#" id="registerBtn">회원가입</a></li>
		        </c:when>
		        <c:otherwise>
	                <li><span>${sessionScope.loginUser.name}님</span></li>
	                <li><a href="#" id="logoutBtn">로그아웃</a></li>
            	</c:otherwise>
		    </c:choose>
		</ul>
	    <div id="hamburgerMenu" onclick="toggleMenu()">
	        &#9776;
	    </div>
	</div>

    <!-- 로그인 모달 -->
    <div class="modal fade" id="loginModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">로그인</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="loginForm">
                        <div class="mb-3">
                            <label for="loginId" class="form-label">아이디</label>
                            <input type="text" class="form-control" id="loginId" required>
                        </div>
                        <div class="mb-3">
                            <label for="loginPwd" class="form-label">비밀번호</label>
                            <input type="password" class="form-control" id="loginPwd" required>
                        </div>
                        <button type="submit" class="btn btn-primary">로그인</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

	<!-- 회원가입 모달은 마이페이지에서는 제외 -->
    <c:if test="${pageContext.request.servletPath != '/WEB-INF/mypage/myPage.jsp'}">
    	<div class="modal fade" id="registerModal" tabindex="-1" aria-hidden="true">
		    <!-- 회원가입 모달 -->
		    <div class="modal fade" id="registerModal" tabindex="-1" aria-hidden="true">
		        <div class="modal-dialog">
		            <div class="modal-content">
		                <div class="modal-header">
		                    <h5 class="modal-title">회원가입</h5>
		                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		                </div>
		                <div class="modal-body">
		                    <form id="registerForm">
		                        <div class="mb-3">
		                            <label for="registerId" class="form-label">아이디</label>
		                            <input type="text" class="form-control" id="registerId" required>
		                        </div>
		                        <div class="mb-3">
		                            <label for="registerName" class="form-label">이름</label>
		                            <input type="text" class="form-control" id="registerName" required>
		                        </div>
		                        <div class="mb-3">
		                            <label for="registerEmail" class="form-label">이메일</label>
		                            <div class="input-group">
		                                <input type="email" class="form-control" id="registerEmail" required>
		                                <button type="button" class="btn btn-primary" id="sendVerificationBtn">인증번호 전송</button>
		                            </div>
		                        </div>
		                        <div class="mb-3">
		                            <label for="verificationCode" class="form-label">인증번호</label>
		                            <div class="input-group">
		                                <input type="text" class="form-control" id="verificationCode" required>
		                                <button type="button" class="btn btn-primary" id="verifyCodeBtn">인증확인</button>
		                            </div>
		                        </div>
		                        <div class="mb-3">
		                            <label for="registerPwd" class="form-label">비밀번호</label>
		                            <input type="password" class="form-control" id="registerPwd" required>
		                        </div>
		                        <button type="submit" class="btn btn-primary" id="registerSubmitBtn" disabled>회원가입</button>
		                    </form>
		                </div>
		            </div>
		        </div>
		    </div>
	    </div>
    </c:if>   

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
        function toggleMenu() {
            const menu = document.getElementById("menu");
            const authMenu = document.getElementById("authMenu");
            menu.classList.toggle("active");
            authMenu.classList.toggle("active");
        }

        $(document).ready(function() {
            $('#loginBtn').click(function() {
                $('#loginModal').modal('show');
            });

            $('#registerBtn').click(function() {
                $('#registerModal').modal('show');
            });

            // 회원가입 폼 제출
            $('#registerForm').submit(function(e) {
                e.preventDefault();
                $.ajax({
                    url: '${pageContext.request.contextPath}/user/register',
                    type: 'POST',
                    data: {
                        id: $('#registerId').val(),
                        name: $('#registerName').val(),
                        email: $('#registerEmail').val(),
                        pwd: $('#registerPwd').val()
                    },
                    success: function(response) {
                        if (response === 'success') {
                            alert('회원가입 성공!');
                            $('#registerModal').modal('hide');
                            location.reload();
                        } else {
                            alert(response);
                        }
                    }
                });
            });

            // 인증번호 전송
            $('#sendVerificationBtn').click(function() {
                var email = $('#registerEmail').val();
                if (!email) {
                    alert('이메일을 입력해주세요.');
                    return;
                }
                $.ajax({
                    url: '${pageContext.request.contextPath}/user/sendVerificationEmail',
                    type: 'POST',
                    data: { email: email },
                    success: function(response) {
                        if (response === 'success') {
                            alert('인증번호가 전송되었습니다. 이메일을 확인해주세요.');
                        } else {
                            alert('이메일 전송 실패: ' + response);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('Ajax request failed:', status, error);
                        alert('서버 오류가 발생했습니다. 나중에 다시 시도해주세요.');
                    }
                });
            });

            // 인증번호 확인
            $('#verifyCodeBtn').click(function() {
                var email = $('#registerEmail').val();
                var code = $('#verificationCode').val();
                $.ajax({
                    url: '${pageContext.request.contextPath}/user/verifyCode',
                    type: 'POST',
                    data: { 
                        email: email,
                        verificationCode: code
                    },
                    success: function(response) {
                        if (response === 'success') {
                            alert('이메일 인증이 완료되었습니다.');
                            $('#registerSubmitBtn').prop('disabled', false);
                        } else {
                            alert('인증번호가 일치하지 않습니다.');
                        }
                    }
                });
            });

            // 로그인 폼 제출
            $('#loginForm').submit(function(e) {
                e.preventDefault();
                $.ajax({
                    url: '${pageContext.request.contextPath}/user/login',
                    type: 'POST',
                    data: {
                        id: $('#loginId').val(),
                        pwd: $('#loginPwd').val()
                    },
                    success: function(response) {
                        if (response === 'success') {
                            alert('로그인 성공!');
                            location.reload();
                        } else {
                            alert('로그인 실패. 아이디와 비밀번호를 확인해주세요.');
                        }
                    }
                });
            });

            // 로그아웃
            $('#logoutBtn').click(function() {
                $.ajax({
                    url: '${pageContext.request.contextPath}/user/logout',
                    type: 'POST',
                    success: function(response) {
                        if (response === 'success') {
                            alert('로그아웃 되었습니다.');
                            location.reload();
                        }
                    }
                });
            });
        });
    </script>
</body>
</html>
