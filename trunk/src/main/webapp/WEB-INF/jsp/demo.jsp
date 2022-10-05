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
    
	<title>������</title>
	
	<link rel="stylesheet" type="text/css" href="css/demo.css?time=${now}">
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script src="js/demo.js?time=${now}"></script>
	
</head>
<body>
	<div id="container">
		<div id="panel">
			<img class="img_logo" alt="" src="/resources/wyoons/images/Igse/log-in/logo.png">
		</div>
		
		<ul>
			<c:forEach var="item" items="${list}">
				<li> <a></a></li>
			
			</c:forEach>			
		</ul>

		<table>
			<thead>
				<tr>
					<th>NO</th>
					<th>Title</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="item" items="${list}">
				<tr>
					<td>${item.demoNo}</td>
					<td><a href="javascript:void(0);">${item.demoTitle}</a></td>
				</tr>
				</c:forEach>			
			</tbody>
		
		</table>

		
	</div>

</body>
</html>