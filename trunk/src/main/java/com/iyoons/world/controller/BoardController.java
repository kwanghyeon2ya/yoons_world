package com.iyoons.world.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.google.gson.Gson;
import com.iyoons.world.common.FinalVariables;
import com.iyoons.world.service.AttachService;
import com.iyoons.world.service.BoardService;
import com.iyoons.world.service.UserActionService;
import com.iyoons.world.service.CommentsService;
import com.iyoons.world.service.impl.PagingService;
import com.iyoons.world.vo.BoardAttachVO;
import com.iyoons.world.vo.BoardVO;
import com.iyoons.world.vo.CommentsVO;
import com.iyoons.world.vo.PageVO;
import com.iyoons.world.vo.UserActionVO;
import com.iyoons.world.vo.UserVO;

import ch.qos.logback.core.net.SyslogOutputStream;

@RequestMapping("/board/*")
@Controller
public class BoardController {
	
	@Autowired
	public BoardService service;
	
	@Autowired
	public UserActionService uaservice;
	
	@Autowired
	public CommentsService cservice;
	
	@Autowired
	public AttachService aservice;
	
	@Autowired 
	PagingService pageService;

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	/*public void commentsList(String pageNum,int postSeq,Model model) {
		
		int pageSize = 4;
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = pageSize * currentPage;
		
		
		
		
		
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("currentPage",currentPage);
		model.addAttribute("startRow",startRow);
		model.addAttribute("endRow",endRow);
		
		model.addAttribute("pageNum",pageNum);
		
	}*/
	
