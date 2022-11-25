package com.iyoons.world.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class UserAutoLoginVO {

	private String cookieKey;
	private int userSeq;
	private String userName;
	private String userIp;
	private String userBrowser;
	private String cookieStatus;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date regDt;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date expiryDt;
	private int adminType;
	
}
