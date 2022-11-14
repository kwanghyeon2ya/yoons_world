package com.iyoons.world.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.iyoons.world.vo.BoardVO;
import com.iyoons.world.vo.CommentsVO;

public interface BoardService {
	
	public int insertBoard(BoardVO vo, MultipartFile[] files);
	public List<BoardVO> getBoardList(String search,String keyword,String searchCheck,int startRow, int endRow, String boardType);
	public int getBoardCount(String boardType);
	public int getSearchCount(String search,String keyword,String searchCheck,int startRow, int endRow, String boardType);
	public BoardVO getView(int postSeq);
	public int modView(BoardVO vo,MultipartFile[] files);
	public void updateCnt(int postSeq);
	public int delView(BoardVO vo);
	public int findUser(int postSeq);
	public List<BoardVO> getNoticeFixedBoard(String boardType);
	public List<BoardVO> getAllBoardListOrderedByReadCount(int startRow,int endRow);
	public int getAllBoardCount();
	public List<BoardVO> getAllBoardListOrderedByReadCountForMonth(int startRow,int endRow);
	public BoardVO getListForMain();
}
