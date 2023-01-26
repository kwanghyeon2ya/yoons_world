package com.iyoons.world.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class DepVO {
	
	
	private int depUserSeq; // 유저 부서 테이블 시퀀스 PK
	private int depSeq; // 부서 일련번호
	private String depName; // 부서 이름 
	private int userSeq; // 유저 고유번호
	private int status; // 소속 상태
	private int regrSeq; //작성자 고유번호
	private List<String> userSeqArray; // 회원정지,복구 리스트
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date firstInsertDt; //첫 작성일자
	private int updrSeq; //글 최근 수정자
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date lastUpdateDt; //글 최근 수정일자
	
}
