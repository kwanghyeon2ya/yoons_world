package com.iyoons.world.common;
//

/*
 * 2022. 11.18
 * @author : 변광현
 * @Descrption
 * 전역에서 쓰는 고정 상수들
 * 
 * 
 */
public class FinalVariables {

	/*
	 * 활동 영역에 대한 상수
	 * */
	public final static String TARGET_BOARD = "01"; // 활동 영역 - 게시글에 대한 활동
	public final static String TARGET_USER = "02"; // 활동 영역 - 회원에 대한 활동
	
	public final static String ACTION_TYPE_LIKE = "01"; // 활동 세부 내역 - 좋아요
	
	
	
	/*
	 * UnCheckedException에 대한 상수
	 * */
	public final static String NULLPOINT_CODE = "1111"; // 널포인트 예외 코드
	public final static String NOSUCHALGORITH_CODE = "2222"; // 알고리즘 예외 코드
	public final static String NUMBERFORMAT_CODE = "3333"; //넘버포맷 예외 코드
	public final static String SQL_CODE = "4444"; // SQL 예외 코드
	public final static String FORBIDDEN_FILE_TYPE_CODE = "5555"; // 금지된 파일 타입 예외 코드
	public final static String OVER_THE_FILE_SIZE_CODE = "6666"; // 금지된 파일 타입 예외 코드
	public final static String EXCEPTION_CODE = "9999"; // 최상위 익셉션 코드
	
	
	
}
