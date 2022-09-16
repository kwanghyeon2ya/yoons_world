package com.iyoons.world.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.iyoons.world.dao.AttachDAO;
import com.iyoons.world.dao.BoardDAO;
import com.iyoons.world.service.BoardService;
import com.iyoons.world.vo.BoardVO;

@Service(value="PostBoardService")
public class BoardServiceImpl implements BoardService {

	@Autowired private BoardDAO dao;
	
	@Autowired private AttachDAO adao;
	
	@Transactional
	@Override
	public int AddBoard(BoardVO vo) {
		
		int result = dao.AddBoard(vo);
		if(vo.getFileAttachYn() == "Y") {
			
		}
		
		return result;
	}
	
	
}
