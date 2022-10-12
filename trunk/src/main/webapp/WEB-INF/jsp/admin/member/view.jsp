<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>

<!-- Header -->
<jsp:include page="../../common/header.jsp" flush="false"/>


<!-- Main -->
<div id="main">
	<div class="container">
		<div class="col-12">
		
			<div class="title-page">
				<h3>회원정보</h3>
			</div>
			
			<div class="area-input-info">
				<label for="userName" >이름</label>
				<input id="userName" type="text" readonly/>
			</div>
			
			<div class="area-input-info">
				<label for="userID" >아이디</label>
				<input id="userID" type="text" readonly/>
			</div>
			
			<div class="area-input-info">
				<label for="userPw" >패스워드</label>
				<input id="userPw" type="password" readonly/>
			</div>
			
			<div class="area-input-info">
				<label for="email" >이메일</label>
				<input id="email" type="text" readonly/>
			</div>
			
			<div class="area-input-info">
				<label for="userDep" >부서</label>
				<input id="userDep" type="text" readonly/>
			</div>
			
			<div class="area-input-info">
				<label for="userStatus" >상태</label>
				<select id="userStatus" name="mem_status" >
					<option disabled="disabled" value="1" selected>활동</option>
					<option disabled="disabled" value="0">중단</option>
					<option disabled="disabled" value="2">탈퇴</option>
				</select>
			</div>
			
			<div class="area-input-info">
				<label for="userType" >구분</label>
				<select id="userType" name="mem_type">
					<option disabled="disabled" value="1" selected>일반회원</option>
					<option disabled="disabled" value="2">관리자</option>
				</select>
			</div>
			
			<div class="area-input-info">
				<label for="userHireDt" >입사일</label>
				<input id="userHireDt" type="text"/>
			</div>
			
			<div class="area-button">
				<button onclick="location.href='/admin/member/modify'">수정</button>
				<button onclick="location.href='/admin/member/list'">취소</button>
			</div>
			
		</div>
	</div>
</div>



<!-- Footer -->
<jsp:include page="../../common/footer.jsp" flush="false"/>