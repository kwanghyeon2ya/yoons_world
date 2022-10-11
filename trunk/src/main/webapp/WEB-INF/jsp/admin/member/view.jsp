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
				<h3>회원목록</h3>
			</div>
			
			<div class="area-input-info">
				<label for="mem_name" >이름</label>
				<input id="mem_name" type="text"/>
			</div>
			
			<div class="area-input-info">
				<label for="mem_id" >아이디</label>
				<input id="mem_id" type="text"/>
			</div>
			
			<div class="area-input-info">
				<label for="mem_pw" >패스워드</label>
				<input id="mem_pw" type="text"/>
			</div>
			
			<div class="area-input-info">
				<label for="mem_email" >이메일</label>
				<input id="mem_email" type="text"/>
			</div>
			
			<div class="area-input-info">
				<label for="mem_dep" >부서</label>
				<input id="mem_dep" type="text"/>
			</div>
			
			<div class="area-input-info">
				<label for="mem_status" >상태</label>
				<select id="mem_status" name="mem_status">
					<option value="1" selected>활동</option>
					<option value="0">중단</option>
					<option value="2">탈퇴</option>
				</select>
			</div>
			
			<div class="area-input-info">
				<label for="mem_type" >구분</label>
				<select id="mem_type" name="mem_type">
					<option value="1" selected>일반회원</option>
					<option value="2">관리자</option>
				</select>
			</div>
			
			<div class="area-input-info">
				<label for="mem_hireDt" >입사일</label>
				<input id="mem_hireDt" type="text"/>
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