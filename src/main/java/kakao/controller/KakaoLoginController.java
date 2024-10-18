package kakao.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;
import spring.conf.KakaoConfiguration;

@RequiredArgsConstructor
@Controller
public class KakaoLoginController {
	
    private final KakaoConfiguration kakaoConfiguration;
    
    @RequestMapping(value="/oauth2/code/kakao")
    public String kakaoLogin(@RequestParam String code){
        // 1. 인가 코드 받기 (@RequestParam String code)

        // 2. 토큰 받기
        String accessToken = kakaoConfiguration.getAccessToken(code);

        // 3. 사용자 정보 받기
        Map<String, Object> userInfo = kakaoConfiguration.getUserInfo(accessToken);

        String email = (String)userInfo.get("email");
        String nickname = (String)userInfo.get("nickname");

        System.out.println("email = " + email);
        System.out.println("nickname = " + nickname);
        System.out.println("accessToken = " + accessToken);

        return "redirect:/index";
    }
}
