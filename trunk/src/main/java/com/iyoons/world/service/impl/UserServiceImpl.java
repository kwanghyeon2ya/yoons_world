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
	public int checkId(UserVO userVO) {
		
		return userDAO.checkId(userVO);
	}

	@Override
	public UserVO findUser(UserVO userVO) {
	
		return userDAO.findUser(userVO);
	}

	@Override
	public int insertUser(UserVO vo) throws SQLException {
		
		vo.setEmail(vo.getEmailPart1()+"@"+vo.getEmailPart2());
		
		return userDAO.insertUser(vo);
	}

	@Override
	public int updateUser(UserVO userVO) throws SQLException {
		
		return userDAO.updateUser(userVO);
	}

	@Override
	public int deleteUser(UserVO userVO) throws SQLException {

		return userDAO.deleteUser(userVO);
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
