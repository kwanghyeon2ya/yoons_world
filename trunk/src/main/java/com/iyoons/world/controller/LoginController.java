package com.iyoons.world.controller;

import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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

        private int testSessionTime = 60;
        private int testCookieTime = 60*60;
        private int localSessTime = 60*60*60*24*7; //개발서버
        private int serverSessTime = 60*60*60*24;//로컬
        private final String secretKey =  "secretKey";
    	private final Logger logger = LoggerFactory.getLogger(this.getClass());
        
    	
    	
	public String createJWT(String userId,int userSeq) { // 토큰 생성 메서드
		
		String userSeqForToken = Integer.toString(userSeq);
		
		Map<String, Object> headers = new HashMap<>();
		headers.put("typ", "JWT");
		headers.put("alg", "HS256");
		headers.put("regDate", System.currentTimeMillis());
		
		Map<String,Object> payloads = new HashMap<>();
		payloads.put("userId",userId);
		payloads.put("userSeq",userSeqForToken);
		
		Long expiredTime = 1000 * 60L * 60L * 2L; // 토큰 유효시간 2시간
		
		Date ext = new Date();
		ext.setTime(ext.getTime() + expiredTime);
		
		
		//토큰 빌더
		String jwt = Jwts.builder()
				.setHeader(headers) // 헤더설정
				.setClaims(payloads) // Claims 설정 
				.setSubject("user") // 토큰의 용도
				.setIssuedAt(new Date()) // 토근 생성일
				.setExpiration(ext) // 토큰 만료 시간 
				.signWith(SignatureAlgorithm.HS256, secretKey.getBytes()) // HS256과 secretKey로 서명정보 추가
								//해당 토큰이 조작되었거나 변경되지 않았음을 확인하는 용도 - 서버 측에서 관리하는 비밀키가 유출되지 않는 이상 복호화할 수 없음
				.compact(); // 토큰생성

		return jwt;
	}	
	
	public String checkSessionCookie(String cookieValue,HttpSession session,Model model) { // 모든페이지 세션 및 쿠키 확인 후 세션재생성 -- 아직미완
		
		String sessionSeqForUser = (String)session.getAttribute("sessionSeqForUser");
		
		if(sessionSeqForUser == null) {
			if(cookieValue == null) { // jsp에서 request로 받아온 cookie에 대한 value가 null이면 
				
				model.addAttribute("msg", "로그인이 필요합니다");
				model.addAttribute("loc", "/main");
				
				return "common/msg";
				
			}else{
				UserAutoLoginVO alvo = userService.getCookieInfo(cookieValue); //db조회 후 회원 고유번호 가져옴
																					//쿠키생성일자에서 만료일까지의 기간 조건,status = 1의 조건
				session.setAttribute("sessionSeqForUser", alvo.getUserSeq());
				session.setAttribute("sessionNameForUser",alvo.getUserName());
				session.setAttribute("sessionBroserForUser",alvo.getUserBrowser()); // 브라우저 세션 고민
			}
		}
		
		return "";
	}
	
	/*public static String updateCookie(@CookieValue(value = "token", required = false) Cookie cookie) {
		
		if(cookie != null) {
			String cookieValue = cookie.getValue();	
		}
		
		return "";
	}	*/
    	
	@RequestMapping("/loginView")
    	public String loginView() {
        	
    		return "login/login";
    	}
        
        
        
        @ResponseBody 
     	@RequestMapping(value = "/login", method = RequestMethod.POST)
    	public int login(UserVO userVO,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws NoSuchAlgorithmException {
        	
    		UserVO userInfovo = userService.findUser(userVO);
    		System.out.println(userInfovo+"userInfovoㅎㅎㅎ");
    		
    		if(userInfovo != null ) {
    			if(userInfovo.getUserStatus() == 1) {
    				
    				
    				if(userVO.getCheckToken() != null && "Y".equals(userVO.getCheckToken())) {
    					
    					
    					System.out.println("userVO.getCheckToken() : "+userVO.getCheckToken());
    					
	    		        
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
	    		        
	    		        System.out.println("아이피정보 :"+userIp); // localhost에서 하면 0:0:0:0:0:0:0:1 뜨는데 개발할 때 만 이렇고 ip주소 사용해서 접속하면 제대로 뜸(확인o)
	    		        
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
	    		        System.out.println("브라우저 정보 :"+userBrowser);

	    		        UserAutoLoginVO alvo = new UserAutoLoginVO();
	    		        alvo.setUserSeq(userInfovo.getUserSeq());
	    		        alvo.setUserBrowser(userBrowser);
	    		        alvo.setUserIp(userIp);
	    		        userService.deleteCookieWhenLogin(alvo); //유저 고유번호+브라우저 정보로 db기존 데이터 status 0
	    		        										//만료
	    		        
	    		        String token = createJWT(userInfovo.getUserId(), userInfovo.getUserSeq());
	    				System.out.println("토큰 확인 : "+token);
	    				
	    				Cookie cookie = new Cookie("auth", token);
	    				cookie.setPath("/");
	    				cookie.setMaxAge(60*60*60*24*30); // 한달
	    		        cookie.setHttpOnly(true);
	    		        response.addCookie(cookie);	    		        
	    		        
	    		        alvo.setCookieKey(token);
	    		        
	    		        userService.insertAutoLoginInfo(alvo);
	    		        logger.info("로그인 vo 정보 : "+alvo);
	    		        
	    				}
	    				
	    				session.setAttribute("userInfovo", userInfovo);
		    			session.setAttribute("sessionIdForUser", userInfovo.getUserId());
		    			session.setAttribute("sessionNameForUser",userInfovo.getUserName());
		    			session.setAttribute("sessionSeqForUser", userInfovo.getUserSeq());
		    			
		    			session.setMaxInactiveInterval(testSessionTime);
		    			
		    			if(userInfovo.getUserType() == 1) {
		    			session.setAttribute("sessionSeqForAdmin", userInfovo.getUserSeq());
		    			session.setMaxInactiveInterval(testSessionTime);
	    			}
    			}else {
    				return 2;
    			}
    			return 1;
    		}else{
				return 0;
    		}
    	 }
     	
    	@RequestMapping(value = "/logout", method = RequestMethod.GET)
    	public String logout(HttpSession session,HttpServletRequest request,HttpServletResponse response) {
    		
    		session.invalidate();
    		
    		try {
    			Cookie[] cookies = request.getCookies();
    			if(cookies != null) {
		    		for(Cookie c : cookies) {
		    		String cookieName = c.getName();
			    		if(cookieName.equals("auth")) {
				    		c.setPath("/");
							c.setMaxAge(0);
							response.addCookie(c);
							userService.deleteCookie(c.getValue());
							System.out.println("쿠키 벨류? : "+c.getValue());
			    		}
		    		}
    			}
    		}catch(NullPointerException np) {
    			logger.info("nullexception "+np);
    		}catch(Exception e) {
    			logger.info("exception "+e);
    		}
    		
    		return "redirect:/login/loginView";
    	}
    	
   
    	
        
        
}

