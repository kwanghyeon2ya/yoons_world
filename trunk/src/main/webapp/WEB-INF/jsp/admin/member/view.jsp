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
				<h3>ȸ�����</h3>
			</div>
			
			<div class="area-input-info">
				<label for="mem_name" >�̸�</label>
				<input id="mem_name" type="text"/>
			</div>
			
			<div class="area-input-info">
				<label for="mem_id" >���̵�</label>
				<input id="mem_id" type="text"/>
			</div>
			
			<div class="area-input-info">
				<label for="mem_pw" >�н�����</label>
				<input id="mem_pw" type="text"/>
			</div>
			
			<div class="area-input-info">
				<label for="mem_email" >�̸���</label>
				<input id="mem_email" type="text"/>
			</div>
			
			<div class="area-input-info">
				<label for="mem_dep" >�μ�</label>
				<input id="mem_dep" type="text"/>
			</div>
			
			<div class="area-input-info">
				<label for="mem_status" >����</label>
				<select id="mem_status" name="mem_status">
					<option value="1" selected>Ȱ��</option>
					<option value="0">�ߴ�</option>
					<option value="2">Ż��</option>
				</select>
			</div>
			
			<div class="area-input-info">
				<label for="mem_type" >����</label>
				<select id="mem_type" name="mem_type">
					<option value="1" selected>�Ϲ�ȸ��</option>
					<option value="2">������</option>
				</select>
			</div>
			
			<div class="area-input-info">
				<label for="mem_hireDt" >�Ի���</label>
				<input id="mem_hireDt" type="text"/>
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