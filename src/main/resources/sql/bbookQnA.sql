Create Table BBookQnA(
    seq INT PRIMARY KEY AUTO_INCREMENT,            	  	 	   -- 글 번호 (자동 증가)
    qnaId VARCHAR(100) NOT NULL,                  	 	       -- 글 작성자
    qnaCheck CHAR(1) NOT NULL,                   	 	       -- 비밀 글인지 아닌지
    qnaUserContent VARCHAR(4000) NOT NULL,        	   		   -- 유저 문의 글 내용
    qnaAdminContent VARCHAR(4000),                   		   -- 관리자 답글 내용
    logtime DATETIME DEFAULT CURRENT_TIMESTAMP    	 		   -- 글 작성 날짜 (현재 시간으로 기본값 설정)
);


