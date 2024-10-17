CREATE TABLE bookReview (
    seq INT AUTO_INCREMENT PRIMARY KEY,
    id VARCHAR(255) NOT NULL,
    grade INT CHECK (grade >= 0 AND grade <= 5), 
    reviewcontent VARCHAR(500) NOT NULL,
    ref INT NOT NULL
);