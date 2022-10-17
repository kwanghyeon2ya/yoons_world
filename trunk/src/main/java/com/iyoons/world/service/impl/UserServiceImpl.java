package com.iyoons.world.service.impl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iyoons.world.dao.UserDAO;
import com.iyoons.world.service.UserService;
import com.iyoons.world.vo.UserVO;

@Service(value = "UserService")
public class UserServiceImpl implements UserService {
	
	@Autowired
	UserDAO userDAO;

	@Override
	public int checkUser(UserVO userVO) {
		
		return userDAO.checkUser(userVO);
	}

	@Override
	public UserVO findUser(UserVO userVO) {
	
		return userDAO.findUser(userVO);
	}

	@Override
	public int insertUser(UserVO userVO) throws SQLException {

		return userDAO.insertUser(userVO);
	}

	@Override
	public int updateUser(UserVO userVO) throws SQLException {
		
		return userDAO.updateUser(userVO);
	}

	@Override
	public int deleteUser(String userId) throws SQLException {

		return 0;
	}

	@Override
	public List<UserVO> userList() {

		return userDAO.userList();
	}

	@Override
	public UserVO viewUser() {

		return userDAO.viewUser();
	}

	@Override
	public UserVO userDetail(String userId) throws SQLException {

		return userDAO.userDetail(userId);
	}

	
}
