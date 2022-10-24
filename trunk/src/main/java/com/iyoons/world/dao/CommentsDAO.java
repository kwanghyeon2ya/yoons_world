package com.iyoons.world.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.iyoons.world.vo.CommentsVO;


@Mapper
public interface CommentsDAO {

	public int insertComments(CommentsVO vo);
	public List<CommentsVO> getCommentsList(int postSeq);
	public int getExistCommentsCount(int postSeq);
	public int getALLCommentsCount(int postSeq);
	public CommentsVO getComment(CommentsVO vo);
	public int delComment(CommentsVO vo);
	public int modComment(CommentsVO vo);
	public void delAllCommentsByPostSeq(CommentsVO vo);
}
