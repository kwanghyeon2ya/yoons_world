package com.iyoons.world.controller;

import java.io.File;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iyoons.world.common.LoginUtil;
import com.iyoons.world.service.UserService;
import com.iyoons.world.vo.UserAutoLoginVO;
import com.iyoons.world.vo.UserVO;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

@Controller
@RequestMapping("/login")
public class LoginController {

	@Autowired
	UserService userService;

	@Autowired
	LoginUtil loginutil;
	
	@Value("${realpath}")
	String REAL_PATH;
	
	@Value("${deletedpath}")
	String DELETED_FILE_PATH;
	
	private int testSessionTime = 60;
	private int testCookieTime = 60 * 60;
	private int localSessTime = 60 * 60 * 60 * 24 * 7; // 개발서버
	private int serverSessTime = 60 * 60 * 60 * 24;// 배포
	private final String secretKey = "secretKey";
	private final Logger logger = LoggerFactory.getLogger(this.getClass());


	@RequestMapping("/loginView")
	public String loginView(HttpSession session) { // 로그인 페이지 진입
		logger.debug("저장 폴더 경로 : "+REAL_PATH);
		logger.debug("삭제 폴더 경로 : "+DELETED_FILE_PATH);
		return "login/login";
	}

	@ResponseBody
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(UserVO userVO, HttpSession session, HttpServletResponse response, HttpServletRequest request,Model model) { // 로그인 정보 DB 조회 및 쿠키생성

		try {
			UserVO userInfovo = null;
			userInfovo = userService.findUser(userVO);
				// TODO Auto-generated catch block
			logger.debug("login시 vo 정보 " + userInfovo);

			if (userInfovo != null) {
				logger.debug("UserStatus : "+userInfovo.getUserStatus());
				if (userInfovo.getUserStatus() == 1) {
					
					if (userVO.getCheckTokenYn() != null && "Y".equals(userVO.getCheckTokenYn())) {
	
						logger.debug("getCheckTokenYn : " + userVO.getCheckTokenYn());
	
						String agent = request.getHeader("User-Agent");
						String userBrowser = null;
	
						String userIp = request.getHeader("X-FORWARDED-FOR");
	
						if (userIp == null) {
							userIp = request.getHeader("Proxy-Client-IP");
						}
						if (userIp == null) {
							userIp = request.getHeader("WL-Proxy-Client-IP");
						}
						if (userIp == null) {
							userIp = request.getHeader("HTTP_CLIENT_IP");
						}
						if (userIp == null) {
							userIp = request.getHeader("HTTP_X_FORWARDED_FOR");
						}
						if (userIp == null) {
							userIp = request.getRemoteAddr(); // ip 외부 주소
						}
						
						logger.debug("아이피정보 :" + userIp); //localhost에서 하면 0:0:0:0:0:0:0:1 뜨는데 개발할 때 만 이렇고 ip주소 사용해서
																// 접속하면 제대로 뜸(확인o)
	
						if (agent != null) {
							if (agent.indexOf("Trident") > -1) {
								userBrowser = "MSIE";
							} else if (agent.indexOf("Chrome") > -1) {
								userBrowser = "Chrome";
							} else if (agent.indexOf("Opera") > -1) {
								userBrowser = "Opera";
							} else if (agent.indexOf("iPhone") > -1 && agent.indexOf("Mobile") > -1) {
								userBrowser = "iPhone";
							} else if (agent.indexOf("Android") > -1 && agent.indexOf("Mobile") > -1) {
								userBrowser = "Android";
							}
						}
						logger.debug("bkh 브라우저 정보 :" + userBrowser);
	
						UserAutoLoginVO alvo = new UserAutoLoginVO();
						alvo.setUserSeq(userInfovo.getUserSeq());
						alvo.setUserBrowser(userBrowser);
						alvo.setUserIp(userIp);
						userService.deleteCookieWhenLogin(alvo); // 유저 고유번호+브라우저 정보로 db기존 데이터 status 0
																	// 만료
						
						String token = loginutil.generateAccessToken(response, userVO);//access token생성	
						loginutil.generateRefreshToken(response, userVO);//refresh token 생성
						logger.debug("bkh 토큰 확인 : " + token);
	
						Cookie cookie = new Cookie("auth", token);
						cookie.setPath("/");
						cookie.setMaxAge(60 * 60 * 60 * 24 * 30); // 한달
						cookie.setHttpOnly(true);
						response.addCookie(cookie);
	
						alvo.setCookieKey(token);
	
						userService.insertAutoLoginInfo(alvo);
						logger.info("bkh 로그인 vo 정보  : " + alvo);
	
					}
					userService.updateLoginDt(userInfovo.getUserSeq());
					
					session.setAttribute("userInfovo", userInfovo);
					session.setAttribute("sessionPicForUser",userInfovo.getPicture());
					session.setAttribute("sessionIdForUser", userInfovo.getUserId());
					session.setAttribute("sessionNameForUser", userInfovo.getUserName());
					session.setAttribute("sessionSeqForUser", userInfovo.getUserSeq());
					session.setAttribute("sessionPwCheck",userInfovo.getFirstUpdatePw());
	
					session.setMaxInactiveInterval(serverSessTime);

					if (userInfovo.getUserType() == 1) {
						session.setAttribute("sessionSeqForAdmin", userInfovo.getUserSeq());
						session.setMaxInactiveInterval(serverSessTime);
					}
				} else {
					return "2";
				}
				return "1";
			} else {
				return "0";
			}
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			logger.error("NoSuchAlgorithmException"+e);
			logger.error("Request URL :"+request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		} catch (SQLException e) {
			logger.error("SQLException "+e);
			logger.error("Request URL :"+request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		} catch (NullPointerException e) {
			logger.error("NullPointerException "+e);
			logger.error("Request URL :"+request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		} catch (Exception e) {
			logger.error("Exception" + e);
			logger.debug(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		}
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response,Model model) { // 로그아웃 - 쿠키 만료 및  세션 무효화

		session.invalidate();
		//loginutil.removeAllTokens(response);
		
		try {
			Cookie[] cookies = request.getCookies();
			if (cookies != null) {
				for (Cookie c : cookies) {
					String cookieName = c.getName();
					if (cookieName.equals("auth")) {
						c.setPath("/");
						c.setMaxAge(0);
						response.addCookie(c);
						userService.deleteCookie(c.getValue());
						logger.debug("cookie value : " + c.getValue());
					}
					if (cookieName.equals("auth")) {
						c.setPath("/");
						c.setMaxAge(0);
						response.addCookie(c);
						userService.deleteCookie(c.getValue());
						logger.debug("cookie value : " + c.getValue());
					}
				}
			}
			
			return "redirect:/login/loginView";
			
		} catch (NullPointerException e) {
			logger.error("NullPointerException "+e);
			logger.error("Request URL :"+request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		} catch (Exception e) {
			logger.error("Exception" + e);
			logger.debug(" Request URI \t:  " + request.getRequestURI());
			model.addAttribute("msg", "잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
			model.addAttribute("loc", "/login/logout");
			return "common/msg";
		}

	
	}
	
	 /*@ExceptionHandler
	    public ResponseEntity<String> handle(IOException ex) {
		 
	 }*/

}
