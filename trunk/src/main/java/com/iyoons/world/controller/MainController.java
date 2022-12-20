package com.iyoons.world.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

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

import com.iyoons.world.service.UserService;
import com.iyoons.world.vo.UserVO;

@Controller

public class MainController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired UserService userService;
	
	@RequestMapping(value= {"/main","/"})
	public String callMain(HttpServletRequest request) {
		
		return "/main/main";
		
	}
	
	@RequestMapping(value="/common/nuguruman")
	public String getNuguruman() {
		
		return "common/nuguruman"; 
	}
	
	@RequestMapping(value="/main/userSearchList")
	public String getUserSearchList(UserVO userVO,HttpServletRequest request,Model model) {
		
		try {
			List<UserVO> uslist = userService.getUserInfoList(userVO);
			model.addAttribute("uslist",uslist);
			model.addAttribute("userVO",userVO);
			model.addAttribute("count",uslist.size());
			
			return "/main/userSearchList";
			
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
	
}