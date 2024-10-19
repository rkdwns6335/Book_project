package book.service;

import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import book.bean.BookDTO;
import book.bean.ReviewDTO;

public interface BookService {

	public Map<String, Object> getBookList(String pg, String searchType, String searchTerm, String sortType);

	public void bookWrite(BookDTO dto);

	public BookDTO getBookDTO(String seq);

	public void reviewform(ReviewDTO reviewDTO);

	public Map<String, Object> getReviewList(String seq);

	public float getPresentRating(int nowSeq);

	public void updateRating(float nowRating, int nowSeq);

	public void updateReply(int nowSeq);

	public void updateLike(int like_seq);

	public void bookDelete(int seq);

	public void updateBook(BookDTO bookDTO, MultipartFile img);

	public int reviewCnt(String userId);

	public void reviewdelete(int review_seq);

	public void updateReplydown(int seq);

	

}
