package com.iyoons.world.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class UserVO {
	
	private String userId; // 유저 ID
	private int userSeq;  // 유저 고유번호
	private String userPw; // 유저비밀번호
	private String changeUserPw; // 새로 바꿀 비밀번호
	private String userName; // 유저이름
	private String email; // 이메일
	private String emailPart1; // 이메일 앞부분
	private String emailPart2; // 이메일 선택부분
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date hireDt; //입사일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date regDt;; //등록일
	private int userType; //회원 구분 (0:일반, 1:관리자)
	private int userStatus; //회원 상태 (0:활동, 1:탈퇴)
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date lastLoginDt; //마지막 로그인 일자
	private int regrSeq; //회원정보 등록자
	private int updrSeq; //회원정보 수정자
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date lastUpdateDt; //회원정보 수정일자
	private String depName; // 부서이름
	private List<String> userSeqArray; // 관리자페이지 - 회원관리리스트에서 삭제or수정에 체크된 회원
	private String checkTokenYn; // 로그인 페이지에서 자동로그인 checkbox의 value값 확인용
	private String phone; // 완성된 핸드폰번호
	private String phone1; // 핸드폰번호 첫번째칸
	private String phone2; // 핸드폰번호 두번째
	private String phone3; // 핸드폰번호 세번째칸
	private String extension; // 내선번호
	private int depSeq; // 부서고유 번호
	private String search; // 메인페이지 유저검색
	private String keyword; // 메인페이지 유저검색 키워드
	private String firstUpdatePw; // 초기비밀번호 변경 유무 변경안함 0 / 변경함 1
	private String picture; //프로필사진 이름 및 확장자 (예 picture.jpg 형태
	private String picturePath; //프로필 사진 저장 경로
}