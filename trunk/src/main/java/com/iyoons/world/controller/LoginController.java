package com.iyoons.world.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;


import org.springframework.beans.factory.annotation.Autowired;
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
        

        @RequestMapping("/loginView")
    	public String loginView() {
        	
    		return "login/login";
    	}
   
        
        @ResponseBody 
     	@RequestMapping(value = "/login", method = RequestMethod.POST)
    	public int login(UserVO userVO,HttpSession session) {
    		
    		int result = userService.checkUser(userVO);
    		userVO = userService.findUser(userVO);
    		if(result != 0) {
    			session.setAttribute("sid", userVO.getUserId());
    			session.setAttribute("sname",userVO.getUserName());
    			session.setAttribute("sseq", userVO.getUserSeq());
    			session.setMaxInactiveInterval(60*60*72);
    			
    			return 1;
    		}else{
				return 0;
    		}
    	 }
     	
    	@RequestMapping(value = "/logout", method = RequestMethod.GET)
    	public String logout(HttpSession session) {
    		session.removeAttribute("sid");
    		session.removeAttribute("sname");
    		session.removeAttribute("sseq");
    		
    		session.invalidate();
    		return "redirect:/login/loginView";
    	}
    	
   
    	
        
        
}

