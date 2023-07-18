package com.iyoons.world.service;

import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.iyoons.world.vo.UserVO;
import com.iyoons.world.vo.PageVO;
import com.iyoons.world.vo.UserAutoLoginVO;

public interface UserService {
	public int checkId(UserVO userVO);
	
	public UserVO findUser(UserVO userVO) throws NoSuchAlgorithmException;
	
	public int insertUser(UserVO userVO) throws Exception;
	
	public int updateUser(UserVO userVO) throws Exception;
	
	public UserVO userDetail(UserVO userVOFromParam) throws Exception;

	public int deleteUser(UserVO userVO) throws Exception;
	
	public List<UserVO> userList(PageVO page) throws Exception;
	
	public UserVO viewUser() throws Exception;

	public int getCountUser() throws Exception;

	public int recoverUserStatus(UserVO userVO) throws Exception;

	public int getSearchedUserCount(PageVO page) throws Exception;

	public int insertAutoLoginInfo(UserAutoLoginVO alvo) throws Exception;
	
	public UserAutoLoginVO getCookieInfo(String cookieKey) throws Exception;
	
	public int deleteCookie(String cookieKey) throws Exception;
	
	public int deleteCookieWhenLogin (UserAutoLoginVO alvo) throws Exception;
	
	public List<UserVO> getUserInfoList(UserVO userVO) throws Exception;
	
	public int getUserCount(UserVO userVO) throws Exception;
	
	public int updateLoginDt(int userSeq);
	
	public int changePw(UserVO userVO) throws NoSuchAlgorithmException;
	
	public int checkPw(UserVO userVO) throws NoSuchAlgorithmException;
	
	public int getPwConfirmNum(int userSeq);
	
	public int updateMypage(UserVO userVO,MultipartFile Nultifile) throws Exception;
	
	public UserVO getPicture(UserVO userVO);
	
	public UserVO getUserInfoByRefToken(UserVO userVO);
	
}