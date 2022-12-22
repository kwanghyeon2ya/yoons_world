package com.iyoons.world.service;

import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.List;

import com.iyoons.world.vo.UserVO;
import com.iyoons.world.vo.PageVO;
import com.iyoons.world.vo.UserAutoLoginVO;

public interface UserService {
	public int checkId(UserVO userVO);
	
	public UserVO findUser(UserVO userVO) throws NoSuchAlgorithmException;
	
	public int insertUser(UserVO userVO) throws SQLException, NoSuchAlgorithmException, Exception;
	
	public int updateUser(UserVO userVO) throws SQLException, NoSuchAlgorithmException, Exception;
	
	public UserVO userDetail(UserVO userVOFromParam) throws SQLException, Exception;

	public int deleteUser(UserVO userVO) throws SQLException, Exception;
	
	public List<UserVO> userList(PageVO page) throws Exception;
	
	public UserVO viewUser() throws Exception;

	public int getCountUser() throws Exception;

	public int recoverUserStatus(UserVO userVO) throws Exception;

	public int getSearchedUserCount(PageVO page) throws Exception;

	public int insertAutoLoginInfo(UserAutoLoginVO alvo) throws Exception;
	
	public UserAutoLoginVO getCookieInfo(String cookieKey) throws Exception;
	
	public int deleteCookie(String cookieKey) throws Exception;
	
	public int deleteCookieWhenLogin (UserAutoLoginVO alvo) throws Exception;
	
	public List<UserVO> getUserInfoList(UserVO userVO) throws SQLException, NullPointerException, Exception;
	
	public int getUserCount(UserVO userVO) throws Exception;
	
}