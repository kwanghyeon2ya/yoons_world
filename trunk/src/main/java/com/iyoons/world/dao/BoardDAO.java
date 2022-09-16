package com.iyoons.world.dao;


import org.apache.ibatis.annotations.Mapper;

import com.iyoons.world.vo.BoardVO;

@Mapper
public interface BoardDAO {
	
	public int AddBoard(BoardVO vo); 
	
}
