package com.iyoons.world.dao;


import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import com.iyoons.world.vo.BoardVO;

@Mapper
public interface BoardDAO {
	
	public int insertBoard(BoardVO vo); 
	public int getBoardCount(String boardType);
	public List<BoardVO> getBoardList(HashMap<String, Object> map);
	public int getSearchCount(HashMap<String,Object> map);
	public BoardVO getView(int postSeq);
	public int modView(BoardVO vo);
	public void updateCnt(int postSeq);
	public int delView(int postSeq);
	
}
