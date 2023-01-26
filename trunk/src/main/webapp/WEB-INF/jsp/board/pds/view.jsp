<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.List"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>

<% pageContext.setAttribute("CRLF", "\r\n");%>
<% pageContext.setAttribute("LF", "\n"); %>

<jsp:useBean id="today" class="java.util.Date" />

<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/WEB-INF/jsp/inc/import.jsp" flush="false" />
	<jsp:include page="/WEB-INF/jsp/inc/boardImport.jsp" flush="false" />
		
	<link rel="stylesheet" type="text/css" href="/css/board/board.css">

	<c:if test="${sessionScope.sessionSeqForUser == null}">
		<script>
		alert("로그인화면으로 이동합니다");
		location.href="/login/loginView";
		</script>
	</c:if>

	<script>
		$(document).ready(function() {
			console.log("first page : " + $("#more_comments_page").val());
			var page_post_seq = $("#post_seq").val();
			getCommentsList(page_post_seq);
		});
	
		function deleteMoveAction() {
			var url = "/board/pds/list";
			deleteViewCheck(url);
		}
	</script>
</head>

<body>
	<div id="page-wrapper">
		
		<!-- Header -->
		<jsp:include page="/WEB-INF/jsp/common/header2.jsp" flush="false"/>

	<div class="container">
		<div class="content">

			<h3>자료실</h3>

				<div class="board_info_area">
					<input type="hidden" id="view_regr_seq" value="${vo.regrSeq}"/>
					<input type="hidden" id="post_seq" value="${vo.postSeq}"/>
					
					<div class="board_title"><c:out escapeXml="true" value="${vo.subject}"/></div>
					<div class="board_view_cnt" title="조회수">
						<span class="view_cnt">${vo.readCnt}</span>
					</div>
	
					<div class="board_info">
						<div class="between">
							<div>
								<c:if test="${vo.picture eq null}">
									<img class="profile" src="/img/common/profile.png">
								</c:if>
								<c:if test="${vo.picture ne null}">
									<img class="profile" src="<%=File.separator%>yoons_world<%=File.separator%>profile<%=File.separator%>${vo.picture}" />
								</c:if>
								<span class="writer"><c:out value="${vo.writerName}"/></span>
							</div>
							<div>
								<span class="date"><fmt:formatDate value="${vo.firstInsertDt}" type="date" pattern="yyyy-MM-dd HH:mm" /></span>
								<c:if test="${vo.lastUpdateDt > vo.firstInsertDt}">
								<span class="date txt_999">(<fmt:formatDate value="${vo.lastUpdateDt}" type="date" pattern="yyyy-MM-dd HH:mm" /> 수정)</span>
								</c:if>
							</div>
						</div>
					</div>
					
					<!-- 첨부파일 영역 -->
					<c:if test="${!empty anlist}">
				    <ul class="file_list">
						<c:forEach var="dlist" items="${anlist}">
						<li>
							<a class="file_name" href="<%=File.separator%>yoons_world<%=File.separator%>files${dlist.fullPath}" download="${dlist.fileName}.${dlist.fileType}">${dlist.fileName}.${dlist.fileType}</a>
						</li>
						</c:forEach>
					</ul>
					</c:if>
				</div>
					
				<div class="board_content_area">
					<!-- 게시글 본문 영역 -->
					${fn:replace(fn:replace(fn:escapeXml(vo.content), CRLF, '<br/>'), LF, '<br/>')}
					
				</div>
					
				<!-- 댓글 영역 -->
				<div id="reload_div_parent" class="comm_area">
					<!-- 페이지 분리 구간 -->
					<input type="hidden" id="more_comments_page" value="1"/>
				</div>
			
				<div class="btn_area right">
					
					<c:if test="${sessionScope.sessionSeqForUser == vo.regrSeq}">
					<button type="button" class="btn type_02 size_s bg_purple f_left" onclick="window.location='/board/pds/modify?postSeq=${vo.postSeq}'">수정</button>
					<button type="button" class="btn type_02 size_s bg_aaa f_left" onclick="deleteMoveAction()">삭제</button>
					</c:if>
					
					<button type="button" class="btn type_02 size_s bg_purple" onclick="window.location='/board/pds/list'">목록</button>
				</div>
				
			</div>
		</div>
		
		<!-- Footer -->
		<jsp:include page="/WEB-INF/jsp/common/footer.jsp" flush="false"/>
		
	</div>
</body>
</html>
