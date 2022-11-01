package com.iyoons.world.service;

import java.sql.SQLException;
import java.util.List;

import com.iyoons.world.vo.UserVO;

public interface UserService {
	public int checkId(UserVO userVO);
	
	public UserVO findUser(UserVO userVO);
	
	public int insertUser(UserVO userVO) throws SQLException;
	
	public int updateUser(UserVO userVO) throws SQLException;
	
	public UserVO userDetail(String userId) throws SQLException;

	public int deleteUser(UserVO userVO) throws SQLException;
	
	public List<UserVO> userList();
	
	public UserVO viewUser();

	
}