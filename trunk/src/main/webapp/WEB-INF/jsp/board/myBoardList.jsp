<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
 
<% pageContext.setAttribute("s", "\"");%>

<div id="my_board_list" class="main_board_area">
	
	<div class="table type_01">
		
		<c:if test="${empty myBoardList}">
		<div class="non_data center">작성된 글이 없습니다.</div>
		</c:if>
		
		<c:if test="${!empty myBoardList}">
		<c:forEach var="list" items="${myBoardList}">
		
		<input type="hidden" class="myBoardListCount" value="0">
		
		<c:set var="boardUrl" value="${list.boardType eq 0 ? '/board/free/view' : list.boardType eq '1' ? '/board/notice/view':'/board/pds/view'}"/>
		<div>
			<a title="${list.subject}" href="${boardUrl}?postSeq=${list.postSeq}">${fn:replace(fn:escapeXml(list.subject), s, "'")}</a>
		</div>
		<div class="right">
			<c:if test="${list.firstInsertDt >= list.lastUpdateDt}">
			<fmt:formatDate value="${list.firstInsertDt}" type="date" pattern="yyyy-MM-dd" />
			</c:if>
			<c:if test="${list.firstInsertDt < list.lastUpdateDt}">
			<fmt:formatDate value="${list.lastUpdateDt}" type="date" pattern="yyyy-MM-dd" />
			</c:if>
		</div>
		</c:forEach>
		</c:if>
	</div>
	<c:if test="${stopList ne 1}">
		<div class="more_myBoardlist_btn" style="text-align:center; margin-top:10px;"><a href="javascript:getMyBoardList()">게시글 더보기</a></div>
	</c:if>
	
</div>


