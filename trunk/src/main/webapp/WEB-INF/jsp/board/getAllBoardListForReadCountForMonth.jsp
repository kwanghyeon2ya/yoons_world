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
<jsp:include page="../common/header.jsp" flush="false"/>

<%-- <c:if test="">  --%>
<%-- </c:if>  --%>
<!-- Main -->
<div id="main">
	<div class="container">
		<div class="col-12">
		
			<div class="title-page">
				<h3>자료실</h3>
			</div>
			
			<div class="board_list">
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
					<c:forEach var="list" items="${boardList}">
						<div>
							<div class="title"><a href="/board/pds/view?postSeq=${list.postSeq}"><c:out value="${list.subject}"/> &nbsp; <span style="color:#81c147">${list.commentsCnt > 0 ? [list.commentsCnt] : ''}</span>
								<c:if test="${list.attachCnt != 0}">
								/${list.fullFileName} 
									<c:if test="${list.attachCnt > 1}">
									외 ${list.attachCnt-1}
									</c:if>
								</c:if>
							</a></div>
							<div class="count">${list.readCnt}</div>
						</div>
					</c:forEach>
				</c:if>
			</div>
							
			<div class="area-button">
				<button onclick="window.location='/board/pds/write'">글쓰기</button>
			</div>
		</div>
	</div>
</div>

<script>
	$("#nav a").removeClass("current-page-item");
	$("#nav").find('a[href*="/pds"]').addClass("current-page-item");
</script>

<!-- Footer -->
<jsp:include page="../common/footer.jsp" flush="false"/>


