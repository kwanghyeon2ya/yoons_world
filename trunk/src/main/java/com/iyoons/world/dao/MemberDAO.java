package com.iyoons.world.dao;

import org.apache.ibatis.annotations.Mapper;

import com.iyoons.world.vo.MemberVO;

@Mapper
public interface MemberDAO {

	public int checkUser(MemberVO vo);
	public MemberVO findUser(MemberVO vo);
	
}
