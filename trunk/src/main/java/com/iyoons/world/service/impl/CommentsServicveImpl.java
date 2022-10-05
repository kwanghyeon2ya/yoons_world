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
	public List<CommentsVO> getCommentsList(int postSeq,int startRow,int endRow) {
		return dao.getCommentsList(postSeq,startRow,endRow);
	}

	@Override
	public int insertComments(CommentsVO vo) {
		vo.setCommGroup(0);
		System.out.println(vo);
		if(vo.getCommSeq() != 0) {
			CommentsVO cvo = dao.getComment(vo.getCommSeq(),vo.getPostSeq(),vo.getCommGroup());
				System.out.println(cvo+"gdgd");
				vo.setCommGroup(cvo.getCommGroup());
				vo.setCommStep(cvo.getCommStep()+1);
				vo.setCommLevel(cvo.getCommLevel()+1);
				vo.setPostSeq(cvo.getPostSeq());
				return dao.insertComments(vo);
		}else{
			return dao.insertComments(vo);
		}
		
	}

	@Override
	public int getCommentsCount(int postSeq) {
			return dao.getCommentsCount(postSeq);
	}
	
}
