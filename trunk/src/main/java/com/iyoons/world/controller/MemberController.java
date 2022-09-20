package com.iyoons.world.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iyoons.world.service.MemberService;
import com.iyoons.world.vo.MemberVO;

@RequestMapping("/member/*")
@Controller
public class MemberController {

	@Autowired
	MemberService service;
	
	@RequestMapping("login/login")
	public String login() {
		return "member/login/login";
	}
	@RequestMapping("login/main")
	public String main() {
		
		return "member/login/main";
	}
	
	@RequestMapping(value="loginPro",method=RequestMethod.POST)
	@ResponseBody public String loginPro(MemberVO vo,HttpSession session) {
		
		int result = service.checkUser(vo);
		vo = service.findUser(vo);
			if(result != 0) {
				session.setAttribute("sid", vo.getUserId());
				session.setAttribute("sname",vo.getUserName());
				session.setAttribute("sseq", vo.getUserSeq());
				session.setMaxInactiveInterval(60*60*72);
			}
		return result+"";
	}
	
}
