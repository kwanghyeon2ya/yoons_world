package com.iyoons.world.dao;

import java.sql.SQLException;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.iyoons.world.vo.UserVO;
import com.iyoons.world.vo.PageVO;
import com.iyoons.world.vo.UserAutoLoginVO;

@Mapper
public interface UserDAO {

	public List<UserVO> getUserList() throws SQLException;

	public int insertUser(UserVO userVO) throws SQLException;
	
	public int updateUser(UserVO userVO) throws SQLException;
	
	public UserVO userDetail(String userId) throws SQLException;

	public int deleteUser(UserVO userVO) throws SQLException;
	
	public int recoverUserStatus(UserVO userVO);
	
	public int checkId(UserVO userVO);
	
	public UserVO findUser(UserVO userVO);

	public List<UserVO> userList(PageVO page);

	public UserVO viewUser();
	
	public int getCountUser();
	
	public int getSearchedUserCount(PageVO page);
	
	public int insertAutoLoginInfo(UserAutoLoginVO alvo);
	
	public UserAutoLoginVO getCookieInfo(String cookieKey);
	
	public int deleteCookie(String cookieKey);
	
	public int deleteCookieWhenLogin(UserAutoLoginVO alvo);
}