	public void boardList(
					String search,
					String keyword,
					String searchCheck,
					String boardType,
					String pageNum,Model model,HttpServletRequest request) {
		try {
			
			int pageSize = 10;
			int currentPage = Integer.parseInt(pageNum);
			int startRow = (currentPage - 1) * pageSize + 1;
			int endRow = pageSize * currentPage;
			int count = 0;
			count = service.getBoardCount(boardType);
			logger.debug("keyword : "+keyword);
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
			
		} catch (NullPointerException ne) {
			logger.error("nullpointException" + ne);
			logger.debug(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
		} catch (Exception e) {
			logger.error("Exception" + e);
			logger.debug(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
		}
	}
	
	@RequestMapping(value="free/list",method=RequestMethod.GET)
	public String getFreeList(BoardVO boardVO,
			@RequestParam(value="pageNum",required=false,defaultValue="1")String pageNum,
			@RequestParam(value="boardType",required=false,defaultValue="0")String boardType,Model model,HttpServletRequest request) {
		boardVO.setBoardType(boardType);
		try {
			int pageSize = 10;
			int count = service.getBoardCount(boardType);
			logger.debug("count 확인 : "+count);
			List<BoardVO> boardList = null;
			logger.debug("페이징 vo return 전");
			PageVO pageVO = pageService.getPaging(pageSize,Integer.parseInt(pageNum));
			logger.debug("pageVO 값 : "+pageVO.toString());
			if(boardVO.getSearchCheck() != null && boardVO.getSearch() != null && boardVO.getKeyword() != null) {
				count = service.getSearchCount(boardVO,pageVO);
				logger.debug("keyword : "+boardVO.getKeyword());
			}
			/*if(count != 0) boardList = service.getBoardList(search,keyword,searchCheck,startRow, endRow, boardType);*/
			if(count != 0) boardList = service.getBoardList(boardVO,pageVO);
			logger.debug("boardList : "+boardList);
			model.addAttribute("count",count);
			model.addAttribute("boardList",boardList);
			model.addAttribute("pageVO",pageVO);
			model.addAttribute("boardVO",boardVO);
			
		} catch (Exception e) {
			logger.error("request uri \t:"+request.getRequestURI());
			StringWriter sw = new StringWriter();
			e.printStackTrace(new PrintWriter(sw));
			logger.debug("Exception :"+sw.toString());
		}
		
		return "board/free/list";
	}
	
	/*@RequestMapping(value="free/list",method=RequestMethod.GET)
	public String getFreeList( // 자유게시판
			@RequestParam(value="search",required=false)String search,
			@RequestParam(value="keyword",required=false)String keyword,
			@RequestParam(value="searchCheck",required=false)String searchCheck,
			@RequestParam(value="boardType",required=false,defaultValue="0")String boardType,
			@RequestParam(value="pageNum",required=false,defaultValue="1")String pageNum,Model model,HttpServletRequest request){
			
		boardList(search,keyword,searchCheck,boardType,pageNum,model,request);
		model.addAttribute("boardType",boardType);
		model.addAttribute("pageNum",pageNum);
		model.addAttribute("keyword",keyword);
		model.addAttribute("searchCheck",searchCheck);
		model.addAttribute("search",search);
		return "board/free/list";
		
	}*/
	
	
	@RequestMapping(value="notice/list",method=RequestMethod.GET)
	public String getNoticeList(@RequestParam(value="pageNum",required=false,defaultValue="1")String pageNum,
			@RequestParam(value="boardType",required=false,defaultValue="1")String boardType,
			BoardVO boardVO,HttpServletRequest request,Model model) {
		
			boardVO.setBoardType(boardType);
		try {
			int pageSize = 10;
			List<BoardVO> boardList = null;
			List<BoardVO> fixedBoardList = service.getNoticeFixedBoard(boardType);
			PageVO pageVO = pageService.getPaging(pageSize,Integer.parseInt(pageNum));
			int count = service.getBoardCount(boardType);
			
			if(boardVO.getSearchCheck() != null && boardVO.getSearch() != null && boardVO.getKeyword() != null) {
				count = service.getSearchCount(boardVO,pageVO);
				logger.debug("keyword : "+boardVO.getKeyword());
			}
			
			logger.debug("공지사항 pageVO 값 : "+pageVO.toString());
			logger.debug("fixedBoardList : "+fixedBoardList);
			if(count != 0) {
				boardList = service.getBoardList(boardVO,pageVO);
			}
			
			logger.debug("boardType 값 :  "+boardType);
			logger.debug("공지사항 게시판 카운트 : "+count);
			logger.debug("공지사항 boardList : "+boardList);
			logger.debug("boardVO 값 : "+boardVO);
			model.addAttribute("pageVO",pageVO);
			model.addAttribute("fixedBoardList",fixedBoardList);
			model.addAttribute("boardVO",boardVO);
			model.addAttribute("count",count);
			model.addAttribute("boardList",boardList);
			
		} catch (NullPointerException ne) {
			logger.error("nullpointException  어떻게 출력될까?" + ne);
			logger.error("request uri \t  :"+request.getRequestURI());
			StringWriter sw = new StringWriter();
			ne.printStackTrace(new PrintWriter(sw));
			logger.error("nullpointException : "+sw.toString());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		} catch (Exception e) {
			logger.error("request uri \t  :"+request.getRequestURI());
			StringWriter sw = new StringWriter();
			e.printStackTrace(new PrintWriter(sw));
			logger.error("Exception : "+sw.toString());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		}
		
		
		return "board/notice/list";
	}
	
	
	/*@RequestMapping(value="notice/list",method=RequestMethod.GET)
	public String getNoticeList( // 공지사항게시판
			@RequestParam(value="search",required=false)String search,
			@RequestParam(value="keyword",required=false)String keyword,
			@RequestParam(value="searchCheck",required=false)String searchCheck,
			@RequestParam(value="boardType",required=false,defaultValue="1")String boardType,
			@RequestParam(value="pageNum",required=false,defaultValue="1")String pageNum,Model model,HttpServletRequest request){
			boardList(search,keyword,searchCheck,boardType,pageNum,model, request);
		try {	
			
			List<BoardVO> fixedBoardList = service.getNoticeFixedBoard(boardType);
			model.addAttribute("boardType",boardType);
			model.addAttribute("pageNum",pageNum);
			model.addAttribute("keyword",keyword);
			model.addAttribute("searchCheck",searchCheck);
			model.addAttribute("search",search);
			model.addAttribute("fixedBoardList",fixedBoardList);
			return "board/notice/list";
			
		} catch (NullPointerException ne) {
			logger.error("nullpointException" + ne);
			logger.debug(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		} catch (Exception e) {
			logger.error("Exception" + e);
			logger.debug(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		}
	}*/
	
	
	@RequestMapping(value="pds/list",method=RequestMethod.GET)
	public String PdsList( // 첨부파일게시판
			@RequestParam(value="boardType",required=false,defaultValue="2")String boardType,
			@RequestParam(value="pageNum",required=false,defaultValue="1")String pageNum,
			BoardVO boardVO,Model model,HttpServletRequest request){
		boardVO.setBoardType(boardType);
		
		try {
			int pageSize = 10;
			int count = service.getBoardCount(boardType);
			List<BoardVO> boardList = null;
			PageVO pageVO = pageService.getPaging(pageSize, Integer.parseInt(pageNum));
			
			boardList = service.getBoardList(boardVO,pageVO);
			
			model.addAttribute("pageNum",pageNum);
			model.addAttribute("count",count);
			model.addAttribute("boardVO",boardVO);
			model.addAttribute("boardList",boardList);
			model.addAttribute("pageVO",pageVO);
		} catch (NullPointerException ne) {
			logger.error("nullpointException" + ne);
			logger.debug(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		} catch (Exception e) {
			logger.error("Exception" + e);
			logger.debug(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		}
			return "board/pds/list";
	}
	
	
	/*@RequestMapping(value="pds/list",method=RequestMethod.GET)
	public String PdsList( // 첨부파일게시판
			@RequestParam(value="search",required=false)String search,
			@RequestParam(value="keyword",required=false)String keyword,
			@RequestParam(value="searchCheck",required=false)String searchCheck,
			@RequestParam(value="boardType",required=false,defaultValue="2")String boardType,
			@RequestParam(value="pageNum",required=false,defaultValue="1")String pageNum,Model model,HttpServletRequest request){
			
		boardList(search,keyword,searchCheck,boardType,pageNum,model, request);
		model.addAttribute("boardType",boardType);
		model.addAttribute("pageNum",pageNum);
		model.addAttribute("keyword",keyword);
		model.addAttribute("searchCheck",searchCheck);
		model.addAttribute("search",search);
		return "board/pds/list";
			
	}*/
	
	@RequestMapping(value="getListForMain",method=RequestMethod.GET)
	public String getListForMain(Model model,HttpServletRequest request) {// 각 게시판을 가져옴 
		
		try {
			
			BoardVO vo = service.getListForMain(); //vo에 각 게시판에 대한 List 객체를 만들어서
													//Hash map타입의 매개변수를 넣어 호출후 vo안의 List객체에 대입
			model.addAttribute("freeBoardList",vo.getFreeBoardList());
			model.addAttribute("fixedBoardList",vo.getFixedBoardList());
			model.addAttribute("noticeBoardList",vo.getNoticeBoardList());
			model.addAttribute("pdsBoardList",vo.getPdsBoardList());
			
			return "board/boardListForMain";
			
		} catch (NullPointerException ne) {
			logger.error("nullpointException" + ne);
			logger.debug(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		} catch (Exception e) {
			logger.error("Exception" + e);
			logger.debug(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		}	
	}
	
	@RequestMapping(value="getMyListByLike",method=RequestMethod.GET)
	public String getMyListByLike(BoardVO boardVO,HttpSession session,Model model) {
		
		int pageSize = 5;
		int stopBtnCheck = boardVO.getPageNum() * 5; // 더보기 버튼 활성화 여부 비교용 - 총 게시글 카운트와 비교
		int stopList = 0; // 1 일시 더보기 버튼 없앰 
		System.out.println("pageNym : "+boardVO.getPageNum());
		int sessionSeqForUser = (int) session.getAttribute("sessionSeqForUser");
		int count = service.getMyListByLikeCnt(sessionSeqForUser);
		boardVO.setUserSeq(sessionSeqForUser);
		
		
		PageVO pageVO = pageService.getPaging(pageSize, boardVO.getPageNum());  
		List<BoardVO> myListByLike = service.getMyListByLike(boardVO,pageVO);
		if(count <= stopBtnCheck) {
			stopList = 1;
		}
		
		model.addAttribute("myListByLike",myListByLike);
		model.addAttribute("count", count);
		model.addAttribute("stopList",stopList);
		return "board/myListByLike";
	}
	
	@RequestMapping(value="getMyListByComments",method=RequestMethod.GET)
	public String getMyListByComments(BoardVO boardVO,HttpSession session,Model model) {
		
		int pageSize = 5;
		int stopBtnCheck = boardVO.getPageNum() * 5; // 더보기 버튼 활성화 여부 비교용 - 총 게시글 카운트와 비교
		int stopList = 0; // 1 일시 더보기 버튼 없앰 
		int sessionSeqForUser = (int) session.getAttribute("sessionSeqForUser");
		int count = service.getMyListByCommentsCnt(sessionSeqForUser);
		boardVO.setUserSeq(sessionSeqForUser);
		PageVO pageVO = pageService.getPaging(pageSize, boardVO.getPageNum());
		
		
		List<BoardVO> myListByComments = service.getMyListByComments(boardVO, pageVO);
		if(count <= stopBtnCheck) {
			stopList = 1;
		}
		model.addAttribute("myListByComments",myListByComments);
		model.addAttribute("count",count);
		model.addAttribute("stopList",stopList);
		return "board/myListByComments";
	}
	
	@RequestMapping(value="getMyBoardList",method=RequestMethod.GET)
	public String getMyBoardList(BoardVO boardVO,HttpSession session,Model model) {
		
		int pageSize = 5;
		int stopBtnCheck = boardVO.getPageNum() * 5; // 더보기 버튼 활성화 여부 비교용 - 총 게시글 카운트와 비교
		int stopList = 0; // 1 일시 더보기 버튼 없앰 
		int sessionSeqForUser = (int) session.getAttribute("sessionSeqForUser");
		int count = service.getMyBoardListCnt(sessionSeqForUser);
		boardVO.setUserSeq(sessionSeqForUser);
		PageVO pageVO = pageService.getPaging(pageSize, boardVO.getPageNum());

		List<BoardVO> myBoardList = service.getMyBoardList(boardVO, pageVO);
		if(count <= stopBtnCheck) {
			stopList = 1;
		}
		model.addAttribute("myBoardList",myBoardList);
		
		model.addAttribute("stopList",stopList);
		return "board/myBoardList";
	}

	
	
	/*@RequestMapping(value="getAllBoardListForReadCount",method=RequestMethod.GET)
	public String getAllBoardListForReadCount(Model model) {
		
		int startRow = 1;
		int endRow = 10;
		int pageSize = 10;
		
		List<BoardVO> boardList = service.getAllBoardListOrderedByReadCount(startRow, endRow);
		
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("boardList",boardList);
		return "board/pds/list";
	}*/
	
	@RequestMapping(value="getAllBoardListForReadCountForMonth",method=RequestMethod.GET)
	public String getAllBoardListForReadCountForMonth(Model model,HttpServletRequest request) { // 한달 조회수 랭킹
		
		try {
			
			int startRow = 1;
			int endRow = 10;
			int pageSize = 10;
			
			List<BoardVO> boardList = service.getAllBoardListOrderedByReadCountForMonth(startRow, endRow);
			
			model.addAttribute("pageSize",pageSize);
			model.addAttribute("boardList",boardList);
			return "board/getAllBoardListForReadCountForMonth";
			
		} catch (NullPointerException ne) {
			logger.error("nullpointException" + ne);
			logger.debug(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		} catch (Exception e) {
			logger.error("Exception" + e);
			logger.debug(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		}
	
	}
	
	@RequestMapping("free/modify")
	public String FreeModify(String postSeq, Model model, HttpSession session, HttpServletRequest request,
			HttpServletResponse response){ // 자유게시판 글수정 페이지 진입

		try {
			int postSeq2 = Integer.parseInt(postSeq);
			BoardVO vo2 = service.getView(postSeq2);
			int sessionSeqForUser = (int) session.getAttribute("sessionSeqForUser");
			if (sessionSeqForUser == vo2.getRegrSeq()) {
				List<BoardAttachVO> anlist = aservice.getAttachList(postSeq2);
				model.addAttribute("vo", vo2);
				model.addAttribute("anlist", anlist);
				return "board/free/modify";
			} else {
				return "common/nuguruman";
			}
		} catch (IllegalStateException ie) {
			logger.error("IllegalStateException" + ie);
			logger.error(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		} catch (NullPointerException ne) {
			logger.error("nullpointException" + ne);
			logger.error(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		} catch (Exception e) {
			logger.error("Exception" + e);
			logger.error(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		}

	}

	@RequestMapping("notice/modify")
	public String NoticeModify(String postSeq, Model model, HttpSession session, HttpServletRequest request,
			HttpServletResponse response){ // 공지사항게시판 글수정 페이지 진입
		
		try {
			
			int postSeq2 = Integer.parseInt(postSeq);
			BoardVO vo2 = service.getView(postSeq2);
			int sessionSeqForUser = (int) session.getAttribute("sessionSeqForUser");
			if (sessionSeqForUser == vo2.getRegrSeq()) {
				List<BoardAttachVO> anlist = aservice.getAttachList(postSeq2);
				model.addAttribute("vo", vo2);
				model.addAttribute("anlist", anlist);
				return "board/notice/modify";
			} else {
				return "common/nuguruman";
			}
			
		} catch (IllegalStateException ie) {
			logger.error("IllegalStateException" + ie);
			logger.error(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		} catch (NullPointerException ne) {
			logger.error("nullpointException" + ne);
			logger.error(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		} catch (Exception e) {
			logger.error("Exception" + e);
			logger.error(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		}
	}

	@RequestMapping("pds/modify")
	public String PdsModify(String postSeq, Model model, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) { // 자료 게시판 글수정 페이지 진입
		
		try {
			
			int postSeq2 = Integer.parseInt(postSeq);
			BoardVO vo2 = service.getView(postSeq2);
			int sessionSeqForUser = (int) session.getAttribute("sessionSeqForUser");
			if (sessionSeqForUser == vo2.getRegrSeq()) {
				List<BoardAttachVO> anlist = aservice.getAttachList(postSeq2);
				model.addAttribute("vo", vo2);
				model.addAttribute("anlist", anlist);
				return "board/pds/modify";
			} else {
				return "common/nuguruman";
			}
		} catch (IllegalStateException ie) {
			logger.error("IllegalStateException" + ie);
			logger.error(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		} catch (NullPointerException ne) {
			logger.error("nullpointException" + ne);
			logger.error(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		} catch (Exception e) {
			logger.error("Exception" + e);
			logger.error(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		}
	}

	@RequestMapping(value = "modifyViewProc", method = RequestMethod.POST)
	@ResponseBody
	public String modViewProc(BoardVO vo, HttpSession session,
			@RequestParam(value = "file", required = false) MultipartFile[] files,
			HttpServletRequest request,Model model) { // 게시글수정 DB 저장
		
		String result = "0";
		
		try {
			
			int sessionSeqForUser = (int) session.getAttribute("sessionSeqForUser");
			BoardVO vo2 = service.getView(vo.getPostSeq());
			if (vo.getBoardFixYn() == null) {
				vo.setBoardFixYn("N");
			}
			if (!files[0].isEmpty()) {
				vo.setFileAttachYn("Y");
			}
			if (vo2.getRegrSeq() == sessionSeqForUser) {
				vo.setUpdrSeq(sessionSeqForUser);
				vo.setRegrSeq(sessionSeqForUser);
	
				return service.modView(vo, files)+"";
			}
	
		} catch (IllegalStateException ie) {
			logger.error("IllegalStateException" + ie);
			logger.error(" Request URI \t:  " + request.getRequestURI());
		} catch (IOException ioe) {
			logger.error("IOException" + ioe);
			logger.error(" Request URI \t:  " + request.getRequestURI());
		} catch (NullPointerException ne) {
			logger.error("nullpointException" + ne);
			logger.error(" Request URI \t:  " + request.getRequestURI());
		} catch (Exception e) {
			logger.debug("에러메시지(controller) : "+e.getMessage());
			if("java.lang.Exception: forbidden_file_type".equals(e.getMessage())) {
				result = FinalVariables.FORBIDDEN_FILE_TYPE_CODE;
				logger.debug("FinalVariables.FORBIDDEN_FILE_TYPE_CODE");
			}
			if("java.lang.Exception: over_the_file_size".equals(e.getMessage())){
				result = FinalVariables.OVER_THE_FILE_SIZE_CODE;
				logger.debug("FinalVariables.OVER_THE_FILE_SIZE_CODE");
			}else {
				result = FinalVariables.EXCEPTION_CODE;
				logger.debug("FinalVariables.EXCEPTION_CODE");
			}
			logger.error("Exception" + e);
			logger.error(" Request URI \t:  " + request.getRequestURI());
		}
		return result;
	}

	@RequestMapping(value = "modifyCommentProc", method = RequestMethod.POST)
	@ResponseBody
	public String modCommentProc(CommentsVO vo, HttpSession session,Model model,HttpServletRequest request) { // 댓글 수정 DB저장
		try {
			
			int sessionSeqForUser = (int) session.getAttribute("sessionSeqForUser");
	
			CommentsVO vo2 = cservice.getComment(vo);
			if (sessionSeqForUser == vo2.getRegrSeq()) {
				vo.setUpdrSeq(sessionSeqForUser);
				if (cservice.modComment(vo) == 1) {
					CommentsVO vo3 = cservice.getComment(vo);
					return vo3.getCommContent();
				}
			}
			return "";
			
		} catch (NullPointerException ne) {
			logger.error("nullpointException" + ne);
			logger.error(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		} catch (Exception e) {
			logger.error("Exception" + e);
			logger.error(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		}
	}

	@RequestMapping(value = "comments")
	public String getComments(CommentsVO cvo, Model model,HttpServletRequest request) { // 댓글 리스트 

		try {
			if (cvo.getStartIndex() == 0) {
				cvo.setStartIndex(1);
				cvo.setEndIndex(10);
			}
	
			if (cvo.getCocoCount() == 0) {
				logger.debug("cocoCount 첫등장: " + cvo.getCocoCount());
				cvo.setCocoCount(10);
			} else {
				cvo.setCocoCount(cvo.getCocoCount() + 10); // 더보기 버튼 필요한지 확인용 +10 - 밑에서 비교함
			} // view페이지에 처음 접근할 때 는 0이 넘어오지만, 후에는 10단위로 더해져 넘어옴(html 태그 length(갯수) 값)
				// ajax후에 태그 갯수를 세는 것이기 때문에 10을 더해서 계산해야함 -> 더보기 버튼 활성화/비활성화 용도
	
			BoardVO vo = service.getView(cvo.getPostSeq());
	
			if (vo == null) { // Null체크 - 글삭제 후 뒤로가기시 Null
				return "redirect:/board/free/list"; // db조회후 null일경우 redirect - 삭제된 글에 뒤로가기로 접근 x
			}
	
			int existCount = cservice.getExistCommentsCount(vo.getPostSeq()); // 존재하는 댓글의 카운트-status가 1인글
	
			List<CommentsVO> clist = cservice.getCommentsList(cvo);
			for (CommentsVO comm : clist) {
				if (comm.getNestedCommentsCnt() >= 1) {// 대댓글 갯수
					comm.setCocoList(cservice.getNestedCommentsList(comm));// 대댓글을 List로 담음
				}
			}
	
			int stopMoreCommentsButton = 0;
	
			int maxCommentsCount = cservice.getALLCommentsCount(vo.getPostSeq()); // 본 댓글 갯 수
	
			if (cvo.getCocoCount() >= maxCommentsCount) { // 더보기 버튼 변화
				stopMoreCommentsButton = 1;
			}
	
			model.addAttribute("stopMoreCommentsButton", stopMoreCommentsButton);
			model.addAttribute("vo", vo);
			model.addAttribute("clist", clist);
			model.addAttribute("existCount", existCount);
	
			return "board/comments";
		} catch (NullPointerException ne) {
			logger.error("nullpointException" + ne);
			logger.error(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		} catch (Exception e) {
			logger.error("Exception" + e);
			logger.error(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		}
	}

	/*@RequestMapping(value = "getMoreCommentsList") // 댓글 더 보기(클릭시)
	@ResponseBody
	public String getMoreCommentsList(CommentsVO cvo) {

		BoardVO vo = service.getView(cvo.getPostSeq());

		if (vo == null) {
			return "redirect:/board/free/list"; // db조회후 null일경우 redirect - 삭제된 글에 뒤로가기로 접근 x
		}

		List<CommentsVO> cmlist = cservice.getCommentsList(cvo);

		Gson gson = new Gson();
		String cmlistString = gson.toJson(cmlist); // list를 object로 바꾸고 다시 문자열로 바꿈

		return cmlistString;
	}*/

	/*
	 * 좋아요 버튼 활성화 여부를 위해 좋아요 누른 기록 조회
	 * 
	@RequestMapping("checkLikeAction") // 
	@ResponseBody public int checkLike(UserActionVO uavo,HttpSession session,HttpServletRequest request) {
		int heartCheck = 1;
		
		try {
			int sessionSeqForUser = (int)session.getAttribute("sessionSeqForUser");
			uavo.setUserSeq(sessionSeqForUser);
			logger.debug("checkLikeAction postSeq check : "+uavo.getTargetSeq()); //  targetSeq - 게시글 고유번호(postSeq)
			heartCheck = uaservice.checkUserAction(uavo);
			logger.debug("heartCheck :"+heartCheck);
		} catch (Exception e) {
			logger.error(" Request URI \t:  " + request.getRequestURI());
			StringWriter sw = new StringWriter();
			e.printStackTrace(new PrintWriter(sw));
			logger.error("Exception "+sw.toString());
		}
		return heartCheck;
	
	}*/
	
	@RequestMapping("checkAction") // 유저활동(좋아요,조회이력) DB조회 - 조회이력없을 시 조회수 증가
	@ResponseBody public Map<String, Integer> checkAction(UserActionVO uavo,HttpSession session,HttpServletRequest request) {
		Map<String,Integer> map = new HashMap<>();
		int heartCheck = 1;
		int viewCheck = 1;
		try {
			int sessionSeqForUser = (int)session.getAttribute("sessionSeqForUser");
			uavo.setUserSeq(sessionSeqForUser);
			logger.debug("checkLikeAction postSeq check : "+uavo.getTargetSeq()); //  targetSeq - 게시글 고유번호(postSeq)
			
			if("01".equals(uavo.getTargetType()) && "01".equals(uavo.getActionType())) {
				heartCheck = uaservice.checkUserAction(uavo);
				logger.debug("heartCheck :"+heartCheck);
			}
			
			if("01".equals(uavo.getTargetType()) && "02".equals(uavo.getActionType())) {
				
				viewCheck = uaservice.checkUserAction(uavo);
				logger.debug("viewCheck :"+viewCheck);
				if(viewCheck == 0) {
					uaservice.insertUserAction(uavo);	
					service.updateCnt(uavo.getTargetSeq()); // 페이지 조회수 업데이트  targetSeq - 게시글 고유번호(postSeq)
					logger.debug("updateReadCnt");
				}
			}
			
		} catch (Exception e) {
			logger.error(" Request URI \t:  " + request.getRequestURI());
			StringWriter sw = new StringWriter();
			e.printStackTrace(new PrintWriter(sw));
			logger.error("Exception "+sw.toString());
		}
		map.put("heartCheck",heartCheck);
		map.put("viewCheck",viewCheck);
		return map;
	
	}
	
	
	/*
	 * 조회수를 업데이트할지 여부를 위해 조회 이력 체크 ,조회이력없다면 조회수업데이트
	 * 
	@RequestMapping("checkViewAction") 
	@ResponseBody public int checkView(UserActionVO uavo,HttpSession session,HttpServletRequest request) {
		
		int viewCheck = 1;
		try {
			
		int sessionSeqForUser = (int)session.getAttribute("sessionSeqForUser");
		uavo.setUserSeq(sessionSeqForUser);
		logger.debug("checkViewAction postSeq check : "+uavo.getTargetSeq()); //  targetSeq - 게시글 고유번호(postSeq)
		viewCheck = uaservice.checkUserAction(uavo);
		if(viewCheck == 0) {
			uaservice.insertUserAction(uavo);	
			service.updateCnt(uavo.getTargetSeq()); // 페이지 조회수 업데이트  targetSeq - 게시글 고유번호(postSeq)
			logger.debug("viewCheck :"+viewCheck);
		}
		
		} catch (Exception e) {
			logger.error(" Request URI \t:  " + request.getRequestURI());
			StringWriter sw = new StringWriter();
			e.printStackTrace(new PrintWriter(sw));
			logger.error("Exception "+sw.toString());
		}
		return viewCheck;
		
	}*/
	
	/*
	 * 좋아요 클릭시 갯수 증가 
	 * */
	@RequestMapping(value="increasingHeartProc",method=RequestMethod.GET)
	@ResponseBody public String increasingHeartProc(UserActionVO uavo,HttpSession session,Model model,HttpServletRequest request) { 
			
			int heartCount = 0;
		
		try {
									/*UserVO userVO = (UserVO)session.getAttribute("userInfovo");*/
			BoardVO vo = service.getView(uavo.getTargetSeq()); // targetSeq - 게시글 고유번호(postSeq)
			
			if(vo == null) { // Null체크 - 뒤로가기시 Null
				 return "redirect:/board/free/list";  // db조회후 null일경우 redirect - 삭제된 글에 뒤로가기로 접근 x
			}
			if(session.getAttribute("sessionSeqForUser") == null) {
				 return "redirect:/board/free/list";
			 }
			
			int userSeq = (int)session.getAttribute("sessionSeqForUser");
			
			uavo.setUserSeq(userSeq);
			
			uaservice.insertUserAction(uavo);
			heartCount = uaservice.getHeartCount(uavo);
			logger.debug("heartCount : "+heartCount);
			return ""+heartCount;			
			
		} catch (NullPointerException ne) {
			logger.error("nullpointException" + ne);
			logger.error(" Request URI \t:  " + request.getRequestURI());
			return FinalVariables.NULLPOINT_CODE;
		} catch (Exception e) {
			logger.error("Exception" + e);
			logger.error(" Request URI \t:  " + request.getRequestURI());
			return FinalVariables.EXCEPTION_CODE;
		}
	}
	
	
	/*
	
	 * 1. 조회수 올림
	 * 		A. 조회했을 시 : 
	 * 		B. 조회 없다면 :
	 
	@RequestMapping("checkUserAction") // 페이지활동이력(좋아요,조회이력)조회 , 조회수 update , 활동기록(user_action) insert
	@ResponseBody public String checkUserAction(String postSeq,HttpSession session,HttpServletRequest request) {
		
			BoardVO vo = new BoardVO();
			
			int typeCheck = 0; // action_type의 확장성을 고려해 조회수 중복검사 변수 생성 - 0일시 첫 조회
			
			int sessionSeqForUser = (int)session.getAttribute("sessionSeqForUser");
			int postSeq2 = Integer.parseInt(postSeq);
			
			vo.setPostSeq(postSeq2);
			vo.setUserSeq(sessionSeqForUser);
			List<UserActionVO> uaList = uaservice.checkAction(vo); //좋아요 및 글에 접속한적 있는지 확인(최대 row 2줄)
			List<UserActionVO> uaList = uaservice.checkActionByTargetType(vo); //좋아요 및 글에 접속한적 있는지 확인(최대 row 2줄)
			// 조회 이력 확인 1번
			
			// 좋아요 이력 확인 1번
			
			uaservice.beforeViewCheck(vo);
			
			
			if(CollectionUtils.isEmpty(uaList)) {
				service.updateCnt(postSeq2); // 페이지 조회수 업데이트
				uaservice.insertUserAction(vo); // 유저 활동 DB입력
				vo.setHeartCount(service.getHeartCount(vo));
				vo.setReadCnt(service.getViewCount(postSeq2));
				logger.debug("free view count update check bkh before 'for'");
			}else {
				logger.debug("free view ualist confirm bkh");
				for(UserActionVO uavo : uaList) {
					logger.debug("uavo for confirm bkh");
					logger.debug("uavo.getTargetType : "+uavo.getTargetType());
					if(FinalVariables.TARGET_BOARD.equals(uavo.getTargetType())) {
						logger.debug("free view target confirm bkh");
						
						// 좋아요 : 좋아요 했음 저장			
						if(FinalVariables.ACTION_TYPE_LIKE.equals(uavo.getActionType())) {
							vo.setHeartCheck(1);
							logger.debug("free view like confirm bkh");
							typeCheck = 1;
						}
						
						// 조회이력없음 : 조회수++						
						if(!FinalVariables.ACTION_TYPE_VIEWCOUNT.equals(uavo.getActionType()) && typeCheck == 0) {
							service.updateCnt(postSeq2); // db조회시 row에 view count값이 없는 조건에 update 
							logger.debug("free view count update check bkh during 'for'");
							vo.setReadCnt(vo.getReadCnt()+1);
						}
					}
					logger.debug("uavo 카운트 : "+uavo.getHeartCount());
				}
			}
			
			return "";
	}
	*/
	
	
	@RequestMapping("free/view") //게시판
	public String getFreeView(@RequestParam(value = "postSeq", required = false) String postSeq, Model model,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) { // 자유게시판 View(글 내용)
		
		try {

			int postSeq2 = Integer.parseInt(postSeq);
			List<BoardAttachVO> anlist = aservice.getAttachList(postSeq2);
			BoardVO vo = service.getView(postSeq2);// DB조회
			
			logger.debug("free view vo 전체 체크 : "+vo);
			if (vo == null) { // Null체크 - 뒤로가기시 Null
				return "redirect:/login/logout"; // db조회후 null일경우 redirect - 삭제된 글에 뒤로가기로 접근 x
			}
			
			int sessionSeqForUser = (int) session.getAttribute("sessionSeqForUser");

			vo.setPostSeq(postSeq2);
			vo.setUserSeq(sessionSeqForUser);
			vo.setTargetSeq(postSeq2);
			/*List<UserActionVO> uaList = service.checkAction(vo); //좋아요 및 글에 접속한적 있는지 확인(최대 row 2줄)
*/			/*if(uaList.isEmpty()) {
				logger.debug("free view ualist is null bkh");
			}
			logger.debug("ualist null확인중 : "+CollectionUtils.isEmpty(uaList));
			logger.debug("free view ualist size check : "+uaList.size());*/
			
			/*vo.setHeartCount(service.getHeartCount(vo));*/
			
			/*if (vo.getRegrSeq() != sessionSeqForUser && service.checkView(vo)==0) {
				service.updateCnt(vo);
			}*/
			logger.debug("조회수체크 : "+vo.getReadCnt());
			
			model.addAttribute("vo", vo);
			model.addAttribute("anlist", anlist);
			return "board/free/view";

		} catch (NullPointerException ne) {
			logger.error("nullpointException" + ne);
			logger.error(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		} catch (Exception e) {
			logger.error("Exception" + e);
			logger.error(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		}
	}
	
	@RequestMapping("notice/view")
	public String getNoticeView(@RequestParam(value = "postSeq", required = false) String postSeq, Model model,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) { // 공지사항 게시판 View(글 내용)
		
		try {
			
			int postSeq2 = Integer.parseInt(postSeq);
			List<BoardAttachVO> anlist = aservice.getAttachList(postSeq2);
			BoardVO vo = service.getView(postSeq2); // DB조회
			
			logger.debug("notice view vo 전체 체크 : "+vo);
			if (vo == null) { // Null체크 - 뒤로가기시 Null
				return "redirect:/board/notice/list"; // db조회후 null일경우 redirect - 삭제된 글에 뒤로가기로 접근 x
			}

			if (session.getAttribute("sessionSeqForUser") == null) {
				return "redirect:/board/notice/list";
			}

			int sessionSeqForUser = (int) session.getAttribute("sessionSeqForUser");
			
			vo.setUserSeq(sessionSeqForUser);
			vo.setTargetSeq(postSeq2);
			
			logger.debug("vo.getFixStartDt() : "+vo.getFixStartDt());
			if(vo.getFixStartDt() != null) {
				Date date = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date startDt = sdf.parse(vo.getFixStartDt());
				Date endDt = sdf.parse(vo.getFixEndDt());
				long currentMilliseconds = System.currentTimeMillis();
				
				if(startDt.getTime()-currentMilliseconds < 0 && endDt.getTime()-currentMilliseconds > 0) { //현재 시간보다 고정 시작 날짜가 과거여야만 작동
					
					int expiryDt = (int) ((endDt.getTime()-currentMilliseconds) / 1000)/60/60/24;
					int expiryHour = (int) ((endDt.getTime()-currentMilliseconds) / 1000) /60/60%24;
					int expiryMinute = (int) (((endDt.getTime()-currentMilliseconds) / 1000) /60/60%60);
					
					Date expiry = new Date(endDt.getTime()-currentMilliseconds); // 분 뽑아내기
					
					vo.setExpiryDt(expiryDt);
					vo.setExpiryHour(expiryHour);
					vo.setExpiryMinute(expiry.getMinutes());
				}
			}
			
			model.addAttribute("vo", vo);
			model.addAttribute("anlist", anlist);
			return "board/notice/view";
		} catch (NullPointerException ne) {
			logger.error("nullpointException" + ne);
			logger.debug(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		} catch (Exception e) {
			logger.error("Exception" + e);
			logger.debug(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		}
	}

	@RequestMapping("pds/view")
	public String getPdsView(@RequestParam(value = "postSeq", required = false) String postSeq, Model model,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) { // 자료 게시판 View(글 내용)
		try {

			int postSeq2 = Integer.parseInt(postSeq);
			List<BoardAttachVO> anlist = aservice.getAttachList(postSeq2);
			BoardVO vo = service.getView(postSeq2);// DB조회

			if (vo == null) { // Null체크 - 뒤로가기시 Null
				return "redirect:/board/pds/list"; // db조회후 null일경우 redirect - 삭제된 글에 뒤로가기로 접근 x
			}

			if (session.getAttribute("sessionSeqForUser") == null) {
				return "redirect:/board/pds/list";
			}

			int sessionSeqForUser = (int) session.getAttribute("sessionSeqForUser");

			vo.setUserSeq(sessionSeqForUser);
			vo.setTargetSeq(postSeq2);
			
			model.addAttribute("vo", vo);
			model.addAttribute("anlist", anlist);
			return "board/pds/view";
			
		} catch (NullPointerException ne) {
			logger.error("nullpointException" + ne);
			logger.error(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		} catch (Exception e) {
			logger.error("Exception" + e);
			logger.error(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		}
	}
	
	
	@RequestMapping("free/write")
	public String FreeWrite() {
		return "board/free/write";
	}
	
	@RequestMapping(value= "writeProc" , method=RequestMethod.POST)
	@ResponseBody public String WriteCheck( // 게시글 작성 DB 저장
			@RequestParam(value="file",required=false) MultipartFile[] files,
			@ModelAttribute(value="BoardVO") BoardVO vo,HttpServletRequest request,
			HttpSession session,HttpServletResponse response,Model model
			){
		String result = "0";
		
		try {
		
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
			if(vo.getBoardFixYn().equals("Y")) {
				logger.debug("고정기간 : "+vo.getFixStartDt()+"~"+vo.getFixEndDt());
			}
			vo.setFileAttachYn("N");
			vo.setRegrSeq(sessionSeqForUser);
			if(!files[0].isEmpty()) {
				vo.setFileAttachYn("Y");
			}
		
			result = service.insertBoard(vo,files,request)+"";
		
		} catch (Exception e) {
			logger.debug("에러메시지(controller) : "+e.getMessage());
			if("java.lang.Exception: forbidden_file_type".equals(e.getMessage())) {
				result = FinalVariables.FORBIDDEN_FILE_TYPE_CODE;
				logger.debug("FinalVariables.FORBIDDEN_FILE_TYPE_CODE");
			}
			if("java.lang.Exception: over_the_file_size".equals(e.getMessage())){
				result = FinalVariables.OVER_THE_FILE_SIZE_CODE;
				logger.debug("FinalVariables.OVER_THE_FILE_SIZE_CODE");
			}else {
				result = FinalVariables.EXCEPTION_CODE;
				logger.debug("FinalVariables.EXCEPTION_CODE");
			}
			
			logger.error(" Request URI \t:  " + request.getRequestURI());
			StringWriter sw = new StringWriter();
			e.printStackTrace(new PrintWriter(sw));
			logger.error("Exception "+sw.toString());
			logger.debug("게시글 작성 catch절 진입확인 : "+result);
		}
			logger.debug("게시글 작성result : "+result);
			
		return result;
		
	}
	
	@RequestMapping("notice/write")
	public String NoticeWrite() { // 공자사항글 작성 페이지 진입
		return "board/notice/write";
	}

	@RequestMapping("pds/write")
	public String PdsWrite() { // 자료글 작성 페이지 진입
	
		return "board/pds/write";
	}
	
	@RequestMapping(value="deleteViewProc",method=RequestMethod.POST)
	@ResponseBody public String deleteViewProc(BoardVO vo,HttpSession session,Model model,HttpServletRequest request) { //게시판 글 삭제
			
		String result = "0";
		
		try {
			/*int dbRegrSeq = service.findUser(vo.getPostSeq());*/
			int sessionSeqForUser = (Integer)session.getAttribute("sessionSeqForUser");
			BoardVO vo2 = service.getView(vo.getPostSeq());
			if(sessionSeqForUser == vo2.getRegrSeq()) {
				vo.setUpdrSeq(sessionSeqForUser);
				result = service.delView(vo)+""; 
			}
			// 세션에 있는 아이디 (= 접속한 사람)랑 
			
			// 제거하려고하는 게시판 글의 작성자랑 비교
				// db select regerSeq from board by post_seq (파라미터로 넘긴)
		} catch (Exception e) {
			logger.error(" Request URI \t:  " + request.getRequestURI());
			StringWriter sw = new StringWriter();
			e.printStackTrace(new PrintWriter(sw));
			logger.error("Exception "+sw.toString());
			result = FinalVariables.EXCEPTION_CODE;
		}
		return result;
	}
	@RequestMapping(value="insertCommentsProc",method=RequestMethod.POST)
	@ResponseBody public String insertCommentsProc(CommentsVO vo,HttpSession session,Model model,HttpServletRequest request){ // 댓글 작성 DB 저장
		/*String version = org.springframework.core.SpringVersion.getVersion();
		System.out.println(version);*/
//		5.3.17
		
		String result = "0";
		
		try {
			int sessionSeqForUser = (Integer) session.getAttribute("sessionSeqForUser");
			String sessionIdForUser = (String) session.getAttribute("sessionIdForUser");
			vo.setRegrSeq(sessionSeqForUser);
			vo.setCommId(sessionIdForUser);
			result = cservice.insertComments(vo)+"";
		} catch (SQLException se) {
			logger.debug("sql오류 에러코드 :"+se.getErrorCode());
			StringWriter sw = new StringWriter();
			se.printStackTrace(new PrintWriter(sw));
			logger.error(sw.toString());
			logger.error(" Request URI \t:  " + request.getRequestURI());
			result = FinalVariables.SQL_CODE;
		} catch (Exception e) {
			logger.error(" Request URI \t:  " + request.getRequestURI());
			StringWriter sw = new StringWriter();
			e.printStackTrace(new PrintWriter(sw));
			logger.error("Exception "+sw.toString());
			result = FinalVariables.EXCEPTION_CODE;
		}
		logger.debug("본 댓글 작성 result : "+result);
		return result;
	}
	
	@RequestMapping(value="deleteCommentsProc",method=RequestMethod.POST)
	@ResponseBody public String deleteCommentsProc(CommentsVO vo,HttpSession session,Model model,HttpServletRequest request) { // 댓글 삭제 DB 저장
		
		String result = "0";
		
		try {
			int sessionSeqForUser = (int)session.getAttribute("sessionSeqForUser");
			CommentsVO vo2 = cservice.getComment(vo);
			if(sessionSeqForUser == vo2.getRegrSeq()) {
				vo.setRegrSeq(vo2.getRegrSeq());
				vo.setUpdrSeq(vo2.getRegrSeq());
				result = cservice.delComment(vo)+""; 
			}
		} catch (Exception e) {
			logger.error(" Request URI \t:  " + request.getRequestURI());
			StringWriter sw = new StringWriter();
			e.printStackTrace(new PrintWriter(sw));
			logger.error("Exception "+sw.toString());
			result = FinalVariables.EXCEPTION_CODE;
		}
		return result;
	}
	
}
