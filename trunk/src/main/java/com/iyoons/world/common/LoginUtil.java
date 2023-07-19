package com.iyoons.world.common;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.util.WebUtils;

import com.iyoons.world.service.UserService;
import com.iyoons.world.vo.UserVO;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

/*
 * @author bkh
 * @decription 로그인 관련 util
 * */

@Component
public class LoginUtil {

	@Autowired
	JWTUtil jwtutil;
	
	@Autowired
	UserService userService;

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	/**
	 * @param Response,UserVO
	 * @discription 엑세스 토큰 발급
	 * @return JWT Access token
	 * */
	public String generateAccessToken(HttpServletResponse response,UserVO userVO) {
	
		String jwt = jwtutil.generateAccessToken(userVO);
		Cookie cookie = new Cookie(FinalVariables.ACCESS_TOKEN_COOKIE_NAME, jwt);
		cookie.setPath("/");
		cookie.setMaxAge(5); // 2시간
		cookie.setHttpOnly(true);
		response.addCookie(cookie);
		return jwt;
	}

	/**
	 * @param Response,UserVO
	 * @discription 리프레쉬 토큰 발급
	 * @return JWT Refresh token
	 * */
	public String generateRefreshToken(HttpServletResponse response,UserVO userVO) {
		
		String jwt = jwtutil.generateRefreshToken(userVO);
		Cookie cookie = new Cookie(FinalVariables.REFRESH_TOKEN_COOKIE_NAME, jwt);
		cookie.setPath("/");
		cookie.setMaxAge(FinalVariables.EXPIRATION_REFRESH/1000); // 2시간
		cookie.setHttpOnly(true);
		response.addCookie(cookie);
		return jwt;
	}
	
	/**
	 * @param JWT token
	 * @discription Access token을 통해 세션을 재생성한다
	 * @return JWT token
	 * */
	

	public void reGenerateSession(String token,HttpSession session) {
		session.setAttribute("sessionPicForUser",getValueFromToken(token,"picture"));
		session.setAttribute("sessionIdForUser", getValueFromToken(token,"userId"));
		session.setAttribute("sessionNameForUser", getValueFromToken(token,"userName"));
		session.setAttribute("sessionSeqForUser", getValueFromToken(token,"userSeq"));
		session.setAttribute("sessionPwCheck",getValueFromToken(token,"firstUpdatePw"));
		session.setAttribute("sessionUserType",getValueFromToken(token,"userType"));
	}
	
	/**
     * 쿠키 가져오기
     *
     * @param request, cookieName (쿠키 이름)
     * @return Cookie
     */
    public Cookie getCookieByName(HttpServletRequest req, String cookieName) {
        return WebUtils.getCookie(req, cookieName);
    }
    
    
    /**
     * 쿠키 value decode
     *
     * @param cookie
     * @return cookie를 decode 후 가져온 cookie value
     * @throws UnsupportedEncodingException 
     */
    public String getValueFromCookie(Cookie cookie) throws UnsupportedEncodingException {
        return URLDecoder.decode(cookie.getValue(), "UTF-8");
    }
    
    
    /*
     * @param jwt token값
     * @discription 토큰 유효 검사
     * @return 유효결과값 boolean
     * */
    public boolean validateToken(String token) {
    	logger.debug("validateToken 진입");
    	return jwtutil.validateToken(token);
    }
    
    /*
     * @param Refresh token
     * @discription Refresh token을 통한 Access token 재발급, session 재생성
     * */
	public void reGenerateByRefToken(HttpServletResponse response,HttpSession session,String reftoken) throws UnsupportedEncodingException {
		int userSeq = Integer.parseInt(getValueFromToken(reftoken,"userSeq"));
		String userId = getValueFromToken(reftoken,"userId");
		UserVO userVO = new UserVO();
		
		userVO.setUserSeq(userSeq);
		userVO.setUserId(userId);
		logger.debug("userVO : "+userVO);
		UserVO userinfovo = userService.getUserInfoByRefToken(userVO);
		logger.debug("userinfovo : "+userinfovo);
		
		String token = jwtutil.generateAccessToken(userinfovo);
		
		if(userinfovo.getUserType() == 1) {
			session.setAttribute("sessionSeqForAdmin", userinfovo.getUserSeq());
		}
		session.setAttribute("sessionPicForUser",userinfovo.getPicture());
		session.setAttribute("sessionIdForUser", userinfovo.getUserId());
		session.setAttribute("sessionNameForUser", userinfovo.getUserName());
		session.setAttribute("sessionSeqForUser", userinfovo.getUserSeq());
		session.setAttribute("sessionPwCheck",userinfovo.getFirstUpdatePw());
		session.setAttribute("sessionUserType",userinfovo.getUserType());
		
		session.setMaxInactiveInterval(FinalVariables.EXPIRATION_SESSION);
		
		Cookie cookie = new Cookie(FinalVariables.ACCESS_TOKEN_COOKIE_NAME, URLEncoder.encode(token,"UTF-8"));
		cookie.setPath("/");
		cookie.setMaxAge(FinalVariables.EXPIRATION_ACCESS * 2);
		response.addCookie(cookie);
		logger.debug("쿠키 재생성 진입 확인");
	}
	
	/*
	 * @param JWT token,검색할 key값
	 * @discription 토큰 속 key의 value값 추출
	 * @return Map형식의 Claims객체 key에 대한 value값
	 * */
	public String getValueFromToken(String token,String key) {
		return jwtutil.getValueFromToken(token,key);
	}
	
	/**
     * 토큰 전체 제거
     *
     * @param response
     */
    public void removeAllTokens(HttpServletResponse response) {
        Cookie cookie = new Cookie(FinalVariables.ACCESS_TOKEN_COOKIE_NAME, null);
        cookie.setPath("/");
        cookie.setMaxAge(0);
        response.addCookie(cookie);

        cookie = new Cookie(FinalVariables.REFRESH_TOKEN_COOKIE_NAME, null);
        cookie.setPath("/");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
    }
	
}

