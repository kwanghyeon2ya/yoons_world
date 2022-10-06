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

    		UserVO userInfo = userService.findUser(userVO);
    		if(userVO != null ) {
    			
    			session.setAttribute("sessionIdForUser", userInfo.getUserId());
    			session.setAttribute("sessionNameForUser",userInfo.getUserName());
    			session.setAttribute("sessionSeqForUser", userInfo.getUserSeq());
    			session.setMaxInactiveInterval(60*60);
    			
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

