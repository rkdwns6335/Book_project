package book.controller;


import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import book.bean.BookDTO;
import book.bean.ReviewDTO;
import book.service.BookService;
import book.service.ObjectStorageService;
import user.bean.UserDTO;

@Controller
public class BookController {
	@Autowired
	private BookService bookService;
	
	@Autowired
	private ObjectStorageService objectStorageService;
	
	private String bucketName = "bitcamp-9th-bucket-141";
	
	@RequestMapping(value="/bookboard/bookListForm")
	public String bookListForm() {
		return "/bookboard/bookListForm";
	}
	
	@RequestMapping(value="/bookboard/bookList", method=RequestMethod.GET)
	public String bookList(@RequestParam(required = false, defaultValue="1") String pg, Model model, 
						   String searchType, String searchTerm, String sortType) {
		Map<String, Object> map2 = bookService.getBookList(pg, searchType , searchTerm , sortType);
		
		map2.put("pg", pg);
		map2.put("searchType", searchType);
		map2.put("searchTerm", searchTerm);
		map2.put("sortType", sortType);
		
		model.addAttribute("map2",map2);
		
		return "/bookboard/bookList";
	}
	
	@RequestMapping(value="/bookboard/upload", method=RequestMethod.POST, produces="text/html; charset=UTF-8")
	@ResponseBody
	public void upload(@ModelAttribute BookDTO bookDTO,
						 @RequestParam("img[]") List<MultipartFile> list,
						 HttpSession session) {
		
		//실제폴더
		String filePath = session.getServletContext().getRealPath("WEB-INF/storage");
		System.out.println("실제 폴더 = " + filePath);
		
		String imageOriginalFileName;
		String imageFileName;
		File file;
		String result = "";
		
		//파일들을 모아서 DB
		List<BookDTO> imageUploadList = new ArrayList<>();
		
		for(MultipartFile img  : list) {

			//네이버 클라우드 Object Storage ------------------------------------
			imageFileName = objectStorageService.uploadFile(bucketName, "storage/", img);
			//---------------------------------------------------------------
			
			imageOriginalFileName = img.getOriginalFilename();
			file = new File(filePath, imageOriginalFileName);
			
			try {
				img.transferTo(file);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			//filename get	
			BookDTO dto = new BookDTO();
			dto.setSubject(bookDTO.getSubject());
			dto.setAuthor(bookDTO.getAuthor());
			dto.setContent(bookDTO.getContent());
			dto.setImageFileName(imageFileName);
			dto.setImageOriginalFileName(imageOriginalFileName);
			
			imageUploadList.add(dto);
			
		}//for
		
		//DB
		for (BookDTO dto : imageUploadList) {
			bookService.bookWrite(dto);
        }
		
	}
	
	@RequestMapping(value="/bookboard/bookView")
	public String bookView(@RequestParam String seq, Model model , HttpSession session) {
		BookDTO bookDTO = bookService.getBookDTO(seq);
		
		Map<String, Object> map2 = bookService.getReviewList(seq);
		
		UserDTO sessionUser = (UserDTO) session.getAttribute("loginUser");
	    String userId = (sessionUser != null) ? sessionUser.getId() : null;
	    System.out.println("userId : "+ userId);
	    
	    model.addAttribute("userId", userId);
		
		model.addAttribute("bookDTO",bookDTO);
		model.addAttribute("seq",seq);
		model.addAttribute("reviewList",map2.get("reviewList"));
		
		return "/bookboard/bookView";
	}
	
	@RequestMapping(value="/bookboard/reviewform", method=RequestMethod.POST)
	public String reviewform(@ModelAttribute ReviewDTO reviewDTO) {
		int nowSeq = reviewDTO.getRef();
		
		bookService.reviewform(reviewDTO);
		
		float nowRating = bookService.getPresentRating(nowSeq); //넣어준 리뷰댓글의 평점을 계산하고 와줌
		
		bookService.updateRating(nowRating, nowSeq); //평점값을 계산해서 bookupload 테이블 업데이트 해줌
		
		bookService.updateReply(nowSeq);
		
		return "redirect:/bookboard/bookView?seq="+reviewDTO.getRef();
	}
	
	@RequestMapping(value="/bookboard/reviewLike", method=RequestMethod.GET)
	public String reviewLike(@RequestParam int like_seq) {
		bookService.updateLike(like_seq);
		
		return "redirect:/bookboard/bookView?seq="+like_seq;
	}
	
	@RequestMapping(value="/bookboard/bookDelete", method=RequestMethod.GET)
	public String bookDelete(@RequestParam int seq) {
		bookService.bookDelete(seq);
		
		return "redirect:/bookboard/bookList";
	}
	
	@RequestMapping(value="/bookboard/bookUpdateform")
	public String bookUpdateform(@RequestParam String seq, Model model){
		BookDTO bookDTO = bookService.getBookDTO(seq);
		model.addAttribute("seq",seq);
		model.addAttribute("bookDTO",bookDTO);
		
		return "/bookboard/bookUpdateform";
	}
	
	@RequestMapping(value="/bookboard/updateBook")
	public String updateBook(@ModelAttribute BookDTO bookDTO,
					      @RequestParam("img[]") MultipartFile img){
		bookService.updateBook(bookDTO, img);
		return "redirect:/bookboard/bookList";
	}
	
}
