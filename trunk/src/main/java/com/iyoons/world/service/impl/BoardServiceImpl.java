package com.iyoons.world.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.iyoons.world.dao.AttachDAO;
import com.iyoons.world.dao.BoardDAO;
import com.iyoons.world.service.BoardService;
import com.iyoons.world.vo.BoardVO;

@Service(value = "BoardService")
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDAO dao;

	@Autowired
	private AttachDAO adao;

	@Override
	public int AddBoard(BoardVO vo) {

		int result = dao.AddBoard(vo);

		return result;
	}

	@Override
	public List<BoardVO> getBoardList(String search,String keyword,String searchCheck,int startRow, int endRow, String boardType) {
		HashMap<String,Object> map = new HashMap<String,Object>();
		if("1".equals(searchCheck)) {
			map.put("search",search);
			map.put("keyword",keyword);
			map.put("searchCheck",searchCheck);
		}
		map.put("startRow",startRow);
		map.put("endRow",endRow);
		map.put("boardType",boardType);
		return dao.getBoardList(map);
	}

	@Override
	public int boardCount(String boardType) {
		return dao.boardCount(boardType);
	}

}
