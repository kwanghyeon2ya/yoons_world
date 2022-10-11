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
		if(vo.getCommSeq() != 0) { //댓글 고유번호 확인
			CommentsVO cvo = dao.getComment(vo); //commentSeq는 대댓글을 통해서만
				vo.setCommLevel(1); 
				vo.setCommGroup(cvo.getCommGroup());
				return dao.insertComments(vo);
		}else{
			return dao.insertComments(vo);
		}
	}

	@Override
	public int getExistCommentsCount(int postSeq) {
			return dao.getExistCommentsCount(postSeq);
	}

	@Override
	public int delComment(CommentsVO vo) {
		return dao.delComment(vo);
	}

	@Override
	public int getALLCommentsCount(int postSeq) {
		return dao.getALLCommentsCount(postSeq);
	}

	@Override
	public int modComment(CommentsVO vo) {
		return dao.modComment(vo);
	}
	
}
