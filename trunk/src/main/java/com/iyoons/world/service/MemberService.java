package com.iyoons.world.service;

import com.iyoons.world.vo.MemberVO;

public interface MemberService {
	
	public int checkUser(MemberVO vo);
	public MemberVO findUser(MemberVO vo);
	
}
