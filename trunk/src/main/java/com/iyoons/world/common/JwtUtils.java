package com.iyoons.world.common;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;


public class JwtUtils {

	private static final String secretKey =  "secretKey";
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public String createJWT(String userId,int userSeq) { // 토큰 생성 메서드
		
		String userSeqForToken = Integer.toString(userSeq);
		
		Map<String, Object> headers = new HashMap<>();
		headers.put("typ", "JWT");
		headers.put("alg", "HS256");
		headers.put("regDate", System.currentTimeMillis());
		
		Map<String,Object> payloads = new HashMap<>();
		payloads.put("userId",userId);
		payloads.put("userSeq",userSeqForToken);
		
		Long expiredTime = 1000 * 60L * 60L * 2L; // 토큰 유효시간 2시간
		
		Date ext = new Date();
		ext.setTime(ext.getTime() + expiredTime);
		
		
		//토큰 빌더
		String jwt = Jwts.builder()
				.setHeader(headers) // 헤더설정
				.setClaims(payloads) // Claims 설정 
				.setSubject("user") // 토큰의 용도
				.setIssuedAt(new Date()) // 토근 생성일
				.setExpiration(ext) // 토큰 만료 시간 
				.signWith(SignatureAlgorithm.HS256, secretKey.getBytes()) // HS256과 secretKey로 서명정보 추가
								//해당 토큰이 조작되었거나 변경되지 않았음을 확인하는 용도 - 서버 측에서 관리하는 비밀키가 유출되지 않는 이상 복호화할 수 없음
				.compact(); // 토큰생성

		
		return jwt;
	}
	
	
	
	public Map<String,Object> verifyJWT(String jwt)throws UnsupportedEncodingException {
	
		Map<String, Object> verifyMap = null;
		try {
			Claims claims = Jwts.parser()
					.setSigningKey(secretKey.getBytes("UTF-8")) //키 설정
					.parseClaimsJws(jwt)//jwt의 정보를 파싱해서 시그니처 값을 검증
					.getBody();
			
			verifyMap = claims;
			
		} catch(ExpiredJwtException ep) { //토큰 만료 예외처리
			ep.printStackTrace();
			logger.info("Catch expiredToken exception", ep);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("오류발생 : "+e);
		}
		
	return verifyMap;
	}
	
	// Request의 Header에서 token 값을 가져옴
    public String resolveToken(HttpServletRequest request) {
        return request.getHeader(HttpHeaders.AUTHORIZATION);
    }

    // 토큰의 유효성 + 만료일자 확인
    public boolean validateToken(String jwtToken) {
        try {
            Jws<Claims> claims = Jwts.parser().setSigningKey(secretKey).parseClaimsJws(jwtToken);
            return !claims.getBody().getExpiration().before(new Date());
        }catch (Exception e) {
        	logger.info(""+e);
            return false;
        }
    }

}
