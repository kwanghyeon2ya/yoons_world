package com.iyoons.world.dao;


import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import com.iyoons.world.vo.BoardVO;
import com.iyoons.world.vo.CommentsVO;

@Mapper
public interface BoardDAO {
	
	public int insertBoard(BoardVO vo); //게시글 작성
	public int getBoardCount(String boardType); //게시글의 총 갯수
	public List<BoardVO> getBoardList(HashMap<String, Object> map);//게시글 리스트 불러오기
	public int getSearchCount(HashMap<String,Object> map); //글 검색 후 검색된 글의 총 갯수
	public BoardVO getView(int postSeq); //게시글 읽기
	public int modView(BoardVO vo); //게시글 수정
	public void updateCnt(int postSeq); //게시글 조회수 업데이트
	public int delView(BoardVO vo); //게시글 삭제
	public int findUser(int postSeq); //입력받은 유저 db검색
}
