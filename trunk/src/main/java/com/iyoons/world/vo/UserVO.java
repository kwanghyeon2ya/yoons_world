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
	private String changeUserPw;
	private String userName;
	private String email;
	private String emailPart1;
	private String emailPart2;
	private String emailPart3;
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
	private List<String> userSeqArray; // 관리자페이지 - 회원관리리스트에서 삭제or수정에 체크된 회원
	private String checkTokenYn; // 로그인 페이지에서 자동로그인 checkbox의 value값 확인용
	private String phone; // 핸드폰번호
	private String phone1; // 핸드폰번호 첫번째칸
	private String phone2; // 핸드폰번호 두번째
	private String phone3; // 핸드폰번호 세번째칸
	private String extension; // 내선번호
	private int depSeq; // 부서고유 seq
	private String search; // 메인페이지 유저검색
	private String keyword; // 메인페이지 유저검색 키워드
}