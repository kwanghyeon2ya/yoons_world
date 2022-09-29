package com.iyoons.world.service.impl;

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
	
}
