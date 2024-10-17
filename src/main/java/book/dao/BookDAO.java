package book.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import book.bean.BookDTO;
import book.bean.ReviewDTO;

@Repository
@Mapper
public interface BookDAO {

	public List<BookDTO> getBookList(Map<String, Integer> map);

	public int getTotalA();

	public void bookWrite(BookDTO dto);

	public BookDTO getBookDTO(String seq);

	public void reviewform(ReviewDTO reviewDTO);

	public List<ReviewDTO> getReviewList(String seq);

	public float getPresentRating(int nowSeq);

	public void updateRating(Map<String, Object> map);

	public void updateReply(int nowSeq);

	public void updateLike(int like_seq);

	public void bookDelete(int seq);

	public String getImageFileName(int seq);

	public void updateBook(BookDTO bookDTO);
	
}
