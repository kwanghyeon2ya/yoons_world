package com.iyoons.world.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class BoardVO {
	
	private int postNum;
	private int postSeq; //글 고유번호
	private String writerName; //글 작성자(Client가 보는 작성자이름)
	private String subject; //글 제목
	private String content; //글 내용
	private int status; // 글 상태(일반1/삭제0)
	private int readCnt; //조회수
	private int boardType; //게시판 타입
	private String fileAttachYn; //첨부파일 여부
	private String boardFixYn;
	private int regrSeq; //작성자 고유번호
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date firstInsertDt; //첫 작성일자
	private int updrSeq; //글 최근 수정자
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date lastUpdateDt; //글 최근 수정일자
	private List<BoardAttachVO> AttachList; //첨부파일 목록
	private String search; //검색 항목
	private String keyword; //검색 내용
	private String hideName;
	private int hideCheck;
	private String fullFileName;
	private int attachCnt;
	
}
