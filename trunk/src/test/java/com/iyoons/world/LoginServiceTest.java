package com.iyoons.world;

import static org.assertj.core.api.Assertions.not;
import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertArrayEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;

import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;
import org.junit.jupiter.api.extension.ExtendWith;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.ui.Model;

import com.iyoons.world.service.UserService;
import com.iyoons.world.vo.UserAutoLoginVO;
import com.iyoons.world.vo.UserVO;


@ExtendWith(SpringExtension.class)
@SpringBootTest
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class LoginServiceTest {
	
	@Autowired
	private UserService userService;

	String userId = "qusrhkdgus";//유저 id
	String userPw = "asdasd";//유저 pw
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Test
	public void testCheck() {
		logger.info("----테스트 시작----");
		int a = 1;
		Assertions.assertThat(a).isEqualTo(1);
		assertThat(a,is(not(1)));
		assertTrue(a == 1);
	}
	
	@Test
	@DisplayName("로그인 체크!")
	public void login() { // 로그인 정보 DB 조회 및 쿠키생성
		logger.info("--------------login check-------------");
		UserVO userVO = new UserVO();
		userVO.setUserId(userId);
		userVO.setUserPw(userPw);
		try {
			UserVO userInfovo = null;
			userInfovo = userService.findUser(userVO);
			
			String [] a = {"1","2","3"};
			String [] b = {"4","5","6"};
			assertArrayEquals("check if a b equal",a,b);
			
			if(userInfovo != null) {
				logger.info("error occured");
			    throw new IllegalArgumentException("사용자 정보가 존재하지 않습니다.");
			}
			assertNull("userInfovo가 과연 널일까요?",userInfovo);
		
		} catch (Exception e) {
			logger.error("error message : \t "+e.getMessage());
		}
	}
	
	@Test
	@DisplayName("로그인 체크 그 두번째 이야기")
	public void login2() { // 로그인 정보 DB 조회 및 쿠키생성
		logger.info("--------------login check2-------------");
		UserVO userVO = new UserVO();
		userVO.setUserId(userId);
		userVO.setUserPw(userPw);
		try {
			UserVO userInfovo = null;
			userInfovo = userService.findUser(userVO);
			assertNotNull("userInfovo은 널이 아니겠죠?",userInfovo);
			String [] a = {"1","2","3"};
			String [] b = {"1","2","3"};
			assertArrayEquals("check if a b equal 그 두번째 이야기",a,b);
		
		} catch (Exception e) {
			
		}
	}
	
	
}
