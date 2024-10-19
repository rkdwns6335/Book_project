<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Page - BooBooBook</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/myPage.css">
    <style>
        .profile-image {
            width: 100px;
            height: 100px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <!-- 헤더 인클루드 -->
    <jsp:include page="/WEB-INF/main/header.jsp" />
    
    <div class="mypage-background">
        <div class="mypage-wrapper">
            <div class="mypage-container">
                <h1 class="mypage-title">${user.name}님의 마이페이지</h1>
                <div class="card-container">
                    <div class="card">
                        <c:choose>
                            <c:when test="${fn:contains(user.id, '@') && fn:endsWith(user.id, '.com')}">
                                <img src="${pageContext.request.contextPath}/image/ghost1.png" alt="소셜 로그인 프로필" class="profile-image">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/image/토끼.jpg" alt="일반 로그인 프로필" class="profile-image">
                            </c:otherwise>
                        </c:choose>
                        <h2>내 정보</h2>
                        <p>이름: <span id="userName">${user.name}</span></p>
                        <p>이메일: ${user.email}</p>
                        <button id="editNameBtn" class="edit-btn">이름 수정</button>
                        <c:if test="${!(fn:contains(user.id, '@') && fn:endsWith(user.id, '.com') && isSocialPassword)}">
						    <button id="editPwdBtn" class="edit-btn">비밀번호 변경</button>
						</c:if>
                        <button id="deleteBtn" class="edit-btn">회원 탈퇴</button>
                        <div id="passwordChangeContainer"></div>
                    </div>
                    <div class="card">
                        <h2>나의 독서 활동</h2>
                        <p>작성한 리뷰: ${writtenReviews}개</p>
                        <p>참여한 Q&A: ${participatedQnA }개</p>
                        <button class="view-btn">자세히 보기</button>
                    </div>
                    <div class="card">
                        <h2>나의 관심 도서</h2>
                        <ul>
                            <li>도서 제목 1</li>
                            <li>도서 제목 2</li>
                            <li>도서 제목 3</li>
                        </ul>
                        <button class="manage-btn">관리하기</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
        function toggleMenu() {
            const menu = document.getElementById("menu");
            const authMenu = document.getElementById("authMenu");
            menu.classList.toggle("active");
            authMenu.classList.toggle("active");
        }
        
        $(document).ready(function() {
            var isEditNameActive = false;

            $('#editNameBtn').click(function() {
                if (isEditNameActive) return; // 이미 활성화되어 있으면 중복 생성 방지
                isEditNameActive = true;

                var currentName = $('#userName').text();
                var nameInput = $('<input>').attr('type', 'text').val(currentName).addClass('form-control');
                var saveBtn = $('<button>').text('저장').addClass('btn btn-primary btn-sm');
                var cancelBtn = $('<button>').text('취소').addClass('btn btn-secondary btn-sm');
                
                $('#userName').hide().after(nameInput, $('<div>').addClass('mt-2').append(saveBtn, ' ', cancelBtn));
                
                saveBtn.click(function() {
        	        var newName = nameInput.val().trim();
        	        if (newName && newName !== currentName) {
        	            $.ajax({
        	                url: '${pageContext.request.contextPath}/user/updateName',
        	                type: 'POST',
        	                contentType: 'application/json',
        	                data: JSON.stringify({
        	                    id: '${loginUser.id}',
        	                    name: newName
        	                }),
        	                success: function(response) {
        	                    if (response === 'success') {
        	                        $('#userName').text(newName).show();
        	                        nameInput.remove();
        	                        saveBtn.parent().remove();
        	                    } else {
        	                        alert('이름 수정에 실패했습니다.');
        	                    }
        	                }
        	            });
        	        } else {
        	            $('#userName').show();
        	            nameInput.remove();
        	            saveBtn.parent().remove();
        	            isEditNameActive = false;
        	        }
        	    });
        	    
                cancelBtn.click(function() {
                    $('#userName').show();
                    nameInput.remove();
                    saveBtn.parent().remove();
                    isEditNameActive = false;
                });
            });
            
            $('#editPwdBtn').click(function() {
                console.log('비밀번호 변경 버튼 클릭됨');
                var passwordForm = `
                    <form id="passwordChangeForm">
                        <div class="mb-3">
                            <label for="currentPassword" class="form-label">현재 비밀번호</label>
                            <input type="password" class="form-control" id="currentPassword" required>
                        </div>
                        <button type="button" class="btn btn-primary" id="verifyCurrentPassword">변경</button>
                        <button type="button" class="btn btn-secondary" id="cancelPasswordChange">취소</button>
                        <div id="newPasswordFields" style="display:none;">
                            <div class="mb-3">
                                <label for="newPassword" class="form-label">새 비밀번호</label>
                                <input type="password" class="form-control" id="newPassword" required>
                            </div>
                            <div class="mb-3">
                                <label for="confirmPassword" class="form-label">새 비밀번호 확인</label>
                                <input type="password" class="form-control" id="confirmPassword" required>
                            </div>
                            <button type="submit" class="btn btn-primary">비밀번호 변경</button>
                        </div>
                    </form>
                `;
                
                $('#passwordChangeContainer').html(passwordForm);
                
                $('#verifyCurrentPassword').click(function() {
                    var currentPwd = $('#currentPassword').val();
                    $.ajax({
                        url: '${pageContext.request.contextPath}/user/verifyCurrentPassword',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify({
                            id: '${loginUser.id}',
                            currentPassword: currentPwd
                        }),
                        success: function(response) {
                            if (response === 'success') {
                                $('#newPasswordFields').show();
                                $('#currentPassword, #verifyCurrentPassword').prop('disabled', true);
                            } else {
                                alert('현재 비밀번호가 올바르지 않습니다.');
                            }
                        }
                    });
                });
        	    
                $('#passwordChangeForm').submit(function(e) {
                    e.preventDefault();
                    var currentPwd = $('#currentPassword').val();
                    var newPwd = $('#newPassword').val();
                    var confirmPwd = $('#confirmPassword').val();
                    
                    if (newPwd !== confirmPwd) {
                        alert("새 비밀번호가 일치하지 않습니다.");
                        return;
                    }
        	        
        	        $.ajax({
        	            url: '${pageContext.request.contextPath}/user/updatePassword',
        	            type: 'POST',
        	            contentType: 'application/json',
        	            data: JSON.stringify({
        	                id: '${loginUser.id}',
        	                currentPassword: currentPwd,
        	                newPassword: newPwd
        	            }),
        	            success: function(response) {
        	                console.log('서버 응답:', response);
        	                if (response === 'success') {
        	                    alert('비밀번호가 성공적으로 변경되었습니다.');
        	                    $('#passwordChangeContainer').empty();
        	                } else if (response === 'wrongPassword') {
        	                    alert('현재 비밀번호가 올바르지 않습니다.');
        	                } else {
        	                    alert('비밀번호 변경에 실패했습니다.');
        	                }
        	            },
        	            error: function(xhr, status, error) {
        	                console.error('AJAX 오류:', xhr.responseText);
        	                alert('비밀번호 변경 중 오류가 발생했습니다.');
        	            }
        	        });
        	    });
        	    
                $('#cancelPasswordChange').click(function() {
                    $('#passwordChangeContainer').empty();
                });
            });
            
         	// 비밀번호 변경 버튼 표시 (소셜로그인 사용자들에게는!!)
            var isSocialLogin = ${fn:contains(user.id, '@') && fn:endsWith(user.id, '.com')};
            if (isSocialLogin) {
                $('#editPwdBtn').hide();
            }
            
            
            $('#deleteBtn').click(function() {
                if (confirm('정말로 탈퇴하시겠습니까? 이 작업은 되돌릴 수 없습니다.')) {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/user/delete',
                        type: 'POST',
                        success: function(response) {
                            if (response === 'success') {
                                alert('회원 탈퇴가 완료되었습니다.');
                                window.location.href = '${pageContext.request.contextPath}/';
                            } else {
                                alert('회원 탈퇴에 실패했습니다.');
                            }
                        }
                    });
                }
            });
        });
    </script>
</body>
</html>