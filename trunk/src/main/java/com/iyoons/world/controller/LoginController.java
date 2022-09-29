package com.iyoons.world.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import java.sql.SQLException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iyoons.world.User;
import com.iyoons.world.dao.UserDAO;
import com.iyoons.world.service.UserService;
import com.iyoons.world.vo.UserVO;

@Controller
@RequestMapping("/login")
public class LoginController {
        
        @Autowired
        UserService  userService;
        
        @RequestMapping(value = "/login", method = RequestMethod.POST)
    	public String login(Model model, UserVO userVO ) {
        	
        	UserVO user = userService.getUser(userVO);
        	
    		return "";
    	}

       
    	@RequestMapping(value = "/logout", method = RequestMethod.GET)
    	public String logout(HttpSession session) {
    		session.removeAttribute("u");
    		return "redirect:/";
    	}
    	
    	@RequestMapping(value = "/loginView", method = RequestMethod.GET)
    	public String loginView(Model model) {
        	
    		return "login/login";
    	}
        
        
}

