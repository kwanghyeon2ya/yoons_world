package com.iyoons.world.dao;

import java.sql.SQLException;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.iyoons.world.vo.UserVO;

@Mapper
public interface UserDAO {

	public List<UserVO> getUserList() throws SQLException;

	public int insertUser(UserVO userVO) throws SQLException;
	
	public int updateUser(UserVO userVO) throws SQLException;
	
	public UserVO userDetail(String userId) throws SQLException;

	public int deleteUser(String userId) throws SQLException;
	
	public int checkUser(UserVO userVO);
	
	public UserVO findUser(UserVO userVO);

	public List<UserVO> userList();

	public UserVO viewUser();
	
}
