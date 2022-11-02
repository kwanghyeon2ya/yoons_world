<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.List"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>
<!-- Header -->
<jsp:useBean id="today" class="java.util.Date" />
<jsp:include page="../../common/header.jsp" flush="false" />


<c:if test="${sessionScope.sessionIdForUser == null}">
	<script>
	alert("로그인화면으로 이동합니다");
	location.href="/login/loginView";
	</script>
</c:if>
<c:if test="${vo.status eq 0}">
	<script>
		alert("삭제된 글입니다");
		location.href="/board/free/list";
	</script>
</c:if>
<script>

$(document).ready(function(){
	console.log("first page : "+$("#more_comments_page").val());
	var page_post_seq = $("#post_seq").val();
	getCommentsList(page_post_seq); //댓글 function ajax 호출
});

function deleteMoveAction(){
	var url = "/board/free/list";
	deleteViewCheck(url);
}
</script>

<!-- Main -->
<div id="main">
	<div class="container">
		<div class="col-12">

			<div class="title-page">
				<h3>자유게시판</h3>
			</div>
			<div class="board_write">

				<div class="area-board-title">
					제목 : <span><c:out escapeXml="" value="${vo.subject}"/></span>
				</div>

				<div class="area-board-info">
					<input type="hidden" id="view_regr_seq" value="${vo.regrSeq}"/>
					<input type="hidden" id="post_seq" value="${vo.postSeq}"/>
					<p>작성자 : <c:out value="${vo.writerName}"/> &nbsp;&nbsp;
					
						<c:if test="${vo.firstInsertDt >= vo.lastUpdateDt}">
							<fmt:formatDate value="${vo.firstInsertDt}" type="date" pattern="yyyy-MM-dd HH:mm" />
								&nbsp;&nbsp; 조회 ${vo.readCnt}
						</c:if>
						
					</p>
					
						<c:if test="${vo.firstInsertDt < vo.lastUpdateDt}">
							원글작성일 : <fmt:formatDate value="${vo.firstInsertDt}" type="date"
								pattern="yyyy-MM-dd" /> &nbsp; /
							<p>수정된 작성일 : <fmt:formatDate value="${vo.lastUpdateDt}" type="date"
								pattern="yyyy-MM-dd" /></p>
								&nbsp;&nbsp; 조회 ${vo.readCnt}
						</c:if>
							</div>
							
						
						
			</div>

				<div class="area-board-btn">
					<c:if test="${sessionScope.sessionSeqForUser == vo.regrSeq}">
						<button type="button"
							onclick="window.location='/board/free/modify?postSeq=${vo.postSeq}'">수정</button>
							<!-- 게시글 수정 -->
						<button type="button"
							onclick="deleteMoveAction()">삭제</button> <!-- 게시글 삭제 -->
					</c:if>
				</div>
				
				<div class="area-board-cont">
					<!-- 첨부파일 영역 -->
					<div class="area-board-attach">
						<c:if test="${!empty anlist}">
							<details>
							    <summary>첨부파일</summary>
							    <ul>
								<c:forEach var="dlist" items="${anlist}">
									<a href="<%=File.separator%>yoons_world<%=File.separator%>files${dlist.fullPath}" download>
										<li>${dlist.fileName}.${dlist.fileType}</li>
									</a>	
								</c:forEach>
								</ul>
							</details>
						</c:if>
					</div>
				
					<!-- 게시글 본문 영역 -->
					${vo.content}
					
				</div>
				
				<!-- 댓글 영역 -->
			<div id="reload_div_parent">
				
				<!-- 페이지 분리 구간 -->
				<input type="hidden" id="more_comments_page" value="1"/>
			</div><!-- reload_div_parent -->
			
				<div class="area-button">
					<button onclick="window.location='/board/free/list'">목록</button>
				</div>
			</div>
		</div>
	</div>

<script>
	$("#nav a").removeClass("current-page-item");
	$("#nav").find('a[href*="/free"]').addClass("current-page-item");
</script>

<!-- Footer -->
<jsp:include page="../../common/footer.jsp" flush="false" />
