package com.iyoons.world.service.impl;

import java.sql.SQLException;
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
	public List<CommentsVO> getCommentsList(CommentsVO vo) throws Exception {
		return dao.getCommentsList(vo);
	}
	
	@Override
	public List<CommentsVO> getNestedCommentsList(CommentsVO comm) throws Exception{
		return dao.getNestedCommentsList(comm);
	}

	@Override
	public int insertComments(CommentsVO vo) throws SQLException {
		
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
	public int getExistCommentsCount(int postSeq) throws Exception {
			return dao.getExistCommentsCount(postSeq);
	}

	@Override
	public int delComment(CommentsVO vo) throws Exception {
		return dao.delComment(vo);
	}

	@Override
	public int getALLCommentsCount(int postSeq) throws Exception {
		return dao.getALLCommentsCount(postSeq);
	}

	@Override
	public int modComment(CommentsVO vo) throws Exception {
		return dao.modComment(vo);
	}

	@Override
	public CommentsVO getComment(CommentsVO vo) throws Exception {
		return dao.getComment(vo);
	}

}
