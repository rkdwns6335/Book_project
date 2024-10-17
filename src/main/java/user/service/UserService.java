package user.service;

import user.bean.UserDTO;

public interface UserService {
    String register(UserDTO userDTO);
    UserDTO login(String id, String pwd);
    String sendVerificationEmail(String email);
    String verifyCode(String email, String verificationCode);
}
