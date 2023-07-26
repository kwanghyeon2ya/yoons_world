package com.iyoons.world.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.iyoons.world.service.RoomService;
import com.iyoons.world.vo.RoomVO;

@Controller
public class RoomController {
	
	@Autowired
	RoomService service; 
	
	@RequestMapping(value="/revCalender",method=RequestMethod.GET)
	public String revCalender() {
		return "reservation/revCalender";
	}
	
	@RequestMapping(value="/makeReservation",method=RequestMethod.POST)
	@ResponseBody 
	public int makeReservation(RoomVO roomVO) {
		
		//int roomChk 중복 예약 확인 필요
		int result = service.makeReservation(roomVO);//insert
		
		return result;
	}

}
