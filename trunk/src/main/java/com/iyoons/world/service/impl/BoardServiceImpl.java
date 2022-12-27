package com.iyoons.world.service.impl;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.iyoons.world.common.FinalVariables;
import com.iyoons.world.dao.AttachDAO;
import com.iyoons.world.dao.BoardDAO;
import com.iyoons.world.dao.CommentsDAO;
import com.iyoons.world.service.BoardService;
import com.iyoons.world.vo.BoardAttachVO;
import com.iyoons.world.vo.BoardVO;
import com.iyoons.world.vo.CommentsVO;
import com.iyoons.world.vo.UserActionVO;

@Service(value = "BoardService")
public class BoardServiceImpl implements BoardService {

	/*final String REAL_PATH= File.separator+"home"+File.separator+"yoons"+File.separator+"files";
	final String DELETED_FILE_PATH=File.separator+"home"+File.separator+"yoons"+File.separator+"deletedfiles";*/
	final String REAL_PATH="C:/yoons_world/files";
	final String DELETED_FILE_PATH="C:/yoons_world/deletedfiles";
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private BoardDAO dao;

	@Autowired
	private AttachDAO adao;
	
	@Autowired
	private CommentsDAO cdao;
	
	@Autowired
	private ServletContext sc;

	/*private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str;
	}*/
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertBoard(BoardVO vo,MultipartFile[] files,HttpServletRequest request)throws Exception { //게시글 작성
		List<BoardAttachVO> blist = new ArrayList<>();
		
		int result = dao.insertBoard(vo);
		
		for(MultipartFile f : files) {
			if(!f.isEmpty()) {
				BoardAttachVO bavo = new BoardAttachVO();
				
				File uploadPath = new File(REAL_PATH);
				if(!uploadPath.exists()) {
					uploadPath.mkdir();
				}
					
				String uploadFileName = f.getOriginalFilename();
				String FileType = f.getContentType(); 
				bavo.setFileName(uploadFileName.substring(0,uploadFileName.lastIndexOf(".")));
				bavo.setFileType(FileType.split("/")[1]);
				String uuid = UUID.randomUUID().toString();
				
				uploadFileName = File.separator + uuid + uploadFileName;
				
				bavo.setPostSeq(vo.getPostSeq());
				bavo.setFileUuid(uuid);
				bavo.setFileSize(f.getSize());
				bavo.setFilePath(REAL_PATH);
				bavo.setRegrSeq(vo.getRegrSeq());
				
				String savePath = REAL_PATH + uploadFileName;
					
				File saveFile = new File(savePath);
				
				/*int i =+ 1; 예외 실험용*/
				
				try {
					
					f.transferTo(saveFile);
					blist.add(bavo);
					
				} catch (Exception e) {
					
					logger.debug("파일처리 catch 진입");
						for(BoardAttachVO avo : blist) { 
							String path = avo.getFilePath()+File.separator+avo.getFileUuid()+avo.getFileName()+"."+avo.getFileType();
							File file = new File(path);
							file.delete();
						}
						
					logger.error("저장소의 첨부파일 삭제 후 controller로 예외 되던짐 ");
					throw e;
				} 
				
				
			}
		}
		
		if(blist.size() > 0) {
			for(BoardAttachVO attach : blist) {
				adao.insertAttach(attach);
			}
		}
			
			return result;
	}

	@Override
	public List<BoardVO> getBoardList(  //게시글 리스트 불러오기
			String search,
			String keyword,
			String searchCheck,
			int startRow,
			int endRow,
			String boardType) throws Exception {
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("search",search);
		map.put("keyword",keyword);
		map.put("searchCheck",searchCheck);
		map.put("startRow",startRow);
		map.put("endRow",endRow);
		map.put("boardType",boardType);
		return dao.getBoardList(map);
	}

	@Override
	public int getBoardCount(String boardType) throws Exception { //게시글의 총 갯수
		return dao.getBoardCount(boardType);
	}

