package com.iyoons.world.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/admin/*")
@Controller

public class AdminController {
	
	@RequestMapping("/member/modify")
	public String callMemberModify() {
		
		return "admin/member/modify";
		
	}
	
}