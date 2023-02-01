package com.iyoons.world.service;

import java.io.IOException;
import java.util.List;

import com.iyoons.world.vo.BoardVO;
import com.iyoons.world.vo.UserActionVO;

public interface UserActionService {
	
	public int insertUserAction(UserActionVO uavo) throws Exception;
	public int checkUserAction(UserActionVO uavo)  throws Exception;
	public int getHeartCount(UserActionVO uavo) throws Exception;
}

