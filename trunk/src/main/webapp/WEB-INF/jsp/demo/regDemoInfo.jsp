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
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMddhhmmssSSS" var="now"/>

<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
    
	<title>윤선생</title>
	
	<link rel="stylesheet" type="text/css" href="css/demo.css?time=${now}">
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script src="js/demo.js?time=${now}"></script>
	
</head>
<body>
	<div id="container">
		<div id="panel">
			<img class="img_logo" alt="" src="/resources/wyoons/images/Igse/log-in/logo.png">
		</div>
		
		<c:if test="${param.demoNo ne null }">
			<c:set var="regAction" value="/demo/modDemoProc"/>
		</c:if>
		<c:if test="${param.demoNo eq null }">
			<c:set var="regAction" value="/demo/regDemoProc"/>
		</c:if>
		
		<form action="${regAction}" method="post">
			<c:if test="${param.demoNo ne null }">
				<input type="hidden" name="demoNo" value="${param.demoNo}"/>
			</c:if>
			
			<table>
				<thead>
					<tr>
						<c:if test="${param.demoNo ne null }">
							<th>NO</th>
						</c:if>
						<th>Title</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<c:if test="${param.demoNo ne null }">
							<td>${info.demoNo}</td>
						</c:if>
						<td>
							<input type="text" name="demoTitle" value="${info.demoTitle}"/>
						</td>
					</tr>
				</tbody>
			</table>
			<button type="submit">저장</button>
		</form>		
	</div>
</body>
</html>