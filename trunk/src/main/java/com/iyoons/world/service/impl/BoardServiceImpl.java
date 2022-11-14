package com.iyoons.world.service.impl;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.FileUtils;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.iyoons.world.dao.AttachDAO;
import com.iyoons.world.dao.BoardDAO;
import com.iyoons.world.dao.CommentsDAO;
import com.iyoons.world.service.BoardService;
import com.iyoons.world.vo.BoardAttachVO;
import com.iyoons.world.vo.BoardVO;
import com.iyoons.world.vo.CommentsVO;

@Service(value = "BoardService")
public class BoardServiceImpl implements BoardService {

	/*final String REAL_PATH= File.separator+"home"+File.separator+"yoons"+File.separator+"files";
	final String DELETED_FILE_PATH=File.separator+"home"+File.separator+"yoons"+File.separator+"deletedfiles";*/
	final String REAL_PATH="C:/yoons_world/files";
	final String DELETED_FILE_PATH="C:/yoons_world/deletedfiles";
	
	
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
	
	@Transactional
	@Override
	public int insertBoard(BoardVO vo,MultipartFile[] files) { //게시글 작성
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
				
				try {
					
				File saveFile = new File(savePath);
				f.transferTo(saveFile); 
				
				blist.add(bavo);
				
				}catch(Exception e) {
					e.printStackTrace();
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
	public List<BoardVO> getBoardList( //게시글 리스트 불러오기
			String search,
			String keyword,
			String searchCheck,
			int startRow,
			int endRow,
			String boardType) {
		
		System.out.println("서비스");
		
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
	public int getBoardCount(String boardType) { //게시글의 총 갯수
		return dao.getBoardCount(boardType);
	}

	@Override
	public int getSearchCount(String search, 
			String keyword, 
			String searchCheck, 
			int startRow, 
			int endRow,
			String boardType) { //글 검색 후 검색된 글의 총 갯수
		
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
	public BoardVO getView(int postSeq) { //게시글 읽기
		return dao.getView(postSeq);
	}

	@Override
	@Transactional
	public int modView(BoardVO vo,MultipartFile[] files) { //게시글 수정
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
				
				try {
					f.transferTo(new File(REAL_PATH + uploadFileName));
					adao.insertAttach(bavo);
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
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
					System.out.println(f.toString());
					File df = FileUtils.getFile(newFilePath);
					System.out.println(df.toString());
					
					try {
						FileUtils.moveFile(f, df);
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					
					
					System.out.println("view 수정페이지 삭제 진입확인");
					System.out.println("uuid : "+file);
					adao.deleteSelectedAttach(vo2);
					System.out.println("view 수정페이지 삭제 완료 확인");
					
				}
			}
		}
		
		int attachCount = adao.getAttachCount(vo.getPostSeq()); //첨부파일 카운트
		System.out.println(attachCount);
		if(attachCount != 0) { //카운트 확인 후 post_board에 첨부파일 여부 컬럼 입력
			vo.setFileAttachYn("Y");
		}else {
			vo.setFileAttachYn("N");
		}
		return dao.modView(vo);
	}
	@Override
	public void updateCnt(int postSeq) { //게시글 조회수 업데이트
		dao.updateCnt(postSeq);
	}
	
	
	@Transactional
	@Override
	public int delView(BoardVO vo) { //게시글 삭제
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
		
		
		System.out.println(vo.getPostSeq());
		List<BoardAttachVO> alist = adao.getAttachList(vo.getPostSeq());
		System.out.println(alist.toString());
		for(BoardAttachVO avo : alist) {
			System.out.println(avo.toString());
			
			String originalFilePath = avo.getFilePath()+File.separator+avo.getFileUuid()+avo.getFileName()+"."+avo.getFileType();
			String newFilePath = DELETED_FILE_PATH+File.separator+avo.getFileUuid()+avo.getFileName()+"."+avo.getFileType();
				
			File f = FileUtils.getFile(originalFilePath);
			System.out.println(f.toString());
			File df = FileUtils.getFile(newFilePath);
			System.out.println(df.toString());
			
			/*File f = new File(originalFilePath); //기존 파일 위치+저장된 파일이름
			File df = new File(newFilePath); //새 파일 위치+옮길 파일이름
*/			try {
				FileUtils.moveFile(f, df);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		adao.delAttach(vo);
//		FileUtils.moveFile(f,new File(DELETED_FILE_PATH));
		
		return dao.delView(vo);
	}
	public int findUser(int regrSeq) {//입력받은 유저 db검색
		return dao.findUser(regrSeq);
	}

	@Override
	public List<BoardVO> getNoticeFixedBoard(String boardType) {
		return dao.getNoticeFixedBoard(boardType);
	}

	@Override
	public List<BoardVO> getAllBoardListOrderedByReadCount(int startRow,int endRow) {
		return dao.getAllBoardListOrderedByReadCount(startRow,endRow);
	}

	@Override
	public int getAllBoardCount() {
		return dao.getAllBoardCount();
	}

	@Override
	public List<BoardVO> getAllBoardListOrderedByReadCountForMonth(int startRow, int endRow) {
		return dao.getAllBoardListOrderedByReadCountForMonth(startRow, endRow);
	}
	@Override
	public BoardVO getListForMain(){ // 메인페이지 게시판 리스트
		
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
}
