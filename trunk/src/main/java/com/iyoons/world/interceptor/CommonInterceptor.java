package com.iyoons.world.interceptor;

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
//import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.iyoons.world.service.UserService;
import com.iyoons.world.vo.UserAutoLoginVO;

//@SuppressWarnings("deprecation")
//public class CommonInterceptor extends HandlerInterceptorAdapter{
public class CommonInterceptor  implements HandlerInterceptor{

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired 
	private UserService userService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception { //controller전에 실행되며 false 일 때 controller를 실행하지 않는다.
		
		Model model = null;
		
		logger.info("DebugEnable : "+logger.isDebugEnabled());
		if (logger.isDebugEnabled()) { // 디버그 레벨인지 아닌지 확인 - 디버그 레벨이면 메세지 출력  
            logger.debug("===================       START       ===================");// start 로그
            logger.debug(" Request URI \t:  " + request.getRequestURI());
        }
		
		Boolean returnValue = false;
		
//		        HttpSession session = request.getSession(false);
		        HttpSession session = request.getSession();
		        
		        logger.debug("세션 ID 확인 : "+request.getRequestedSessionId());
		        Integer sessionuserSeq = null;
		        logger.debug("bkh session null check"+session.getAttribute("sessionSeqForUser"));
		        logger.debug("bkh session valueof null check"+String.valueOf(session.getAttribute("sessionSeqForUser")));
		        if(session.getAttribute("sessionSeqForUser") != null) {
		        	sessionuserSeq = Integer.parseInt(String.valueOf(session.getAttribute("sessionSeqForUser")));
		        //세션이 빈걸 체크할 것 (X)
		        }
		        if(sessionuserSeq != null) {
		            	returnValue = true;
		            	logger.debug("진입성공");
		        }else{
		        	
			        Cookie [] cookies = request.getCookies();
			        logger.info("쿠키확인 :"+cookies);

			        if(cookies != null) {
			        	
			        	for(Cookie c : cookies){
			        		String cookieName = c.getName();
			        			if(cookieName.equals("auth")){
			        				logger.info("cookie value :"+c.getValue());
			        			UserAutoLoginVO alvo = userService.getCookieInfo(c.getValue());
			        			
				        			if(alvo != null) {
				        				logger.debug("bkh cookie db 조회 완료"+alvo);
				        				/*HttpSession session2 = request.getSession(false);*/
				        				session.setAttribute("sessionSeqForUser", alvo.getUserSeq());
					    				session.setAttribute("sessionNameForUser",alvo.getUserName());	
					    				session.setMaxInactiveInterval(60*60*3);
					    				if(alvo.getAdminType()==1) {
					    					session.setAttribute("sessionSeqForAdmin", alvo.getUserSeq());
							    			session.setMaxInactiveInterval(60*60*3);
					    				}
					    				returnValue = true;
				        			}else{
				        				logger.debug("bkh there is no cookie here");
				        				response.sendRedirect(request.getContextPath() + "/login/logout");
				        				returnValue = false;
				        			}
			        			
			        			}
			        	}
			        }	

		        }
		        if(!returnValue) {
		        	response.sendRedirect(request.getContextPath() + "/login/logout");
		        }
		        logger.debug("쿠키를 통해 진입성공");
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
