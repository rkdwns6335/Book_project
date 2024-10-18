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
	<%@ include file="../main/header.jsp" %>
	
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
			                    <img alt="rating" src="../image/rating.png"/><span id="rating_num">${ data.rating }</span>
			                    <img alt="like" src="../image/like.png"/><span id="like_num">${ data.like }</span>
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
	    <div id="search_sort_div" style="margin-bottom: 20px;">
            <form id="searchForm" action="/BooBooBookProject/bookboard/bookList" method="GET">
            	<input type="hidden" name="pg" value="${map2.pg}"> <!-- 페이지 번호 유지 -->
            	
				<select name="searchType" id="searchType" style="height: 40px; padding: 7px 14px; border: 1px solid #ccc; border-radius: 4px; ">
					<option value="title" ${param.searchType == 'title' ? 'selected' : ''}>제목</option>
					<option value="content" ${param.searchType == 'content' ? 'selected' : ''}>저자</option>
					<option value="both" ${param.searchType == 'both' ? 'selected' : ''}>제목 + 저자</option>
				</select>
                
	            <input id="search" type="search" name="searchTerm" placeholder="검색어를 입력해주세요." value="${param.searchTerm}" style="height: 40px; width: 300px; padding: 7px; border: 1px solid #ccc; border-radius: 4px;">

                
                <button type="submit" class="foodreview_search_submit" style="height: 40px; padding: 0 20px; background-color: #555; color: white; border: none; cursor: pointer; border-radius: 4px;">
					검색
				</button>
                
                <div id="order" style="display: inline-block; margin-left: 10px;">
					<select name="sortType" id="sortType" onchange="this.form.submit();" style="height: 40px; padding: 7px 14px; border: 1px solid #ccc; border-radius: 4px;">
						<option value="seq" ${param.sortType == 'seq' ? 'selected' : ''}>최신순</option>
						<option value="like" ${param.sortType == 'like' ? 'selected' : ''}>좋아요순</option>
						<option value="rating" ${param.sortType == 'rating' ? 'selected' : ''}>별점순</option>
					</select>
				</div>
            </form>
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