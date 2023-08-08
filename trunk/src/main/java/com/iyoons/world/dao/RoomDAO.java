package com.iyoons.world.dao;


import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.iyoons.world.vo.RoomVO;

@Mapper
public interface RoomDAO {
	
	public int makeReservation(RoomVO roomVO); //게시글 작성
	public int checkIsAvailableStartDT(String startDt);//회의 예약 시작시간 중복확인
	public int checkIsAvailableEndDT(String endDt);//회의 예약 종료시간 중복확인
	public List<RoomVO> getReservation();//일정List 가져오기
	public RoomVO readReservation(int reserveSeq);//캘린더에서 예약 상세 내용 읽기
	public int updateReservation(RoomVO roomVO);//회의실 예약 내용 update
	public RoomVO getDepName(RoomVO roomVO);//같은 부서 사람 체크위한 dep코드 가져옴
	public int checkIsAvailableStartUPD(RoomVO roomVO);//update전 회의 예약 시작 시간 중복 확인
	public int checkIsAvailableEndUPD(RoomVO roomVO);//update전 회의 예약 종료 시간 중복 확인
	public int cancelReservation(RoomVO roomVO);//예약 취소 update
}
