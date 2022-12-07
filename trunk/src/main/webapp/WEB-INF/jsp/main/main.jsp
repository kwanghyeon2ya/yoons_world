<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>

<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/WEB-INF/jsp/inc/import.jsp" flush="false" />
	
	<link rel="stylesheet" type="text/css" href="/css/main/main.css">
	
	<script src="/js/main.js"></script>
	
</head>
<body>
	<div id="page-wrapper">
		
		<!-- Header -->
		<jsp:include page="/WEB-INF/jsp/common/header2.jsp" flush="false"/>
		
		<!-- Container -->
		<div id="container">
			<div class="content">
				
				<!-- main_wrapper begin -->
				<div class="main_wrappper">
					
					<!-- 메인 영역 (right) -->
					<div>
						<!-- 로그인 영역 -->
						<div class="login_area">
							<%-- 로그인 전 --%>
							<c:if test="${sessionScope.sessionSeqForUser == null}">
							<div class="login_info">
								<div>
									<p>
										<strong>Yoons World</strong> - 윤선생 직원들의 새로운 세상
									</p>
								</div>
							</div>
							<button onClick="location.href='/login/loginView'">LOGIN</button>
							</c:if>
							
							<%-- 로그인 후 --%>
							<c:if test="${sessionScope.sessionSeqForUser != null}">
							<div class="login_info">
								<img class="profile" src="/img/common/profile.png">
								<div>
									<p>
										<strong>${sessionScope.sessionNameForUser}</strong>님 환영합니다.
									</p>
									<p>${sessionScope.sessionSeqForAdmin != null ? "관리자" : "일반 회원"}</p>
								</div>
								<div>
									<button type="button" class="btn type_02 size_s bg_purple" onclick="location.href='/admin/member/list'">회원관리</button>
								</div>
							</div>
							<button onClick="location.href='/login/logout'">LOGOUT</button>
							</c:if>
						</div>
						
						<!-- 조회수 TOP 리스트 -->
						<h3>조회수 TOP (한달)</h3>
						<div id="rank_board_list" class="rank_area"></div>
						<button id="rank_more_btn">더보기</button>
						
					</div>
					
					<!-- 메인 영역 (left) -->
					<div>
						<!-- 전체 게시글 리스트 -->
						<div id="main_board_list"></div>
					</div>
					
				</div>
				<!-- main_wrapper end -->
				
			</div>
		</div>
		
		<!-- footer -->
		<jsp:include page="/WEB-INF/jsp/common/footer.jsp" flush="false"/>
		
	</div>

</body>
</html>