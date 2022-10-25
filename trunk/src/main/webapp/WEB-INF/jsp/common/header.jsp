<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="/js/browser.min.js"></script>
	<script src="/js/breakpoints.min.js"></script>	
	<script src="/js/summernote-lite.js"></script>
	<script src="/js/summernote-ko-KR.js"></script>
	<script src="/js/boardWriteModify.js"></script>
	<script src="/js/commentsWriteModify.js"></script>
	<script src="/js/delview.js"></script>
	<script src="/js/nestedcommWrite.js"></script>
	<script src="/js/delcomments.js"></script>
	<script src="/js/commnetsShowHide.js"></script>
	<script src="/js/randomName.js"></script>
	<script>	
		/* console.log(performance.getEntriesByType('navigation')[0]);	
		console.log(performance.getEntriesByType('navigation')[0].type == 'reload');
		console.log(window.performance.getEntriesByType('navigation')[0]);
		console.log(performance.getEntriesByType('navigation')[0].type);
		console.log(window.performance.getEntriesByType("navigation")[0].type == "back_forward");
		console.log(window.performance.getEntriesByType("navigation")[0].type === "back_forward");
		console.log(window.performance.navigation.type === 2);
		console.log(window.performance.navigation.type);
		if(window.performance.getEntriesByType("navigation")[0].type == "back_forward") {

			location.reload();

		} */
		console.log(window.performance.navigation.type == 2);
		window.onpageshow = function(event){ // 뒤로가기 공부
			if(event.persisted){ //캐시 남아있는지 확인 후 남아있다면 true
				console.log(event.persisted);
				location.reload(true);
			}
		} 
	</script>
	
</head>
<body>
	<div id="page-wrapper">
		<!-- Header -->
		<div id="header-wrapper">
			<div class="container">
				<div class="row">
					<div class="col-12">
						<header id="header">
							<h1><a href="/main" id="logo">YOONS WoRLD</a></h1>
							<nav id="nav">
								<c:if test="${sessionScope.sessionIdForUser == null}">
		                            <a href="/login/loginView" class="tag-show-m">로그인하세요</a>
									<a href="/main" class="current-page-item">Home</a>
									<a href="/board/notice/list">공지사항 </a>
									<a href="/board/free/list">자유게시판</a>
									<a href="/board/pds/list">자료실</a>
		                            <a class="tag-show-m"></a>
		                        </c:if>
		                        <c:if test="${sessionScope.sessionIdForUser != null}">
		                            <a class="tag-show-m">Hello, ${sessionScope.sessionNameForUser} 님</a>
									<a href="/main" class="current-page-item">Home</a>
									<a href="/board/notice/list">공지사항 </a>
									<a href="/board/free/list">자유게시판</a>
									<a href="/board/pds/list">자료실</a>
									<!-- <a href="">게시판관리</a> 추후 개발 예정-->
									<a href="/admin/member/list">회원관리</a> <!-- 추후 관리자일 경우만 노출되도록 할것 -->
									<a href="">마이페이지</a> <!-- 추후 개발 예정 -->
		                            <a href="/login/logout" class="tag-show-m">Logout</a>
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