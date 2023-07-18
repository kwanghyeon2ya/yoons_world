package com.iyoons.world.common;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.iyoons.world.vo.UserVO;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

public class JWTUtil {

	
	protected String secretKey = "rhkdgusWkd";//JWT secret key
	
	/**
	 * @param 유저정보가 들어있는 UserVO 객체
	 * @description Access token 발행
	 * @return Access token
	 * */
	public String generateAccessToken(UserVO userVO) {
		Date ext = new Date();
		
		String jwt = Jwts.builder().setHeader(getHeader()) // 헤더설정
				.setClaims(getClaims(userVO)) // Claims 설정
				.setSubject("user") // 토큰의 용도
				.setIssuedAt(new Date()) // 토근 생성일
				.setExpiration(new Date(ext.getTime() + FinalVariables.EXPIRATION_ACCESS))// 토큰 만료 시간
				.signWith(SignatureAlgorithm.HS256, secretKey.getBytes()) // HS256과 secretKey로 서명정보 추가
				// 해당 토큰이 조작되었거나 변경되지 않았음을 확인하는 용도 - 서버 측에서 관리하는 비밀키가 유출되지 않는 이상 복호화할 수 없음
				.compact(); // 토큰생성
		return jwt;
	}
	
	
	/**
	 * @param 유저정보가 들어있는 UserVO 객체
	 * @description Refresh token 발행
	 * @return Refresh token
	 * */
	public String generateRefreshToken(UserVO userVO) {
		Date ext = new Date();
		HashMap<String, Object> claimMap = new HashMap<>();//Claims에 들어갈 hashMap객체
		claimMap.put("userId", userVO.getUserId());
		claimMap.put("userSeq", userVO.getUserSeq());
		
		String jwt = Jwts.builder().setHeader(getHeader()) // 헤더설정
				.setClaims(claimMap) // Claims 설정
				.setSubject("user") // 토큰의 용도
				.setIssuedAt(new Date()) // 토근 생성일
				.setExpiration(new Date(ext.getTime() + FinalVariables.EXPIRATION_REFRESH))// 토큰 만료 시간
				.signWith(SignatureAlgorithm.HS256, secretKey.getBytes()) // HS256과 secretKey로 서명정보 추가
				// 해당 토큰이 조작되었거나 변경되지 않았음을 확인하는 용도 - 서버 측에서 관리하는 비밀키가 유출되지 않는 이상 복호화할 수 없음
				.compact(); // 토큰생성
		return jwt;
	}
	
	
	
	/**
     * 토큰 검증
     * @throws ExpiredJwtException,Exception
     * @param  JWT token
     * @return 검증 결과(boolean)
     */
    public boolean validateToken(String token) {
        try {
            Jwts.parser().setSigningKey(secretKey.getBytes()).parseClaimsJws(token).getBody();
            return true;
        } catch (ExpiredJwtException e) { // 토큰이 만료되었을 경우
            return false;
        } catch (Exception e) { // 나머지 에러의 경우
            return false;
        }
    }
	
	/**
	 * @param token,key값
	 * @discription JWT token분석하고 Claim속 key값의 value를 return한다
	 * @return Claim속 key값의 value
	 * */
    public Claims getClaimByToken(String token) {
        return Jwts.parser().setSigningKey(secretKey.getBytes()).parseClaimsJws(token).getBody();
    }
    
    /**
     * @param JWT token,찾을 key값
     * @description JWT token을 복호화한 후  key에 대한 value값을 return한다
     * @return Claims객체 속 value값
     * */
    public String getValueFromToken(String token,String key) {
    	return String.valueOf(getClaimByToken(token).get(key));
    }
    
    
	/**
	 * @param 
	 * @description JWT토큰 Header값 세팅
	 * @return header값이 들어간 Map
	 * */
	public Map<String,Object> getHeader() {
		Map<String, Object> headers = new HashMap<>();
		headers.put("typ", "JWT");
		headers.put("alg", "HS256");
		headers.put("regDate", System.currentTimeMillis());
		return headers;
	}
	
	/**
	 * @param 유저 정보가 들어간 vo객체
	 * @description JWT토큰의 Claims객체 세팅
	 * @return Claims값이 들어간 Map
	 * */
	public Map<String,Object> getClaims(UserVO userVO){
		Map<String, Object> payloads = new HashMap<>();
		payloads.put("userId", userVO.getUserId());
		payloads.put("userSeq", userVO.getUserSeq());
		payloads.put("userName", userVO.getUserName());
		payloads.put("firstUpdatePw", userVO.getFirstUpdatePw());
		payloads.put("picture",userVO.getPicture());
		return payloads; 
	}
	
	
}
