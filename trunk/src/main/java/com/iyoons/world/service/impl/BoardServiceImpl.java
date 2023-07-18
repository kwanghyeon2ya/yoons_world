package com.iyoons.world.service.impl;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.iyoons.world.common.FinalVariables;
import com.iyoons.world.dao.AttachDAO;
import com.iyoons.world.dao.BoardDAO;
import com.iyoons.world.dao.CommentsDAO;
import com.iyoons.world.service.BoardService;
import com.iyoons.world.service.UserActionService;
import com.iyoons.world.vo.BoardAttachVO;
import com.iyoons.world.vo.BoardVO;
import com.iyoons.world.vo.CommentsVO;
import com.iyoons.world.vo.PageVO;
import com.iyoons.world.vo.UserActionVO;

@Service(value = "BoardService")
public class BoardServiceImpl implements BoardService {

	@Value("${realpath}")
	String REAL_PATH;
	
	@Value("${deletedpath}")
	String DELETED_FILE_PATH;
	
	
	//final String REAL_PATH= File.separator+"home"+File.separator+"yoons"+File.separator+"files"; 
	//final String DELETED_FILE_PATH=File.separator+"home"+File.separator+"yoons"+File.separator+"deletedfiles";
	 
	/*final String REAL_PATH = "C:/yoons_world/files";
	final String DELETED_FILE_PATH = "C:/yoons_world/deletedfiles";*/

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private BoardDAO dao;

	@Autowired
	private AttachDAO adao;

	@Autowired
	private CommentsDAO cdao;

	@Autowired
	private ServletContext sc;

	/*
	 * private String getFolder() { SimpleDateFormat sdf = new
	 * SimpleDateFormat("yyyy-MM-dd"); Date date = new Date(); String str =
	 * sdf.format(date); return str; }
	 */

