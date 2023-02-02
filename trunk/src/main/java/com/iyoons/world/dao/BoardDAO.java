package com.iyoons.world.dao;


import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import com.iyoons.world.vo.BoardVO;
import com.iyoons.world.vo.CommentsVO;
import com.iyoons.world.vo.UserActionVO;

@Mapper
public interface BoardDAO {
	
	public int insertBoard(BoardVO vo); //게시글 작성
	public int getBoardCount(String boardType); //게시글의 총 갯수
	public List<BoardVO> getBoardList(HashMap<String, Object> map);//게시글 리스트 불러오기
	public int getSearchCount(HashMap<String,Object> map); //글 검색 후 검색된 글의 총 갯수
	public BoardVO getView(int postSeq); //게시글 읽기
	public int modView(BoardVO vo); //게시글 수정
	public int delView(BoardVO vo); //게시글 삭제
	public int findUser(int postSeq); //입력받은 유저 db검색
	public List<BoardVO> getNoticeFixedBoard(String boardType);//상단 고정된 게시글만 가져옴
	public List<BoardVO> getAllBoardListOrderedByReadCount(@Param("startRow")int startRow,@Param("endRow")int endRow);
	public int getAllBoardCount();
	public List<BoardVO> getAllBoardListOrderedByReadCountForMonth(@Param("startRow")int startRow,@Param("endRow")int endRow);
	public int insertUserAction(UserActionVO uavo);
	public int checkUserAction(UserActionVO uavo);
	public List<UserActionVO> checkAction(BoardVO vo);
	public int getViewCount(int postSeq);
	public void updateCnt(int postSeq);//게시글 조회수 업데이트
	public List<BoardVO> getMyListByLike(HashMap<String,Object> map);//내가 좋아요 누른 게시글 가져오기
	public List<BoardVO> getMyListByComments(HashMap<String,Object> map);//내가 작성한 댓글의 게시글 가져오기
	public List<BoardVO> getMyBoardList(HashMap<String,Object> map);//내가 작성한 게시글 가져오기
	public int getMyListByLikeCnt(int userSeq);
	public int getMyListByCommentsCnt(int userSeq);
	public int getMyBoardListCnt(int userSeq);
}
