<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>

<!DOCTYPE html>
<html>
<head>
	<title>Yoons WoRLD</title>
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" type="text/css" href="/css/main.css">
	<link rel="stylesheet" type="text/css" href="/css/intro.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="/js/browser.min.js"></script>
	<script src="/js/breakpoints.min.js"></script>	
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
								<c:if test="${sessionScope.sessionIdForUser == null}">
		                            <a href="/login/loginView" class="a-login">로그인하세요</a>
									<a href="/main" class="current-page-item">Home</a>
									<a href="/board/free/list">공지사항 </a>
									<a href="/board/free/list">자유게시판</a>
									<a href="/board/free/list">자료실</a>
		                            <a class="a-login"></a>
		                        </c:if>
		                        <c:if test="${sessionScope.sessionIdForUser != null}">
		                            <a class="a-login">Hello, ${sessionScope.sessionNameForUser} 님</a> <!--로그인 시에만 노출-->
									<a href="index.html" class="current-page-item">Home</a>
									<a href="/board/free/list">공지사항 </a>
									<a href="/board/free/list">자유게시판</a>
									<a href="/board/free/list">자료실</a>
									<a href="mypage.html" class="a-login">마이페이지</a> <!--로그인 시에만 노출-->
		                            <a href="/login/logout" class="a-login">Logout</a> <!--로그인 시에만 노출-->
		                        </c:if>
							</nav>
					</header>
				</div>
			</div>
		</div>
	</div>
</div>
	
<!-- Main -->

<div class="intro-container">
  <div class="snow"></div>
  <div class="tree1"></div>
  <div class="tree2"></div>
  <div class="house">
  <div class="roof1">
    <div class="b1"></div>
    <div class="b2"></div>
  </div>
  <div class="wall1">
    <div class="w3">
      <div class="window1">
        <div class="glass1"></div>
      </div>
    </div>
  </div>
  <div class="wall2">
    <div class="light">
      <div class="w1">
        <div class="window">
          <div class="glass"></div>
        </div>
      </div>
      <div class="w2">
        <div class="window">
          <div class="glass"></div>
        </div>
      </div>
    </div>
    <div class="door">
      <div class="handle"></div>
    </div>
    <div class="snw1"></div>
    <div class="snw2"></div>
  </div>
  <div class="wall3">
    <div class="b3"></div>
    <div class="b4"></div>
    <div class="chimney">
      <div class="top">
        <div class="smoke">
          <div class="s1"></div>
          <div class="s2"></div>
          <div class="s3"></div>
        </div>
        <div class="shne1"></div>
        <div class="shne2"></div>
      </div>
    </div>
    <div class="sn">
      <div class="dr1"></div>
      <div class="dr2"></div>
      <div class="dr3"></div>
    </div>
    <div class="sn1">
      <div class="dr4"></div>
    </div>
    <div class="sh1"></div>
    <div class="sh2"></div>
    <div class="sh3"></div>
    <div class="sh4"></div>
    <div class="sh5"></div>
    </div>
  </div>
  <div class="snowfall"></div>
  <div class="cover"></div>
  <div class="bottom">
    <div class="bt1"></div>
    <div class="bt2"></div>
  </div>
  <div class="fence">
    <div class="fn1">
      <div class="screw"></div>
    </div>
    <div class="fn2">
      <div class="screw"></div>
    </div>
    <div class="fn3">
      <div class="screw"></div>
    </div>
    <div class="stck"></div>
  </div>
</div>

<script src="/js/util.js"></script>
<script src="/js/main.js"></script>

</body>
</html>