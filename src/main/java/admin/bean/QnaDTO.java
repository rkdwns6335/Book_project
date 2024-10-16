package admin.bean;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class QnaDTO {
	private int seq;
	private String qnaId;
	private String qnaCheck;
	private String qnaUserContent;
	private String qnaAdminContent;
	private Date logtime;
}
