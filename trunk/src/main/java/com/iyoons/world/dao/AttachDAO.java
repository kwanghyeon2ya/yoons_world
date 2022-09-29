package com.iyoons.world.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.iyoons.world.vo.BoardAttachVO;


@Mapper
public interface AttachDAO {
	
	public int insertAttach(BoardAttachVO vo);
	public int deleteAttach(int postSeq);
	public List<BoardAttachVO> getAttach(int postSeq);
	
}
