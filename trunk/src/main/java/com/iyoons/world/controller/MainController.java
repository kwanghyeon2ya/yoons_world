package com.iyoons.world.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.SQLException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.HandlerMapping;

import com.iyoons.world.common.FinalVariables;
import com.iyoons.world.service.UserService;
import com.iyoons.world.vo.UserVO;

@Controller

public class MainController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired UserService userService;
	
	@RequestMapping(value= {"/main","/"})
	public String callMain(HttpServletRequest request,HttpSession session,Model model) { // 메인페이지 진입
		
		logger.debug("메인 세션확인입니다 : "+String.valueOf(session.getAttribute("sessionSeqForUser")));
		try {
		
		if(session.getAttribute("sessionSeqForUser") != null) {
			int pwCheck = userService.getPwConfirmNum(Integer.parseInt(String.valueOf(session.getAttribute("sessionSeqForUser"))));
			model.addAttribute("pwCheck",pwCheck);
			logger.debug("pwCheck :"+pwCheck);
		}
		
		} catch (Exception e) {
			logger.error("Exception : " + e);
			logger.error(" Request URI \t:  " + request.getRequestURI());
		}
		return "/main/main";
		
	}
	
	@RequestMapping(value="/common/nuguruman")
	public String getNuguruman() {
		
		return "common/nuguruman"; 
	}
	
	@RequestMapping(value="/main/changePw")
	public String changePw(HttpSession session,Model model) { // 초기 비밀번호 변경 팝업창 진입 
		int sessionSeqForUser = (int)session.getAttribute("sessionSeqForUser");
		
		model.addAttribute("pwCheck",userService.getPwConfirmNum(sessionSeqForUser));
		return "/main/changePw";
	}
	
	
	@RequestMapping(value="/main/changePwProc")
	@ResponseBody public String changePw(UserVO userVO,HttpServletRequest request,HttpSession session) { // 비밀번호 변경 DB 저장
		logger.debug("changePw 진입");
		
		logger.debug("changePw userVO확인 : "+userVO);
		
		String result = "0";
		
		try {
			int sessionSeqForUser = (int)session.getAttribute("sessionSeqForUser");
			userVO.setUserSeq(sessionSeqForUser);
			
			if(userService.checkPw(userVO) == 1) {
				result = userService.changePw(userVO)+"";
			};
		} catch (Exception e) {
			logger.error(" Request URI \t:  " + request.getRequestURI());
			StringWriter sw = new StringWriter();
			e.printStackTrace(new PrintWriter(sw));
			logger.error("Exception "+sw.toString());
			result = FinalVariables.EXCEPTION_CODE;
		}
		return result;
	}
	
	@RequestMapping(value="/main/userSearchList")
	public String getUserSearchList(UserVO userVO,HttpServletRequest request,Model model) { // 메인페이지 회원 검색 
		
		try {
			logger.debug("메인 유저 검색 키워드 : "+userVO.getKeyword());
			
			List<UserVO> uslist = userService.getUserInfoList(userVO);
			model.addAttribute("uslist",uslist);
			model.addAttribute("userVO",userVO);
			model.addAttribute("count",uslist.size());
			
			return "/main/userSearchList";
			
		} catch (SQLException e) {
			logger.error("SQLException "+e);
			logger.error("Request URL :"+request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		} catch (NullPointerException e) {
			logger.error("NullPointerException "+e);
			logger.error("Request URL :"+request.getRequestURI());
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
	
}