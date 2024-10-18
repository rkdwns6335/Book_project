package spring.conf;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import org.json.JSONObject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import lombok.Getter;
import lombok.Setter;

@Configuration
@PropertySource("classpath:spring/kakao.properties")
@Getter
@Setter
public class KakaoConfiguration {
	private @Value("${kakao.apiKey}") String apiKey;
    private @Value("${kakao.redirectUri}") String redirectUri;
    
    //인가 코드를 받아서 accessToken을 반환
    public String getAccessToken(String code){
    	String accessToken = "";
        String refreshToken = "";
        String requestURL = "https://kauth.kakao.com/oauth/token";
        
        try {
            URL url = new URL(requestURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            
            // POST 요청에 필요한 파라미터 설정
            String params = "grant_type=authorization_code"
                    + "&client_id=" + apiKey  // 실제 client_id 사용
                    + "&redirect_uri=" + redirectUri  // 실제 redirect_uri 사용
                    + "&code=" + code;

            // 요청 전송
            OutputStream os = conn.getOutputStream();
            os.write(params.getBytes());
            os.flush();
            os.close();

            // 응답 확인
            int responseCode = conn.getResponseCode();
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line;
            StringBuffer response = new StringBuffer();
            while ((line = br.readLine()) != null) {
                response.append(line);
            }
            br.close();

            // JSON 파싱
            JSONObject jsonObject = new JSONObject(response.toString());
            accessToken = jsonObject.getString("access_token");
            refreshToken = jsonObject.getString("refresh_token");

        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return accessToken;
    }
    
    //accessToken을 받아서 UserInfo 반환
  	public HashMap<String, Object> getUserInfo(String accessToken) {
  		HashMap<String, Object> userInfo = new HashMap<>();
        String requestURL = "https://kapi.kakao.com/v2/user/me";
        
        try {
            URL url = new URL(requestURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);
            
            int responseCode = conn.getResponseCode();
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line;
            StringBuffer response = new StringBuffer();
            while ((line = br.readLine()) != null) {
                response.append(line);
            }
            br.close();
            
            // JSON 파싱
            JSONObject jsonObject = new JSONObject(response.toString());
            JSONObject kakaoAccount = jsonObject.getJSONObject("kakao_account");
            JSONObject profile = kakaoAccount.getJSONObject("profile");

            String nickname = profile.getString("nickname");
            String email = kakaoAccount.getString("email");

            userInfo.put("nickname", nickname);
            userInfo.put("email", email);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return userInfo;
  	}
  	
      //accessToken을 받아서 로그아웃 시키는 메서드
  	public void kakaoLogout(String accessToken) {
  		String requestURL = "https://kapi.kakao.com/v1/user/logout";
        
        try {
            URL url = new URL(requestURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);
            
            int responseCode = conn.getResponseCode();
            if (responseCode == 200) {
                System.out.println("로그아웃 성공");
            } else {
                System.out.println("로그아웃 실패");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }	
  	}
}
