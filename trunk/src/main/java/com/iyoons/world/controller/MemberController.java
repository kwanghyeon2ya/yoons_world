package com.iyoons.world.controller;

import java.io.File;
import java.io.PrintWriter;
import java.io.StringWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.iyoons.world.common.FinalVariables;

import com.iyoons.world.service.UserService;
import com.iyoons.world.vo.UserVO;

@RequestMapping("/member")
@Controller
public class MemberController {
	@Autowired
	UserService userService;

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value="/mypage")
	public String mypage() {
		
		return "/mypage/mypage";
	}
	
	@RequestMapping(value="updateMypage")
	@ResponseBody public String insertMypage(@RequestParam(value="file",required=false)MultipartFile file,
			HttpServletRequest request,HttpSession session) { // 프로필 사진 수정

		String result = "0";
		
		try {
			logger.debug("컨트롤러 파일 null확인  : "+file);
			logger.debug("컨트롤러 file name : "+file.getOriginalFilename());
			UserVO userVO = new UserVO();
			userVO.setUserSeq((int)session.getAttribute("sessionSeqForUser"));
			result = userService.updateMypage(userVO,file)+"";
			session.removeAttribute("sessionPicForUser");
			UserVO voForProfile = userService.getPicture(userVO);
			logger.debug("userVO 확인 : "+voForProfile);
			if(voForProfile != null) {
				session.setAttribute("sessionPicForUser",File.separator+voForProfile.getPicture());
			}
		} catch (Exception e) {
			logger.debug("에러메시지(controller) : "+e.getMessage());
			if("java.lang.Exception: forbidden_file_type".equals(e.getMessage())) {
				result = FinalVariables.FORBIDDEN_FILE_TYPE_CODE;
				logger.debug("FinalVariables.FORBIDDEN_FILE_TYPE_CODE");
			}
			if("java.lang.Exception: over_the_file_size".equals(e.getMessage())){
				result = FinalVariables.OVER_THE_FILE_SIZE_CODE;
				logger.debug("FinalVariables.OVER_THE_FILE_SIZE_CODE");
			}else {
				result = FinalVariables.EXCEPTION_CODE;
				logger.debug("FinalVariables.EXCEPTION_CODE");
			}
			
			logger.error(" Request URI \t:  " + request.getRequestURI());
			StringWriter sw = new StringWriter();
			e.printStackTrace(new PrintWriter(sw));
			logger.error("Exception "+sw.toString());
			logger.debug("게시글 작성 catch절 진입확인 : "+result);
		}
		
		return result;
	}
	 /*@ExceptionHandler
	    public ResponseEntity<String> handle(IOException ex) {
		 
	 }*/

}
