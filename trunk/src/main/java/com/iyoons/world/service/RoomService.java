package com.iyoons.world.service;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.iyoons.world.vo.BoardVO;
import com.iyoons.world.vo.CommentsVO;
import com.iyoons.world.vo.PageVO;
import com.iyoons.world.vo.RoomVO;
import com.iyoons.world.vo.UserActionVO;

public interface RoomService {
	
	public int makeReservation(RoomVO roomVO);
	public int checkIsAvailableStartDT(String startDt);//회의 예약 시작시간 중복확인
	public int checkIsAvailableEndDT(String endDt);//회의 예약 종료시간 중복확인
	public List<RoomVO> getReservation();//일정List 가져오기
	public RoomVO readReservation(int reserveSeq);//캘린더에서 예약 상세 내용 읽기
}
