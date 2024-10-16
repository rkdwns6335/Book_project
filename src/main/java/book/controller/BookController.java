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
import book.service.BookService;
import book.service.ObjectStorageService;

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
	public String bookList(@RequestParam(required = false, defaultValue="1") String pg, Model model) {
		Map<String, Object> map2 = bookService.getBookList(pg);
		
		map2.put("pg", pg);
		
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
	
}
