package com.iyoons.world.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import java.sql.SQLException;
import javax.servlet.http.HttpSession;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.google.gson.Gson;
import com.pcwk.ehr.cmn.MessageVO;
import com.pcwk.ehr.user.domain.UserVO;
import com.pcwk.ehr.user.service.UserService;


@Controller("longinController")
@RequestMapping(value="/login/login")
public String loginForm(){
    return "login/loginForm";
}
 

@RequestMapping(value="/login/loginCheck")
public void loginCheck(HttpSession session, @ModelAttribute("usersVO") UsersVO usersVO, HttpServletRequest request, HttpServletResponse response) throws Exception{

	
    String beforeUrl=request.getHeader("Referer");
    session.setAttribute("Referer",beforeUrl);
    
    	System.out.println("==============BEFORE==============="+beforeUrl+"==========================");
    	
	if("true".equals(request.getHeader("AJAX"))) {
		System.out.println("==============AJAX==============="+request.getHeader("AJAX")+"========================");
	}
	
	String reqUrl = request.getRequestURL().toString();
	System.out.println("-----------------> Url check Interceptor , reqUrl : " +reqUrl );
	
	
    usersVO.setId(request.getParameter("user_id"));
    usersVO.setPw(request.getParameter("user_pwd"));
    
    UsersVO loginUser = usersService.getUser(usersVO);
    
    if (loginUser != null) {
    	System.out.println("============test===========로그인성공=============================");
        session.setAttribute("loginInfo", loginUser);
        
        //returnURL = "redirect:/index";
        
        try {
            response.getWriter().write("true");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }else {
    	
        //returnURL = "redirect:/login/loginForm";
    	
        try {
            response.getWriter().write("false");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //return returnURL;
}

//로그아웃하는 부분
@RequestMapping(value="/login/logout")
public String logout(HttpSession session) {    	
    session.invalidate();        
    return "redirect:/login/login.do";
}
}
