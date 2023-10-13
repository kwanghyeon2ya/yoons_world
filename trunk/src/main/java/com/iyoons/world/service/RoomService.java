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
	
	public int makeReservation(RoomVO roomVO) throws Exception;
	public int checkIsAvailableStartDT(RoomVO roomVO);//회의 예약 시작시간 중복확인
	public int checkIsAvailableEndDT(RoomVO roomVO);//회의 예약 종료시간 중복확인
	public RoomVO readReservation(RoomVO chkVO);//캘린더에서 예약 상세 내용 읽기
	public int updateReservation(RoomVO roomVO);//회의실 예약 내용 update
	public RoomVO getDepName(RoomVO roomVO);//update 전 같은 부서 사람 여부 체크
	public int checkIsAvailableStartUPD(RoomVO roomVO);//update 전 회의 예약 시작시간 중복확인
	public int checkIsAvailableEndUPD(RoomVO roomVO);//update 전 회의 예약 시작시간 중복확인
	public int cancelReservation(RoomVO roomVO);//예약 취소 update
	public int checkIsAvailable(RoomVO roomVO);//예약 가능 확인
	public List<RoomVO> getRoomInfo();//회의실,층 정보
	public List<RoomVO> getReservation(String mgtRoomId);//일정List 가져오기
	public List<RoomVO> getRsvtType();//회의유형목록 가져오기
	
}
