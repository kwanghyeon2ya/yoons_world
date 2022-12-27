package com.iyoons.world.service;

import java.sql.SQLException;
import java.util.List;

import com.iyoons.world.vo.CommentsVO;

public interface CommentsService {
	
	public List<CommentsVO> getCommentsList(CommentsVO cvo) throws Exception;
	public int insertComments(CommentsVO vo) throws SQLException;
	public int getExistCommentsCount(int postSeq) throws Exception;
	public int delComment(CommentsVO vo) throws Exception;
	public int getALLCommentsCount(int postSeq) throws Exception;
	public int modComment(CommentsVO vo) throws Exception;
	public CommentsVO getComment(CommentsVO vo) throws Exception;
	public List<CommentsVO> getNestedCommentsList(CommentsVO comm) throws Exception;
}
