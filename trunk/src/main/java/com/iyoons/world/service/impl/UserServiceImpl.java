package com.iyoons.world.service.impl;

import java.io.File;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

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
	
	final String REAL_PATH= File.separator+"home"+File.separator+"yoons"+File.separator+"profile";
	final String DELETED_FILE_PATH=File.separator+"home"+File.separator+"yoons"+File.separator+"deletedprofile";
	/*final String REAL_PATH="C:/yoons_world/profile";
	final String DELETED_FILE_PATH="C:/yoons_world/deletedprofile";*/
	

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
	@Transactional(rollbackFor = {Exception.class})
	public int insertUser(UserVO userVO) throws Exception {
		DepVO depVO = new DepVO();
		
		if("self_writing".equals(userVO.getEmailPart2())) {
			userVO.setEmail(userVO.getEmailPart1());
		}else {
			userVO.setEmail(userVO.getEmailPart1()+"@"+userVO.getEmailPart2());
		}
		
		userVO.setPhone(userVO.getPhone1()+"-"+userVO.getPhone2()+"-"+userVO.getPhone3());
		logger.debug("userVO 번호확인 : "+userVO.getPhone());
		userVO.setUserPw(getHashPw(userVO));
		
		int result = userDAO.insertUser(userVO);
		logger.debug("transactional 실험중(에러 전)");
		depVO.setDepSeq(userVO.getDepSeq());
		depVO.setUserSeq(userVO.getUserSeq());
		depVO.setRegrSeq(userVO.getRegrSeq());
		
		userDAO.insertDepUser(depVO);
		logger.debug("transactional 실험중(에러 후)");
		
		return result;
	}

	@Override
	@Transactional(rollbackFor = {Exception.class})
	public int updateUser(UserVO userVO) throws Exception {
		
		if("self_writing".equals(userVO.getEmailPart2())) {
			userVO.setEmail(userVO.getEmailPart1());
		}else {
			userVO.setEmail(userVO.getEmailPart1()+"@"+userVO.getEmailPart2());
		}
		
		userVO.setPhone(userVO.getPhone1()+"-"+userVO.getPhone2()+"-"+userVO.getPhone3());
		
		userVO.setUserPw(getHashPw(userVO));
		
		int result = userDAO.updateUser(userVO);
		
		DepVO depVO = new DepVO();
		depVO.setUserSeq(userVO.getUserSeq());
		depVO.setDepSeq(userVO.getDepSeq());
		depVO.setUpdrSeq(userVO.getUpdrSeq());
		
		logger.debug("UpdateUser userServiceImpl depVO : "+depVO);
		
		int depResult = userDAO.updateDepUser(depVO);
		
		logger.debug("UpdateUser userServiceImpl dep_user업데이트 확인  1 - 성공 : "+depResult);
		
		return result;
	}

	@Override
	@Transactional(rollbackFor = {Exception.class})
	public int deleteUser(UserVO userVO) throws Exception {
		
		DepVO depVO = new DepVO();
		depVO.setUpdrSeq(userVO.getUpdrSeq());
		depVO.setUserSeqArray(userVO.getUserSeqArray());
		
		userDAO.deleteDepUser(depVO);
		return userDAO.deleteUser(userVO);
	}

	@Override
	public List<UserVO> userList(PageVO page) throws Exception {

		return userDAO.userList(page);
	}

	@Override
	public UserVO viewUser() throws Exception {

		return userDAO.viewUser();
	}

	@Override
	public UserVO userDetail(UserVO userVOFromParam) throws Exception {
		
		return userDAO.userDetail(userVOFromParam);
	}

	@Override
	public int getCountUser() throws Exception {
		return userDAO.getCountUser();
	}

	@Override
	@Transactional(rollbackFor = {Exception.class})
	public int recoverUserStatus(UserVO userVO) throws Exception {
		
		for(String userSeq : userVO.getUserSeqArray()) {
			DepVO depVO = new DepVO();
			depVO.setUpdrSeq(userVO.getUpdrSeq());
			depVO.setUserSeq(Integer.parseInt(userSeq));
			userDAO.recoverDepUserStatus(depVO);
		}
		return userDAO.recoverUserStatus(userVO);
	}

	@Override
	public int getSearchedUserCount(PageVO page) throws Exception {
		return userDAO.getSearchedUserCount(page);
	}

	@Override
	public int insertAutoLoginInfo(UserAutoLoginVO alvo) throws Exception {
		return userDAO.insertAutoLoginInfo(alvo);
	}

	@Override
	public UserAutoLoginVO getCookieInfo(String cookieKey) throws Exception {
		return userDAO.getCookieInfo(cookieKey);
	}

	@Override
	public int deleteCookie(String cookieKey) throws Exception {
		return userDAO.deleteCookie(cookieKey);
	}

	@Override
	public int deleteCookieWhenLogin(UserAutoLoginVO alvo) throws Exception {
		return userDAO.deleteCookieWhenLogin(alvo);
	}

	@Override
	public List<UserVO> getUserInfoList(UserVO userVO) throws Exception{
		return userDAO.getUserInfoList(userVO);
	}

	@Override
	public int getUserCount(UserVO userVO) throws Exception {
		return userDAO.getUserCount(userVO);
	}

	@Override
	public int updateLoginDt(int userSeq) {
		return userDAO.updateLoginDt(userSeq);
	}

	@Override
	public int changePw(UserVO userVO) throws NoSuchAlgorithmException {
		userVO.setUserPw(userVO.getChangeUserPw());
		userVO.setUserPw(getHashPw(userVO));
		return userDAO.changePw(userVO);
	}

	@Override
	public int checkPw(UserVO userVO) throws NoSuchAlgorithmException {
		userVO.setUserPw(getHashPw(userVO));
		return userDAO.checkPw(userVO);
	}

	@Override
	public int getPwConfirmNum(int userSeq) {
		return userDAO.getPwConfirmNum(userSeq);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int updateMypage(UserVO userVO,MultipartFile multifile)throws Exception {
		int result = 0;
		
		/*
		 * 확장자 체크
		 * */
		int fileLength = multifile.getOriginalFilename().length();
		int fileLastIndex = multifile.getOriginalFilename().lastIndexOf('.');
		logger.debug("파일 타입 확인 : " + multifile.getOriginalFilename().substring(fileLastIndex + 1, fileLength));

		String fileCheck = multifile.getOriginalFilename().substring(fileLastIndex + 1, fileLength).toLowerCase();// 파일
		
		String[] allowedFileType = {"jpg","png","gif"};
		ArrayList<String> fileTypeArry = new ArrayList<>(Arrays.asList(allowedFileType));
		if(fileTypeArry.indexOf(fileCheck) == -1) { // 파일 타입이 jpg,png,gif확장자가 아닐 때 타입오류 발생시킴
			throw new Exception("forbidden_file_type");
		}
		
		userVO.setUpdrSeq(userVO.getUserSeq());
		UserVO picVO = userDAO.getPicture(userVO); // 기존 프로필사진 불러오기  
		
		logger.debug("서비스 진입 로그");
		
		if(picVO != null) {
			if(picVO.getPicture() != null) {//프로필 사진이 존재한다면
				
				File f = FileUtils.getFile(picVO.getPicturePath()+File.separator+picVO.getPicture());//현재저장폴더
				File df = FileUtils.getFile(DELETED_FILE_PATH+File.separator+picVO.getPicture());//삭제폴더이동
				FileUtils.moveFile(f, df);
			}
		}
		
		if (multifile.getSize() > 1000000) {
			throw new Exception("over_the_file_size");
		}
		
		
		logger.debug("기존파일 삭제전 로그");
		logger.debug("multifile : "+multifile);
		logger.debug("파일 이름 : "+multifile.getName());
		if(!multifile.isEmpty()) { // 기존파일 삭제폴더 이동후 파일등록  // 경로까지 저장할 필요가 있는가? 
			
			logger.debug("");
			
			String uploadFileName = multifile.getOriginalFilename();
			
			userVO.setPicturePath(REAL_PATH);
			logger.debug("file name : "+multifile.getOriginalFilename());
			
			String uuid = UUID.randomUUID().toString();
			
			userVO.setPicture(uuid + uploadFileName);
			
			uploadFileName = REAL_PATH + File.separator + uuid + uploadFileName; 
			
			File saveFile = new File(uploadFileName);
		
			try {
				
				if(!saveFile.exists()) {
					saveFile.mkdir();
				}
				
				multifile.transferTo(saveFile);
				userVO.setUpdrSeq(userVO.getUserSeq());
				
				result = userDAO.updateMypage(userVO);
	
				
			} catch (Exception e) {
				/*File file = new File(uploadFileName);
				file.delete();
				logger.error("저장소의 첨부파일 삭제 후 controller로 예외 되던짐 ");*/
				logger.debug("에러메시지 service: "+e.getMessage());
				throw new Exception(e);
			}
		
		}else {// 프로필사진 null입력시
			userVO.setPicture(null);
			userVO.setPicturePath(null);
			result = userDAO.updateMypage(userVO);
		}
		return result;
	}

	@Override
	public UserVO getPicture(UserVO userVO) {
		return userDAO.getPicture(userVO);
	}
	
}
