package com.iyoons.world.interceptor;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import io.jsonwebtoken.Jwts;
//import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.iyoons.world.common.FinalVariables;
import com.iyoons.world.common.LoginUtil;
import com.iyoons.world.service.UserService;
import com.iyoons.world.vo.UserAutoLoginVO;

//@SuppressWarnings("deprecation")
//public class CommonInterceptor extends HandlerInterceptorAdapter{
public class CommonInterceptor implements HandlerInterceptor {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private UserService userService;
	
	@Autowired
	LoginUtil loginutil;
	
//	catch
//	로그정보 : requestURL, Exception
// 리다이렉트 처리 (로그아웃, 오류메세지 출력, ...)
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception { // controller전에
																											// 실행되며
		Model model = null;

		Boolean returnValue = false;
		
		try {

			if (logger.isDebugEnabled()) { // 디버그 레벨인지 아닌지 확인 - 디버그 레벨이면 메세지 출력
				logger.debug("===================       START       ===================");// start 로그
				logger.debug(" Request URI \t:  " + request.getRequestURI());
			}

			HttpSession session = request.getSession();
			Integer sessionuserSeq = null;
			if (logger.isDebugEnabled()) {
				logger.debug("세션 ID 확인 : " + request.getRequestedSessionId());
				logger.debug("bkh session null check" + session.getAttribute("sessionSeqForUser"));
				logger.debug(
						"bkh session valueof null check" + String.valueOf(session.getAttribute("sessionSeqForUser")));
			}

			if (session.getAttribute("sessionSeqForUser") != null) {
				sessionuserSeq = Integer.parseInt(String.valueOf(session.getAttribute("sessionSeqForUser")));
				// 세션이 빈걸 체크할 것 (X)
			}
			if (sessionuserSeq != null) {
				returnValue = true;
				logger.info("첫 세션을 통해 진입성공");
			} else {
				
				Cookie cookieAccess = loginutil.getCookieByName(request, FinalVariables.ACCESS_TOKEN_COOKIE_NAME);
	            Cookie cookieRefresh = loginutil.getCookieByName(request, FinalVariables.REFRESH_TOKEN_COOKIE_NAME);
	            logger.debug("cookieAccess == null : "+(cookieAccess == null));
	            logger.debug("cookieRefresh == null : "+(cookieRefresh == null));
	            if (cookieRefresh== null) {
	                throw new Exception("token cookie is null");
	            }
	            boolean checkAccessToken = false;
	            String accessToken = null;
	            if(cookieAccess != null) { 
	            	accessToken = loginutil.getValueFromCookie(cookieAccess);//쿠키에서 암호화된 토큰값 가져오기
	            	checkAccessToken = loginutil.validateToken(accessToken);//암호화된 토큰값으로 유효확인
	            	logger.debug("checkAccessToken : "+checkAccessToken);
	            }
	            String refreshToken = loginutil.getValueFromCookie(cookieRefresh);
	            
	            if(!checkAccessToken) {
	            	boolean checkRefreshToken = loginutil.validateToken(refreshToken);
	            	if(!checkRefreshToken) {
	            		throw new Exception("token cookie is null");
	            	}else{
	            		loginutil.reGenerateByRefToken(response,session,refreshToken);
	            		returnValue = true; 
	            	}
	            }else{
	            	loginutil.reGenerateSession(accessToken,session);//세션 재생성
	            	returnValue = true;
	            }
	            
	            
	            
	            
				/*Cookie[] cookies = request.getCookies();
				
				logger.debug("쿠키확인 :" + cookies);

				if (cookies != null) {
					
					for (Cookie c : cookies) {
						String cookieName = c.getName();
						logger.debug("쿠키 이름 : "+c.getName());
						logger.debug("쿠키 해독 전 : "+c.getValue());
						String decJwt = URLDecoder.decode(c.getValue(), "UTF-8");
						logger.debug("쿠키 내용 확인 : "+URLDecoder.decode(c.getValue(), "UTF-8"));
						if (cookieName.equals("auth")) {
							logger.debug("cookie value :" + c.getValue());
							UserAutoLoginVO alvo = userService.getCookieInfo(c.getValue());
							
							if (alvo != null) {
								session.setAttribute("sessionSeqForUser", alvo.getUserSeq());
								session.setAttribute("sessionIdForUser", alvo.getUserId());
								session.setAttribute("sessionNameForUser", alvo.getUserName());
								session.setMaxInactiveInterval(60 * 60 * 3);
								if (alvo.getAdminType() == 1) {
									session.setAttribute("sessionSeqForAdmin", alvo.getUserSeq());
									session.setMaxInactiveInterval(60 * 60 * 3);
								}
								returnValue = true;
							} else {
								logger.info("not cookie here");
								returnValue = false;
							}

						}
					}
				}*/

			}
			
			
			
			logger.info("쿠키를 통해 진입성공");
			
			/*throw new Exception("오류가 나긴 했읍니다만?");*/
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			logger.debug("exception " + e);
			logger.debug(" Request URI \t:  " + request.getRequestURI());
			returnValue = false;
		}
		
		if (!returnValue) {

			response.sendRedirect(request.getContextPath() + "/login/loginView"); // 프로젝트 이름만 가져온 후 uri더해줌

		}
		
		return returnValue;

	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception { // 클라이언트의 요청을 처리한 뒤에 호출 됨 controller에서 예외가 발생되면 실행 안 한다
		if (logger.isDebugEnabled()) {
			logger.debug("===================        END        ===================\n"); // end 로그

//		super.postHandle(request, response, handler, modelAndView);
		}

	}
}
