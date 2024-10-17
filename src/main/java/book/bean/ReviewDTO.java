package book.bean;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class ReviewDTO {
	private int seq;
	private String id;
	private int grade;
	private String reviewcontent;
	private int ref;
}
