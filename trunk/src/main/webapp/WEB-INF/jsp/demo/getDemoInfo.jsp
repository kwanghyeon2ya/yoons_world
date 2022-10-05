<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<meta charset="UTF-8">
    
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
		
		<table>
			<thead>
				<tr>
					<th>NO</th>
					<th>Title</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>${info.demoNo}</td>
					<td>${info.demoTitle}</td>
				</tr>
			</tbody>
		
		</table>
		<a href="/demo/regDemoInfo?demoNo=${info.demoNo}">수정</a>
		
	</div>

</body>
</html>