package com.iyoons.world.service;

import java.util.List;

import com.iyoons.world.vo.CommentsVO;

public interface CommentsService {
	
	public List<CommentsVO> getCommentsList(CommentsVO cvo);
	public int insertComments(CommentsVO vo);
	public int getExistCommentsCount(int postSeq);
	public int delComment(CommentsVO vo);
	public int getALLCommentsCount(int postSeq);
	public int modComment(CommentsVO vo);
	public CommentsVO getComment(CommentsVO vo);
	public List<CommentsVO> getNestedCommentsList(int postSeq);
}
