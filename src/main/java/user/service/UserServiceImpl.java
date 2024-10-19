package user.service;

import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import user.bean.UserDTO;
import user.dao.UserDAO;

@Service
public class UserServiceImpl implements UserService {
    private static final Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);

    @Autowired	
    private UserDAO userDAO;
    
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;
    
    @Autowired
    private JavaMailSender mailSender;
    
    private ConcurrentHashMap<String, String> verificationCodes = new ConcurrentHashMap<>();

    @Override
    public String register(UserDTO userDTO) {
        logger.info("Attempting to register user: {}", userDTO.getId());
        if (userDAO.isIdExists(userDTO.getId())) {
            logger.warn("Registration failed: ID already exists - {}", userDTO.getId());
            return "이미 존재하는 아이디입니다.";
        }
        if (userDAO.isEmailExists(userDTO.getEmail())) {
            logger.warn("Registration failed: Email already exists - {}", userDTO.getEmail());
            return "이미 존재하는 이메일입니다.";
        }
        
        userDTO.setPwd(passwordEncoder.encode(userDTO.getPwd()));
        userDAO.register(userDTO);
        logger.info("User registered successfully: {}", userDTO.getId());
        return "success";
    }

    @Override
    public String sendVerificationEmail(String email) {
        logger.info("Attempting to send verification email to: {}", email);
        if (userDAO.isEmailExists(email)) {
            logger.warn("Email already exists: {}", email);
            return "이미 존재하는 이메일입니다.";
        }
        
        String verificationCode = generateVerificationCode();
        verificationCodes.put(email, verificationCode);
        
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setFrom("gustlr887@naver.com");
            helper.setTo(email);
            helper.setSubject("BooBooBook 이메일 인증");
            helper.setText("인증 코드: " + verificationCode);
            
            mailSender.send(message);
            
            logger.info("Verification email sent successfully to: {}", email);
            
            return "success";
        } catch (MessagingException e) {
            logger.error("Failed to send verification email to: {}", email, e);
            return "이메일 전송 중 오류가 발생했습니다: " + e.getMessage();
        }
    }
    
    @Override
    public String verifyCode(String email, String verificationCode) {
        logger.info("Attempting to verify code for email: {}", email);
        String storedCode = verificationCodes.get(email);
        if (storedCode != null && storedCode.equals(verificationCode)) {
            verificationCodes.remove(email);
            logger.info("Code verification successful for email: {}", email);
            return "success";
        }
        logger.warn("Code verification failed for email: {}", email);
        return "fail";
    }
    
    private String generateVerificationCode() {
        Random random = new Random();
        String code = String.format("%06d", random.nextInt(1000000));
        logger.debug("Generated verification code: {}", code);
        return code;
    }
    
    @Override
    public UserDTO login(String id, String pwd) {
        logger.info("Attempting login for user: {}", id);
        UserDTO userDTO = userDAO.login(id);
        if (userDTO != null && passwordEncoder.matches(pwd, userDTO.getPwd())) {
            logger.info("Login successful for user: {}", id);
            return userDTO;
        }
        logger.warn("Login failed for user: {}", id);
        return null;
    }

    @Override
    public boolean isIdExists(String id) {
        return userDAO.isIdExists(id);
    }
    
    @Override
    public void updateName(UserDTO user) throws Exception {
        userDAO.updateName(user);
    }

    @Override
    public void updatePassword(String userId, String newPassword) throws Exception {
        logger.info("비밀번호 변경 시도: {}", userId);
        String encodedPassword = passwordEncoder.encode(newPassword);
        int result = userDAO.updatePassword(userId, encodedPassword);
        if (result > 0) {
            logger.info("비밀번호 변경 완료: {}", userId);
        } else {
            logger.warn("비밀번호 변경 실패: {}", userId);
            throw new Exception("비밀번호 변경에 실패했습니다.");
        }
    }


    @Override
    public boolean verifyPassword(String userId, String password) throws Exception {
        String storedPassword = userDAO.getPassword(userId);
        return passwordEncoder.matches(password, storedPassword);
    }

    @Override
    public void deleteUser(String userId) throws Exception {
        userDAO.deleteUser(userId);
    }

    @Override
    public boolean isSocialPassword(String userId) {
        String storedPassword = userDAO.getPassword(userId);
        return passwordEncoder.matches("@1234567890", storedPassword);
	}

	
}
