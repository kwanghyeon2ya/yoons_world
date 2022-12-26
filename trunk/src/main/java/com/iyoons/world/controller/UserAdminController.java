package com.iyoons.world.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iyoons.world.common.FinalVariables;
import com.iyoons.world.service.UserService;
import com.iyoons.world.vo.UserVO;
import com.iyoons.world.vo.PageVO;



@Controller
@RequestMapping("/admin")
public class UserAdminController {
	
	@Autowired
	UserService userService;
	
	@Autowired 
	PagingService pageService;
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	
	String traceErrorPrint(Exception e) {
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		PrintStream printStream = new PrintStream(out);
		e.printStackTrace(printStream);
		
		return out.toString();
		
	}
	
	
	
	@RequestMapping(value = "/member/list", method = RequestMethod.GET)
	public String userList(PageVO pagevo,Model model,HttpServletRequest request) {
		//pagevo는 검색어,pageNum 받아오는 용도
		
		try {
			int count = userService.getCountUser();
			int pageSize = 10;
			PageVO page2 = pageService.getPaging(pageSize,pagevo.getPageNum());
			//service를 통해 jsp에서 사용할 pageSize,currentPage,startRow,endRow 세팅
			
			pagevo.setStartRow(page2.getStartRow());
			pagevo.setEndRow(page2.getEndRow());
			pagevo.setPageSize(pageSize);
			pagevo.setCurrentPage(page2.getCurrentPage());
			
			if(!pagevo.getSearch().equals("")) {
				count = userService.getSearchedUserCount(pagevo);
			}
			
			List<UserVO> userList = userService.userList(pagevo);
			model.addAttribute("userList",userList);
			model.addAttribute("page",pagevo); //페이징용 page객체
			model.addAttribute("count",count);
			
			return "admin/member/list";
		
		} catch (NullPointerException e) {
			logger.error("NullPointerException "+e);
			logger.error("Request URL :"+request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/loginView");
			return "common/msg";
		} catch (Exception e) {
			logger.error("Exception" + e);
			logger.debug(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/loginView");
			return "common/msg";
		}
	}
	
	
	// 회원 등록 페이지
	@RequestMapping(value = "/member/createUserForm", method = RequestMethod.GET)
 	public String userCreate(){
     	
 		return "admin/member/createUserForm";
 	}
	
	@RequestMapping(value = "/member/duplicatedIdCheck", method = RequestMethod.GET)
	@ResponseBody public String checkDuplicatedId(UserVO vo,Model model,HttpServletRequest request){
		
		try {
			
			if(userService.checkId(vo) == 1) {
				return "0";	
			}else {
				return "1";
			}
			
		} catch (NullPointerException e) {
			logger.error("NullPointerException "+e);
			logger.error("Request URL :"+request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/loginView");
			return "common/msg";
		} catch (Exception e) {
			logger.error("Exception" + e);
			logger.debug(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/loginView");
			return "common/msg";
		}
		
	}
	
	
	// 회원 등록 처리
		@RequestMapping(value = "/member/createUser", method = RequestMethod.POST)
		@ResponseBody public String userInsert(@RequestBody UserVO userVO, HttpSession session,HttpServletRequest request,Model model){
			

			if("self_writing".equals(userVO.getEmailPart2())) {
				userVO.setEmailPart2(userVO.getEmailPart3());
			}
			int sessionSeqForAdmin = (int)session.getAttribute("sessionSeqForAdmin");
			userVO.setRegrSeq(sessionSeqForAdmin);
			
			String result = "0";
			
			if(userService.checkId(userVO) == 1) {
				result = "2";
			}else {
				try {
					result = userService.insertUser(userVO)+"";
				} catch (Exception e) {
					result = FinalVariables.EXCEPTION_CODE;
					logger.error("Exception" + e.getStackTrace()[0]);
					logger.error(" Request URI \t:  " + request.getRequestURI());
					StringWriter sw = new StringWriter();
					e.printStackTrace(new PrintWriter(sw));
					logger.error(sw.toString());
				}
			}
		
			return result;
				
		}
	
	
	
	
	/*@RequestMapping(value = "/member/createUser", method = RequestMethod.POST)
	@ResponseBody public HashMap<String, Object> userInsert(@RequestBody UserVO userVO, HttpSession session,HttpServletRequest request,Model model) {
		
		HashMap<String, Object> resultMap = new HashMap<>();
		
		if(userService.checkId(userVO) == 1) {
			resultMap.put("2", 2);
			return resultMap;
		}
		if("self_writing".equals(userVO.getEmailPart2())) {
			userVO.setEmailPart2(userVO.getEmailPart3());
		}
		int sessionSeqForAdmin = (int)session.getAttribute("sessionSeqForAdmin");
		userVO.setRegrSeq(sessionSeqForAdmin);
		
		try {
			userService.insertUser(userVO);
			resultMap.put("commList", userService.selectCommByPosgtSEq(postSEQ));
			resultMap.put("CODE", 1111);
		
		} catch (NullPointerException e) {
			logger.error("NullPointerException "+e);
			logger.error("Request URL :"+request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/loginView");
			return "common/msg";
		} catch (Exception e) {
			logger.error("Exception" + e);
			logger.debug(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/loginView");
			return "common/msg";
		}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
			resultMap.put("CODE", SUCCENC);
		}
		
		return resultMap;
	}*/
	
	// 회원 수정 페이지
	@RequestMapping(value = "/member/modifyUserForm", method = RequestMethod.GET)
	public String userDetail(UserVO userVOFromParam, Model model,HttpServletRequest request){	
		
		try {
			
			logger.debug("member/modifyUserForm의 userVOFromParam 확인 : "+userVOFromParam);
			
			UserVO userVO = userService.userDetail(userVOFromParam);
			/*if(userVO != null) {*/
				
			logger.debug("member/modifyUserForm에서 db조회 후  userVO 확인 : "+userVO);
			
			userVO.setEmailPart1(userVO.getEmail().split("@")[0]);
			String [] emailList = {"naver.com","daum.net","gmail.com","hanmail.com","yahoo.co.kr"};
			for(String email : emailList) {
				if(userVO.getEmail().split("@")[1].equals(email)) {
					userVO.setEmailPart2(email);
				}
			}
			
			String [] phone = userVO.getPhone().split("-");
			userVO.setPhone1(phone[0]);
			userVO.setPhone2(phone[1]);
			userVO.setPhone3(phone[2]);
			
			if(userVO.getEmailPart2() == null) {
				userVO.setEmailPart2("self_writing");
				userVO.setEmailPart3(userVO.getEmail().split("@")[1]);
			}
			model.addAttribute("userVO",userVO);
			return "admin/member/modifyUserForm";
		
		} catch (SQLException e) {
			logger.error("SQLException "+e);
			logger.error("Request URL :"+request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/loginView");
			return "common/msg";
		} catch (NullPointerException e) {
			logger.error("NullPointerException "+e);
			logger.error("Request URL :"+request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/loginView");
			return "common/msg";
		} catch (Exception e) {
			logger.error("Exception" + e);
			logger.debug(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/loginView");
			return "common/msg";
		}
		
	}

	// 회원 수정 처리
		@RequestMapping(value = "/member/modifyUser", method = RequestMethod.POST)
		public String userUpdate(UserVO userVO,Model model,HttpServletResponse response,HttpServletRequest request){
			
			if("self_writing".equals(userVO.getEmailPart2())) {
				userVO.setEmailPart2(userVO.getEmailPart3());
			}
			
			try {
				
				logger.debug("member/modifyUser의 userVO 확인 : "+userVO);
				
				int result = userService.updateUser(userVO);
				
				if(result == 1) {
					model.addAttribute("msg", "수정 되었습니다!");
					model.addAttribute("loc", "/admin/member/list");
				}else {
					model.addAttribute("msg", "수정 되지않았습니다!");
					model.addAttribute("loc", "/admin/member/modifyUser");
				}
			
				return "common/msg";
			
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				logger.error("NoSuchAlgorithmException"+e);
				logger.error("Request URL :"+request.getRequestURI());
				model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
				model.addAttribute("loc", "/login/loginView");
				return "common/msg";
			} catch (SQLException e) {
				logger.error("SQLException "+e);
				logger.error("Request URL :"+request.getRequestURI());
				model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
				model.addAttribute("loc", "/login/loginView");
				return "common/msg";
			} catch (NullPointerException e) {
				logger.error("NullPointerException "+e);
				logger.error("Request URL :"+request.getRequestURI());
				model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
				model.addAttribute("loc", "/login/loginView");
				return "common/msg";
			} catch (Exception e) {
				logger.error("Exception" + e);
				logger.debug(" Request URI \t:  " + request.getRequestURI());
				model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
				model.addAttribute("loc", "/login/loginView");
				return "common/msg";
			}
			
			/*return "redirect:/admin/member/list";*/ //회원 목록으로 이동
		
		
		}
	
		@ResponseBody
		@RequestMapping(value = "/member/recoverUserStatus", method = RequestMethod.POST)
		 public String recoverUserStatus (UserVO userVO,HttpSession session,HttpServletRequest request,Model model){
			

				String result = "0";
				
				logger.debug("=========================아이디 배열 확인: " +userVO.getUserSeqArray().size());
				logger.debug("=========================아이디 배열 확인: " +userVO.getUserSeqArray().get(0));
				int sessionSeqForAdmin = (int)session.getAttribute("sessionSeqForAdmin");
				userVO.setUpdrSeq(sessionSeqForAdmin);
				
				try {
					
					int recoverUserStatusResult = userService.recoverUserStatus(userVO);
					
					if(recoverUserStatusResult != 0 ) {
						result = "1";
		    		}
					
				} catch (Exception e) {
					result = FinalVariables.EXCEPTION_CODE;
					logger.error("Exception" + e.getStackTrace()[0]);
					logger.error(" Request URI \t:  " + request.getRequestURI());
					StringWriter sw = new StringWriter();
					e.printStackTrace(new PrintWriter(sw));
					logger.error(sw.toString());
				}
				
				return result;
		}
		
		
	// 회원 정지 처리
		@ResponseBody 
		@RequestMapping(value = "/member/deleteUser", method = RequestMethod.POST)
		public String deleteUser(UserVO vo,HttpSession session,HttpServletRequest request,Model model){
			
			String result = "0";
			
			try {
					
				logger.debug("=========================아이디 배열 확인: " +vo.getUserSeqArray().size());
				logger.debug("=========================아이디 배열 확인: " +vo.getUserSeqArray().get(0));
				int sessionSeqForAdmin = (int)session.getAttribute("sessionSeqForAdmin");
				vo.setUpdrSeq(sessionSeqForAdmin);
				int deleteUserResult = userService.deleteUser(vo);
				
				if(deleteUserResult != 0 ) {
					result = "1";
	    		}else{
					result =  "0";
	    		}
			} catch (Exception e) {
				result = FinalVariables.EXCEPTION_CODE;
				logger.error("Exception" + e.getStackTrace()[0]);
				logger.error(" Request URI \t:  " + request.getRequestURI());
				StringWriter sw = new StringWriter();
				e.printStackTrace(new PrintWriter(sw));
				logger.error(sw.toString());
			}
			return result;
		}
	}		
		
