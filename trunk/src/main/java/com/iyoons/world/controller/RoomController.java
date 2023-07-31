package com.iyoons.world.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iyoons.world.common.FinalVariables;
import com.iyoons.world.service.RoomService;
import com.iyoons.world.vo.RoomVO;

@Controller
public class RoomController {
	
	@Autowired
	RoomService service; 
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	/** @discription 캘린더 진입
	 *  @param
	 * */
	@RequestMapping(value="/revCalender",method=RequestMethod.GET)
	public String revCalender() {
		return "reservation/revCalender";
	}
	
	/** @discription 캘린더 페이지 진입시 회의실 예약 db조회
	 *  @param 
	 *  @return 예약 List
	 * */
	@RequestMapping(value="/getReservation",method=RequestMethod.GET)
	@ResponseBody public List<RoomVO> getReservation() {
		List<RoomVO> resultList = service.getReservation();
		logger.debug("list 내용 : "+resultList);
		return resultList;
	}
	
	
	/** @discription 캘린더에서 예약 상세 내용 읽기
	 *  @param 
	 *  @return 예약 내역(시간,회의주제,회의상세내용)
	 * */
	@RequestMapping(value="/readReservation",method=RequestMethod.GET)
	@ResponseBody public RoomVO readReservation(@RequestParam(value = "reserveSeq", required = false) String reserveSeq) {
		
		logger.debug("reserveSeq : "+reserveSeq);
		RoomVO roomVO = service.readReservation(Integer.parseInt(reserveSeq));
		logger.debug("roomVO 내용 : "+roomVO);
		return roomVO;
	}
	
	
	/** @discription 예약 날짜 예약 insert
	 *  @param RoomVO
	 *  @return 예약 성공 여부
	 * */
	@RequestMapping(value="/makeReservation",method=RequestMethod.POST)
	@ResponseBody 
	public int makeReservation(@RequestBody RoomVO roomVO,HttpServletRequest request,HttpSession session) {
		logger.info("---------- makeReservation get in ---------");
		
		logger.debug("roomVO toString ---- "+roomVO);
		
		int result = 0;//insert성공 결과 담을 변수
		
		try {
			logger.debug("seq확인 : "+String.valueOf(session.getAttribute("sessionSeqForUser")));
			roomVO.setRgtrId(String.valueOf(session.getAttribute("sessionSeqForUser")));
			logger.debug("seq String변환 : "+roomVO.getRgtrId());
	
			int startDtChk = service.checkIsAvailableStartDT(roomVO.getStartDt());//시작시간 중복확인
			int endDtChk = service.checkIsAvailableEndDT(roomVO.getStartDt());//종료시간 중복확인
			if(startDtChk >= 1) {
				throw new Exception("startDt is no available");
			}
			if(endDtChk >= 1) {
				throw new Exception("endDt is no available");
			}
			
			result = service.makeReservation(roomVO);//예약정보 insert
			
		}catch(Exception e){
			if("startDt is no available".equals(e.getMessage())) {
				logger.error("start e message : "+e.getMessage());
				return Integer.parseInt(FinalVariables.STARTDT_DUPLICATED_CODE);
			}
			if("endDt is no available".equals(e.getMessage())) {
				logger.error("end e message : "+e.getMessage());
				return Integer.parseInt(FinalVariables.ENDDT_DUPLICATED_CODE);
			}		
			logger.error("Exception : " + e.getMessage());
			logger.debug(" Request URI \t:  " + request.getRequestURI());
			return result;
		}

		
		
		return result;
	}

}
