package com.iyoons.world.service.impl;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.iyoons.world.dao.UserDAO;
import com.iyoons.world.service.UserService;
import com.iyoons.world.vo.UserVO;
import com.iyoons.world.vo.DepVO;
import com.iyoons.world.vo.PageVO;
import com.iyoons.world.vo.UserAutoLoginVO;

@Service(value = "UserService")
public class UserServiceImpl implements UserService {
	
	@Autowired
	UserDAO userDAO;
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	public String getShaAlgorithm(String password , String salt_key) throws NoSuchAlgorithmException {
		String hashString = "";
		
		MessageDigest sh = MessageDigest.getInstance("SHA-256");
		sh.update(password.getBytes()); // 데이터를 해쉬
		byte byteData[] = sh.digest(); // 시큐리티의 MessageDigest클래스의 digest() - 바이트 배열로 해쉬를 반환함
		
		logger.debug("byteData - 바이트배열 크기 : "+byteData.length);
		
		StringBuffer sb = new StringBuffer();
		
		for(byte bt: byteData) {
			sb.append(Integer.toString((bt & 0xff) + 0x100, 16).substring(1));//바이트를 문자열로
		}
		hashString = sb.toString();
		
		return hashString;
	}
	
	public String getHashPw(UserVO vo)throws NoSuchAlgorithmException {
		
		String pw = vo.getUserPw(); // 비밀번호
		String salt_key = getSalt(); // salt를 통해 바이트 난수
		String hashPw = getShaAlgorithm(pw, salt_key); //algorism을 활용한 해시문자열 생성
		
//		String [] str = {pw,hashPw,salt_key};
//		String resultPw = Arrays.toString(str);
		return hashPw;
	}
	
	public String getSalt() throws NoSuchAlgorithmException{
		SecureRandom rnd = SecureRandom.getInstance("SHA1PRNG"); // 
		byte[] bytes = new byte[16]; // 바이트 배열 생성
		rnd.nextBytes(bytes); // nextBytes를 호출하여 난수바이트 생성
		String salt = new String(Base64.getEncoder().encode(bytes));
		
		return salt;
		
	}
	
	
	@Override
	public int checkId(UserVO userVO) {
		
		return userDAO.checkId(userVO);
	}

	@Override
	public UserVO findUser(UserVO userVO) throws NoSuchAlgorithmException {
		
		userVO.setUserPw(getHashPw(userVO));
		
		return userDAO.findUser(userVO);
	}
	
	@Override
	@Transactional
	public int insertUser(UserVO userVO) throws SQLException, NoSuchAlgorithmException {
		DepVO depVO = new DepVO();
		userVO.setEmail(userVO.getEmailPart1()+"@"+userVO.getEmailPart2());
		userVO.setPhone(userVO.getPhone1()+"-"+userVO.getPhone2()+"-"+userVO.getPhone3());
		System.out.println("userVO 번호확인 : "+userVO.getPhone());
		userVO.setUserPw(getHashPw(userVO));
		
		System.out.println("userVO.getRegrSeq() :"+userVO.getRegrSeq());
		
		int result = userDAO.insertUser(userVO);
		
		depVO.setDepId(userVO.getDepId());
		depVO.setUserSeq(userVO.getUserSeq());
		depVO.setRegrSeq(userVO.getRegrSeq());
		
		userDAO.insertDepUser(depVO);
		
		
		return result;
	}

	@Override
	@Transactional
	public int updateUser(UserVO userVO) throws SQLException, NoSuchAlgorithmException {
		
		int result = userDAO.updateUser(userVO);
		
		userVO.setEmail(userVO.getEmailPart1()+"@"+userVO.getEmailPart2());
		userVO.setPhone(userVO.getPhone1()+"-"+userVO.getPhone2()+"-"+userVO.getPhone3());
		
		userVO.setUserPw(getHashPw(userVO));
		
		return result;
	}

	@Override
	@Transactional
	public int deleteUser(UserVO userVO) throws SQLException {
		
		for(String userSeq : userVO.getUserSeqArray()) {
			DepVO depVO = new DepVO();
			depVO.setUpdrSeq(userVO.getUpdrSeq());
			depVO.setUserSeq(Integer.parseInt(userSeq));
			userDAO.deleteDepUser(depVO);
		}
		return userDAO.deleteUser(userVO);
	}

	@Override
	public List<UserVO> userList(PageVO page) {

		return userDAO.userList(page);
	}

	@Override
	public UserVO viewUser() {

		return userDAO.viewUser();
	}

	@Override
	public UserVO userDetail(UserVO userVOFromParam) throws SQLException {
		
		return userDAO.userDetail(userVOFromParam);
	}

	@Override
	public int getCountUser() {
		return userDAO.getCountUser();
	}

	@Override
	@Transactional
	public int recoverUserStatus(UserVO userVO) {
		
		for(String userSeq : userVO.getUserSeqArray()) {
			DepVO depVO = new DepVO();
			depVO.setUpdrSeq(userVO.getUpdrSeq());
			depVO.setUserSeq(Integer.parseInt(userSeq));
			userDAO.recoverDepUserStatus(depVO);
		}
		return userDAO.recoverUserStatus(userVO);
	}

	@Override
	public int getSearchedUserCount(PageVO page) {
		return userDAO.getSearchedUserCount(page);
	}

	@Override
	public int insertAutoLoginInfo(UserAutoLoginVO alvo) {
		return userDAO.insertAutoLoginInfo(alvo);
	}

	@Override
	public UserAutoLoginVO getCookieInfo(String cookieKey) {
		return userDAO.getCookieInfo(cookieKey);
	}

	@Override
	public int deleteCookie(String cookieKey) {
		return userDAO.deleteCookie(cookieKey);
	}

	@Override
	public int deleteCookieWhenLogin(UserAutoLoginVO alvo) {
		return userDAO.deleteCookieWhenLogin(alvo);
	}

	@Override
	public List<UserVO> getUserInfoList(UserVO userVO) throws SQLException,NullPointerException{
		return userDAO.getUserInfoList(userVO);
	}

	@Override
	public int getUserCount(UserVO userVO) {
		return userDAO.getUserCount(userVO);
	}
	
}
