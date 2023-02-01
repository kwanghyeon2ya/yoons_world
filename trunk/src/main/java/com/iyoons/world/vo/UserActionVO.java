package com.iyoons.world.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class UserActionVO { //유저활동 VO - 좋아요 및 기타 활동에 대한 정보
	
	private int actionSeq; // 활동 기록에 대한 고유번호
	private int userSeq; // 활동유저 고유번호
	private String targetType; // 활동한 곳의 타입    BOARD 게시글 관련 / USER 유저 관련
	private int targetSeq; // 활동한 대상 게시글(유저)의 고유번호    POST_SEQ - 게시글고유 / USER_SEQ - 유저고유 
	private String actionType; // targetType의 세부 활동 내역 - 예)게시글에서 좋아요버튼을 누를 시 01로 등록 
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date firstInsertDt; // 활동한 날짜
	private int heartCount; // 좋아요 갯수
	private int heartCheck; // 좋아요 확인
	
}
