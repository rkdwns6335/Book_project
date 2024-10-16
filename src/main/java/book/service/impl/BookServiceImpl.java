package book.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import book.bean.BookDTO;
import book.bean.BookListPaging;
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
	
	
}
