<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",1L);
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>
<jsp:useBean id="today" class="java.util.Date" />
<!DOCTYPE html>
<html>
<head>
	<title>Yoons WoRLD</title>
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" type="text/css" href="/css/main.css?time=${today}">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">	
	<script src="/js/browser.min.js"></script>
	<script src="/js/breakpoints.min.js"></script>	
	<script src="/js/summernote-lite.js"></script>
	<script src="/js/summernote-ko-KR.js"></script>
	<script src="/js/write.js"></script>
	<script src="/js/comments.js"></script>
	<script src="/js/delview.js"></script>
	<script src="/js/nestedcomm.js"></script>
	
	
</head>
<body>
	<div id="page-wrapper">
		<!-- Header -->
		<div id="header-wrapper">
			<div class="container">
				<div class="row">
					<div class="col-12">
						<header id="header">
							<h1><a href="index.html" id="logo">YOONS WoRLD</a></h1>
							<nav id="nav">
								<c:if test="${sessionScope.sid == null}">
		                            <a class="a-login">�α����ϼ���</a>
									<a href="/main" class="current-page-item">Home</a>
									<a href="/board/free/list">�������� </a>
									<a href="/board/free/list">�����Խ���</a>
									<a href="/board/free/list">�ڷ��</a>
		                            <a class="a-login"></a>
		                        </c:if>
		                        <c:if test="${sessionScope.sid != null}">
		                            <a class="a-login">Hello, ${sessionScope.sname} ��</a> <!--�α��� �ÿ��� ����-->
									<a href="index.html" class="current-page-item">Home</a>
									<a href="/board/free/list">�������� </a>
									<a href="/board/free/list">�����Խ���</a>
									<a href="/board/free/list">�ڷ��</a>
									<a href="mypage.html" class="a-login">����������</a> <!--�α��� �ÿ��� ����-->
		                            <a href="/login/logout" class="a-login">Logout</a> <!--�α��� �ÿ��� ����-->
		                        </c:if>
							</nav>
						</header>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>