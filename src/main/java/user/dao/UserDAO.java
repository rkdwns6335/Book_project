package user.dao;

import org.apache.ibatis.annotations.Mapper;
import user.bean.UserDTO;

@Mapper
public interface UserDAO {
    void register(UserDTO userDTO);
    UserDTO login(String id);
    boolean isIdExists(String id);
    boolean isEmailExists(String email);
}