package com.iyoons.world.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.iyoons.world.vo.BoardVO;
import com.iyoons.world.vo.CommentsVO;

public interface BoardService {
	
	public int insertBoard(BoardVO vo, MultipartFile[] files) throws Exception;
	public List<BoardVO> getBoardList(String search,String keyword,String searchCheck,int startRow, int endRow, String boardType) throws Exception;
	public int getBoardCount(String boardType)throws Exception;
	public int getSearchCount(String search,String keyword,String searchCheck,int startRow, int endRow, String boardType)throws Exception;
	public BoardVO getView(int postSeq)throws Exception;
	public int modView(BoardVO vo,MultipartFile[] files) throws Exception;
	public void updateCnt(int postSeq)throws Exception;
	public int delView(BoardVO vo)throws Exception;
	public int findUser(int postSeq)throws Exception;
	public List<BoardVO> getNoticeFixedBoard(String boardType)throws Exception;
	public List<BoardVO> getAllBoardListOrderedByReadCount(int startRow,int endRow)throws Exception;
	public int getAllBoardCount()throws Exception;
	public List<BoardVO> getAllBoardListOrderedByReadCountForMonth(int startRow,int endRow)throws Exception;
	public BoardVO getListForMain()throws Exception;
	public int increasingHeart(BoardVO vo)throws Exception;
	public int checkHeart(BoardVO vo)throws Exception;
	public int getHeartCount(BoardVO vo)throws Exception;
}
