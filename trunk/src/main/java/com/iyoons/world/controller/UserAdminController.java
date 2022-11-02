package com.iyoons.world.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iyoons.world.service.UserService;
import com.iyoons.world.vo.UserVO;
import com.iyoons.world.vo.PageVO;



@Controller
@RequestMapping("/admin")
public class UserAdminController {
	
	@Autowired
	UserService userService;
	
	@Autowired 
	PagingService pageService;
	
	@RequestMapping(value = "/member/list", method = RequestMethod.GET)
	public String userList(PageVO pagevo,Model model) {
		//pagevo는 검색어,pageNum 받아오는 용도
		int count = userService.getCountUser();
		int pageSize = 10;
		PageVO page2 = pageService.getPaging(pageSize,pagevo.getPageNum());
		//service를 통해 jsp에서 사용할 pageSize,currentPage,startRow,endRow 세팅
		
		pagevo.setStartRow(page2.getStartRow());
		pagevo.setEndRow(page2.getEndRow());
		System.out.println("page2 : "+page2);
		List<UserVO> userList = userService.userList(pagevo);
		model.addAttribute("userList",userList);
		model.addAttribute("page",page2); //페이징용 page객체
		model.addAttribute("count",count);
		
		return "admin/member/list";
	}
	
	
	// 회원 등록 페이지
	@RequestMapping(value = "/member/createUserForm", method = RequestMethod.GET)
 	public String userCreate() throws SQLException {
     	
 		return "admin/member/createUserForm";
 	}
	
	@RequestMapping(value = "/member/duplicatedIdCheck", method = RequestMethod.GET)
	@ResponseBody public int checkDuplicatedId(UserVO vo) throws SQLException {
		
		if(userService.checkId(vo) == 1) {
			return 0;	
		}else {
			return 1;
		}
		
	}
	
	// 회원 등록 처리
	@RequestMapping(value = "/member/createUser", method = RequestMethod.POST)
	@ResponseBody public int userInsert(@RequestBody UserVO userVO, HttpSession session) throws SQLException {
		
		if(userService.checkId(userVO) == 1) {
			return 2;
		}
		System.out.println(userVO.getEmailPart2());
		if("self_writing".equals(userVO.getEmailPart2())) {
			userVO.setEmailPart2(userVO.getEmailPart3());
		}
		int sessionSeqForAdmin = (int)session.getAttribute("sessionSeqForAdmin");
		userVO.setRegrSeq(sessionSeqForAdmin);
		
		return userService.insertUser(userVO);
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
			
			if("self_writing".equals(userVO.getEmailPart2())) {
				userVO.setEmailPart2(userVO.getEmailPart3());
			}
			userService.updateUser(userVO);
			
			return "redirect:/admin/member/list"; //회원 목록으로 이동
		
		
		}
	
		@ResponseBody
		@RequestMapping(value = "/member/recoverUserStatus", method = RequestMethod.POST)
		 public int recoverUserStatus (UserVO userVO,HttpSession session) throws SQLException {
			
			System.out.println("=========================아이디 배열 확인: " +userVO.getUserSeqArray().size());
			System.out.println("=========================아이디 배열 확인: " +userVO.getUserSeqArray().get(0));
			int sessionSeqForAdmin = (int)session.getAttribute("sessionSeqForAdmin");
			userVO.setUpdrSeq(sessionSeqForAdmin);
			int recoverUserStatusResult = userService.recoverUserStatus(userVO);
			
			if(recoverUserStatusResult != 0 ) {
				return 1;
    		}else{
				return 0;
    		}
			
	}
		
		
	// 회원 정지 처리
		@ResponseBody 
		@RequestMapping(value = "/member/deleteUser", method = RequestMethod.POST)
		public int deleteUser(UserVO vo,HttpSession session) throws SQLException {
			
			System.out.println("=========================아이디 배열 확인: " +vo.getUserSeqArray().size());
			System.out.println("=========================아이디 배열 확인: " +vo.getUserSeqArray().get(0));
			int sessionSeqForAdmin = (int)session.getAttribute("sessionSeqForAdmin");
			vo.setUpdrSeq(sessionSeqForAdmin);
			int deleteUserResult = userService.deleteUser(vo);
			
			if(deleteUserResult != 0 ) {
				return 1;
    		}else{
				return 0;
    		}
			
	}		
		
}