	@Override
	public int getSearchCount(String search, 
			String keyword, 
			String searchCheck, 
			int startRow, 
			int endRow,
			String boardType) throws Exception { //글 검색 후 검색된 글의 총 갯수
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("search",search);
		map.put("keyword",keyword);
		map.put("searchCheck",searchCheck);
		map.put("startRow",startRow);
		map.put("endRow",endRow);
		map.put("boardType",boardType);
		return dao.getSearchCount(map);
	}

	@Override
	public BoardVO getView(int postSeq) throws Exception { //게시글 읽기
		return dao.getView(postSeq);
	}

	@Override
	@Transactional
	public int modView(BoardVO vo,MultipartFile[] files) throws Exception { //게시글 수정
/*		List<BoardAttachVO> blist = new ArrayList<>();*/	
	
		
	for(MultipartFile f : files){
			if(!f.isEmpty()) {
				BoardAttachVO bavo = new BoardAttachVO();
				
				File uploadPath = new File(REAL_PATH);
				if(!uploadPath.exists()) {
					uploadPath.mkdir();
				}
				
				String uploadFileName = f.getOriginalFilename();
				bavo.setFileName(uploadFileName.substring(0,uploadFileName.lastIndexOf(".")));
				String fileType = f.getContentType();
				bavo.setFileType(fileType.split("/")[1]);
				String uuid = UUID.randomUUID().toString();
				bavo.setFileSize(f.getSize());
				bavo.setFileUuid(uuid);
				bavo.setPostSeq(vo.getPostSeq());
				bavo.setFilePath(REAL_PATH);
				bavo.setUpdrSeq(vo.getUpdrSeq());
				bavo.setRegrSeq(vo.getRegrSeq());
				
				uploadFileName = File.separator + uuid + uploadFileName;
				
				f.transferTo(new File(REAL_PATH + uploadFileName));
				adao.insertAttach(bavo);
			}
		}
	
		
			
			/*File f = new File(originalFilePath); //기존 파일 위치+저장된 파일이름
			File df = new File(newFilePath); //새 파일 위치+옮길 파일이름
	*/		
		
		if(vo.getFileUuidArray() != null) { 
			if(vo.getFileUuidArray().length != 0) {
				for(String file : vo.getFileUuidArray()) {
					BoardVO vo2 = new BoardVO();
					
					vo2.setPostSeq(vo.getPostSeq());
					vo2.setUpdrSeq(vo.getUpdrSeq());
					vo2.setFileUuid(file);
					
					BoardAttachVO avo = adao.getSeletedAttach(vo2);
					
					String originalFilePath = avo.getFilePath()+File.separator+avo.getFileUuid()+avo.getFileName()+"."+avo.getFileType();
					String newFilePath = DELETED_FILE_PATH+File.separator+avo.getFileUuid()+avo.getFileName()+"."+avo.getFileType();
					
					File f = FileUtils.getFile(originalFilePath);
					File df = FileUtils.getFile(newFilePath);
					
					FileUtils.moveFile(f, df);
					logger.debug("view 수정페이지 삭제 진입확인");
					adao.deleteSelectedAttach(vo2);
					logger.debug("view 수정페이지 삭제 처리 완료 확인");
				}
			}
		}
		
		int attachCount = adao.getAttachCount(vo.getPostSeq()); //첨부파일 카운트
		if(attachCount != 0) { //카운트 확인 후 post_board에 첨부파일 여부 컬럼 입력
			vo.setFileAttachYn("Y");
		}else {
			vo.setFileAttachYn("N");
		}
		return dao.modView(vo);
	}
	@Override
	public void updateCnt(int postSeq) throws Exception { //게시글 조회수 업데이트
		dao.updateCnt(postSeq);
	}
	
	
	@Transactional
	@Override
	public int delView(BoardVO vo) throws Exception { //게시글 삭제
		/*List<BoardAttachVO> list = adao.getAttachList(vo.getPostSeq()); //물리경로 보존위해 주석
		System.out.println(vo);*/
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
		for(BoardAttachVO avo : alist) {
			
			String originalFilePath = avo.getFilePath()+File.separator+avo.getFileUuid()+avo.getFileName()+"."+avo.getFileType();
			String newFilePath = DELETED_FILE_PATH+File.separator+avo.getFileUuid()+avo.getFileName()+"."+avo.getFileType();
				
			File f = FileUtils.getFile(originalFilePath);
			File df = FileUtils.getFile(newFilePath);
			
			/*File f = new File(originalFilePath); //기존 파일 위치+저장된 파일이름
			File df = new File(newFilePath); //새 파일 위치+옮길 파일이름*/		
			FileUtils.moveFile(f, df);
		}
		
		adao.delAttach(vo);
//		FileUtils.moveFile(f,new File(DELETED_FILE_PATH));
		
		return dao.delView(vo);
	}
	public int findUser(int regrSeq) throws Exception {//입력받은 유저 db검색
		return dao.findUser(regrSeq);
	}

