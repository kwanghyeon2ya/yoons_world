package com.iyoons.world.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iyoons.world.service.UserService;
import com.iyoons.world.vo.UserVO;

@Controller
@RequestMapping("/login")
public class LoginController {
        
		
        @Autowired
        UserService userService;


        private int localSessTime = 60*60*60*60; //개발서버
        private int serverSessTime = 60*60;//로컬
        
	@RequestMapping("/msgTest")
	public String loginView(Model model) {

		model.addAttribute("msg", "메세지를 이렇게 출력합니다!");
		model.addAttribute("loc", "/main");

		return "common/msg";
	}




	@RequestMapping("/loginView")
    	public String loginView() {
        	
    		return "login/login";
    	}
        
        
        
        @ResponseBody 
     	@RequestMapping(value = "/login", method = RequestMethod.POST)
    	public int login(UserVO userVO,HttpSession session) {

    		UserVO userInfovo = userService.findUser(userVO);
    		System.out.println(userInfovo+"userInfovoㅎㅎㅎ");
    		
    		if(userInfovo != null ) {
    			if(userInfovo.getUserStatus() == 1) {
    				
    				session.setAttribute("userInfovo", userInfovo);
	    			session.setAttribute("sessionIdForUser", userInfovo.getUserId());
	    			session.setAttribute("sessionNameForUser",userInfovo.getUserName());
	    			session.setAttribute("sessionSeqForUser", userInfovo.getUserSeq());
	    			
	    			UserVO userVO2 = (UserVO)session.getAttribute("userInfovo");
	    			System.out.println("ㅎㅇ요"+userVO2);
	    			
	    			session.setMaxInactiveInterval(localSessTime);
	    			if(userInfovo.getUserType() == 1) {
	    			session.setAttribute("sessionSeqForAdmin", userInfovo.getUserSeq());
	    			session.setMaxInactiveInterval(localSessTime);
	    			}
    			}else {
    				return 2;
    			}
    			return 1;
    		}else{
				return 0;
    		}
    	 }
     	
    	@RequestMapping(value = "/logout", method = RequestMethod.GET)
    	public String logout(HttpSession session) {
    		
    		session.invalidate();
    		return "redirect:/login/loginView";
    	}
    	
   
    	
        
        
}

