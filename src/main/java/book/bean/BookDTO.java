package book.bean;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class BookDTO {
	private int seq;
	private String imageFileName; 
	private String imageOriginalFileName;
	private String subject;
	private String author;
	private String content;
	private int like;
	private int view;
	private int reply;
	private float rating;
}
