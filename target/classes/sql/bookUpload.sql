//mySQL
CREATE TABLE bookUpload (
seq INT(10) PRIMARY KEY AUTO_INCREMENT,
imageFileName VARCHAR(100) NOT NULL,
imageOriginalFileName VARCHAR(100) NOT NULL,
subject VARCHAR(255) NOT NULL,            -- 책의 제목
author VARCHAR(255) NOT NULL,             -- 책의 저자
content VARCHAR(500) NOT NULL,                    -- 책의 내용 요약
`like` INT(10) DEFAULT 0,                 -- 좋아요 수
view INT(10) DEFAULT 0,                   -- 조회수
reply INT(10) DEFAULT 0,                  -- 리뷰 댓글 수
rating DECIMAL(2,1) DEFAULT 0.0           -- 평균 별점
);