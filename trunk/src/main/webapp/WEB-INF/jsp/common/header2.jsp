<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",1L);
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>
<header id="header">
	
	<!-- 상단 메뉴 -->
	<div id="gnb">
		<div id="btn_side_menu" class="btn_menu tag_m_only">
			<span></span>
			<span></span>
			<span></span>
		</div>
		
		<a href="/main" id="logo">YOONS WoRLD</a>
		<nav class="tag_pc_only">
			<!--
			<a href="/main" class="current-page-item">Home</a>
			-->
			<a href="/board/notice/list" >공지사항 </a>
			<a href="/board/free/list">자유게시판</a>
			<a href="/board/pds/list">자료실</a>
			<a href="javascript:alert('서비스 준비중입니다.');">회의실 예약</a>
		</nav>
		
		<c:if test="${sessionScope.sessionSeqForUser != null}">
		<a href="/login/logout" class="btn_logout">
			<img title="Logout" src="/img/common/logout.png">
		</a>
		</c:if>
	</div>
	
	<!-- 사이드 메뉴 -->
	<div id="snb" class="tag_m_only">
		
		<%-- 로그인 전 --%>
		<c:if test="${sessionScope.sessionSeqForUser == null}">
		<div onclick="location.href='/login/loginView';">
			<img class="login_profile" src="/img/common/profile.png">
			<div>
				<p>로그인 하세요</p>
			</div>
		</div>
		</c:if>
		
		<%-- 로그인 후 --%>
		<c:if test="${sessionScope.sessionSeqForUser != null}">
		<div>
			<img class="login_profile" src="/img/common/profile.png">
			<div>
				<p>Hello, ${sessionScope.sessionNameForUser} 님</p>
				<p>${sessionScope.sessionSeqForAdmin != null ? "관리자" : "일반 회원"}</p>
			</div>
		</div>
		</c:if>
		
		<nav>
			<a href="/board/notice/list">
				<img src="/img/common/icon_notice.png">
				<span>공지사항</span>
			</a>
			<a href="/board/free/list">
				<img src="/img/common/icon_free_board.png">
				<span>자유게시판</span>
			</a>
			<a href="/board/pds/list">
				<img src="/img/common/icon_archive.png">
				<span>자료실</span>
			</a>
			<c:if test="${sessionScope.sessionSeqForAdmin != null}">
			<a href="/admin/member/list">
				<img src="/img/common/icon_members.png">
				<span>회원관리</span>
			</a>
			</c:if>
		</nav>
	</div>
	
</header>
