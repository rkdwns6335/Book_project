package kakao.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import book.service.ObjectStorageService;
import kakao.service.KakaoService;
import lombok.RequiredArgsConstructor;
import spring.conf.KakaoConfiguration;
import user.bean.UserDTO;
import user.service.UserService;

@RequiredArgsConstructor
@Controller
public class KakaoLoginController {
	@Autowired
	private KakaoService kakaoService;
	
	@Autowired
	private ObjectStorageService objectStorageService;
	
	private String bucketName = "bitcamp-9th-bucket-141";
	
    private final KakaoConfiguration kakaoConfiguration;
    
    @RequestMapping(value="/oauth2/code/kakao")
    public String kakaoLogin(@RequestParam String code, HttpSession session){
        // 1. 인가 코드 받기 (@RequestParam String code)
    	 System.out.println("code = " + code);
        // 2. 토큰 받기
        String accessToken = kakaoConfiguration.getAccessToken(code);

        // 3. 사용자 정보 받기
        Map<String, Object> userInfo = kakaoConfiguration.getUserInfo(accessToken);

        String email = (String)userInfo.get("email");
        String nickname = (String)userInfo.get("nickname");

        System.out.println("email = " + email);
        System.out.println("nickname = " + nickname);
        System.out.println("accessToken = " + accessToken);
        
        UserDTO userDTO = new UserDTO();
        
        userDTO.setId(email);
        userDTO.setName(nickname);
        userDTO.setEmail(email);
        userDTO.setPwd("@1234567890");    
        
        String result = kakaoService.isIdExists2(email);
        
        if(result.equals("false")) { //이미 DB에 존재하는 아이디 일때 
        	 System.out.println("이미 존재하는 아이디 입니다.");
        	 session.setAttribute("loginUser",userDTO);
        }else if(result.equals("success")) {  //DB에 존재하지 않는 아이디 일때 
        	System.out.println("회원가입완료");
        	kakaoService.signUp(userDTO);
        	session.setAttribute("loginUser",userDTO);
        }
        
        return "redirect:/";
    }
}
