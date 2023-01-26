package com.iyoons.world.dao;

import java.sql.SQLException;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.iyoons.world.vo.UserVO;
import com.iyoons.world.vo.DepVO;
import com.iyoons.world.vo.PageVO;
import com.iyoons.world.vo.UserAutoLoginVO;

@Mapper
public interface UserDAO {

	public List<UserVO> getUserList() throws SQLException;

	public int insertUser(UserVO userVO) throws SQLException;
	
	public int updateUser(UserVO userVO) throws SQLException;
	
	public int updateDepUser(DepVO depVO);
	
	public UserVO userDetail(UserVO userVOFromParam) throws SQLException;

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
	
	public int insertDepUser(DepVO depVO);
	
	public int deleteDepUser(DepVO depVO);
	
	public int recoverDepUserStatus(DepVO depVO);
	
	public List<UserVO> getUserInfoList(UserVO userVO);
	
	public int getUserCount(UserVO userVO);
	
	public int updateLoginDt(int userSeq);
	
	public int changePw(UserVO userVO);
	
	public int checkPw(UserVO userVO);
	
	public int getPwConfirmNum(int userSeq);
	
	public int updateMypage(UserVO userVO);
	
	public UserVO getPicture(UserVO userVO);
}
