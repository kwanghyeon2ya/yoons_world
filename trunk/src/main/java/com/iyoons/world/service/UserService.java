package com.iyoons.world.service;

import com.iyoons.world.vo.UserVO;

public interface UserService {
	public int checkUser(UserVO userVO);
	public UserVO findUser(UserVO userVO);
}