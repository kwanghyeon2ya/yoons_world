package com.iyoons.world.dao;


import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.iyoons.world.vo.BoardVO;

@Mapper
public interface BoardDAO {
	
	public int AddBoard(BoardVO vo); 
	public int boardCount(String boardType);
	public List<BoardVO> getBoardList(HashMap<String, Object> map);
	public int searchCount(HashMap<String,Object> map);
	public BoardVO getView(int postSeq);
	public int modView(BoardVO vo);
}
