package com.iyoons.world.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class DepVO {
	
	private String depId;
	private String depName;
	private int userSeq;
	private int status;
	private int regrSeq; //작성자 고유번호
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date firstInsertDt; //첫 작성일자
	private int updrSeq; //글 최근 수정자
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date lastUpdateDt; //글 최근 수정일자
	
}
