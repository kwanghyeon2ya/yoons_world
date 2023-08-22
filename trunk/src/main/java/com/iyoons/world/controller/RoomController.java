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
	@RequestMapping(value="/revCalendar",method=RequestMethod.GET)
	public String revCalendar() {
		return "reservation/revCalendar";
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
	@ResponseBody public RoomVO readReservation(@RequestParam(value = "reserveSeq", required = false) String reserveSeq,HttpSession session) {
		
		RoomVO depChkVO = new RoomVO();
		
		int seq = Integer.parseInt(String.valueOf(session.getAttribute("sessionSeqForUser")));
		logger.debug("seq확인 : "+seq);
		depChkVO.setUserSeq(seq);//팝업창에 진입한 유저의 고유번호 Set
		depChkVO.setReserveSeq(Integer.parseInt(reserveSeq));//예약 고유 번호 Set
		depChkVO = service.getDepName(depChkVO);
		
		logger.debug("reserveSeq : "+reserveSeq);
		RoomVO roomVO = service.readReservation(Integer.parseInt(reserveSeq));
		roomVO.setRgtrDepName(depChkVO.getRgtrDepName());
		roomVO.setMdfrDepName(depChkVO.getMdfrDepName());
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
				throw new Exception("startDt is not available");
			}
			if(endDtChk >= 1) {
				throw new Exception("endDt is not available");
			}
			
			result = service.makeReservation(roomVO);//예약정보 insert
			
		}catch(Exception e){
			if("startDt is not available".equals(e.getMessage())) {
				logger.error("start time error message : "+e.getMessage());
				return Integer.parseInt(FinalVariables.STARTDT_DUPLICATED_CODE);
			}
			if("endDt is not available".equals(e.getMessage())) {
				logger.error("end time error message : "+e.getMessage());
				return Integer.parseInt(FinalVariables.ENDDT_DUPLICATED_CODE);
			}		
			logger.error("Exception : " + e.getMessage());
			logger.debug(" Request URI \t:  " + request.getRequestURI());
			return result;
		}

		
		
		return result;
	}
	
	
	/** @discription 예약 취소 update
	 *  @param RoomVO
	 *  @return 예약 성공 여부
	 * */
	@RequestMapping(value="/cancelReservation",method=RequestMethod.GET)
	@ResponseBody 
	public int cancelReservation(@RequestParam(value = "reserveSeq",required = false) String reserveSeq,HttpServletRequest request,HttpSession session) {
		logger.info("---------- updateReservation get in ---------");
		
		int result = 0;//예약 취소 성공 결과 담을 변수
		
		try {
			
			String seqStr = String.valueOf(session.getAttribute("sessionSeqForUser"));
			logger.debug("seq확인 : "+seqStr);
			
			RoomVO roomVO = new RoomVO();
			roomVO.setUserSeq(Integer.parseInt(seqStr));//userSeq 넣었는데 왜 null?
			roomVO.setMdfrId(seqStr);
			roomVO.setReserveSeq(Integer.parseInt(reserveSeq));
			RoomVO depChkVO = service.getDepName(roomVO);//같은 부서의 사람이 update메서드에 접근한 것인지 확인
			logger.debug("depChkVO 확인 : "+depChkVO);
			if(depChkVO != null) {
				if(!depChkVO.getRgtrDepName().equals(depChkVO.getMdfrDepName())) {
					throw new Exception("not same dep");
				}
			}
			
			logger.debug("reserveSeq 확인 : "+roomVO.getReserveSeq());
			logger.debug("start 확인 : "+roomVO.getStartDt());
			logger.debug("end 확인 : "+roomVO.getEndDt());
			logger.debug("mdfrid 확인 : "+roomVO.getMdfrId());
			
			result = service.cancelReservation(roomVO);//예약정보 update
			logger.debug("update result : "+result);
			
		}catch(Exception e){
			if("startDt is not available".equals(e.getMessage())) {
				logger.error("start time error message : "+e.getMessage());
				return Integer.parseInt(FinalVariables.STARTDT_DUPLICATED_CODE);
			}
			if("endDt is not available".equals(e.getMessage())) {
				logger.error("end time error message : "+e.getMessage());
				return Integer.parseInt(FinalVariables.ENDDT_DUPLICATED_CODE);
			}			
			if("not same dep".equals(e.getMessage())) {
				logger.error("dep error message : "+e.getMessage());
				return Integer.parseInt(FinalVariables.DUPLICATED_CODE);
			}
			logger.error("Exception : " + e.getMessage());
			logger.debug(" Request URI \t:  " + request.getRequestURI());
			return result;
		}

		return result;
	}
	
	
	
	/** @discription 예약 날짜 예약 update
	 *  @param RoomVO
	 *  @return 예약 성공 여부
	 * */
	@RequestMapping(value="/updateReservation",method=RequestMethod.POST)
	@ResponseBody 
	public int updateReservation(@RequestBody RoomVO roomVO,HttpServletRequest request,HttpSession session) {
		logger.info("---------- updateReservation get in ---------");
		
		logger.debug("update roomVO toString ---- "+roomVO);
		
		int result = 0;//update성공 결과 담을 변수
		
		try {
			
			String seqStr = String.valueOf(session.getAttribute("sessionSeqForUser"));
			logger.debug("seq확인 : "+seqStr);
			
			roomVO.setUserSeq(Integer.parseInt(seqStr));
			roomVO.setMdfrId(seqStr);
			RoomVO depChkVO = service.getDepName(roomVO);//같은 부서의 사람이 update메서드에 접근한 것인지 확인
			logger.debug("depChkVO 확인 : "+depChkVO);
			if(depChkVO != null) {
				if(!depChkVO.getRgtrDepName().equals(depChkVO.getMdfrDepName())) {
					throw new Exception("not same dep");
				}
			}
			
			logger.debug("reserveSeq 확인 : "+roomVO.getReserveSeq());
			logger.debug("start 확인 : "+roomVO.getStartDt());
			logger.debug("end 확인 : "+roomVO.getEndDt());
			logger.debug("mdfrid 확인 : "+roomVO.getMdfrId());
			
			int startDtChk = service.checkIsAvailableStartUPD(roomVO);
			int endDtChk = service.checkIsAvailableEndUPD(roomVO);
			
			logger.debug("startDtChk : "+startDtChk);
			logger.debug("endDtChk : "+endDtChk);
			
			if(startDtChk >= 1) {
				throw new Exception("startDt is not available");
			}
			if(endDtChk >= 1) {
				throw new Exception("endDt is not available");
			}
			logger.debug("update직전 roomVO : "+roomVO);
			result = service.updateReservation(roomVO);//예약정보 update
			logger.debug("update result : "+result);
			
		}catch(Exception e){
			if("startDt is not available".equals(e.getMessage())) {
				logger.error("start time error message : "+e.getMessage());
				return Integer.parseInt(FinalVariables.STARTDT_DUPLICATED_CODE);
			}
			if("endDt is not available".equals(e.getMessage())) {
				logger.error("end time error message : "+e.getMessage());
				return Integer.parseInt(FinalVariables.ENDDT_DUPLICATED_CODE);
			}			
			if("not same dep".equals(e.getMessage())) {
				logger.error("dep error message : "+e.getMessage());
				return Integer.parseInt(FinalVariables.DUPLICATED_CODE);
			}
			logger.error("Exception : " + e.getMessage());
			logger.debug(" Request URI \t:  " + request.getRequestURI());
			return result;
		}

		return result;
	}

}
