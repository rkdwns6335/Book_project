package book.service;

import java.util.Map;

import book.bean.BookDTO;

public interface BookService {

	public Map<String, Object> getBookList(String pg);

	public void bookWrite(BookDTO dto);

	

}