	@Override
	public List<BoardVO> getNoticeFixedBoard(String boardType) throws Exception {
		return dao.getNoticeFixedBoard(boardType);
	}

	@Override
	public List<BoardVO> getAllBoardListOrderedByReadCount(int startRow,int endRow) throws Exception {
		return dao.getAllBoardListOrderedByReadCount(startRow,endRow);
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
		
		HashMap<String,Object> freeMap = new HashMap<>();
		BoardVO vo = new BoardVO();
		
		freeMap.put("search","");
		freeMap.put("keyword","");
		freeMap.put("searchCheck",null);
		freeMap.put("startRow",1);
		freeMap.put("endRow",5);
		freeMap.put("boardType",'0');
		vo.setFreeBoardList(dao.getBoardList(freeMap)); // 자유게시판
		
		vo.setFixedBoardList(dao.getNoticeFixedBoard("1")); // 공지사항게시판 고정글
		
		HashMap<String,Object> noticeMap = new HashMap<>();
		
		noticeMap.put("search","");
		noticeMap.put("keyword","");
		noticeMap.put("searchCheck",null);
		noticeMap.put("startRow",1);
		noticeMap.put("endRow",5);
		noticeMap.put("boardType",'1');
		vo.setNoticeBoardList(dao.getBoardList(noticeMap)); // 공지사항게시판
		
		HashMap<String,Object> pdsMap = new HashMap<>();
		
		pdsMap.put("search","");
		pdsMap.put("keyword","");
		pdsMap.put("searchCheck",null);
		pdsMap.put("startRow",1);
		pdsMap.put("endRow",5);
		pdsMap.put("boardType",'2');
		vo.setPdsBoardList(dao.getBoardList(pdsMap)); // 자료실게시판
		
		return vo;
	}

	@Override
	public int increasingHeart(BoardVO vo) throws Exception { // 좋아요 입력
		
		UserActionVO uavo = new UserActionVO();
		uavo.setUserSeq(vo.getUserSeq());
		uavo.setTargetType(FinalVariables.TARGET_BOARD);
		uavo.setTargetSeq(vo.getPostSeq());
		uavo.setActionType(FinalVariables.ACTION_TYPE_LIKE);
		
		return dao.increasingHeart(uavo);
	}

	@Override
	public int checkHeart(BoardVO vo) throws Exception {
		
		UserActionVO uavo = new UserActionVO();
		uavo.setUserSeq(vo.getUserSeq());
		uavo.setTargetSeq(vo.getPostSeq());
//		uavo.setTargetType(FinalVariables.TARGET_BOARD);
		uavo.setTargetType(FinalVariables.TARGET_BOARD);
		uavo.setActionType(FinalVariables.ACTION_TYPE_LIKE);
		return dao.checkHeart(uavo);
	}

	@Override
	public int getHeartCount(BoardVO vo) throws Exception {
		
		UserActionVO uavo = new UserActionVO();
		uavo.setTargetSeq(vo.getPostSeq());
		uavo.setTargetType(FinalVariables.TARGET_BOARD);
		uavo.setActionType(FinalVariables.ACTION_TYPE_LIKE);
		return dao.getHeartCount(uavo);
	}
}
