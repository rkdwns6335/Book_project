package book.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import book.bean.BookDTO;

@Repository
@Mapper
public interface BookDAO {

	public List<BookDTO> getBookList(Map<String, Integer> map);

	public int getTotalA();

	public void bookWrite(BookDTO dto);
	
}
