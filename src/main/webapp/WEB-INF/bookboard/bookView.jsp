<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book View</title>
<link rel="stylesheet" href="../css/header.css">
<link rel="stylesheet" href="../css/bookView.css">
</head>
<body>
	<!-- 상단 탑 메뉴바 -->
	<%@ include file="../main/header.jsp" %>
	
	<!-- content -->
	<div id="bookView_div">
		<div id="bookView_div_left"> 
			<div class="image_part">
				<img src="https://kr.object.ncloudstorage.com/bitcamp-9th-bucket-141/storage/${bookDTO.imageFileName}" alt="${ bookDTO.subject }"/>
			</div>
		</div>
		<div id="bookView_div_right">
			<div class="top_book">
				<div class="top_subject">
					<h2 class="book_name">${bookDTO.subject}</h2>
					<!-- 세션 값 받아오면 이 부분 admin만 볼수있도록 할 것 -->
					<c:if test="${userId == 'admin'}">
						<div id="delete_zone">
							<form action="/BooBooBookProject/bookboard/bookDelete" id="delete_go">
			            		<input type="hidden" name="seq" value="${ seq }">
						  		<button class="btn-delete" id="delete_button">삭제</button>
						  	</form>
						</div>
						<div id="delete_zone">
							<form action="/BooBooBookProject/bookboard/bookUpdateform" id="update_go">
			            		<input type="hidden" name="seq" value="${ seq }">
						  		<button class="btn-update" id="update_button">수정</button>
						  	</form>
						</div>
					</c:if>
					<!-- 여기까지 -->
				</div>
				<span class="top_author">
					저자 : ${bookDTO.author} 
				</span>
				<span class="top_rating">
					<span id="star-rating">
						<div class="star-rating" data-grade="${bookDTO.rating}">
						    <span class="star">&#9733;</span>
						    <span class="star">&#9733;</span>
						    <span class="star">&#9733;</span>
						    <span class="star">&#9733;</span>
						    <span class="star">&#9733;</span>
						</div>
						<div id="score-rating">
							평점 : ${bookDTO.rating}&nbsp;&nbsp;&nbsp;&nbsp;좋아요 : ${bookDTO.like}&nbsp;&nbsp;&nbsp;
							<form action="/BooBooBookProject/bookboard/reviewLike" id="like_go">
			            		<input type="hidden" name="like_seq" value="${ seq }">
						  		<button class="btn-like" id="like_button"><img id="like_image" alt="like" src="../image/like.png"/></button>
						  	</form>
						</div>
					</span>
					<span class="reply_count">
						리뷰 ( ${ bookDTO.reply}개 )
					</span>
				</span>
			</div>
			<div class="bottom_book">
				<div class="book_content">
					<pre>${ bookDTO.content}</pre>
				</div>
			</div>
		</div>
	</div>
	<div class="review-list">
		<div class="review-form">
			<span id="review_title">리뷰</span>
             <form action="/BooBooBookProject/bookboard/reviewform" method="post" id="review_form">
                 <input type="hidden" name="ref" value="${seq}">
                 <input type="hidden" id="id" name="id" value="test">
                 <input type="hidden" id="grade" name="grade" value="">
                 <textarea id="reviewcontent" name="reviewcontent" placeholder="리뷰를 입력하세요"></textarea>
                 <div class="star-group">
				    <label for="grade_star-input">평점 입력</label>
				    <div class="star-rating-input">
				        <input type="radio" id="star5" name="grade_star" value="5" />
				        <label for="star5" class="star-input">&#9733;</label>
				        <input type="radio" id="star4" name="grade_star" value="4" />
				        <label for="star4" class="star-input">&#9733;</label>
				        <input type="radio" id="star3" name="grade_star" value="3" />
				        <label for="star3" class="star-input">&#9733;</label>
				        <input type="radio" id="star2" name="grade_star" value="2" />
				        <label for="star2" class="star-input">&#9733;</label>
				        <input type="radio" id="star1" name="grade_star" value="1" />
				        <label for="star1" class="star-input">&#9733;</label>
				    </div>
				 </div>
                 <button type="button" id="review_button" class="btn btn-dark">리뷰 작성</button>
             </form>
         </div>
		<ul>
			<c:forEach var="review" items="${reviewList}">
				<li>
					<div class="review-author">
                       <img src="../image/reply.png">&nbsp;${review.id}&nbsp;&nbsp;&nbsp;
                       <form id="report_form" action="/BooBooBookProject/bookboard/reviewWrite">
	                    	<input type="hidden" class="review_id" name="review_id" value="${review.id}">
	                    	<input type="hidden" name="seq" value="${ seq }">
			            </form>
                    </div>
                    <div class="review-content"><pre>${review.reviewcontent}</pre></div>	
                    <button class="btn-reply" id="replyreply_button" onclick="toggleReplyForm('${review.seq}')">답글 달기</button>
                    <!-- 답글 목록 -->
                    <ul class="reply-reply-list">
                        <c:forEach var="replyreply" items="${replyreplyList}">
                            <c:if test="${review.seq == replyreply.refref}">                    		
                           		<li>
                                   <div class="reply-reply-author">↳ &nbsp;${replyreply.replyreplyid}</div>
                                   <div class="reply-reply-content"><pre>${replyreply.replyreplycontent}</pre></div>
                   				</li>
                    		</c:if>
                        </c:forEach>
                    </ul>
                    <!-- 답글 작성 폼 (숨김 상태) -->
                    <div id="reply-form-${review.seq}" class="reply-reply-form" style="display:none;">
					    <form action="/BooBooBookProject/bookboard/replyreplyWrite" method="post">
					   		<input type="hidden" name="ref" value="${seq}">
							<input type="hidden" name="refref" value="${review.seq}"/>
                    		<input type="hidden" name="subject" value="답글">
							<textarea name="replyreplycontent" placeholder="답글을 입력하세요"></textarea>
					        <button type="submit" class="btn btn-dark">답글 작성</button>
					    </form>
					</div>	  	
				</li>
			</c:forEach>
		</ul>
	</div>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript">

$(function(){
	$('#review_button').click(function(){
		if($('#id').val()!=="" && $('#reviewcontent').val()!=="" && $('#grade').val()!==""){
			$('#review_form').submit();
		}else{
			alert("리뷰 내용을 입력해주세요!");
		}
	});
});

$('.star-rating-input input').change(function() {
    var selectedRating = $(this).val(); 
    console.log("선택된 평점:", selectedRating);
    $('#grade').val(selectedRating);
});

function toggleReplyForm(reviewSeq) {
    var form = document.getElementById('reply-form-' + reviewSeq);
    if (form.style.display === 'none') {
        form.style.display = 'block';
    } else {
        form.style.display = 'none';
    }
}

document.addEventListener("DOMContentLoaded", function() {
    var ratingElement = document.querySelector('.star-rating');
    var rating = parseFloat(ratingElement.getAttribute('data-grade'));
    
    // 별의 개수 및 소수점 계산
    var fullStars = Math.floor(rating);
    var halfStar = (rating % 1) >= 0.5 ? 1 : 0;

    // 별 색상 변경
    for (let i = 0; i < fullStars; i++) {
        ratingElement.children[i].style.color = '#FFD700'; // 채워진 별 색상
    }
    if (halfStar) {
        ratingElement.children[fullStars].style.color = '#FFD700'; // 반 별 색상 처리 (이 부분은 CSS로 커버 가능)
    }
});

</script>	
</body>
</html>