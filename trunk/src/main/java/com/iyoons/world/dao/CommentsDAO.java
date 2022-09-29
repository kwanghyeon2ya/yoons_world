package com.iyoons.world.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.iyoons.world.vo.CommentsVO;


@Mapper
public interface CommentsDAO {

	public int AddComments(CommentsVO vo);
	public List<CommentsVO> getComments(@Param("postSeq") int postSeq,@Param("startRow") int startRow,@Param("endRow") int endRow);
	public int CommentsCount(int postSeq);
	
}
