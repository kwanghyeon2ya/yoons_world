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
		int allCount = 0;
		
		int existCount = cservice.getExistCommentsCount(postSeq); //존재하는 댓글의 카운트-status가 1인글
		
		allCount = cservice.getALLCommentsCount(postSeq);//모든 댓글의 카운트 -status가 0,1인글
		List<CommentsVO> clist = cservice.getCommentsList(postSeq,startRow,endRow);
		
		model.addAttribute("clist",clist);
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("currentPage",currentPage);
		model.addAttribute("startRow",startRow);
		model.addAttribute("endRow",endRow);
		model.addAttribute("allCount",allCount);
		model.addAttribute("existCount",existCount);
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
		
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("currentPage",currentPage);
		model.addAttribute("startRow",startRow);
		model.addAttribute("endRow",endRow);
		model.addAttribute("count",count);
		model.addAttribute("boardList",boardList);
	}
	
	
	@RequestMapping("free/list")
	public String getFreeList(
			@RequestParam(value="search",required=false)String search,
			@RequestParam(value="keyword",required=false)String keyword,
			@RequestParam(value="searchCheck",required=false)String searchCheck,
			@RequestParam(value="boardType",required=false,defaultValue="0")String boardType,
			@RequestParam(value="pageNum",required=false,defaultValue="1")String pageNum,Model model){
		boardList(search,keyword,searchCheck,boardType,pageNum,model);
		model.addAttribute("boardType",boardType);
		model.addAttribute("pageNum",pageNum);
		model.addAttribute("keyword",keyword);
		model.addAttribute("searchCheck",searchCheck);
		model.addAttribute("search",search);
		return "board/free/list";
	}
	
	@RequestMapping("notice/list")
	public String getNoticeList(
			@RequestParam(value="search",required=false)String search,
			@RequestParam(value="keyword",required=false)String keyword,
			@RequestParam(value="searchCheck",required=false)String searchCheck,
			@RequestParam(value="boardType",required=false,defaultValue="1")String boardType,
			@RequestParam(value="pageNum",required=false,defaultValue="1")String pageNum,Model model){
		boardList(search,keyword,searchCheck,boardType,pageNum,model);
		
		List<BoardVO>fixedBoardList = service.getNoticeFixedBoard(boardType);
		model.addAttribute("boardType",boardType);
		model.addAttribute("pageNum",pageNum);
		model.addAttribute("keyword",keyword);
		model.addAttribute("searchCheck",searchCheck);
		model.addAttribute("search",search);
		model.addAttribute("fixedBoardList",fixedBoardList);
		return "board/notice/list";
	}
	
	@RequestMapping("pds/list")
	public String PdsList(
			@RequestParam(value="search",required=false)String search,
			@RequestParam(value="keyword",required=false)String keyword,
			@RequestParam(value="searchCheck",required=false)String searchCheck,
			@RequestParam(value="boardType",required=false,defaultValue="2")String boardType,
			@RequestParam(value="pageNum",required=false,defaultValue="1")String pageNum,Model model){
		boardList(search,keyword,searchCheck,boardType,pageNum,model);
		model.addAttribute("boardType",boardType);
		model.addAttribute("pageNum",pageNum);
		model.addAttribute("keyword",keyword);
		model.addAttribute("searchCheck",searchCheck);
		model.addAttribute("search",search);
		return "board/pds/list";
	}
	
	@RequestMapping("free/modify")
	public String FreeModify(String postSeq,Model model,HttpSession session) {
		int postSeq2 = Integer.parseInt(postSeq);
		BoardVO vo2 = service.getView(postSeq2);
		int sessionSeqForUser = (int)session.getAttribute("sessionSeqForUser");
		if(sessionSeqForUser == vo2.getRegrSeq()) {
			List<BoardAttachVO> anlist = aservice.getAttachList(postSeq2);
			model.addAttribute("vo",vo2);
			model.addAttribute("anlist",anlist);
			return "board/notice/modify";	
		}
			return "common/nuguruman";
	}
	
	@RequestMapping("notice/modify")
	public String NoticeModify(String postSeq,Model model,HttpSession session) {
		int postSeq2 = Integer.parseInt(postSeq);
		BoardVO vo2 = service.getView(postSeq2);
		int sessionSeqForUser = (int)session.getAttribute("sessionSeqForUser");
		if(sessionSeqForUser == vo2.getRegrSeq()) {
			List<BoardAttachVO> anlist = aservice.getAttachList(postSeq2);
			model.addAttribute("vo",vo2);
			model.addAttribute("anlist",anlist);
			return "board/notice/modify";	
		}
			return "common/nuguruman";
	}
	
	@RequestMapping("pds/modify")
	public String PdsModify(String postSeq,Model model,HttpSession session) {
		int postSeq2 = Integer.parseInt(postSeq);
		BoardVO vo2 = service.getView(postSeq2);
		int sessionSeqForUser = (int)session.getAttribute("sessionSeqForUser");
		if(sessionSeqForUser == vo2.getRegrSeq()) {
			List<BoardAttachVO> anlist = aservice.getAttachList(postSeq2);
			model.addAttribute("vo",vo2);
			model.addAttribute("anlist",anlist);
			return "board/notice/modify";	
		}
			return "common/nuguruman";
	}
	
	@RequestMapping(value="modifyViewProc",method=RequestMethod.POST)
	@ResponseBody public int modViewProc(BoardVO vo,HttpSession session,
										@RequestParam(value="file",required=false)MultipartFile[] files) {
		int sessionSeqForUser = (int)session.getAttribute("sessionSeqForUser");
		BoardVO vo2 = service.getView(vo.getPostSeq());
		if(vo.getBoardFixYn() == null) {
			vo.setBoardFixYn("N");
		}
		if(!files[0].isEmpty()) {
			vo.setFileAttachYn("Y");
			}
		if(vo2.getRegrSeq() == sessionSeqForUser) {
		vo.setUpdrSeq(sessionSeqForUser);
		vo.setRegrSeq(sessionSeqForUser);
		return service.modView(vo,files);
		}
		
		return 0;
	}
	@RequestMapping(value="modifyCommentProc",method=RequestMethod.POST)
	@ResponseBody public int modCommentProc(CommentsVO vo,HttpSession session) {
		
		int sessionSeqForUser = (int)session.getAttribute("sessionSeqForUser");
		
		BoardVO vo2 = service.getView(vo.getPostSeq());
		
		if(sessionSeqForUser == vo2.getRegrSeq()) {
		vo.setUpdrSeq(sessionSeqForUser);
		
		return cservice.modComment(vo);
		}
		return 0;
	}
	
	@RequestMapping("free/view")
	public String getFreeView(@RequestParam(value="postSeq",required=false)String postSeq,
			@RequestParam(value="pageNum",required=false,defaultValue="1")String pageNum,
						Model model,HttpSession session) {
			 
			 int postSeq2 = Integer.parseInt(postSeq);
			 List<BoardAttachVO> anlist = aservice.getAttachList(postSeq2);
			 BoardVO vo = service.getView(postSeq2);
			 int sessionSeqForUser = (int)session.getAttribute("sessionSeqForUser");
			 
			 if(vo.getRegrSeq() != sessionSeqForUser) {
				 service.updateCnt(postSeq2);	 
			 }
			 
			 commentsList(pageNum,postSeq2,model);
			 model.addAttribute("vo",vo);
			 model.addAttribute("anlist",anlist);
		return "board/free/view";
	}
	
	@RequestMapping("notice/view")
	public String getNoticeView(@RequestParam(value="postSeq",required=false)String postSeq,
			@RequestParam(value="pageNum",required=false,defaultValue="1")String pageNum,
						Model model,HttpSession session) {
			 
			 int postSeq2 = Integer.parseInt(postSeq);
			 List<BoardAttachVO> anlist = aservice.getAttachList(postSeq2);
			 BoardVO vo = service.getView(postSeq2);
			 int sessionSeqForUser = (int)session.getAttribute("sessionSeqForUser");
			 
			 if(vo.getRegrSeq() != sessionSeqForUser) {
				 service.updateCnt(postSeq2);	 
			 }
			 
			 commentsList(pageNum,postSeq2,model);
			 model.addAttribute("vo",vo);
			 model.addAttribute("anlist",anlist);
			 
			 return "/board/notice/view";
	}
	
	@RequestMapping("pds/view")
	public String getPdsView(@RequestParam(value="postSeq",required=false)String postSeq,
			@RequestParam(value="pageNum",required=false,defaultValue="1")String pageNum,
						Model model,HttpSession session) {
			 
			 int postSeq2 = Integer.parseInt(postSeq);
			 List<BoardAttachVO> anlist = aservice.getAttachList(postSeq2);
			 BoardVO vo = service.getView(postSeq2);
			 int sessionSeqForUser = (int)session.getAttribute("sessionSeqForUser");
			 
			 if(vo.getRegrSeq() != sessionSeqForUser) {
				 service.updateCnt(postSeq2);	 
			 }
			 
			 commentsList(pageNum,postSeq2,model);
			 model.addAttribute("vo",vo);
			 model.addAttribute("anlist",anlist);
			 
			 return "/board/pds/view";
	}
	
	@RequestMapping("free/write")
	public String FreeWrite() {
		return "board/free/write";
	}
	
	@RequestMapping(value= "writeProc" , method=RequestMethod.POST)
	@ResponseBody public int FreeWriteCheck(
			@RequestParam(value="file",required=false) MultipartFile[] files,
			@ModelAttribute(value="BoardVO") BoardVO vo,HttpServletRequest request,
			HttpSession session
			) throws Exception {
		
		
		String name = (String)session.getAttribute("sessionNameForUser");
		int sessionSeqForUser = (Integer)session.getAttribute("sessionSeqForUser");
		
		if(vo.getHideCheck() == 1 && (!vo.getHideName().equals(""))) {
			vo.setWriterName(vo.getHideName());
		}else {
			vo.setWriterName(name);	
		}
		if(vo.getBoardFixYn() == null) {
			vo.setBoardFixYn("N");
		}
		vo.setFileAttachYn("N");
		vo.setRegrSeq(sessionSeqForUser);
		if(!files[0].isEmpty()) {
		vo.setFileAttachYn("Y");
		}
		
		int result = service.insertBoard(vo,files);
		return result;
	}
	
	@RequestMapping("notice/write")
	public String NoticeWrite() {
		return "board/notice/write";
	}

	@RequestMapping("pds/write")
	public String PdsWrite() {
	
		return "board/pds/write";
	}
	
	@RequestMapping(value="deleteViewProc",method=RequestMethod.POST)
	@ResponseBody public int deleteViewProc(BoardVO vo,HttpSession session) { //게시판 글 삭제
			
			/*int dbRegrSeq = service.findUser(vo.getPostSeq());*/
			int sessionSeqForUser = (Integer)session.getAttribute("sessionSeqForUser");
			BoardVO vo2 = service.getView(vo.getPostSeq());
			if(sessionSeqForUser == vo2.getRegrSeq()) {
				vo.setUpdrSeq(sessionSeqForUser);
				return service.delView(vo);
			}
			// 세션에 있는 아이디 (= 접속한 사람)랑 
			
			// 제거하려고하는 게시판 글의 작성자랑 비교
				// db select regerSeq from board by post_seq (파라미터로 넘긴)
		return 0;
	}
	@RequestMapping(value="insertCommentsProc",method=RequestMethod.POST)
	@ResponseBody public int insertCommentsProc(CommentsVO vo,HttpSession session) {
		/*String version = org.springframework.core.SpringVersion.getVersion();
		System.out.println(version);*/
//		5.3.17
		
		int sessionSeqForUser = (Integer) session.getAttribute("sessionSeqForUser");
		String sessionIdForUser = (String) session.getAttribute("sessionIdForUser");
		vo.setRegrSeq(sessionSeqForUser);
		vo.setCommId(sessionIdForUser);
		int result = cservice.insertComments(vo);
		return result;
	}
	
	@RequestMapping(value="deleteCommentsProc",method=RequestMethod.POST)
	@ResponseBody public int deleteCommentsProc(CommentsVO vo,HttpSession session) {
		
		
		int sessionSeqForUser = (int)session.getAttribute("sessionSeqForUser");
		
		BoardVO vo2 = service.getView(vo.getPostSeq());
		
		if(sessionSeqForUser == vo2.getRegrSeq()) {
			vo.setUpdrSeq(sessionSeqForUser);
			return cservice.delComment(vo);
		}
		return 0;
	}
	
}
