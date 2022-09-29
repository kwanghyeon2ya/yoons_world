package com.iyoons.world.vo;

import java.util.Date;
import java.util.UUID;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class BoardAttachVO {
	private int postSeq;
	private String filePath;
	private long fileSize;
	private String fileName;
	private String fileUuid;
	private String fileType;
	private int regrSeq;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date firstInsertDt;
	private int updrSeq;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date lastUpdateDT;
}