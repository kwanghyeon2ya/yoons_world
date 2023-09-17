package com.iyoons.world.service.impl;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.iyoons.world.common.FinalVariables;
import com.iyoons.world.dao.AttachDAO;
import com.iyoons.world.dao.BoardDAO;
import com.iyoons.world.dao.CommentsDAO;
import com.iyoons.world.dao.RoomDAO;
import com.iyoons.world.service.BoardService;
import com.iyoons.world.service.RoomService;
import com.iyoons.world.service.UserActionService;
import com.iyoons.world.vo.BoardAttachVO;
import com.iyoons.world.vo.BoardVO;
import com.iyoons.world.vo.CommentsVO;
import com.iyoons.world.vo.PageVO;
import com.iyoons.world.vo.RoomVO;
import com.iyoons.world.vo.UserActionVO;

@Service(value = "RoomService")
public class RoomServiceImpl implements RoomService {

	@Autowired
	RoomDAO dao;
	
	/**@author qus46
	 * @param roomVO(roomSubject,roomContent,startDt,endDt,rgtr_id)
	 * @discription 회의 예약 insert
	 * @return insert 성공여부(0/1)
	 * */
	@Override
	public int makeReservation(RoomVO roomVO) {
		return dao.makeReservation(roomVO);
	}

	/**@author qus46
	 * @param 회의예약 시작시간(startDt)
	 * @discription 회의 예약 시작 시간 중복 확인
	 * @return count값(1 중복/0 중복없음)
	 * */
	@Override
	public int checkIsAvailableStartDT(RoomVO roomVO) {
		return dao.checkIsAvailableStartDT(roomVO);
	}

	/**@author qus46
	 * @param 회의예약 종료시간(endDt)
	 * @discription 회의 예약 종료 시간 중복 확인
	 * @return count값(1 중복/0 중복없음)
	 * */
	@Override
	public int checkIsAvailableEndDT(RoomVO roomVO) {
		return dao.checkIsAvailableEndDT(roomVO);
	}
	
	/**@author qus46
	 * @param roomVO(startDt,reserveSeq(자기자신과는 비교하지 않기위한 파라미터))
	 * @discription update전 회의 예약 시작 시간 중복 확인
	 * @return count값(1 중복/0 중복없음)
	 * */
	@Override
	public int checkIsAvailableStartUPD(RoomVO roomVO) {
		return dao.checkIsAvailableStartUPD(roomVO);
	}

	/**@author qus46
	 * @param roomVO(endDt,reserveSeq(자기자신과는 비교하지 않기위한 파라미터))
	 * @discription update전 회의 예약 종료 시간 중복 확인
	 * @return count값(1 중복/0 중복없음)
	 * */
	@Override
	public int checkIsAvailableEndUPD(RoomVO roomVO) {
		return dao.checkIsAvailableEndUPD(roomVO);
	}

	/**@author qus46
	 * @param 
	 * @discription 캘린더 페이지 진입시 회의실 예약 db조회
	 * @return 
	 * */
	@Override
	public List<RoomVO> getReservation(String mgtRoomId) {
		return dao.getReservation(mgtRoomId);
	}

	
	/**@author qus46
	 * @param 캘린더 일정List 가져오기
	 * @discription 캘린더 페이지 진입시 회의실 예약 db조회
	 * @return 
	 * */
	@Override
	public RoomVO readReservation(RoomVO roomVO) {
		return dao.readReservation(roomVO);
	}

	/**@author qus46
	 * @param roomVO(roomSubject,roomContent,startDt,endDt,rgtr_id) 
	 * @discription 회의실 예약 내용 update
	 * @return update 성공여부 (0/1)
	 * */
	@Override
	public int updateReservation(RoomVO roomVO) {
		return dao.updateReservation(roomVO);
	}
	
	/**@author qus46
	 * @param roomVO(reserveSeq(회의실 고유번호),mdfrId(수정자 id)) 
	 * @discription 같은 부서의 사람이 update메서드에 접근한 것인지 확인
	 * @return roomVO(rgtrDepSeq,mdfrDepSeq)
	 * */
	@Override
	public RoomVO getDepName(RoomVO roomVO) {
		return dao.getDepName(roomVO);
	}

	/**@author qus46
	 * @param roomVO(reserveSeq(회의실 고유번호),mdfrId(수정자 id)) 
	 * @discription 예약취소 update
	 * @return 
	 * */
	@Override
	public int cancelReservation(RoomVO roomVO) {
		return dao.cancelReservation(roomVO);
	}

	/**@author qus46
	 * @param roomVO 
	 * @discription 회의실 예약 가능 여부 확인
	 * @return 
	 * */
	@Override
	public int checkIsAvailable(RoomVO roomVO) {
		// TODO Auto-generated method stub
		return dao.checkIsAvailable(roomVO);
	}

	/**@author qus46
	 * @param  
	 * @discription 회의실 전체 층,이름 정보 가져오기
	 * @return RoomVO(MGT_ROOM_ID,MGT_ROOM_NM,MGT_ROOM_NOFL)
	 * */
	@Override
	public List<RoomVO> getRoomInfo() {
		return dao.getRoomInfo();
	}
	
}
