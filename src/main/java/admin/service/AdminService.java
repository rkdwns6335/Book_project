package admin.service;

import java.util.Map;

import admin.bean.QnaDTO;

public interface AdminService {

	Map<String, Object> list(String pg); // QnA 목록

	public void qnaWrite(QnaDTO qnaDTO); // QnA 문의글 등록( 사용자 )

	public void qnaReplyWrite(int seq, String replyContent); // QnA 문의글 답글 ( 관리자 )

	public int qnaCnt(String id);
}
