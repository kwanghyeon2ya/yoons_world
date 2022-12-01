package com.iyoons.world.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class CommentsVO {

	private int commSeq; //댓글의 고유번호
	private String commContent; // 댓글 내용
	private int commGroup; // 댓글 그룹
	private int commLevel; // 댓글 레벨(들여쓰기 구분용)
	private int postSeq; // 게시글의 고유번호
	private int regrSeq; // 게시글 첫 작성자
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date firstInsertDt; // 게시글 첫 작성일자
	private int updrSeq; // 게시글에 최근 변화를 준 자 
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date lastUpdateDt; // 게시글이 변화가 있던 가장 최근 일자
	private String commId; // 댓글 id
	private int status;// 댓글 상태(일반1/삭제0)
	private int nestedCommentsCnt; // 대댓글 갯수
	private int startIndex; // 댓글 페이징 시작 갯수
	private int endIndex; // 댓글 페이징 마지막 갯수
	private int cocoCount;//게시글 jsp에 for문을 통해 보여지는 댓글 갯수
	private List<CommentsVO> cocoList; //대댓글 리스트를 List객체로 묶음
	
}
