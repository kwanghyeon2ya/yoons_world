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
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.iyoons.world.common.FinalVariables;
import com.iyoons.world.dao.AttachDAO;
import com.iyoons.world.dao.BoardDAO;
import com.iyoons.world.dao.CommentsDAO;
import com.iyoons.world.dao.UserActionDAO;
import com.iyoons.world.service.UserActionService;
import com.iyoons.world.vo.BoardAttachVO;
import com.iyoons.world.vo.BoardVO;
import com.iyoons.world.vo.CommentsVO;
import com.iyoons.world.vo.PageVO;
import com.iyoons.world.vo.UserActionVO;

@Service(value = "UserActionServiceImpl")
public class UserActionServiceImpl implements UserActionService {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private UserActionDAO uadao;
	
	@Autowired
	private BoardDAO dao;
	
	/*
	 * 조회 활동이력 저장
	 * 
	@Override
	public int insertViewAction(UserActionVO uavo) throws Exception { 
		
		UserActionVO uavo = new UserActionVO();
		uavo.setTargetSeq(vo.getPostSeq());
		uavo.setUserSeq(vo.getUserSeq());
		uavo.setTargetType(FinalVariables.TARGET_BOARD); // 활동장소 : 게시글
		uavo.setActionType(FinalVariables.ACTION_TYPE_VIEWCOUNT); // 활동내역 : 조회
		return uadao.insertUserAction(uavo);
		
	}*/
	
	
	/*
	 * 유저 활동이력 저장 (좋아요 , 조회)
	 * 
	 * */
	@Override
	public int insertUserAction(UserActionVO uavo) throws Exception { 
		logger.debug("UserActionVo insertUserAction service 단 확인 :"+uavo);
		return uadao.insertUserAction(uavo);
		
	}
	
	@Override
	public int getHeartCount(UserActionVO uavo){
		return uadao.getHeartCount(uavo);
	}
	
	/*
	 * 조회 활동이력 저장
	 * 
	@Override
	public int increasingHeart(UserActionVO uavo) throws Exception {

		UserActionVO uavo = new UserActionVO();
		uavo.setUserSeq(vo.getUserSeq());
		uavo.setTargetSeq(vo.getPostSeq());
		uavo.setTargetType(FinalVariables.TARGET_BOARD); // 활동장소 : 게시글
		uavo.setActionType(FinalVariables.ACTION_TYPE_LIKE); // 활동내역 : 좋아요

		return uadao.insertUserAction(uavo);
	}*/
	
	
	@Override
	public int checkUserAction(UserActionVO uavo)  throws Exception{// 좋아요 버튼 활성화 여부를 위해 좋아요 누른 기록 조회
		logger.debug("UserActionVo UserCheck service 단 확인 :"+uavo);
		return uadao.checkUserAction(uavo); 
		
	}

	/*@Override
	public int checkLikeAction(UserActionVO uavo)  throws Exception{// 좋아요 버튼 활성화 여부를 위해 좋아요 누른 기록 조회
		return uadao.checkUserAction(uavo); 
		
	}
	
	@Override
	public int checkViewAction(UserActionVO uavo) throws Exception { // 조회수를 업데이트 할지 여부를 위해 조회 이력 체크
		
		return uadao.checkUserAction(uavo);
		
	}*/
	
	
}
