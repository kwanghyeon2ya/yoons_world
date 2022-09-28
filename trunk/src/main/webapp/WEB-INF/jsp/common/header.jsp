<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

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
	                            <a class="a-login">Hello, User</a> <!--로그인 시에만 노출-->
								<a href="index.html" class="current-page-item">Home</a>
								<a href="twocolumn1.html">공지사항 </a>
								<a href="twocolumn2.html">자유게시판</a>
								<a href="onecolumn.html">자료실</a>
								<a href="mypage.html" class="a-login">마이페이지</a> <!--로그인 시에만 노출-->
	                            <a class="a-login">Logout</a> <!--로그인 시에만 노출-->
							</nav>
						</header>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>