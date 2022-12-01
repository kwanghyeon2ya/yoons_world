package com.iyoons.world.vo;

import java.util.Date;
import java.util.UUID;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class BoardAttachVO { 
	private int postSeq; // 파일이 저장된 게시글의 고유번호
	private String filePath; // 파일이 저장된 물리경로
	private long fileSize; // 파일 사이즈
	private String fileName; // 파일 이름
	private String fileUuid; // 파일의 고유번호 pk
	private String fileType; // 파일의 타입(확장자)
	private int regrSeq; // 파일 첫 등록자
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date firstInsertDt; // 파일 첫 입력날짜
	private int updrSeq; // 파일에게 db상의 변화를 준 자 
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")  
	private Date lastUpdateDT; // 파일에게 변화가 있던 가장 최근 일자
	private String fullPath; // 전체 경로
}