package com.iyoons.world.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
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
	public String revCalendar(@RequestParam(value = "mgtRoomId", required = false) String mgtRoomId,Model model) {
		if(mgtRoomId == null) {
			mgtRoomId = "B101";
		}
		model.addAttribute("mgtRoomId",mgtRoomId);
		return "reservation/revCalendar";
	}
	
	/** @discription 캘린더 페이지 진입시 회의실 예약 db조회
	 *  @param 
	 *  @return 예약 List
	 * */
	@RequestMapping(value="/getReservation",method=RequestMethod.GET)
	@ResponseBody public List<RoomVO> getReservation(@RequestParam(value="mgtRoomId") String mgtRoomId) {
		
		logger.debug("-------- Request URI : /getReservation -------- mgtRoomId : "+mgtRoomId);
		
		List<RoomVO> resultList = service.getReservation(mgtRoomId);
		for(RoomVO list:resultList) {
			
			list.setId(list.getMgtRoomId()+"-"+list.getUseBgngYmd()+"-"+list.getUseBgngTm());
			if("01".equals(list.getMgtRoomUseSeCode())) {
				if(!list.getUseBgngYmd().equals(list.getUseEndYmd())) {//사용구분이 반복사용일시
					list.setStartRecur(list.getStart().split(" ")[0]);
					list.setEndRecur(list.getEnd().split(" ")[0]);
					list.setStartTime(list.getStart().split(" ")[1]);
					list.setEndTime(list.getEnd().split(" ")[1]);
					logger.debug("list recur"+list.toString());
				}
			}
		}
		logger.debug("list 내용 : "+resultList);
		return resultList;
	}
	
	@RequestMapping(value="/getRoomInfo",method=RequestMethod.GET)
	@ResponseBody public List<RoomVO> getRoomInfo() {
		
		logger.debug("-------- Request URI : /getRoomInfo --------");
		
		List<RoomVO> roomList = service.getRoomInfo();
		
		logger.debug("list 내용 : "+roomList);
		return roomList;
	}
	
	
	
	/** @discription 캘린더에서 예약 상세 내용 읽기
	 *  @param id(mgtRoomID-useBgngYmd-useBgngTm 형식의 파라미터)
	 *  @return 예약 내역(시간,회의주제,회의상세내용)
	 * */
	@RequestMapping(value="/readReservation",method=RequestMethod.GET)
	@ResponseBody public RoomVO readReservation(@RequestParam(value = "id", required = false) String id,HttpSession session) {
		
		logger.debug("-------------/readReservation----------- id : "+id);
		
		RoomVO chkVO = new RoomVO();//부서 확인, 팝업창 누른 일정 정보 확인용 파라미터
		chkVO.setMgtRoomId(id.split("-")[0]);
		chkVO.setUseBgngYmd(id.split("-")[1]);
		chkVO.setUseBgngTm(id.split("-")[2]);
		
		logger.debug("chkVO chk1 : "+chkVO);
		
		int seq = Integer.parseInt(String.valueOf(session.getAttribute("sessionSeqForUser")));
		logger.debug("seq확인 : "+seq);
		chkVO.setUserSeq(seq);//팝업창에 진입한 유저의 고유번호 Set
		
		chkVO = service.getDepName(chkVO);
		chkVO.setMgtRoomId(id.split("-")[0]);
		chkVO.setUseBgngYmd(id.split("-")[1]);
		chkVO.setUseBgngTm(id.split("-")[2]);
		
		logger.debug("chkVO chk2 : "+chkVO);
		
		logger.debug("id : "+id);
		RoomVO roomVO = service.readReservation(chkVO);
		roomVO.setRgtrDepName(chkVO.getRgtrDepName());
		roomVO.setMdfrDepName(chkVO.getMdfrDepName());
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
		
		String seqStr = String.valueOf(session.getAttribute("sessionSeqForUser"));
		
		if(roomVO.getMgtRoomUseSeCode() == null||roomVO.getMgtRoomUseSeCode() == "") {
			logger.debug("se code null chk");
		}else {
			logger.debug("se code : "+roomVO.getMgtRoomUseSeCode());
		}
		
		if(StringUtils.isEmpty(roomVO.getMgtRoomUseSeCode())) {
			roomVO.setMgtRoomUseSeCode("01");
		}
		
		roomVO.setRgtrId(seqStr);
		roomVO.setUserSeq(Integer.parseInt(seqStr));
		
		try {
			
			logger.debug("seq String변환 : "+roomVO.getRgtrId());
			
			int reserveChk = service.checkIsAvailable(roomVO);//예약 가능 확인
			
			if(reserveChk >= 1) {
				throw new Exception("it is not available");
			}
			
			result = service.makeReservation(roomVO);//예약정보 insert
			
		}catch(Exception e){
			if("it is not available".equals(e.getMessage())) {
				logger.error("reservation error message : "+e.getMessage());
				return Integer.parseInt(FinalVariables.NOT_AVAILABLE);
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
	public int cancelReservation(@RequestParam(value = "id",required = false) String id,HttpServletRequest request,HttpSession session) {
		logger.info("---------- updateReservation get in ---------");
		
		int result = 0;//예약 취소 성공 결과 담을 변수
		
		try {
			
			String seqStr = String.valueOf(session.getAttribute("sessionSeqForUser"));
			logger.debug("seq확인 : "+seqStr);
			
			RoomVO roomVO = new RoomVO();
			
			roomVO.setMgtRoomId(id.split("-")[0]);
			roomVO.setUseBgngYmd(id.split("-")[1]);
			roomVO.setUseBgngTm(id.split("-")[2]);
			
			roomVO.setUserSeq(Integer.parseInt(seqStr));//userSeq 넣었는데 왜 null?
			roomVO.setMdfrId(seqStr);
			/*roomVO.setReserveSeq(Integer.parseInt(reserveSeq));*/
			RoomVO depChkVO = service.getDepName(roomVO);//같은 부서의 사람이 update메서드에 접근한 것인지 확인
			logger.debug("depChkVO 확인 : "+depChkVO);
			if(depChkVO != null) {
				if(!depChkVO.getRgtrDepName().equals(depChkVO.getMdfrDepName())) {
					throw new Exception("not same dep");
				}
			}
			
			logger.debug("mdfrid 확인 : "+roomVO.getMdfrId());
			
			result = service.cancelReservation(roomVO);//예약정보 update
			logger.debug("update result : "+result);
			
		}catch(Exception e){
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
			
			if(StringUtils.isEmpty(roomVO.getMgtRoomUseSeCode())) {
				roomVO.setMgtRoomUseSeCode("01");
			}
			
			roomVO.setMgtRoomId(roomVO.getId().split("-")[0]);
			
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
			
			logger.debug("mdfrid 확인 : "+roomVO.getMdfrId());
			
			int reserveChk = service.checkIsAvailable(roomVO);//예약 가능 확인
			
			if(reserveChk >= 1) {
				throw new Exception("it is not available");
			}
			
			logger.debug("update직전 roomVO : "+roomVO);
			result = service.updateReservation(roomVO);//예약정보 update
			logger.debug("update result : "+result);
			
		}catch(Exception e){
			if("it is not available".equals(e.getMessage())) {
				logger.error("reservation error message : "+e.getMessage());
				return Integer.parseInt(FinalVariables.NOT_AVAILABLE);
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
