package com.iyoons.world.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/admin/*")
@Controller

public class AdminController {
	
	@RequestMapping("/member/list")
	public String callMemberList() {
		
		return "admin/member/list";
		
	}
	
	@RequestMapping("/member/modify")
	public String callMemberModify() {
		
		return "admin/member/modify";
		
	}
	
	@RequestMapping("/member/regist")
	public String callMemberRegist() {
    	
		return "admin/member/regist";
		
	}
	
	@RequestMapping("/board/list")
	public String callBoardList() {
    	
		return "admin/board/list";
		
	}
	
}