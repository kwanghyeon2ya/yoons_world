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



<%-- <c:if test="${count > 0}">
    <c:if test="${searchCheck != null && searchCheck != ''}">
    검색된 키워드 "${keyword}"<br/>
    </c:if>
</c:if> --%>

<c:if test="${sessionScope.sessionIdForUser == null}">
	<script>
		alert("로그인이 필요합니다")
		window.location.href="/login/loginView";
	</script>
</c:if>

<script>
	$(document).ready(function(){
		/* $("#every_board_list").children(".title_href").trim() */	
	})
</script>

<!-- Header -->
<jsp:include page="../common/header.jsp" flush="false"/>

<!-- Main -->
<div id="main">
	<div class="container">
		<div class="col-12">
		
			<div id="every_board_list">
					
				<div id="notice_board_list">
			
					<div class="title-page">
						<h3><a class="board_title_color" href="/board/notice/list">공지사항</a></h3>
					</div>
								
					<div class="board_list">
					
						<div class="top">
							<div class="title">제목</div>
							<div class="count">작성일</div>
						</div>
						
						<c:if test="${empty noticeBoardList && empty fixedBoardList}">
							<div style="width:100%; text-align:center;">
								<div>작성된 글이 없습니다</div>
							</div>
						</c:if>
						
						<c:if test="${!empty noticeBoardList && !empty fixedBoardList}">
						
							<c:forEach var="fixedBoardList" items="${fixedBoardList}">
								<div>
									<div class="title"><span style="color:#DC143C">[중요] </span><a class="title_href" title="${fixedBoardList.subject}" href="/board/notice/view?postSeq=${fixedBoardList.postSeq}"><c:out value="${fixedBoardList.subject}"/></a></div>
									<div class="date">	
									<fmt:formatDate value="${fixedBoardList.firstInsertDt}" type="date" pattern="yyyy-MM-dd" /></div>
								</div>
							</c:forEach>
						
							 <c:forEach var="list" items="${noticeBoardList}">
								<div>
									<div class="title"><a class="title_href" title="${list.subject}" href="/board/notice/view?postSeq=${list.postSeq}"><c:out value="${list.subject}"/></a></div>
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
			
			
				<div id="free_board_list">
					
					<div class="title-page">
						<h3><a class="board_title_color" href="/board/free/list">자유게시판</a></h3>
					</div>
					
					<div class="board_list"><!-- 카운트 안 써야함 -->
						<div class="top">
							<div class="title">제목</div>
							<div class="count">작성일</div>
						</div>
						
						<c:if test="${empty freeBoardList}">
							<div style="width:100%; text-align:center;">
								<div>작성된 글이 없습니다</div>
							</div>
						</c:if>
						
						<c:if test="${!empty freeBoardList}">
							<c:forEach var="list" items="${freeBoardList}">
								<div>
									<div class="title"><a class="title_href" title="${list.subject}" href="/board/free/view?postSeq=${list.postSeq}"><c:out value="${list.subject}"/></a></div>
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
				
				<div id="pds_board_list">
					
					<div class="title-page">
						<h3><a class="board_title_color" href="/board/pds/list">자료실</a></h3>
					</div>
					
					<div class="board_list">
						<div class="top">
							<div class="title">제목</div>
							<div class="count">작성일</div>
						</div>
						
						<c:if test="${empty pdsBoardList}">
							<div style="width:100%; text-align:center;">
								<div>작성된 글이 없습니다</div>
							</div>
						</c:if>
						
						<c:if test="${!empty pdsBoardList}">
							<c:forEach var="list" items="${pdsBoardList}">
								<div>
									<div class="title"><a title="${list.subject}" href="/board/pds/view?postSeq=${list.postSeq}"><c:out value="${list.subject}"/>
										<c:if test="${list.attachCnt != 0}">
										/${list.fullFileName} 
											<c:if test="${list.attachCnt > 1}">
											외 ${list.attachCnt-1}
											</c:if>
										</c:if>
									</a></div>
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
		</div>
	</div>
</div>
<!-- Footer -->
<jsp:include page="../common/footer.jsp" flush="false"/>


