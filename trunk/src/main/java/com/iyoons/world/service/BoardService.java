package com.iyoons.world.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.iyoons.world.vo.BoardVO;
import com.iyoons.world.vo.CommentsVO;
import com.iyoons.world.vo.PageVO;
import com.iyoons.world.vo.UserActionVO;

public interface BoardService {
	
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
	public int insertBoard(BoardVO vo, MultipartFile[] files, HttpServletRequest request) throws Exception;
	public int getSearchCount(BoardVO boardVO, PageVO pageVO) throws Exception;
	public List<BoardVO> getBoardList(BoardVO vo,PageVO pagevo) throws Exception;
	public List<BoardVO> getMyListByLike(BoardVO boardVO,PageVO pageVO);//내가 좋아요 누른 게시글 가져오기
	public List<BoardVO> getMyListByComments(BoardVO boardVO,PageVO pageVO);//내가 작성한 댓글의 게시글 가져오기
	public List<BoardVO> getMyBoardList(BoardVO boardVO,PageVO pageVO);//내가 작성한 게시글 가져오기
	public int getMyListByLikeCnt(int userSeq);
	public int getMyListByCommentsCnt(int userSeq);
	public int getMyBoardListCnt(int userSeq);
}
