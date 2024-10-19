package user.controller;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import user.bean.UserDTO;
import user.service.UserService;

@Controller
@RequestMapping("/mypage")
public class MyPageController {
    
    @Autowired
    private UserService userService;

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
        
        return "/mypage/myPage";
    }
}
