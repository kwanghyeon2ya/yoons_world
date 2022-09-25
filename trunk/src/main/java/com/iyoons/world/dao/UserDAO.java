package com.iyoons.world.dao;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Mapper;

import com.iyoons.world.vo.MemberVO;

@Mapper
public interface UserDAO {

	public List<UserVO> getUserList() throws SQLException;

	public int insertUser(UserVO userVO) throws SQLException;
	
	public int updateUser(UserVO userVO) throws SQLException;

	public int deleteUser(String usedrId) throws SQLException;
	}
	
}