	public int confirmFileType(String fileType) {
		int result = 0;
		String[] forbidden_extension = { "jsp", "zip", "ade", "adp", "apk", "appx", "appxbundle", "bat", "cab", "chm",
				"cmd", "com", "cpl", "diagcab", "diagcfg", "diagpack", "dll", "dmg", "ex", "ex_", "exe", "hta", "img",
				"ins", "iso", "isp", "jar", "jnlp", "js", "jse", "lib", "lnk", "mde", "msc", "msi", "msix",
				"msixbundle", "msp", "mst", "nsh", "pif", "ps1", "scr", "sct", "shb", "sys", "vb", "vbe", "vbs", "vhd",
				"vxd", "wsc", "wsf", "wsh", "xll", "%00", "0x00" };
		ArrayList<String> fileTypeArry = new ArrayList<>(Arrays.asList(forbidden_extension));
		if (fileTypeArry.indexOf(fileType) == -1) { // 발견 못 할시 -1 / 발견되면 0
			result = 1;
		}
		logger.debug("파일타입 확인 0이면 금지파일 : " + result);
		return result;
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertBoard(BoardVO vo, MultipartFile[] files, HttpServletRequest request) throws Exception { // 게시글 작성
		List<BoardAttachVO> blist = new ArrayList<>();

		int result = dao.insertBoard(vo);

		for (MultipartFile f : files) {
			if (!f.isEmpty()) {
				BoardAttachVO bavo = new BoardAttachVO();

				File uploadPath = new File(REAL_PATH);
				if (!uploadPath.exists()) {
					uploadPath.mkdir();
				}

				String uploadFileName = f.getOriginalFilename();
				logger.debug("file name : " + f.getOriginalFilename());
				String FileType = f.getContentType();
				logger.debug("file type : " + f.getContentType());
				bavo.setFileName(uploadFileName.substring(0, uploadFileName.lastIndexOf(".")));
				bavo.setFileType(FileType.split("/")[1]);
				String uuid = UUID.randomUUID().toString();

				uploadFileName = File.separator + uuid + uploadFileName;

				bavo.setPostSeq(vo.getPostSeq());
				bavo.setFileUuid(uuid);
				bavo.setFileSize(f.getSize());
				bavo.setFilePath(REAL_PATH);
				bavo.setRegrSeq(vo.getRegrSeq());

				try {
					int fileLength = f.getOriginalFilename().length();
					int fileLastIndex = f.getOriginalFilename().lastIndexOf('.');
					logger.debug("파일 타입 확인 : " + f.getOriginalFilename().substring(fileLastIndex + 1, fileLength));

					int fileCheck = confirmFileType(f.getOriginalFilename().substring(fileLastIndex + 1, fileLength));// 파일
																														// 타입
																														// 확인

					logger.debug("fileCheck : " + fileCheck);
					if (fileCheck == 0) {
						logger.debug("serviceImpl fileType 오류 발생");
						throw new Exception("forbidden_file_type");
					}

					if (bavo.getFileSize() > 1000000) {
						throw new Exception("over_the_file_size");
					}

					String savePath = REAL_PATH + uploadFileName;
					logger.debug("savePath : "+savePath);
					File saveFile = new File(savePath);

					f.transferTo(saveFile);
					blist.add(bavo);

					/*
					 * int i =+ 1; //예외처리 실험용
					 * 
					 * 
					 * /*if(i < 2) { //예외처리 실험용 throw new Exception(); }
					 */
				} catch (Exception e) {

					logger.debug("파일처리 catch 진입");
					for (BoardAttachVO avo : blist) {
						String path = avo.getFilePath() + File.separator + avo.getFileUuid() + avo.getFileName() + "."
								+ avo.getFileType();
						File file = new File(path);
						file.delete();
					}

					logger.error("저장소의 첨부파일 삭제 후 controller로 예외 되던짐 ");
					logger.debug("에러메시지 service: " + e.getMessage());
					throw new Exception(e);
				}

			}
		}

		if (blist.size() > 0) {
			logger.debug("글작성 첨부파일 확인 : " + blist.toString());
			for (BoardAttachVO attach : blist) {
				adao.insertAttach(attach);
			}
		}

		return result;
	}


	@Override
	public List<BoardVO> getBoardList( // 게시글 리스트 불러오기
			String search, String keyword, String searchCheck, int startRow, int endRow, String boardType)
			throws Exception {

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("keyword", keyword);
		map.put("searchCheck", searchCheck);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("boardType", boardType);
		return dao.getBoardList(map);
	}

	@Override
	public int getBoardCount(String boardType) throws Exception { // 게시글의 총 갯수
		return dao.getBoardCount(boardType);
	}

	@Override
	public int getSearchCount(BoardVO boardVO, PageVO pageVO) throws Exception { // 글 검색 후 검색된 글의 총 갯수

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("search", boardVO.getSearch());
		map.put("keyword", boardVO.getKeyword());
		map.put("searchCheck", boardVO.getKeyword());
		map.put("startRow", pageVO.getStartRow());
		map.put("endRow", pageVO.getEndRow());
		map.put("boardType", boardVO.getBoardType());
		return dao.getSearchCount(map);
	}

	@Override
	public int getSearchCount(String search, String keyword, String searchCheck, int startRow, int endRow,
			String boardType) throws Exception { // 글 검색 후 검색된 글의 총 갯수

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("keyword", keyword);
		map.put("searchCheck", searchCheck);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("boardType", boardType);
		return dao.getSearchCount(map);
	}

	@Override
	public BoardVO getView(int postSeq) throws Exception { // 게시글 읽기
		return dao.getView(postSeq);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int modView(BoardVO vo, MultipartFile[] files) throws Exception { // 게시글 수정
		/* List<BoardAttachVO> blist = new ArrayList<>(); */
		List<BoardAttachVO> blist = new ArrayList<>();

		for (MultipartFile f : files) {
			if (!f.isEmpty()) {
				BoardAttachVO bavo = new BoardAttachVO();
				try {
					File uploadPath = new File(REAL_PATH);
					if (!uploadPath.exists()) {
						uploadPath.mkdir();
					}

					String uploadFileName = f.getOriginalFilename();
					logger.debug("file name : " + f.getOriginalFilename());
					bavo.setFileName(uploadFileName.substring(0, uploadFileName.lastIndexOf(".")));
					String fileType = f.getContentType();
					bavo.setFileType(fileType.split("/")[1]);
					logger.debug("file type : " + f.getContentType());
					String uuid = UUID.randomUUID().toString();
					bavo.setFileSize(f.getSize());
					bavo.setFileUuid(uuid);
					bavo.setPostSeq(vo.getPostSeq());
					bavo.setFilePath(REAL_PATH);
					bavo.setUpdrSeq(vo.getUpdrSeq());
					bavo.setRegrSeq(vo.getRegrSeq());

					int fileLength = f.getOriginalFilename().length();
					int fileLastIndex = f.getOriginalFilename().lastIndexOf('.');
					logger.debug("파일 타입 확인 : " + f.getOriginalFilename().substring(fileLastIndex + 1, fileLength));

					int fileCheck = confirmFileType(f.getOriginalFilename().substring(fileLastIndex + 1, fileLength));

					logger.debug("fileCheck : " + fileCheck);
					if (fileCheck == 0) {
						logger.debug("serviceImpl fileType 오류 발생");
						throw new Exception("forbidden_file_type");
					}
					if (bavo.getFileSize() > 1000000) {
						throw new Exception("over_the_file_size");
					}

					uploadFileName = File.separator + uuid + uploadFileName;

					f.transferTo(new File(REAL_PATH + uploadFileName));
					blist.add(bavo);
				} catch (Exception e) {

					logger.debug("파일처리 catch 진입");
					for (BoardAttachVO avo : blist) {
						String path = avo.getFilePath() + File.separator + avo.getFileUuid() + avo.getFileName() + "."
								+ avo.getFileType();
						File file = new File(path);
						file.delete();
					}

					logger.error("저장소의 첨부파일 삭제 후 controller로 예외 되던짐 ");
					logger.debug("에러메시지 : " + e.getMessage());
					throw new Exception(e);
				}
			}
		}

		if (blist.size() > 0) {
			logger.debug("글작성 첨부파일 확인 : " + blist.toString());
			for (BoardAttachVO attach : blist) {
				adao.insertAttach(attach);
			}
		}

		/*
		 * File f = new File(originalFilePath); //기존 파일 위치+저장된 파일이름 File df = new
		 * File(newFilePath); //새 파일 위치+옮길 파일이름
		 */

		if (vo.getFileUuidArray() != null) {
			if (vo.getFileUuidArray().length != 0) {
				for (String file : vo.getFileUuidArray()) {
					BoardVO vo2 = new BoardVO();

					vo2.setPostSeq(vo.getPostSeq());
					vo2.setUpdrSeq(vo.getUpdrSeq());
					vo2.setFileUuid(file);

					BoardAttachVO avo = adao.getSeletedAttach(vo2);

					String originalFilePath = avo.getFilePath() + File.separator + avo.getFileUuid() + avo.getFileName()
							+ "." + avo.getFileType();
					String newFilePath = DELETED_FILE_PATH + File.separator + avo.getFileUuid() + avo.getFileName()
							+ "." + avo.getFileType();

					File f = FileUtils.getFile(originalFilePath);
					File df = FileUtils.getFile(newFilePath);

					FileUtils.moveFile(f, df);
					logger.debug("view 수정페이지 삭제 진입확인");
					adao.deleteSelectedAttach(vo2);
					logger.debug("view 수정페이지 삭제 처리 완료 확인");
				}
			}
		}

		int attachCount = adao.getAttachCount(vo.getPostSeq()); // 첨부파일 카운트
		if (attachCount != 0) { // 카운트 확인 후 post_board에 첨부파일 여부 컬럼 입력
			vo.setFileAttachYn("Y");
		} else {
			vo.setFileAttachYn("N");
		}
		return dao.modView(vo);
	}

	@Override
	public void updateCnt(int postSeq){ // 게시글 조회수 업데이트
		dao.updateCnt(postSeq); // 글 조회수 올리기
	}

	@Transactional
	@Override
	public int delView(BoardVO vo) throws Exception { // 게시글 삭제
		/*
		 * List<BoardAttachVO> list = adao.getAttachList(vo.getPostSeq()); //물리경로 보존위해
		 * 주석 System.out.println(vo);
		 */
//		for(BoardAttachVO avo : list) { 
//			String path = avo.getFilePath()+File.separator+avo.getFileUuid()+avo.getFileName()+"."+avo.getFileType();
//			File f = new File(path);
//			f.delete();
//		}

		CommentsVO cvo = new CommentsVO();

		cvo.setPostSeq(vo.getPostSeq());
		cvo.setUpdrSeq(vo.getUpdrSeq());

		cdao.delAllCommentsByPostSeq(cvo);

		List<BoardAttachVO> alist = adao.getAttachList(vo.getPostSeq());
		for (BoardAttachVO avo : alist) {

			String originalFilePath = avo.getFilePath() + File.separator + avo.getFileUuid() + avo.getFileName() + "."
					+ avo.getFileType();
			String newFilePath = DELETED_FILE_PATH + File.separator + avo.getFileUuid() + avo.getFileName() + "."
					+ avo.getFileType();

			File f = FileUtils.getFile(originalFilePath);
			File df = FileUtils.getFile(newFilePath);

			/*
			 * File f = new File(originalFilePath); //기존 파일 위치+저장된 파일이름 File df = new
			 * File(newFilePath); //새 파일 위치+옮길 파일이름
			 */
			FileUtils.moveFile(f, df);
		}

		adao.delAttach(vo);
//		FileUtils.moveFile(f,new File(DELETED_FILE_PATH));

		return dao.delView(vo);
	}

	public int findUser(int regrSeq) throws Exception {// 입력받은 유저 db검색
		return dao.findUser(regrSeq);
	}

	@Override
	public List<BoardVO> getNoticeFixedBoard(String boardType) throws Exception {
		return dao.getNoticeFixedBoard(boardType);
	}

	@Override
	public List<BoardVO> getAllBoardListOrderedByReadCount(int startRow, int endRow) throws Exception {
		return dao.getAllBoardListOrderedByReadCount(startRow, endRow);
	}

	@Override
	public int getAllBoardCount() throws Exception {
		return dao.getAllBoardCount();
	}

	@Override
	public List<BoardVO> getAllBoardListOrderedByReadCountForMonth(int startRow, int endRow) throws Exception {
		return dao.getAllBoardListOrderedByReadCountForMonth(startRow, endRow);
	}

	@Override
	public BoardVO getListForMain() throws Exception { // 메인페이지 게시판 리스트

		HashMap<String, Object> freeMap = new HashMap<>();
		BoardVO vo = new BoardVO();

		freeMap.put("search", "");
		freeMap.put("keyword", "");
		freeMap.put("searchCheck", null);
		freeMap.put("startRow", 1);
		freeMap.put("endRow", 5);
		freeMap.put("boardType", '0');
		vo.setFreeBoardList(dao.getBoardList(freeMap)); // 자유게시판

		vo.setFixedBoardList(dao.getNoticeFixedBoard("1")); // 공지사항게시판 고정글

		HashMap<String, Object> noticeMap = new HashMap<>();

		noticeMap.put("search", "");
		noticeMap.put("keyword", "");
		noticeMap.put("searchCheck", null);
		noticeMap.put("startRow", 1);
		noticeMap.put("endRow", 5);
		noticeMap.put("boardType", '1');
		vo.setNoticeBoardList(dao.getBoardList(noticeMap)); // 공지사항게시판

		HashMap<String, Object> pdsMap = new HashMap<>();

		pdsMap.put("search", "");
		pdsMap.put("keyword", "");
		pdsMap.put("searchCheck", null);
		pdsMap.put("startRow", 1);
		pdsMap.put("endRow", 5);
		pdsMap.put("boardType", '2');
		vo.setPdsBoardList(dao.getBoardList(pdsMap)); // 자료실게시판

		return vo;
	}


	@Override
	public List<BoardVO> getBoardList( // 게시판 타입에 따른 게시글 리스트 가져오기
			BoardVO boardVO, PageVO pageVO) throws Exception {

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("search", boardVO.getSearch());
		map.put("keyword", boardVO.getKeyword());
		map.put("searchCheck", boardVO.getKeyword());
		map.put("startRow", pageVO.getStartRow());
		map.put("endRow", pageVO.getEndRow());
		map.put("boardType", boardVO.getBoardType());
		return dao.getBoardList(map);
	}

	@Override
	public List<BoardVO> getMyListByLike(BoardVO boardVO,PageVO pageVO) {//내가 좋아요 누른 게시글 리스트 가져오기
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("userSeq",boardVO.getUserSeq());
		map.put("startRow",pageVO.getStartRow());
		map.put("endRow",pageVO.getEndRow());
		return dao.getMyListByLike(map);
	}

	@Override
	public List<BoardVO> getMyListByComments(BoardVO boardVO,PageVO pageVO) {//내가 작성한 댓글의 게시글 리스트 가져오기
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("userSeq",boardVO.getUserSeq());
		map.put("startRow",pageVO.getStartRow());
		map.put("endRow",pageVO.getEndRow());
		return dao.getMyListByComments(map);
	}

	@Override
	public List<BoardVO> getMyBoardList(BoardVO boardVO,PageVO pageVO) {//내가 작성한 게시글 리스트 가져오기
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("userSeq",boardVO.getUserSeq());
		map.put("startRow",pageVO.getStartRow());
		map.put("endRow",pageVO.getEndRow());
		return dao.getMyBoardList(map);
	}

	@Override
	public int getMyListByLikeCnt(int userSeq) {
		return dao.getMyListByLikeCnt(userSeq);
	}

	@Override
	public int getMyListByCommentsCnt(int userSeq) {
		return dao.getMyListByCommentsCnt(userSeq);
	}

	@Override
	public int getMyBoardListCnt(int userSeq) {
		return dao.getMyBoardListCnt(userSeq);
	}

	
	
	
	/*@Override
	public int increasingHeart(BoardVO vo) throws Exception { // 좋아요 입력

		UserActionVO uavo = new UserActionVO();
		uavo.setUserSeq(vo.getUserSeq());
		uavo.setTargetType(FinalVariables.TARGET_BOARD);
		uavo.setTargetSeq(vo.getPostSeq());
		uavo.setActionType(FinalVariables.ACTION_TYPE_LIKE);

		return dao.insertUserAction(uavo);
	}*/

	/*
	 * @Override public int checkHeart(BoardVO vo) throws Exception {
	 * 
	 * UserActionVO uavo = new UserActionVO(); uavo.setUserSeq(vo.getUserSeq());
	 * uavo.setTargetSeq(vo.getPostSeq()); //
	 * uavo.setTargetType(FinalVariables.TARGET_BOARD);
	 * uavo.setTargetType(FinalVariables.TARGET_BOARD);
	 * uavo.setActionType(FinalVariables.ACTION_TYPE_LIKE); return
	 * dao.checkUserAction(uavo); }
	 * 
	 * @Override public int checkView(BoardVO vo) throws Exception {
	 * 
	 * UserActionVO uavo = new UserActionVO(); uavo.setUserSeq(vo.getUserSeq());
	 * uavo.setTargetSeq(vo.getPostSeq()); //
	 * uavo.setTargetType(FinalVariables.TARGET_BOARD);
	 * uavo.setTargetType(FinalVariables.TARGET_BOARD);
	 * uavo.setActionType(FinalVariables.ACTION_TYPE_VIEWCOUNT); return
	 * dao.checkUserAction(uavo); }
	 */


	/*@Override
	public List<UserActionVO> checkAction(BoardVO vo) {
		return dao.checkAction(vo);
	}*/

	/*@Override
	public int checkView(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}*/
/*
	@Override
	public int insertUserAction(BoardVO vo) {
		UserActionVO uavo = new UserActionVO();
		uavo.setUserSeq(vo.getUserSeq());
		uavo.setTargetSeq(vo.getPostSeq());
//		uavo.setTargetType(FinalVariables.TARGET_BOARD);
		uavo.setTargetType(FinalVariables.TARGET_BOARD);
		uavo.setActionType(FinalVariables.ACTION_TYPE_VIEWCOUNT);
		dao.insertUserAction(uavo); // 조회 이력 쌓기
		return dao.insertUserAction(uavo);
	}

	@Override
	public int getViewCount(int postSeq) {
		return dao.getViewCount(postSeq);
	}

	@Override
	public BoardVO beforeViewCheck(BoardVO vo) {
		
		return null;
	}
*/
	
}
