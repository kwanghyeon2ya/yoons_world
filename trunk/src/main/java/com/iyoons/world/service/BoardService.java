package com.iyoons.world.service;

import java.util.List;

import com.iyoons.world.vo.BoardVO;

public interface BoardService {
	
	public int AddBoard(BoardVO vo);
	public List<BoardVO> getBoardList(String search,String keyword,String searchCheck,int startRow, int endRow, String boardType);
	public int boardCount(String boardType);
}
