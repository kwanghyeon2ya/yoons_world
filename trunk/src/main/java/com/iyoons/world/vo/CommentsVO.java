package com.iyoons.world.vo;

import java.util.Date;
import java.util.List;

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
	private int maxCommStep;
	private String commId;
	private int status;// 댓글 상태(일반1/삭제0)
	private int nestedCommentsCnt;
	private int startIndex;
	private int endIndex;
	private int cocoCount;//게시글 jsp에 for문을 통해 보여지는 댓글 갯수
	private List<CommentsVO> cocoList; //대댓글 List
	private int isExistComm;
	
}
