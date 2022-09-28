package com.iyoons.world.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import java.sql.SQLException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iyoons.world.service.UserService;
import com.iyoons.world.vo.UserVO;

@Controller("longinController")
@RequestMapping("login")
public class LoginController {
        final Logger LOG = LogManager.getLogger(getClass());
        
        @Autowired
        UserService  userService;
        
        public LoginController() {
                LOG.debug("===========================");
                LOG.debug("=LonginController()=");
                LOG.debug("===========================");
        }
        
        @RequestMapping(value="/doLogin.do"
                        , method = RequestMethod.POST 
                        ,produces = "application/json;charset=UTF-8")
        @ResponseBody
        public String doLogin(UserVO  inVO, HttpSession session)throws SQLException{
                String jsonString = "";
                LOG.debug("===========================");
                LOG.debug("=inVO="+inVO);
                LOG.debug("===========================");
                
       
                
                LOG.debug("===========================");
                LOG.debug("=jsonString="+jsonString);
                LOG.debug("===========================");               
                return jsonString;
        }
        
        
        
        @RequestMapping(value="/loginView.do", method=RequestMethod.GET)
        public String loginView()throws SQLException{
                LOG.debug("===========================");
                LOG.debug("=loginView()=");
                LOG.debug("===========================");
                
                return "login/login";
        }
        
        
}

