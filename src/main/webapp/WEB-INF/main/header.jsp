<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- 최상단 고정 메뉴 바  -->
<div id="topMenu">
    <div id="logo">
        <img alt="로고" src="../image/booboobooklogo-remove.jpeg" id="logo_image" onclick="location='/BooBooBookProject/'">
    </div>
    <ul id="menu">
        <li><a href="/BooBooBookProject/bookboard/bookList">Book</a></li>
        <li><a href="#">Q&A</a></li>
        <li><a href="#">My Page</a></li>
    </ul>
    <ul id="authMenu">
        <li><a href="#">로그인</a></li>
        <li><a href="#">회원가입</a></li>
    </ul>
    <div id="hamburgerMenu" onclick="toggleMenu()">
        &#9776;
    </div>
</div>
