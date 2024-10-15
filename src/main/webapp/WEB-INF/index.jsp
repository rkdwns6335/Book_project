<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>test</title>
<link rel="stylesheet" href="./css/index.css">
</head>
<body>
	<!-- 최상단 고정 메뉴 바  -->
	<div id="topMenu">
	    <div id="logo">
	        <img alt="로고" src="./image/booboobooklogo-remove.jpeg" id="logo_image" onclick="location='http://localhost:8080/booboobook/'" style="width:60px; height:60px; cursor: pointer;">
	    </div>
	    <ul id="menu">
	        <li><a href="#">Book</a></li>
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

	<section id="inc01">
	   <div class="big_txt">
	      <p class="b_txt">나의 생활과 인생에</p>
	      <p class="b_txt">한줄기 위로가</p>
	      <p class="b_txt">하나의 지식이 필요할 때</p>
	     <p class="b_txt">BOOBOOBOOK에서..</p>
	   </div>
	</section>
	<div class="marquee_title">
    	<h2>BooBooBook List</h2>
  	</div>
  	<div class="marquee_conts">
	     <ul>
	      <li class="big">
	       <a href="javascript:">
	         <img src="./image/book1.jpeg" alt="sample"/>
	       </a>
	     </li>
	      <li class="small">
	       <a href="javascript:">
	         <img src="./image/book2.jpeg" alt="sample"/>
	       </a>
	     </li>
	      <li class="big">
	       <a href="javascript:">
	         <img src="./image/book3.jpeg" alt="sample"/>
	       </a>
	     </li>
	      <li class="small">
	       <a href="javascript:">
	         <img src="./image/book4.jpeg" alt="sample"/>
	       </a>
	     </li>
	      <li class="big">
	       <a href="javascript:">
	         <img src="./image/book5.jpeg" alt="sample"/>
	       </a>
	     </li>
	      <li class="small">
	       <a href="javascript:">
	         <img src="./image/book6.jpeg" alt="sample"/>
	       </a>
	     </li>
	       <li class="big">
	       <a href="javascript:">
	         <img src="./image/book7.jpeg" alt="sample"/>
	       </a>
	     </li>
	      <li class="small">
	       <a href="javascript:">
	         <img src="./image/book8.jpeg" alt="sample"/>
	       </a>
	     </li>
   		</ul>
  	</div>
  	<div class="marquee_conts2">
	    <ul>
	      <li class="big">
	       <a href="javascript:">
	         <img src="./image/book9.jpeg" alt="sample"/>
	       </a>
	     </li>
	      <li class="small">
	       <a href="javascript:">
	         <img src="./image/book10.jpeg" alt="sample"/>
	       </a>
	     </li>
	      <li class="big">
	       <a href="javascript:">
	         <img src="./image/book11.jpeg" alt="sample"/>
	       </a>
	     </li>
	      <li class="small">
	       <a href="javascript:">
	         <img src="./image/book12.jpeg" alt="sample"/>
	       </a>
	     </li>
	      <li class="big">
	       <a href="javascript:">
	         <img src="./image/book13.jpeg" alt="sample"/>
	       </a>
	     </li>
	      <li class="small">
	       <a href="javascript:">
	         <img src="./image/book14.jpeg" alt="sample"/>
	       </a>
	     </li>
	       <li class="big">
	       <a href="javascript:">
	         <img src="./image/book15.jpeg" alt="sample"/>
	       </a>
	     </li>
	      <li class="small">
	       <a href="javascript:">
	         <img src="./image/book16.jpeg" alt="sample"/>
	       </a>
	     </li>
   		</ul>
  	</div>
  	<div class="marquee_title">
  		<h2>Bestseller</h2>
  	</div>
	<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet">

	<section class="hero-section">
	  <div class="card-grid">
	    <a class="card" href="#">
	      <div class="card__background" style="background-image: url(./image/book12.jpeg)"></div>
	      <div class="card__content">
	        <p class="card__category">한강</p>
	        <h3 class="card__heading">채식주의자</h3>
	      </div>
	    </a>
	    <a class="card" href="#">
	      <div class="card__background" style="background-image: url(./image/book8.jpeg)"></div>
	      <div class="card__content">
	        <p class="card__category">무라카미 하루키</p>
	        <h3 class="card__heading">도시와 그 불확실한 벽</h3>
	      </div>
	    </a>
	    <a class="card" href="#">
	      <div class="card__background" style="background-image: url(./image/book1.jpeg)"></div>
	      <div class="card__content">
	        <p class="card__category">정유정</p>
	        <h3 class="card__heading">영원한 천국</h3>
	      </div>
	    </li>
	    <a class="card" href="#">
	      <div class="card__background" style="background-image: url(./image/book5.jpeg)"></div>
	      <div class="card__content">
	        <p class="card__category">한아야나리하라</p>
	        <h3 class="card__heading">리틀 라이프</h3>
	      </div>
	    </a>
	  <div>
	</section>
	<section id="audiodrama" class="audiodrama-section animation">
		<div class="section-wrap">
			<div class="text-wrap">
				<h2>
					나에게 휴식과 안정을
					<br>
					책임지는 오디오북
				</h2>
				<p>
					생생한 오디오를 통해
					<br>
					책의 세계에 빠져보세요.
				</p>
			</div>
			<div class="video-wrap">
				<div class="video-poster">
					<img data-v-003e81a0="" 
					src="./image/audioImage.jpg" 
					alt="나만의 공간을 아름답게 채워주는 오브제북">
				</div>
			</div>
		</div>
	</section>
	
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery.marquee@1.6.0/jquery.marquee.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.4/gsap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.4/ScrollTrigger.min.js"></script>
<script type="text/javascript">
let marquee = $(".marquee_conts").marquee({
    duration: 25000,
    delayBeforeStart: 500,
    direction: "left",
    startVisible: true,
    duplicated: true,
  });
let marquee2 = $(".marquee_conts2").marquee({
    duration: 25000,
    delayBeforeStart: 500,
    direction: "right",
    startVisible: true,
    duplicated: true,
  });

marqueePaused = false;

$("ul > li").mouseenter(function () {
    if (!marqueePaused) {
      marquee.marquee("pause");
      marquee2.marquee("pause");
    }
});

$("ul > li").mouseleave(function () {
    if (!marqueePaused) {
      marquee.marquee("resume");
      marquee2.marquee("resume");
    }
});



const textElements = gsap.utils.toArray('#inc01 .b_txt');
textElements.forEach(text => {
	gsap.to(text, {
		backgroundSize: '100%',
		ease: 'none',
		scrollTrigger: {
			trigger: text,
			start: 'center 30%',
			end: 'center 30%',
			scrub: true,
		},
	});
});


function toggleMenu() {
    const menu = document.getElementById("menu");
    const authMenu = document.getElementById("authMenu");
    menu.classList.toggle("active");
    authMenu.classList.toggle("active");
}



</script>	
</body>
</html>