package com.iyoons.world.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.iyoons.world.vo.BoardAttachVO;
import com.iyoons.world.vo.BoardVO;


@Mapper
public interface AttachDAO {
	
	public int insertAttach(BoardAttachVO vo);
	public List<BoardAttachVO> getAttachList(int postSeq);
	public void delAttach(BoardVO vo);
	public int getAttachCount(int postSeq);
	public void deleteSelectedAttach(BoardVO vo);
	public BoardAttachVO getSeletedAttach(BoardVO vo2);
}
