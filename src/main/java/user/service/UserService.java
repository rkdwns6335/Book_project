package user.service;

import user.bean.UserDTO;

public interface UserService {
    String register(UserDTO userDTO);
    UserDTO login(String id, String pwd);
    String sendVerificationEmail(String email);
    String verifyCode(String email, String verificationCode);
    boolean isIdExists(String id);    
    void updateName(UserDTO user) throws Exception;
    void updatePassword(String userId, String newPassword) throws Exception;
    boolean verifyPassword(String userId, String password) throws Exception;
    void deleteUser(String userId) throws Exception;
    boolean isSocialPassword(String userId);
}
