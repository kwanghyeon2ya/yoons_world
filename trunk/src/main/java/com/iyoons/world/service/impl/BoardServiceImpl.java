package com.iyoons.world.service.impl;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.iyoons.world.dao.AttachDAO;
import com.iyoons.world.dao.BoardDAO;
import com.iyoons.world.service.BoardService;
import com.iyoons.world.vo.BoardAttachVO;
import com.iyoons.world.vo.BoardVO;

@Service(value = "BoardService")
public class BoardServiceImpl implements BoardService {

	final String realPath = "C:/yoons_world/files";
	
	@Autowired
	private BoardDAO dao;

	@Autowired
	private AttachDAO adao;
	
	@Autowired
	private ServletContext sc;

	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	
	@Transactional
	@Override
	public int AddBoard(BoardVO vo,MultipartFile[] files) {
		
	BoardAttachVO bavo = new BoardAttachVO();
		
	for(MultipartFile f : files) {
		if(!f.isEmpty()) {
			
			File uploadPath = new File(realPath);
			if(!uploadPath.exists()) {
				uploadPath.mkdir();
			}
				
			String uploadFileName = f.getOriginalFilename();
			System.out.println(uploadFileName);
			bavo.setFileType(uploadFileName.substring(uploadFileName.lastIndexOf(".")+1));
			UUID uuid = UUID.randomUUID();
			uploadFileName += uuid.toString() + "_" + getFolder();
			bavo.setFileName(uploadFileName);
			bavo.setFileUuid(uuid.toString());
			bavo.setFileSize(f.getSize());
			bavo.setFilePath(realPath);
			
			
			
			try {
			File saveFile = new File(uploadPath,uploadFileName);
			f.transferTo(saveFile); // 파일 저장
			
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
		int result = dao.AddBoard(vo,files);
		return result;
}

	@Override
	public List<BoardVO> getBoardList(
			String search,
			String keyword,
			String searchCheck,int startRow, int endRow, String boardType) {
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("search",search);
		map.put("keyword",keyword);
		map.put("searchCheck",searchCheck);
		map.put("startRow",startRow);
		map.put("endRow",endRow);
		map.put("boardType",boardType);
		return dao.getBoardList(map);
	}

	@Override
	public int boardCount(String boardType) {
		return dao.boardCount(boardType);
	}

	@Override
	public int searchCount(String search, String keyword, String searchCheck, int startRow, int endRow,
			String boardType) {
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("search",search);
		map.put("keyword",keyword);
		map.put("searchCheck",searchCheck);
		map.put("startRow",startRow);
		map.put("endRow",endRow);
		map.put("boardType",boardType);
		return dao.searchCount(map);
	}

	@Override
	public BoardVO getView(int postSeq) {
		return dao.getView(postSeq);
	}

	@Override
	public int modView(BoardVO vo) {
		return dao.modView(vo);
	}

}
