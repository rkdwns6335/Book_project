package book.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import book.bean.BookDTO;
import book.bean.BookListPaging;
import book.bean.ReviewDTO;
import book.dao.BookDAO;
import book.service.BookService;
import book.service.ObjectStorageService;

@Service
public class BookServiceImpl implements BookService{
	@Autowired
	private BookDAO bookDAO;
	
	@Autowired
	private BookListPaging bookListPaging;
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private ObjectStorageService objectStorageService;
	
	private String bucketName = "bitcamp-9th-bucket-141";

	@Override
	public Map<String, Object> getBookList(String pg) {
		int endNum = 16;
		int startNum = (Integer.parseInt(pg)-1) * 16;
		
		Map<String, Integer> map = new HashMap<>();
		map.put("startNum", startNum);
		map.put("endNum", endNum);
		
		//DB
		List<BookDTO> getBookList = bookDAO.getBookList(map);
		
		
		//paging
		int totalA = bookDAO.getTotalA();
		bookListPaging.setCurrentPage(Integer.parseInt(pg));
		bookListPaging.setPageBlock(3);
		bookListPaging.setPageSize(16);
		bookListPaging.setTotalA(totalA);
		bookListPaging.makePagingHTML();
		
		Map<String, Object> map2 = new HashMap<>();
		map2.put("getBookList", getBookList);
		map2.put("bookListPaging", bookListPaging);
		
		
		return map2;
	}

	@Override
	public void bookWrite(BookDTO dto) {
		bookDAO.bookWrite(dto);
	}

	@Override
	public BookDTO getBookDTO(String seq) {
		return bookDAO.getBookDTO(seq);
	}

	@Override
	public void reviewform(ReviewDTO reviewDTO) {
		bookDAO.reviewform(reviewDTO);
	}

	@Override
	public Map<String, Object> getReviewList(String seq) {
		
		List<ReviewDTO> reviewList = bookDAO.getReviewList(seq);
		
		Map<String, Object> map2 = new HashMap<>();
		map2.put("reviewList", reviewList);
		return map2;
	}

	@Override
	public float getPresentRating(int nowSeq) {
		float getRating = bookDAO.getPresentRating(nowSeq);
		return getRating;
	}

	@Override
	public void updateRating(float nowRating, int nowSeq) {
		Map<String, Object> map = new HashMap<>();
		
		map.put("nowRating", nowRating);
		map.put("nowSeq", nowSeq);
		
		bookDAO.updateRating(map);
	}

	@Override
	public void updateReply(int nowSeq) {	
		bookDAO.updateReply(nowSeq);
	}

	@Override
	public void updateLike(int like_seq) {
		bookDAO.updateLike(like_seq);
	}

	@Override
	public void bookDelete(int seq) {
		String filePath = session.getServletContext().getRealPath("WEB-INF/storage");
		System.out.println("실제 폴더 = " + filePath);
		
		String imageFileName = bookDAO.getImageFileName(seq);
		objectStorageService.deleteFile(bucketName,"storage/",imageFileName);
		
		bookDAO.bookDelete(seq);
	}

	@Override
	public void updateBook(BookDTO bookDTO, MultipartFile img) {
		String filePath = session.getServletContext().getRealPath("WEB-INF/storage");
		System.out.println("실제 폴더 = " + filePath);
		
		String imageFileName = bookDAO.getImageFileName(bookDTO.getSeq());
		System.out.println("imageFileName = " + imageFileName);
		
		objectStorageService.deleteFile(bucketName,"storage/",imageFileName); //기존 파일 삭제
		
		// 새로운 이미지 파일 업로드 전에 유효성 검사
		if (img.isEmpty() || img.getSize() == 0) {
	        throw new RuntimeException("업로드할 이미지 파일이 없습니다.");
	    }
		
		//새 이미지 파일 업로드 전에 중복 체크를 해야한다.
		String newImageFileName = UUID.randomUUID().toString();
	    if (objectStorageService.doesFileExist(bucketName, "storage/", newImageFileName)) {
	        throw new RuntimeException("이미 동일한 파일이 존재합니다.");
	    }
		
		imageFileName = objectStorageService.uploadFile(bucketName, "storage/", img);
		
		String imageOriginalFileName = img.getOriginalFilename();
		File file = new File(filePath, imageOriginalFileName);
		
		// 로컬에 파일이 존재하면 삭제 후 새로운 파일 저장
	    if (file.exists()) {
	        file.delete(); // 기존 파일 삭제
	    }
		
		try {
			img.transferTo(file);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		bookDTO.setImageFileName(imageFileName);
		bookDTO.setImageOriginalFileName(imageOriginalFileName);
		
		bookDAO.updateBook(bookDTO);
	}
	
	
}
