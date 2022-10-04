package com.iyoons.world.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iyoons.world.dao.CommentsDAO;
import com.iyoons.world.service.CommentsService;
import com.iyoons.world.vo.CommentsVO;

@Service(value="CommentsService")
public class CommentsServicveImpl implements CommentsService {

	@Autowired
	private CommentsDAO dao;
	
	@Override
	public List<CommentsVO> getComments(int postSeq,int startRow,int endRow) {
		return dao.getComments(postSeq,startRow,endRow);
	}

	@Override
	public int insertComments(CommentsVO vo) {
		return dao.insertComments(vo);
	}

	@Override
	public int getCommentsCount(int postSeq) {
			return dao.getCommentsCount(postSeq);
	}

	
	
}
