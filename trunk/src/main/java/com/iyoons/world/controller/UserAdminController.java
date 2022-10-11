package com.iyoons.world.controller;

import java.sql.SQLException;
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
	
	/*
	@RequestMapping(value = "/member/list/view", method = RequestMethod.POST)
	public String userView(String userId, Model model) {
		model.addAttribute(null, userService.viewUser(userId));
		return "admin/user/view";
	}
	*/
	
	// 회원 등록 페이지
	@RequestMapping(value = "/member/createUserForm", method = RequestMethod.GET)
 	public String userCreate() throws SQLException {
     	
 		return "admin/member/createUserForm";
 	}
	
	// 회원 등록 처리
	@RequestMapping(value = "/member/createUser", method = RequestMethod.POST)
	public String userInsert(UserVO userVO) throws SQLException {

		userService.insertUser(userVO);
		
		return "redirect:/admin/member/list"; //회원 목록으로 이동
	}
	
	// 회원 수정
	@RequestMapping("/member/modifyUser")
	public String userModify() {
		
		return "redirect:/admin/user/modify";
	
	
	}

}