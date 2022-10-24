package com.iyoons.world.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class UserVO {
	
	private String userId;
	private int userSeq; 
	private String userPw; 
	private String userName;
	private String email;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date hireDt; //입사일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date regDt;; // 등록일
	private int userType; //회원 구분 (0:일반, 1:관리자)
	private int userStatus; //회원 상태 (0:활동, 1:탈퇴)
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date lastLoginDt; //마지막 로그인 일자
	private int regrSeq; //회원정보 등록자
	private int updrSeq; //회원정보 수정자
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date lastUpdateDt; //회원정보 수정일자
	private String depName;
	private List<String> userIdArray;
	
}