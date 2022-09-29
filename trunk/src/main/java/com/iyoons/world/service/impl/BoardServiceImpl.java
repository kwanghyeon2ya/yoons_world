package com.iyoons.world.service.impl;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
		return str;
	}
	
	@Transactional
	@Override
	public int AddBoard(BoardVO vo,MultipartFile[] files) {
		List<BoardAttachVO> blist = new ArrayList<>();
		int result = dao.AddBoard(vo);
		
		for(MultipartFile f : files) {
			if(!f.isEmpty()) {
				BoardAttachVO bavo = new BoardAttachVO();
				
				File uploadPath = new File(realPath);
				if(!uploadPath.exists()) {
					uploadPath.mkdir();
				}
					
				String uploadFileName = f.getOriginalFilename();
				String FileType = f.getContentType();
				bavo.setFileName(uploadFileName.substring(0,f.getOriginalFilename().lastIndexOf(".")));
				bavo.setFileType(FileType.split("/")[0]);
				String uuid = UUID.randomUUID().toString();
				
				uploadFileName = File.separator + uuid + "_" + getFolder() + uploadFileName;
				
				bavo.setPostSeq(vo.getPostSeq());
				bavo.setFileUuid(uuid);
				bavo.setFileSize(f.getSize());
				bavo.setFilePath(realPath);
				bavo.setRegrSeq(vo.getRegrSeq());
				
				String savePath = realPath + uploadFileName;
				
				try {
					
				File saveFile = new File(savePath);
				f.transferTo(saveFile); 
				
				blist.add(bavo);
				
				}catch(Exception e) {
					e.printStackTrace();
				}
				
			}
		}
		
		if(blist.size() > 0) {
			for(BoardAttachVO attach : blist) {
				adao.insertAttach(attach);
			}
		}
			
			return result;
	}

	@Override
	public List<BoardVO> getBoardList(
			String search,
			String keyword,
			String searchCheck,
			int startRow,
			int endRow,
			String boardType) {
		
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
	public int searchCount(String search, 
			String keyword, 
			String searchCheck, 
			int startRow, 
			int endRow,
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
	@Override
	public void cntUpdate(int postSeq) {
		dao.cntUpdate(postSeq);
	}
	@Override
	public int viewDelete(int postSeq) { //작업중
		List<BoardAttachVO> list = new ArrayList<>();
		
		for(BoardAttachVO vo : list) {
			/*String path = vo.getFilePath+File.separator+vo.getFileUuid()+vo.get*/
		}
		
		adao.getAttach(postSeq);
		
		adao.deleteAttach(postSeq);
			
		return dao.viewDelete(postSeq);
	}
	
}
