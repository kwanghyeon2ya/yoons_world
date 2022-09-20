package com.iyoons.world.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class MemberVO {

	private String userId;
	private int userSeq;
	private String userPw;
	private String userName;
	private String Email;
	@DateTimeFormat(pattern="yyyy-MM-dd hh:mm")
	private Date hireDt;
	@DateTimeFormat(pattern="yyyy-MM-dd hh:mm")
	private Date regDt;
	private int userType;
	private int userStatus;
	@DateTimeFormat(pattern="yyyy-MM-dd hh:mm")
	private Date lastLoginDt;
	private int updrSeq;
	@DateTimeFormat(pattern="yyyy-MM-dd hh:mm")
	private Date lastUpdateDt;
	
}
