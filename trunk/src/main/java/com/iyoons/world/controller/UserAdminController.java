package com.iyoons.world.controller;

import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	// 회원 수정 페이지
	@RequestMapping(value = "/member/modifyUserForm", method = RequestMethod.GET)
	public String userDetail(String userId, Model model) throws SQLException {	
		
		//System.out.println("클릭한 아이디: "+ userId); //확인은 항상 위에서 하기
		
		model.addAttribute("userVO",userService.userDetail(userId));
		return "admin/member/modifyUserForm";
		
	}

	// 회원 수정 처리
		@RequestMapping(value = "/member/modifyUser", method = RequestMethod.POST)
		public String userUpdate(UserVO userVO) throws SQLException {

			userService.updateUser(userVO);
			
			return "redirect:/admin/member/list"; //회원 목록으로 이동
		
		
		}
	
	// 회원 삭제 처리
			@ResponseBody 
			@RequestMapping(value = "/member/deleteUser", method = RequestMethod.POST)
			public int deleteUser(UserVO userVO) throws SQLException {
				
				System.out.println("=========================아이디 배열 확인: " +userVO.getUserIdArray().size());
				System.out.println("=========================아이디 배열 확인: " +userVO.getUserIdArray().get(0));
				System.out.println("=========================아이디 배열 확인: " +userVO.getUserIdArray().get(1));
				
				int deleteUserResult = userService.deleteUser(userVO);
				
				if(deleteUserResult != 0 ) {
					return 1;
	    		}else{
					return 0;
	    		}
				
		}		
		
}