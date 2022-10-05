package com.iyoons.world.service;

import java.util.List;

import com.iyoons.world.vo.BoardAttachVO;

public interface AttachService {

	public List<BoardAttachVO> getAttachList(int postSeq);
	
}
