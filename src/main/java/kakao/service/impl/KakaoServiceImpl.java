package kakao.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kakao.service.KakaoService;
import user.bean.UserDTO;
import user.dao.UserDAO;

@Service
public class KakaoServiceImpl implements KakaoService{

	@Autowired	
    private UserDAO userDAO;
	
	@Override
	public void signUp(UserDTO userDTO) {
		userDAO.register(userDTO);
	}

	@Override
	public String isIdExists2(String id) {
	    int count = userDAO.isIdExists2(id);
	    return count > 0 ? "false" : "success"; // count가 0보다 크면 이미 존재함
	}

}
