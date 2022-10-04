package com.iyoons.world.service;

import java.sql.SQLException;
import java.util.List;

import com.iyoons.world.vo.UserVO;

public interface UserService {
	public int checkUser(UserVO userVO);
	
	public UserVO findUser(UserVO userVO);
	
	public int insertUser(UserVO userVO) throws SQLException;
	
	public int updateUser(UserVO userVO) throws SQLException;

	public int deleteUser(String userId) throws SQLException;
	
	public List<UserVO> userList();

	public UserVO viewUser(UserVO userVO);
	
}