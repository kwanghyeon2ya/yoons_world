package com.iyoons.world.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class RoomVO {//회의실 예약 VO Class
	
	private int reserveSeq;//예약고유번호
	private int roomSeq;//회의실 일련번호
	private String roomSubject;//회의 주제
	private String roomContent;//주요 회의 내용
	private int roomStatus;//예약상태 일반:1 예약취소:0 반려:2
	private String startDt;//사용자에게 입력받는 예약 시작 시간
	private String endDt;//사용자에게 입력받는 예약 종료 시간
	private String regDt;//등록일자
	private String rgtrId;//등록자
	private String mdfrDt;//수정일자
	private String mdfrId;//수정자
	private char delYn;//삭제여부(Y/N)
	private String roomName;//회의실 이름
	private char roomFloor;//회의실 층 정보
	private int userSeq; //유저 고유번호
	private int id;//캘린더에 뿌릴 id
	private String title;//캘린더에 뿌릴 회의 제목
	private String start;//캘린더에 뿌릴 회의 시작시간
	private String end;//캘린더에 뿌릴 회의 종료시간
	
}
