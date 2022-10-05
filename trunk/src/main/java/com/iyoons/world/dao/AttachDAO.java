package com.iyoons.world.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.iyoons.world.vo.BoardAttachVO;


@Mapper
public interface AttachDAO {
	
	public int insertAttach(BoardAttachVO vo);
	public int delAttach(@Param("postSeq") int postSeq,
						@Param("regrSeq")int regrSeq,
						@Param("updrSeq")int updrSeq);
	public List<BoardAttachVO> getAttachList(int postSeq);
}
