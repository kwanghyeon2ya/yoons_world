package com.iyoons.world.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class CommentsVO {

	private int commSeq;
	private String commContent;
	private int commGroup;
	private int commLevel;
	private int postSeq;
	private int regrSeq;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date firstInsertDt;
	private int updrSeq;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date lastUpdateDt;
	private int commStep;
	
	
}
