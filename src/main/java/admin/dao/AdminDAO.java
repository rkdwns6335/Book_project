package admin.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import admin.bean.QnaDTO;

@Mapper
public interface AdminDAO {

	public List<QnaDTO> list(Map<String, Integer> map); // qna 문의 게시판 목록

	public int getTotalA(); // 문의 게시판 총 글 수

	public int noCheck(); // 문의 게시판 답글이 안 달린 글 수

	public void qnaWrite(QnaDTO qnaDTO); // 문의글 등록 ( 사용자 )

	public void qnaReplyWrite(@Param("seq") int seq, @Param("replyContent") String replyContent); // 문의글 답글 ( 관리자 )

}
