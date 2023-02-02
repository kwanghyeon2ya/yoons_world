package com.iyoons.world.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class BoardVO {
	
	private int postNum; //작성시간에 따라 내림차순으로 매겨진 살아있는 글에 대한 번호
	private int postSeq; //글 고유번호
	private int userSeq; //유저 고유번호
	private String writerName; //글 작성자(Client가 보는 작성자이름)
	private String subject; //글 제목
	private String content; //글 내용
	private int status; // 글 상태(일반1/삭제0)
	private int readCnt; //조회수
	private String boardType; //게시판 타입
	private String fileAttachYn; //첨부파일 여부
	private String boardFixYn;
	private int regrSeq; //작성자 고유번호
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date firstInsertDt; //첫 작성일자
	private int updrSeq; //글 최근 수정자
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date lastUpdateDt; //글 최근 수정일자
	private List<BoardAttachVO> AttachList; //첨부파일 목록
	private List<BoardVO> freeBoardList;
	private List<BoardVO> noticeBoardList;
	private List<BoardVO> pdsBoardList;
	private List<BoardVO> fixedBoardList;
	private String search; //검색 항목
	private String keyword; //검색 내용
	private String hideName; // 익명이름
	private int hideCheck; // 익명 확인 숫자  - 1 익명
	private String fullFileName; // 게시글에 첨부된 파일이름 -  파일명.확장자
	private int attachCnt; // 첨부파일 갯수
	private int commentsCnt; // 댓글 수
	private String [] fileUuidArray; // 글 수정시 가감되는 첨부파일의 배열
	private String fileUuid; // 글 수정시 가감되는 첨부파일 배열에게서 for문으로 대입되어 db에 입력되는 첨부파일 테이블의 pk
	private String fixStartDt; // 공지사항 게시판 상단고정 시작날짜
	private String fixEndDt; // 공지사항 게시판 상단고정 종료날짜
	private int heartCount; // 게시글에 대한 좋아요 총 갯수
	private int heartCheck; // 좋아요를 누른적이 있는지 확인용
	private int expiryDt; // 고정 종료까지 남은 날짜
	private int expiryHour; // 고정 종료까지 남은 시간
	private int expiryMinute; // 고정 종료까지 남은 분
	private String picture; // 글 작성자의 프로필사진
	private String searchCheck;
	private int targetSeq; //유저가 활동한 대상의 고유번호(검색할 때 사용)   POST_SEQ - 게시글고유 / USER_SEQ - 유저고유
	private List<BoardVO> myListByLike; // 내가 좋아요를 누른 게시글
	private List<BoardVO> myListByComments; // 내가 댓글을 작성한 게시글 
	private List<BoardVO> myBoardList; // 내가 작성한 게시글
	private int pageNum;
}
