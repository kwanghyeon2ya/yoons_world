package com.iyoons.world.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class RoomVO {//회의실 예약 VO Class
	
	private String mgtRoomId;//회의실 ID
	private String useBgngYmd;//사용자에게 입력받는 사용시작일자
	private String useBgngTm;//사용자에게 입력받는 사용시작시각
	private String rsvtStatusCode;//예약상태 사용:01 취소:02
	
	private String prevUseBgngYmd;//파라미터로 받은 id값에서 가운데 숫자 스트링 예(20230913)
	private String prevUseBgngTm;//파라미터로 받은 id값에서 마지막 숫자 스트링 예(090000)
	private String useEndYmd;//사용자에게 입력받는 사용시작일자
	private String useEndTm;//사용자에게 입력받는 사용시작시각
	private String mgtNm;//회의 주제
	private String mgtCn;//주요 회의 내용
	private int userSeq; //유저 고유번호
	private String mgtRoomUseSeCode;//반복,연속 예약 확인(01반복 02연속)
	private String rsvtDtm;//예약 등록 일자
	private String [] dateArr;
	
	private String regDt;//등록일자 - 시스템컬럼
	private String rgtrId;//등록자 - 시스템컬럼
	private String mdfcnDt;//수정일자 - 시스템컬럼
	private String mdfrId;//수정자 - 시스템컬럼
	private char delYn;//삭제여부(Y/N) - 시스템컬럼
	
	private String mgtRoomNm;//회의실 이름
	private String mgtRoomNofl;//회의실 층 정보
	private String mgtRoomOperTm;//회의실 운영시간
	private String mgtRoomInfoCn;//회의실 정보
	
	private String id;//캘린더에 뿌릴 id
	private String title;//캘린더에 뿌릴 회의 제목
	private String start;//캘린더에 뿌릴 회의 시작시간
	private String end;//캘린더에 뿌릴 회의 종료시간
	private String startRecur;//캘린더에 뿌릴 반복시작일자
	private String endRecur;//캘린더에 뿌릴 반복종료일자
	private String startTime;//캘린더에 뿌릴 반복시작시각
	private String endTime;//캘린더에 뿌릴 반복종료시각 
	
	private String rgtrDepName;//db조회후 가져올 본글 작성자의 부서 고유번호
	private String mdfrDepName;//db조회후 가져올 수정자의 부서 고유번호
	private String rgtrName;//db에서 받아오는 등록자 이름
	private String mdfrName;//db에서 받아오는 수정자 이름

	private String mgtTypeCode;//mgt_room_rsvt테이블 회의유형코드
	private String code;//코드테이블 회의실 유형 코드
	private String value;//코드테이블 회의실 유형 값
	
	private int recurCnt;//주간,월간 회의 반복횟수 - db에 없는 컬럼 - script로 횟수 받아올때만 사용
	private List<String> recurDates;//주간,월간 반복해서 예약할 일자 List
	
}
