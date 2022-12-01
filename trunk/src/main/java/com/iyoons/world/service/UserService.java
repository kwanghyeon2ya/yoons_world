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
	
	public int insertUser(UserVO userVO) throws SQLException, NoSuchAlgorithmException;
	
	public int updateUser(UserVO userVO) throws SQLException, NoSuchAlgorithmException;
	
	public UserVO userDetail(String userId) throws SQLException;

	public int deleteUser(UserVO userVO) throws SQLException;
	
	public List<UserVO> userList(PageVO page);
	
	public UserVO viewUser();

	public int getCountUser();

	public int recoverUserStatus(UserVO userVO);

	public int getSearchedUserCount(PageVO page);

	public int insertAutoLoginInfo(UserAutoLoginVO alvo);
	
	public UserAutoLoginVO getCookieInfo(String cookieKey);
	
	public int deleteCookie(String cookieKey);
	
	public int deleteCookieWhenLogin (UserAutoLoginVO alvo);
	
}