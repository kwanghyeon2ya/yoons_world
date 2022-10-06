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
		vo.setCommGroup(1); // 일단 댓글인지 대댓글인 확인용 숫자 대입
		System.out.println(vo);
		if(vo.getCommSeq() != 0) {
			CommentsVO cvo = dao.getComment(vo);//commentSeq는 대댓글을 통해서만
				dao.incrementOriginalCommStep(cvo);
				vo.setCommStep(cvo.getCommStep()+1);
				vo.setCommLevel(cvo.getCommLevel()+1); //대댓작성시 레벨이 오르는것은 필수
				vo.setCommGroup(cvo.getCommGroup());
				
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
