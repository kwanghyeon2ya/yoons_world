package com.iyoons.world.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.iyoons.world.vo.BoardVO;

public interface BoardService {
	
	public int AddBoard(BoardVO vo, MultipartFile[] files);
	public List<BoardVO> getBoardList(String search,String keyword,String searchCheck,int startRow, int endRow, String boardType);
	public int boardCount(String boardType);
	public int searchCount(String search,String keyword,String searchCheck,int startRow, int endRow, String boardType);
	public BoardVO getView(int postSeq);
	public int modView(BoardVO vo);
}
