package com.iyoons.world.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.iyoons.world.service.BoardService;
import com.iyoons.world.vo.BoardVO;

@RequestMapping("/board/*")
@Controller
public class BoardController {
	
	@Autowired
	public BoardService service;
	
	
	public void boardList(String search,String keyword,String searchCheck,String boardType , String pageNum,Model model) {
		
		if(searchCheck == null) searchCheck = "0"; search = ""; keyword="";
		if(pageNum == null) pageNum = "1";
		if(boardType == null) boardType = "0";
		int pageSize = 10;
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = pageSize * currentPage;
		int count = 0;
		System.out.println(boardType);
		count = service.boardCount(boardType);
		
		List<BoardVO> boardList = null;
		
		if(count != 0) boardList = service.getBoardList(search,keyword,searchCheck,startRow, endRow, boardType);
		System.out.println(count+" "+boardType);
		
		model.addAttribute("boardType",boardType);
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("currentPage",currentPage);
		model.addAttribute("startRow",startRow);
		model.addAttribute("endRow",endRow);
		model.addAttribute("count",count);
		model.addAttribute("boardList",boardList);
		model.addAttribute("pageNum",pageNum);
	}
	
	@RequestMapping("free/list")
	public String FreeList(String search,String keyword,String searchCheck,String boardType,String pageNum,Model model) {
		boardList(search,keyword,searchCheck,boardType,pageNum,model);
		return "board/free/list";
	}
	
	@RequestMapping("notice/list")
	public String NoticeList() {
	
		return "board/notice/list";
	}
	
	@RequestMapping("pds/list")
	public String PdsList() {
	
		return "board/pds/list";
	}
	
	@RequestMapping("free/modify")
	public String FreeModify() {
	
		return "board/free/modify";
	}
	
	@RequestMapping("free/modifyPro")
	public @ResponseBody String FreeModifyPro() {
		
		return "";
	}
	
	@RequestMapping("notice/modify")
	public String NoticeModify() {
	
		return "board/notice/modify";
	}
	
	@RequestMapping("notice/modifyPro")
	public @ResponseBody String noticeModifyPro() {
		
		return "";
	}
	
	@RequestMapping("pds/modify")
	public String PdsModify() {
	
		return "board/pds/modify";
	}
	
	@RequestMapping("pds/modifyPro")
	@ResponseBody public String PdsModifyPro() {
		
		return "";
	}
	
	@RequestMapping("free/view")
	public String FreeView() {
	
		return "board/free/view";
	}
	
	@RequestMapping("notice/view")
	public String NoticeView() {
	
		return "board/notice/view";
	}
	
	@RequestMapping("pds/view")
	public String PdsView() {
		
		return "board/pds/view";
	}
	
	@RequestMapping("free/write")
	public String FreeWrite() {
		return "board/free/write";
	}
	
	@RequestMapping(value= "writePro" , method=RequestMethod.POST)
	@ResponseBody public String FreeWriteCheck(BoardVO vo,HttpServletRequest request
			) throws Exception {
		
//		String file = request.getParameter("file");
		
		
		vo.setFileAttachYn("N");
//		if(file != null){
//			vo.setFileAttachYn("Y");
//		}
		int result = service.AddBoard(vo);
		
		return result+"";
	}
	
	@RequestMapping("notice/write")
	public String NoticeWrite() {
		return "board/notice/write";
	}

	@RequestMapping("pds/write")
	public String PdsWrite() {
	
		return "board/pds/write";
	}
	
}
