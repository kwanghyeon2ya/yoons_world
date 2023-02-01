package com.iyoons.world.dao;

import org.apache.ibatis.annotations.Mapper;

import com.iyoons.world.vo.UserActionVO;

@Mapper
public interface UserActionDAO {

	public int insertUserAction(UserActionVO uavo);

	public int checkUserAction(UserActionVO uavo);

	public int getHeartCount(UserActionVO uavo);
	
}
