package com.iyoons.world.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	
	@RequestMapping("free/list")
	public String FreeList() {
		
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
	@RequestMapping("free/writePro")
	public String FreeWritePro() {
		return "board/free/list";
	}
	
	@RequestMapping(value= "free/writePro" , method=RequestMethod.POST)
	@ResponseBody public String FreeWriteCheck(BoardVO vo,
			@RequestParam("file") MultipartFile files) throws Exception {
		
		vo.setFileAttachYn("N");
		if(files != null){
			vo.setFileAttachYn("Y");
		}
		System.out.println(vo.getFileAttachYn());
		int result = service.AddBoard(vo);
		
		return result+"";
	}
	
	@RequestMapping("notice/write")
	public String NoticeWrite() {
		return "board/notice/write";
	}
	@RequestMapping("notice/writePro")
	@ResponseBody public String NoticeWritePro() {
		
		return "";
	}
	
	@RequestMapping("pds/write")
	public String PdsWrite() {
	
		return "board/pds/write";
	}
	
	@RequestMapping("pds/writePro")
	@ResponseBody public String PdsWritePro() {
		
		return "";
	}
	

	
}
