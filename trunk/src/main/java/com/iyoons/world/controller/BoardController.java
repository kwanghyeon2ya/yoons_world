package com.iyoons.world.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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

import com.google.gson.Gson;
import com.iyoons.world.service.AttachService;
import com.iyoons.world.service.BoardService;
import com.iyoons.world.service.CommentsService;
import com.iyoons.world.vo.BoardAttachVO;
import com.iyoons.world.vo.BoardVO;
import com.iyoons.world.vo.CommentsVO;
import com.iyoons.world.vo.UserVO;

import ch.qos.logback.core.net.SyslogOutputStream;

@RequestMapping("/board/*")
@Controller
public class BoardController {
	
	@Autowired
	public BoardService service;
	
	@Autowired
	public CommentsService cservice;
	
	@Autowired
	public AttachService aservice;

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
	
	
	@RequestMapping(value="free/list",method=RequestMethod.GET)
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
	
	@RequestMapping(value="notice/list",method=RequestMethod.GET)
	public String getNoticeList(
			@RequestParam(value="search",required=false)String search,
			@RequestParam(value="keyword",required=false)String keyword,
			@RequestParam(value="searchCheck",required=false)String searchCheck,
			@RequestParam(value="boardType",required=false,defaultValue="1")String boardType,
			@RequestParam(value="pageNum",required=false,defaultValue="1")String pageNum,Model model){
		boardList(search,keyword,searchCheck,boardType,pageNum,model);
		
		List<BoardVO> fixedBoardList = service.getNoticeFixedBoard(boardType);
		model.addAttribute("boardType",boardType);
		model.addAttribute("pageNum",pageNum);
		model.addAttribute("keyword",keyword);
		model.addAttribute("searchCheck",searchCheck);
		model.addAttribute("search",search);
		model.addAttribute("fixedBoardList",fixedBoardList);
		return "board/notice/list";
	}
	
	@RequestMapping(value="pds/list",method=RequestMethod.GET)
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
	
	@RequestMapping(value="getListForMain",method=RequestMethod.GET)
	public String getListForMain(Model model) {// 각 게시판을 가져옴 
		
		BoardVO vo = service.getListForMain(); //vo에 각 게시판에 대한 List 객체를 만들어서
												//Hash map타입의 매개변수를 넣어 호출후 vo안의 List객체에 대입
		model.addAttribute("freeBoardList",vo.getFreeBoardList());
		model.addAttribute("fixedBoardList",vo.getFixedBoardList());
		model.addAttribute("noticeBoardList",vo.getNoticeBoardList());
		model.addAttribute("pdsBoardList",vo.getPdsBoardList());
		
		return "board/boardListForMain"; 
	}
	
	/*@RequestMapping(value="free/freeListForMain",method=RequestMethod.GET)
	public String freeListForMain(Model model) {
		
		int count = 0;
		String boardType = "0";
		int startRow = 1;
		int endRow = 5;
		int pageSize = 0;
		count = service.getBoardCount(boardType);
		System.out.println("free count : "+count);
		
		List<BoardVO> boardList = service.getListForMain(startRow,endRow,boardType);
		
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("count",count);
		model.addAttribute("boardList",boardList);
		
		return "board/free/freeListForMain";
	}
	@RequestMapping(value="notice/noticeListForMain",method=RequestMethod.GET)
	public String noticeListForMain(Model model) {
		
		int count = 0;
		String boardType = "1";
		int startRow = 1;
		int endRow = 5;
		int pageSize = 0;
		System.out.println("service.getBoardCount(boardType) : " + service.getBoardCount(boardType));
		count = service.getBoardCount(boardType);
		System.out.println("notice count : "+count);
		
		List<BoardVO> boardList = service.getListForMain(startRow,endRow,boardType);
		
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("count",count);
		model.addAttribute("boardList",boardList);
		
		return "board/notice/noticeListForMain";
	}
	@RequestMapping(value="pds/pdsListForMain",method=RequestMethod.GET)
	public String pdsListForMain(Model model) {
		
		int count = 0;
		String boardType = "2";
		int startRow = 1;
		int endRow = 5;
		int pageSize = 0;
		count = service.getBoardCount(boardType);
		System.out.println("pds count : "+count);
		
		List<BoardVO> boardList = service.getListForMain(startRow,endRow,boardType);
		
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("count",count);
		model.addAttribute("boardList",boardList);
		
		return "board/pds/pdsListForMain";
	}*/
	
	@RequestMapping(value="getAllBoardListForReadCount",method=RequestMethod.GET)
	public String getAllBoardListForReadCount(Model model) {
		
		int startRow = 1;
		int endRow = 10;
		int pageSize = 10;
		
		List<BoardVO> boardList = service.getAllBoardListOrderedByReadCount(startRow, endRow);
		
		System.out.println("boardList : zz"+boardList);
		
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("boardList",boardList);
		return "board/pds/list";
	}
	
