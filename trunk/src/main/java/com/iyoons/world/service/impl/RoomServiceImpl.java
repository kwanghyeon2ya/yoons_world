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
	public int checkIsAvailableStartDT(String startDt) {
		return dao.checkIsAvailableStartDT(startDt);
	}

	/**@author qus46
	 * @param 회의예약 종료시간(endDt)
	 * @discription 회의 예약 종료 시간 중복 확인
	 * @return count값(1 중복/0 중복없음)
	 * */
	@Override
	public int checkIsAvailableEndDT(String endDt) {
		return dao.checkIsAvailableEndDT(endDt);
	}

	/**@author qus46
	 * @param 
	 * @discription 캘린더 페이지 진입시 회의실 예약 db조회
	 * @return 
	 * */
	@Override
	public List<RoomVO> getReservation() {
		return dao.getReservation();
	}

	
	/**@author qus46
	 * @param 캘린더 일정List 가져오기
	 * @discription 캘린더 페이지 진입시 회의실 예약 db조회
	 * @return 
	 * */
	@Override
	public RoomVO readReservation(int reserveSeq) {
		return dao.readReservation(reserveSeq);
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
	
	
	

	
}
