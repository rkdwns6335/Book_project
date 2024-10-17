package admin.controller;

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

import admin.bean.QnaDTO;
import admin.service.AdminService;
import user.bean.UserDTO;

@Controller
@RequestMapping(value="/qna")
public class AdminController {
	@Autowired
	AdminService adminService;
	
	//qna 문의 글 목록
	@RequestMapping(value="/qnaList" , method=RequestMethod.GET)
    public String qnaList(@RequestParam(required = false, defaultValue="1") String pg, Model model, HttpSession session) {
		Map<String,Object> map = adminService.list(pg);
		map.put("pg", pg);
		model.addAttribute("map",map);
		model.addAttribute("totalA", map.get("totalA"));
		model.addAttribute("noCheck", map.get("noCheck"));
		model.addAttribute("pagingHTML", map.get("pagingHTML"));
		
		// 세션에서 사용자 정보 가져오기
	    UserDTO sessionUser = (UserDTO) session.getAttribute("loginUser");
	    String userId = (sessionUser != null) ? sessionUser.getId() : null; // userId가 null일 경우 처리를 추가
	    
	    model.addAttribute("userId", userId);
		
        return "/qna/qnaList"; 
    }
	
	//qna 문의 글 등록
	@RequestMapping(value="/qnaWriteForm" , method=RequestMethod.GET)
    public String qnaWriteForm(@RequestParam(required = false, defaultValue="1") String pg , Model model, HttpSession session) {
		UserDTO sessionUser = (UserDTO) session.getAttribute("loginUser");
	    String userId = (sessionUser != null) ? sessionUser.getId() : null; // userId가 null일 경우 처리를 추가

	    model.addAttribute("userId", userId);
	    
	    return "/qna/qnaWriteForm";
    }
	
	@RequestMapping(value = "/qnaWrite", method = RequestMethod.POST)
	@ResponseBody
    public void qnaWrite(@ModelAttribute QnaDTO qnaDTO) {
		System.out.println("qnaCheck: " + qnaDTO.getQnaCheck());
    	adminService.qnaWrite(qnaDTO);
    }
	
	@RequestMapping(value="/qnaReplyWrite")
	@ResponseBody
	public void qnaReplyWrite(@RequestParam Map<String, String> data) {
		int seq = Integer.parseInt(data.get("seq"));
		String replyContent = data.get("replyContent");
		System.out.println(seq);
		System.out.println(replyContent);
		adminService.qnaReplyWrite(seq, replyContent);
	}
	
	
	
}
