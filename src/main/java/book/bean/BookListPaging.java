package book.bean;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Component
@Getter
@Setter
public class BookListPaging {
	private int currentPage;
	private int pageBlock; 
	private int pageSize; 
	private int totalA; 
	private StringBuffer pagingHTML;
	
	public void makePagingHTML() {
		pagingHTML = new StringBuffer();
		
		int totalP = (totalA + pageSize-1) / pageSize;
		
		int startPage = (currentPage-1) / pageBlock * pageBlock + 1 ;
		int endPage = startPage + pageBlock - 1;
		if(endPage > totalP) endPage = totalP;
		
		if(startPage != 1)
			pagingHTML.append("<a class='paging' href='/BooBooBookProject/bookboard/bookList?pg="+ (startPage-1) + "'>이전</a>");
	
		for(int i = startPage;i<=endPage;i++) {
			if(i == currentPage)
				pagingHTML.append("<a class='currentpaging' href='/BooBooBookProject/bookboard/bookList?pg="+ i + "'>" + i + "</a>");
			else
				pagingHTML.append("<a class='paging' href='/BooBooBookProject/bookboard/bookList?pg="+ i + "'>" + i + "</a>");
		}
		
		if(endPage < totalP)
			pagingHTML.append("<a class='paging' href='/BooBooBookProject/bookboard/bookList?pg="+ (endPage+1) + "'>다음</a>");
		
		
	}
}
