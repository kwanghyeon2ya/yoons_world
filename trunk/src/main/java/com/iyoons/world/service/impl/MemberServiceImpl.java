package com.iyoons.world.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iyoons.world.dao.MemberDAO;
import com.iyoons.world.service.MemberService;
import com.iyoons.world.vo.MemberVO;

@Service(value="MemberService")
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO dao;
	
	@Override
	public int checkUser(MemberVO vo) {
		return dao.checkUser(vo);
	}

	@Override
	public MemberVO findUser(MemberVO vo) {
		return dao.findUser(vo);
	}
	


	
	
}
