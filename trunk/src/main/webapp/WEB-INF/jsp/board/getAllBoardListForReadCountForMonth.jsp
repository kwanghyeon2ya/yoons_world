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

<c:if test="${sessionScope.sessionSeqForUser == null}">
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

<script>
	$(document).ready(function(){
		
	})
</script>

<!-- Header -->
<jsp:include page="../common/header.jsp" flush="false"/>

<%-- <c:if test="">  --%>
<%-- </c:if>  --%>
<!-- Main -->
<div id="main">
	<div class="container">
			
			<div id="pds_board_list">
				
				<div class="title-page">
				</div>
				
				<div class="board_list">
					<div class="top">
						<div class="title">제목</div>
						<div class="count">조회수</div>
					</div>
					
					<c:if test="${empty boardList}">
						<div style="width:100%; text-align:center;">
							<div>작성된 글이 없습니다</div>
						</div>
					</c:if>
					
					<c:if test="${!empty boardList}">
						<c:forEach var="list" items="${boardList}">
							<div>
								<c:set var="boardUrl" value="${list.boardType eq 0 ? '/board/free/view' : list.boardType eq '1' ? '/board/notice/view':'/board/pds/view'}"/>
								<div class="title"><a href="${boardUrl}?postSeq=${list.postSeq}" title="${list.subject}"><c:out value="${list.subject}"/></a></div>
								<div class="count">${list.readCnt}</div>
							</div>
						</c:forEach>
					</c:if>
				</div>
							
		</div>
	</div>
</div>

<!-- Footer -->
<jsp:include page="../common/footer.jsp" flush="false"/>


