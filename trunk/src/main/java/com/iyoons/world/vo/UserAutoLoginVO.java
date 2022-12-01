package com.iyoons.world.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class UserAutoLoginVO {

	private String cookieKey; // 쿠키의 key -  pk
	private String userId;
	private int userSeq; // 유저의 고유번호
	private String userName; // 유저의 이름
	private String userIp; // 유저가 현재 접속한 pc의 외부ip
	private String userBrowser; // 유저가 사용하는 브라우저
	private String cookieStatus; // 유저가 생성한 쿠키의 상태(1유효,0삭제) 
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date regDt; // 쿠키 생성일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date expiryDt; // 쿠키 만료날(쿠키 생성일로부터 30일)
	private int adminType; // 세션이 만료된 관리자에게 관리자에대한 세션을 발급해주기위한 숫자 (1 관리자 0 일반)
	
}
