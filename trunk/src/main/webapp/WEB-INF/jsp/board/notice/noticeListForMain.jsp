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

<c:if test="${sessionScope.sessionIdForUser == null}">
	<script>
		alert("로그인이 필요합니다")
		window.location.href="/login/loginView";
	</script>
</c:if>

<%-- <c:if test="${count > 0}">
    <c:if test="${searchCheck != null && searchCheck != ''}">
    검색된 키워드 "${keyword}"<br/>
    </c:if>
</c:if> --%>

<!-- Header -->
<jsp:include page="../../common/header.jsp" flush="false"/>

<!-- Main -->
<div id="main">
	<div class="container">
		<div id="every_board_list" class="col-12">
		
		
			<div id="notice_board_list">
		
				<div class="title-page">
					<h3>공지사항</h3>
				</div>
							
				<div id="notice_board_list" class="board_list">
					<div class="top">
						<div class="title">제목</div>
						<div class="count">조회수</div>
					</div>
					
					<c:if test="${count == 0}">
						<div style="width:100%; text-align:center;">
							<div>작성된 글이 없습니다</div>
						</div>
					</c:if>
					
					<c:if test="${count > 0}">
					
						<c:forEach var="fixedBoardList" items="${fixedBoardList}">
							<div>
								<div class="num" style="color:#DC143C">[중요]</div>
								<div class="title"><a href="/board/notice/view?postSeq=${fixedBoardList.postSeq}"><c:out value="${fixedBoardList.subject}"/> &nbsp; <span style="color:#81c147">${fixedBoardList.commentsCnt > 0 ? [fixedBoardList.commentsCnt] : ''}</span></a></div>
								<div class="date">	
								<fmt:formatDate value="${fixedBoardList.firstInsertDt}" type="date" pattern="yyyy-MM-dd" /></div>
							</div>
						</c:forEach>
					
						 <c:forEach var="list" items="${boardList}">
						<%-- <c:if test="${list.boardFixYn == Y}">
						</c:if> --%>
						<div>
								<div class="num">${list.postNum}</div>
								<div class="title"><a href="/board/notice/view?postSeq=${list.postSeq}"><c:out value="${list.subject}"/> &nbsp; <span style="color:#81c147">${list.commentsCnt > 0 ? [list.commentsCnt] : ''}</span></a></div>
								<div class="date">
									<c:if test="${list.firstInsertDt >= list.lastUpdateDt}">
										<fmt:formatDate value="${list.firstInsertDt}" type="date" pattern="yyyy-MM-dd" />
									</c:if>
									<c:if test="${list.firstInsertDt < list.lastUpdateDt}">
										<fmt:formatDate value="${list.lastUpdateDt}" type="date" pattern="yyyy-MM-dd" />&nbsp <!--수정필요-->
									</c:if>
								</div>
						</div>
						</c:forEach> 
					</c:if>
				</div>
			</div>
		</div>

			<div class="area-button">
				<c:if test="${sessionScope.sessionSeqForAdmin ne null}">
				<button onclick="window.location='/board/notice/write'">글쓰기</button>
				</c:if>
			</div>
			
						
		
	</div>
</div>
<script>
	$("#nav a").removeClass("current-page-item");
	$("#nav").find('a[href*="/notice"]').addClass("current-page-item");
</script>

<!-- Footer -->
<jsp:include page="../../common/footer.jsp" flush="false"/>


