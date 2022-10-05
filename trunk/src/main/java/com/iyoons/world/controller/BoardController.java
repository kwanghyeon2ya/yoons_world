package com.iyoons.world.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.iyoons.world.service.AttachService;
import com.iyoons.world.service.BoardService;
import com.iyoons.world.service.CommentsService;
import com.iyoons.world.vo.BoardAttachVO;
import com.iyoons.world.vo.BoardVO;
import com.iyoons.world.vo.CommentsVO;

@RequestMapping("/board/*")
@Controller
public class BoardController {
	
	@Autowired
	public BoardService service;
	
	@Autowired
	public CommentsService cservice;
	
	@Autowired
	public AttachService aservice;

	public void commentsList(String pageNum,int postSeq,Model model) {
		
		int pageSize = 4;
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = pageSize * currentPage;
		int count = 0;
		
		count = cservice.getCommentsCount(postSeq);
		List<CommentsVO> clist = cservice.getCommentsList(postSeq,startRow,endRow);
		
		model.addAttribute("clist",clist);
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("currentPage",currentPage);
		model.addAttribute("startRow",startRow);
		model.addAttribute("endRow",endRow);
		model.addAttribute("count",count);
		model.addAttribute("pageNum",pageNum);
	}
	
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
		count = service.getBoardCount(boardType);
		System.out.println(keyword);
		if(searchCheck != null && search != null && keyword != null) {
			count = service.getSearchCount(search, keyword, searchCheck, startRow, endRow, boardType);
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
	public String getFreeList(
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
	@ResponseBody public String modViewProc(BoardVO vo) {
		int result = service.modView(vo);
		return ""+result;
	}
	
	@RequestMapping("free/view")
	public String getFreeView(@RequestParam(value="postSeq",required=false)String postSeq,
			@RequestParam(value="pageNum",required=false,defaultValue="1")String pageNum,
						Model model) {
			 
			 int postSeq2 = Integer.parseInt(postSeq);
			 List<BoardAttachVO> anlist = aservice.getAttachList(postSeq2);
			 BoardVO vo = service.getView(postSeq2);
			 
			 service.updateCnt(postSeq2);
			 
			 commentsList(pageNum,postSeq2,model);
			 model.addAttribute("vo",vo);
			 model.addAttribute("anlist",anlist);
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
	@ResponseBody public String FreeWriteCheck(
			@RequestParam(value="file",required=false) MultipartFile[] files,
			@ModelAttribute(value="BoardVO") BoardVO vo,HttpServletRequest request,
			HttpSession session
			) throws Exception {
		
		String name = (String)session.getAttribute("sname");
		int sseq = (Integer)session.getAttribute("sseq");
		
		vo.setWriterName(name);
		vo.setRegrSeq(sseq);
		vo.setFileAttachYn("N");
		
		int result = service.insertBoard(vo,files);
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
	
	@RequestMapping(value="deleteProc",method=RequestMethod.POST)
	@ResponseBody public int deleteProc(BoardVO vo,HttpSession session) {
			
			/*int dbRegrSeq = service.findUser(vo.getPostSeq());*/
			int sseq = (Integer)session.getAttribute("sseq");
			
			if(sseq == vo.getRegrSeq()) {
				vo.setUpdrSeq(sseq);
				return service.delView(vo);
			}
			
			// 세션에 있는 아이디 (= 접속한 사람)랑 
			
			// 제거하려고하는 게시판 글의 작성자랑 비교
				// db select regerSeq from board by post_seq (파라미터로 넘긴)
		return 0;
	}
	@RequestMapping(value="commentsProc",method=RequestMethod.POST)
	@ResponseBody public int CommentsProc(CommentsVO vo,HttpSession session) {
		
		int sseq = (Integer) session.getAttribute("sseq");
		System.out.println(vo.getCommContent());
		vo.setRegrSeq(sseq);
		
		int result = cservice.insertComments(vo);
		return result;
	}
	
}
