<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.io.File"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>
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
		$(document).ready(function(){
			console.log("first page : "+$("#more_comments_page").val());
			var page_post_seq = $("#post_seq").val();
			getCommentsList(page_post_seq);
		});
		
		function deleteMoveAction(){
			var url = "/board/notice/list";
			deleteViewCheck(url);
		}
	</script>
</head>
<body>
	<div id="page-wrapper">
		
		<!-- Header -->
		<jsp:include page="/WEB-INF/jsp/common/header2.jsp" flush="false"/>
		
		<!-- Container -->
		<div id="container">
			<div class="content">
				
				<h2>공지사항</h2>
				
				<div class="board_info_area">
					<input type="hidden" id="view_regr_seq" value="${vo.regrSeq}"/>
					<input type="hidden" id="post_seq" value="${vo.postSeq}"/>
					
					<div class="board_title"><c:out escapeXml="" value="${vo.subject}"/></div>
					<div class="board_view_cnt" title="조회수">
						<span class="view_cnt">${vo.readCnt}</span>
					</div>

					

					<div class="board_info">
						<div class="between">
							<div>
								<img class="profile" src="/img/common/profile.png">
								<span class="writer"><c:out value="${vo.writerName}"/></span>
							</div>
							<div>
								<span class="date"><fmt:formatDate value="${vo.firstInsertDt}" type="date" pattern="yyyy-MM-dd HH:mm" /></span>
								<c:if test="${vo.lastUpdateDt > vo.firstInsertDt}">
								<span class="date txt_999">(<fmt:formatDate value="${vo.lastUpdateDt}" type="date" pattern="yyyy-MM-dd HH:mm" /> 수정)</span>
								</c:if>
							</div>
						</div>
						<c:if test="${vo.expiryDt gt 0 || vo.expiryHour gt 0}">
							<div class="input_area" style="text-align:right;">
								<span style="font-size: 12px;">
								<c:if test="${vo.expiryDt gt 0}">
								${vo.expiryDt}일 &nbsp;
								</c:if> 
								${vo.expiryHour}시간 후에 고정이 해제됩니다.</span>
							</div>
						</c:if>
					</div>
					
					<!-- 첨부파일 영역 -->
					<c:if test="${!empty anlist}">
				    <ul class="file_list">
						<c:forEach var="dlist" items="${anlist}">
						<li>
							<a class="file_name" href="<%=File.separator%>yoons_world<%=File.separator%>files${dlist.fullPath}" download>${dlist.fileName}.${dlist.fileType}</a>
						</li>
						</c:forEach>
					</ul>
					</c:if>
				</div>

				<div class="board_content_area">
					<!-- 게시글 본문 영역 -->
					${vo.content}
				</div>
					
				<!-- 댓글 영역 -->
				<div id="reload_div_parent" class="comm_area">
					<!-- 페이지 분리 구간 -->
					<input type="hidden" id="more_comments_page" value="1"/>
				</div>
			
				<div class="btn_area right">
					
					<c:if test="${sessionScope.sessionSeqForUser == vo.regrSeq}">
					<button type="button" class="btn type_02 size_s bg_purple f_left" onclick="window.location='/board/notice/modify?postSeq=${vo.postSeq}'">수정</button>
					<button type="button" class="btn type_02 size_s bg_aaa f_left" onclick="deleteMoveAction()">삭제</button>
					</c:if>
					
					<button type="button" class="btn type_02 size_s bg_purple" onclick="window.location='/board/notice/list'">목록</button>
					
				</div>
				
			</div>
		</div>
		
		<!-- Footer -->
		<jsp:include page="/WEB-INF/jsp/common/footer.jsp" flush="false"/>
		
	</div>
</body>
</html>