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
				<h3>ȸ������</h3>
			</div>
			
			<div class="area-input-info">
				<label for="userName" >�̸�</label>
				<input id="userName" type="text" readonly/>
			</div>
			
			<div class="area-input-info">
				<label for="userID" >���̵�</label>
				<input id="userID" type="text" readonly/>
			</div>
			
			<div class="area-input-info">
				<label for="userPw" >�н�����</label>
				<input id="userPw" type="password" readonly/>
			</div>
			
			<div class="area-input-info">
				<label for="email" >�̸���</label>
				<input id="email" type="text" readonly/>
			</div>
			
			<div class="area-input-info">
				<label for="userDep" >�μ�</label>
				<input id="userDep" type="text" readonly/>
			</div>
			
			<div class="area-input-info">
				<label for="userStatus" >����</label>
				<select id="userStatus" name="mem_status" >
					<option disabled="disabled" value="1" selected>Ȱ��</option>
					<option disabled="disabled" value="0">�ߴ�</option>
					<option disabled="disabled" value="2">Ż��</option>
				</select>
			</div>
			
			<div class="area-input-info">
				<label for="userType" >����</label>
				<select id="userType" name="mem_type">
					<option disabled="disabled" value="1" selected>�Ϲ�ȸ��</option>
					<option disabled="disabled" value="2">������</option>
				</select>
			</div>
			
			<div class="area-input-info">
				<label for="userHireDt" >�Ի���</label>
				<input id="userHireDt" type="text"/>
			</div>
			
			<div class="area-button">
				<button onclick="location.href='/admin/member/modify'">����</button>
				<button onclick="location.href='/admin/member/list'">���</button>
			</div>
			
		</div>
	</div>
</div>



<!-- Footer -->
<jsp:include page="../../common/footer.jsp" flush="false"/>