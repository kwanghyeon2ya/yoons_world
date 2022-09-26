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

import ch.qos.logback.core.net.SyslogOutputStream;

@RequestMapping("/board/*")
@Controller
public class BoardController {
	
	@Autowired
	public BoardService service;
	
	
	public void boardList(
					String search,
					String keyword,
					String searchCheck,
					String boardType,
					String pageNum,Model model) {
		
		int pageSize = 10;
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = pageSize * currentPage;
		int count = 0;
		System.out.println(boardType);
		count = service.boardCount(boardType);
		
		if(searchCheck != null && search != null && keyword != null) {
			count = service.searchCount(search, keyword, searchCheck, startRow, endRow, boardType);
		}
		
		List<BoardVO> boardList = null;
		
		if(count != 0) boardList = service.getBoardList(search,keyword,searchCheck,startRow, endRow, boardType);
		
		model.addAttribute("boardType",boardType);
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("currentPage",currentPage);
		model.addAttribute("startRow",startRow);
		model.addAttribute("endRow",endRow);
		model.addAttribute("count",count);
		model.addAttribute("boardList",boardList);
		model.addAttribute("pageNum",pageNum);
		model.addAttribute("keyword",keyword);
		model.addAttribute("searchCheck",searchCheck);
		model.addAttribute("search",search);
	}
	
	public void getComments() {
		
	}
	
	@RequestMapping("free/list")
	public String FreeList(
			@RequestParam(value="search",required=false)String search,
			@RequestParam(value="keyword",required=false)String keyword,
			@RequestParam(value="searchCheck",required=false)String searchCheck,
			@RequestParam(value="boardType",required=false,defaultValue="0")String boardType,
			@RequestParam(value="pageNum",required=false,defaultValue="1")String pageNum,Model model){
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
	public String FreeModify(BoardVO vo,Model model) {
		model.addAttribute("vo",vo);
		return "board/free/modify";
	}
	
	@RequestMapping("notice/modify")
	public String NoticeModify() {
	
		return "board/notice/modify";
	}
	
	@RequestMapping("pds/modify")
	public String PdsModify() {
	
		return "board/pds/modify";
	}
	
	@RequestMapping(value="modifyProc",method=RequestMethod.POST)
	@ResponseBody public String modifyProc(BoardVO vo) {
		int result = service.modView(vo);
		return ""+result;
	}
	
	@RequestMapping("free/view")
	public String FreeView(@RequestParam(value="postSeq",required=false)String postSeq,Model model) {
			 
			 int postSeq2 = Integer.parseInt(postSeq);
			 BoardVO vo = service.getView(postSeq2);
			 model.addAttribute("vo",vo);
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
	
	@RequestMapping(value= "writeProc" , method=RequestMethod.POST)
	@ResponseBody public String FreeWriteCheck(BoardVO vo,HttpServletRequest request,
			@RequestParam("file")MultipartFile[] files) throws Exception {
		
		String[] file = request.getParameterValues("files");
		vo.setFileAttachYn("N");
		if(file != null) vo.setFileAttachYn("Y");
		
		int result = service.AddBoard(vo,files);
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
