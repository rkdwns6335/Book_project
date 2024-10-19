package user.controller;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import admin.service.AdminService;
import book.service.BookService;
import user.bean.UserDTO;
import user.service.UserService;

@Controller
@RequestMapping("/mypage")
public class MyPageController {
    
    @Autowired
    private UserService userService;
    @Autowired
    private BookService bookService;
    @Autowired
    private AdminService adminService;

    @GetMapping("/myPage")
    public String myPage(Model model, HttpSession session) {
        UserDTO user = (UserDTO) session.getAttribute("loginUser");
        if (user == null) {
            return "redirect:/"; // 로그인되지 않은 경우 메인 페이지로 리다이렉트
        }
        model.addAttribute("user", user);
        
        // 비밀번호가 @1234567890인지 확인
        boolean isSocialPassword = userService.isSocialPassword(user.getId());
        model.addAttribute("isSocialPassword", isSocialPassword);
        
        int reviewCnt = bookService.reviewCnt(user.getId()); //자신이 쓴 리뷰 수
        int qnaCnt = adminService.qnaCnt(user.getId()); // 자신이 쓴 문의글 수
        
        model.addAttribute("reviewCnt", reviewCnt == 0 ? 0 : reviewCnt); // 쓴 글이 없으면 0으로 출력
        model.addAttribute("qnaCnt", qnaCnt == 0 ? 0 : qnaCnt); // 쓴 글이 없으면 0으로 출력
        
        return "/mypage/myPage";
    }
}
