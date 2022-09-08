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
	<title>윤스월드</title>
	<link rel="stylesheet" type="text/css" href="/css/common.css?time=${now}">
	<link rel="stylesheet" type="text/css" href="/css/login/login.css?time=${now}">
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script src="js/common.js?time=${now}"></script>
	<script src="js/login/login.js?time=${now}"></script>
</head>
<body>
	<div class="login_container">
		<div class="logo01">윤스월드</div>
		
	</div>
</body>
</html>