package com.iyoons.world.service;

import java.util.List;

import com.iyoons.world.vo.CommentsVO;

public interface CommentsService {
	
	public List<CommentsVO> getComments(int postSeq, int startRow, int endRow);
	public int insertComments(CommentsVO vo);
	public int getCommentsCount(int postSeq);
	
}