	@RequestMapping(value="getAllBoardListForReadCountForMonth",method=RequestMethod.GET)
	public String getAllBoardListForReadCountForMonth(Model model) {
		
		int startRow = 1;
		int endRow = 10;
		int pageSize = 10;
		
		List<BoardVO> boardList = service.getAllBoardListOrderedByReadCountForMonth(startRow, endRow);
		
		System.out.println("boardList : "+boardList);
		
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("boardList",boardList);
		return "board/getAllBoardListForReadCountForMonth";
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
			return "board/free/modify";	
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
			return "board/pds/modify";	
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
	@ResponseBody public String modCommentProc(CommentsVO vo,HttpSession session) {
		
		int sessionSeqForUser = (int)session.getAttribute("sessionSeqForUser");
		
		CommentsVO vo2 = cservice.getComment(vo);
		System.out.println("sessionSeq : "+sessionSeqForUser);
		System.out.println("vo2.regrSeq : "+vo2.getRegrSeq());
		System.out.println("vo2postSeq : "+vo2.getPostSeq());
		if(sessionSeqForUser == vo2.getRegrSeq()) {
		vo.setUpdrSeq(sessionSeqForUser);
			if(cservice.modComment(vo) == 1) {
				System.out.println("댓글 업데이트 진입 확인");
				CommentsVO vo3 = cservice.getComment(vo);
				System.out.println(vo3.getCommContent());
				return vo3.getCommContent();
			}
		}
		return "";
	}
	
	
	@RequestMapping(value="comments")
	public String getComments(CommentsVO cvo,Model model) {
		
		if(cvo.getStartIndex() == 0) {
			System.out.println("StartIndex nullcheck");
			cvo.setStartIndex(1);
			cvo.setEndIndex(10);
		}
		
		if(cvo.getCocoCount() == 0) {
			System.out.println("cocoCount 첫등장: "+cvo.getCocoCount());
			cvo.setCocoCount(10);
		}else {
			cvo.setCocoCount(cvo.getCocoCount()+10); //더보기 버튼 필요한지 확인용 +10 - 밑에서 비교함
		}	// view페이지에 처음 접근할 때 는 0이 넘어오지만, 후에는 10단위로 더해져 넘어옴(html 태그 length 값)
			// ajax후에 태그 갯수를 세는 것이기 때문에 10을 더해서 계산해야함 -> 더보기 버튼 활성화/비활성화 용도
		
		BoardVO vo = service.getView(cvo.getPostSeq());
		
		if(vo == null) { // Null체크 - 글삭제 후 뒤로가기시 Null
			 return "redirect:/board/free/list";  // db조회후 null일경우 redirect - 삭제된 글에 뒤로가기로 접근 x
		 }
		
		int existCount = cservice.getExistCommentsCount(vo.getPostSeq()); //존재하는 댓글의 카운트-status가 1인글
		
		List<CommentsVO> clist = cservice.getCommentsList(cvo);
		System.out.println("clist size :" +clist.size());
		for(CommentsVO comm : clist) {
			if(comm.getNestedCommentsCnt() >= 1) {//대댓글 갯수
				comm.setCocoList(cservice.getNestedCommentsList(comm));//대댓글을 List로 담음
			}
		}
		
		int stopMoreCommentsButton = 0;
		
		int maxCommentsCount = cservice.getALLCommentsCount(vo.getPostSeq()); //본 댓글 갯 수
		
		System.out.println("cococount : "+cvo.getCocoCount());
		System.out.println("endindex : "+cvo.getEndIndex());
		System.out.println("maxcommentcount : "+maxCommentsCount);
		
		if(cvo.getCocoCount() >= maxCommentsCount) { //더보기 버튼 변화
			stopMoreCommentsButton = 1;
			System.out.println("stopMoreCommentsButton : "+stopMoreCommentsButton);
		}
		
		model.addAttribute("stopMoreCommentsButton",stopMoreCommentsButton);
		model.addAttribute("vo",vo);
		model.addAttribute("clist",clist);
		model.addAttribute("existCount",existCount);
		
		return "board/comments";
	}
	
	@RequestMapping(value="getMoreCommentsList") // 댓글 더 보기(클릭시)
	@ResponseBody public String getMoreCommentsList(CommentsVO cvo) {
		
		BoardVO vo = service.getView(cvo.getPostSeq());

		if(vo == null) {
			return "redirect:/board/free/list";  // db조회후 null일경우 redirect - 삭제된 글에 뒤로가기로 접근 x
		}
		
		List<CommentsVO> cmlist = cservice.getCommentsList(cvo);
		
		Gson gson = new Gson();
		String cmlistString = gson.toJson(cmlist); // list를 object로 바꾸고 다시 문자열로 바꿈
		
		return cmlistString;
	}
	
	@RequestMapping("free/view")
	public String getFreeView(@RequestParam(value="postSeq",required=false)String postSeq,
						Model model,HttpSession session) {
			 
		 int postSeq2 = Integer.parseInt(postSeq);
		 List<BoardAttachVO> anlist = aservice.getAttachList(postSeq2);
		 BoardVO vo = service.getView(postSeq2);//DB조회
		 

		 if(vo == null) { // Null체크 - 뒤로가기시 Null
			 return "redirect:/login/logout";  // db조회후 null일경우 redirect - 삭제된 글에 뒤로가기로 접근 x
		 }
		 
		 int sessionSeqForUser = (int)session.getAttribute("sessionSeqForUser");
		 
		 vo.setPostSeq(postSeq2); 
		 vo.setRegrSeq(sessionSeqForUser);
		 vo.setUserSeq(sessionSeqForUser);
		 
		 int checkHeart = service.checkHeart(vo);
		 int heartCount = service.getHeartCount(vo);
		
		 System.out.println(checkHeart+": 좋아요 체크 0 = 하트안누름");
		 System.out.println(heartCount);
		 if(vo.getRegrSeq() != sessionSeqForUser) {
			 service.updateCnt(postSeq2);	 
		 }
		 
			 model.addAttribute("vo",vo);
			 model.addAttribute("heartCount",heartCount);
			 model.addAttribute("checkHeart",checkHeart);
			 model.addAttribute("anlist",anlist);
			 return "board/free/view";
	}
	
	
	@RequestMapping("notice/view")
	public String getNoticeView(@RequestParam(value="postSeq",required=false)String postSeq,
						Model model,HttpSession session) {
			 
		int postSeq2 = Integer.parseInt(postSeq);
		 List<BoardAttachVO> anlist = aservice.getAttachList(postSeq2);
		 BoardVO vo = service.getView(postSeq2); //DB조회
		 
		 if(vo == null) { // Null체크 - 뒤로가기시 Null
			 return "redirect:/board/notice/list";  // db조회후 null일경우 redirect - 삭제된 글에 뒤로가기로 접근 x
		 }
		 
		 if(session.getAttribute("sessionSeqForUser") == null) {
			 return "redirect:/board/notice/list";
		 }
		
		 int sessionSeqForUser = (int)session.getAttribute("sessionSeqForUser");
		 
		 if(vo.getRegrSeq() != sessionSeqForUser) {
			 service.updateCnt(postSeq2);	 
		 }
		 
			 model.addAttribute("vo",vo);
			 model.addAttribute("anlist",anlist);
			 return "board/notice/view";
		 }
	
	@RequestMapping("pds/view")
	public String getPdsView(@RequestParam(value="postSeq",required=false)String postSeq,
						Model model,HttpSession session) {
			 
		int postSeq2 = Integer.parseInt(postSeq);
		 List<BoardAttachVO> anlist = aservice.getAttachList(postSeq2);
		 BoardVO vo = service.getView(postSeq2);//DB조회
		 
		 if(vo == null) { // Null체크 - 뒤로가기시 Null
			 return "redirect:/board/free/list";  // db조회후 null일경우 redirect - 삭제된 글에 뒤로가기로 접근 x
		 }
		 
		 if(session.getAttribute("sessionSeqForUser") == null) {
			 return "redirect:/board/pds/list";
		 }
		 
		 int sessionSeqForUser = (int)session.getAttribute("sessionSeqForUser");
		 
		 if(vo.getRegrSeq() != sessionSeqForUser) {
			 service.updateCnt(postSeq2);	 
		 }
			 model.addAttribute("vo",vo);
			 model.addAttribute("anlist",anlist);
			 return "board/pds/view";
	}
	
	@RequestMapping(value="increasingHeartProc",method=RequestMethod.GET)
	@ResponseBody public String increasingHeartProc(BoardVO boardVO,HttpSession session) {
		
		
		/*UserVO userVO = (UserVO)session.getAttribute("userInfovo");*/
		BoardVO vo = service.getView(boardVO.getPostSeq());
		
		if(vo == null) { // Null체크 - 뒤로가기시 Null
			 return "redirect:/board/free/list";  // db조회후 null일경우 redirect - 삭제된 글에 뒤로가기로 접근 x
		}
		if(session.getAttribute("sessionSeqForUser") == null) {
			 return "redirect:/board/free/list";
		 }
		
		/*System.out.println(userVO);*/
		int userSeq = (int)session.getAttribute("sessionSeqForUser");
		
		vo.setUserSeq(userSeq);
		
		service.increasingHeart(vo);
		int heartCount = service.getHeartCount(vo);
		return ""+heartCount;
	}
	
	
	@RequestMapping("free/write")
	public String FreeWrite() {
		return "board/free/write";
	}
	
	@RequestMapping(value= "writeProc" , method=RequestMethod.POST)
	@ResponseBody public int WriteCheck(
			@RequestParam(value="file",required=false) MultipartFile[] files,
			@ModelAttribute(value="BoardVO") BoardVO vo,HttpServletRequest request,
			HttpSession session
			) throws Exception {
		
		System.out.println("vo값 :"+vo);
		
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
			System.out.println(vo.getFixStartDt()+"할로?ㅋㅋ"+vo.getFixEndDt());
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
		System.out.println(vo);
		CommentsVO vo2 = cservice.getComment(vo);
		System.out.println(vo2.getRegrSeq());
		System.out.println(sessionSeqForUser);
		if(sessionSeqForUser == vo2.getRegrSeq()) {
			vo.setRegrSeq(vo2.getRegrSeq());
			vo.setUpdrSeq(vo2.getRegrSeq());
			return cservice.delComment(vo);
		}
		return 0;
	}
	
}
