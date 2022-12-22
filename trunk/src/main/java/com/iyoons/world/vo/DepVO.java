package com.iyoons.world.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class DepVO {
	
	private int depUserSeq; // 유저 부서 테이블 시퀀스 PK
	private int depSeq;
	private String depName;
	private int userSeq;
	private int status;
	private int regrSeq; //작성자 고유번호
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date firstInsertDt; //첫 작성일자
	private List<String> userSeqArray;
	private int updrSeq; //글 최근 수정자
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date lastUpdateDt; //글 최근 수정일자
	
}
