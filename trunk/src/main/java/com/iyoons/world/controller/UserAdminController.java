package com.iyoons.world.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.iyoons.world.service.UserService;
import com.iyoons.world.vo.UserVO;


@Controller
@RequestMapping("/admin")
public class UserAdminController {
	
	@Autowired
	UserService userService;
	
	@RequestMapping(value = "/member/list", method = RequestMethod.GET)
	public String userList(Model model) {
		List<UserVO> userList = userService.userList();
		model.addAttribute("userList",userList);
		
		return "admin/member/list";
	}
	
	@RequestMapping(value = "/user/insert", method = RequestMethod.POST)
	public String userInsert() {
		
		return "admin/user/insert";
	}
	
	@RequestMapping("/user/modify")
	public String userModify() {
		
		return "admin/user/modify";
	
	
	}

}