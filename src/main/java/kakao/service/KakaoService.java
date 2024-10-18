package kakao.service;

import org.springframework.stereotype.Service;

import user.bean.UserDTO;

@Service
public interface KakaoService {

	public void signUp(UserDTO userDTO);

	public String isIdExists2(String id);

}
