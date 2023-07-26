package com.iyoons.world.service;

import java.io.IOException;
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
}
