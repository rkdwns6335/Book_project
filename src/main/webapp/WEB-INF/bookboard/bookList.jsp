<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book List</title>
<link rel="stylesheet" href="../css/header.css">
<link rel="stylesheet" href="../css/bookList.css">
</head>
<body>
	<!-- 상단 탑 메뉴바 -->
	<jsp:include page="../main/header.jsp" />
	
	<!-- content -->
	<div id="book_div">
		<ul class="book_list">
			<c:forEach var="data" items="${ map2.getBookList }">
				<li>
					<div class="book_main_content">
						<a href="/BooBooBookProject/bookboard/bookView?seq=${ data.seq }" class="book_content_a">
							<span class="book_image">
								<img alt="food_image" src="https://kr.object.ncloudstorage.com/bitcamp-9th-bucket-141/storage/${data.imageFileName}">
								<!-- <img alt="food_image" src="https://kr.object.ncloudstorage.com/bitcamp-9th-bucket-141/storage/book1.jpeg">-->
							</span>
							<div class="book_subject">
			                    <p>${ data.subject }</p>
			                </div>
			                <div class="book_mini">
			                    <img alt="like" src="../image/like.png"/><span id="like_num">${ data.like }</span>
			                    <img alt="eye" src="../image/eye.png"/><span id="view_num">${ data.view }</span>
			                    <img alt="reply" src="../image/reply.png"/><span id="reply_num">${ data.reply }</span>
			                </div>
						</a>
					</div>
				</li>
			</c:forEach>
		</ul>
		<div style='text-align: center; margin: 20px 0;'>
	    	<div>${ map2.bookListPaging.pagingHTML } </div>
	    </div>
	</div>
	

<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript">

function toggleMenu() {
    const menu = document.getElementById("menu");
    const authMenu = document.getElementById("authMenu");
    menu.classList.toggle("active");
    authMenu.classList.toggle("active");
}

</script>
</body>
</html>