package user.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import user.bean.UserDTO;
import user.service.UserService;

@RestController
@RequestMapping("/user")
public class UserController {
    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private UserService userService;
    
    @PostMapping("/register")
    public String register(UserDTO userDTO, HttpSession session) {
        String result = userService.register(userDTO);
        if("success".equals(result)) {
            UserDTO sessionUser = new UserDTO();
            sessionUser.setId(userDTO.getId());
            sessionUser.setName(userDTO.getName());
            sessionUser.setEmail(userDTO.getEmail());
            // 비밀번호는 세션에 저장 NONO!!
            session.setAttribute("loginUser", sessionUser);
        }
        return result;
    }
        
    @PostMapping("/sendVerificationEmail")
    public String sendVerificationEmail(@RequestParam String email) {
        try {
            String result = userService.sendVerificationEmail(email);
            if ("success".equals(result)) {
                return "success";
            } else {
                logger.error("Failed to send verification email: {}", result);
                return "이메일 전송에 실패했습니다: " + result;
            }
        } catch (Exception e) {
            logger.error("Error while sending verification email", e);
            return "서버 오류가 발생했습니다. 나중에 다시 시도해주세요.";
        }
    }
    
    @PostMapping("/verifyCode")
    public String verifyCode(@RequestParam String email, @RequestParam String verificationCode) {
        return userService.verifyCode(email, verificationCode);
    }
    
    @PostMapping("/login")
    public String login(@RequestParam String id, @RequestParam String pwd, HttpSession session) {
        UserDTO userDTO = userService.login(id, pwd);
        if (userDTO != null) {
            // 로그인 성공 시 세션에 사용자 정보 저장
            session.setAttribute("loginUser", userDTO);
            return "success";
        }
        return "fail";
    }
    
    @PostMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "success";
    }
    
    @PostMapping("/checkId")
    public ResponseEntity<String> checkId(@RequestParam String id) {
        boolean isExist = userService.isIdExists(id);
        if (isExist) {
            return ResponseEntity.ok("duplicate");
        } else {
            return ResponseEntity.ok("available");
        }
    }
    
    @PostMapping("/updateName")
    @ResponseBody
    public String updateName(@RequestBody UserDTO user, HttpSession session) {
        try {
            userService.updateName(user);
            UserDTO sessionUser = (UserDTO) session.getAttribute("loginUser");
            sessionUser.setName(user.getName());
            session.setAttribute("loginUser", sessionUser);
            return "success";
        } catch (Exception e) {
            return "error";
        }
    }
    
    @PostMapping("/verifyCurrentPassword")
    @ResponseBody
    public String verifyCurrentPassword(@RequestBody Map<String, String> passwordData, HttpSession session) {
        try {
            UserDTO sessionUser = (UserDTO) session.getAttribute("loginUser");
            String currentPassword = passwordData.get("currentPassword");
            
            if (userService.verifyPassword(sessionUser.getId(), currentPassword)) {
                logger.info("현재 비밀번호 확인 성공: {}", sessionUser.getId());
                return "success";
            } else {
                logger.warn("잘못된 현재 비밀번호: {}", sessionUser.getId());
                return "wrongPassword";
            }
        } catch (Exception e) {
            logger.error("현재 비밀번호 확인 중 오류 발생", e);
            return "error";
        }
    }
    
    @PostMapping("/updatePassword")
    @ResponseBody
    public String updatePassword(@RequestBody Map<String, String> passwordData, HttpSession session) {
        try {
            logger.info("비밀번호 변경 요청 받음: {}", passwordData);
            UserDTO sessionUser = (UserDTO) session.getAttribute("loginUser");
            String currentPassword = passwordData.get("currentPassword");
            String newPassword = passwordData.get("newPassword");
            
            if (userService.verifyPassword(sessionUser.getId(), currentPassword)) {
                userService.updatePassword(sessionUser.getId(), newPassword);
                logger.info("비밀번호 변경 성공: {}", sessionUser.getId());
                return "success";
            } else {
                logger.warn("잘못된 현재 비밀번호: {}", sessionUser.getId());
                return "wrongPassword";
            }
        } catch (Exception e) {
            logger.error("비밀번호 변경 중 오류 발생", e);
            return "error";
        }
    }
    
    @PostMapping("/delete")
    public String deleteUser(HttpSession session) {
        try {
            UserDTO sessionUser = (UserDTO) session.getAttribute("loginUser");
            if (sessionUser != null) {
                userService.deleteUser(sessionUser.getId());
                session.invalidate();
                return "success";
            } else {
                return "error";
            }
        } catch (Exception e) {
            return "error";
        }
    }

}
