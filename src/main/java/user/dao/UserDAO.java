package user.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import user.bean.UserDTO;

@Mapper
public interface UserDAO {
    void register(UserDTO userDTO);
    UserDTO login(String id);
    boolean isIdExists(String id);
    boolean isEmailExists(String email);
    void updateName(UserDTO user);
    int updatePassword(@Param("userId") String userId, @Param("encodedPassword") String encodedPassword);
    String getPassword(String userId);
    void deleteUser(String userId);
	int isIdExists2(String id);
}
