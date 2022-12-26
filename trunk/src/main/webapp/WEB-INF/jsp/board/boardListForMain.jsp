<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
 
<% pageContext.setAttribute("s", "\"");%>
<div id="notice_board_list" class="main_board_area">
	<h3>
		<a class="board_title_color" href="/board/notice/list">공지사항</a>
	</h3>
	
	<div class="table type_01">
		
		<c:if test="${empty noticeBoardList && empty fixedBoardList}">
		<div class="non_data center">작성된 글이 없습니다.</div>
		</c:if>
		
		<c:if test="${!empty noticeBoardList && !empty fixedBoardList}">
		<c:forEach var="fixedBoardList" items="${fixedBoardList}">
		<div>
			<span class="txt_red">[중요] </span>
			<a class="title_href" title="${fixedBoardList.subject}" href="/board/notice/view?postSeq=${fixedBoardList.postSeq}"><c:out value="${fixedBoardList.subject}"/></a>
		</div>
		<div class="right">
			<fmt:formatDate value="${fixedBoardList.firstInsertDt}" type="date" pattern="yyyy-MM-dd" />
		</div>
		</c:forEach>
	
		<c:forEach var="list" items="${noticeBoardList}">
		<div>
			<a class="title_href" title="${list.subject}" href="/board/notice/view?postSeq=${list.postSeq}"><c:out value="${list.subject}"/></a>
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
</div>	

<div id="free_board_list" class="main_board_area">
	<h3>
		<a class="board_title_color" href="/board/free/list">자유게시판</a>
	</h3>
	
	<div class="table type_01">
		
		<c:if test="${empty freeBoardList}">
		<div class="non_data center">작성된 글이 없습니다.</div>
		</c:if>
		
		<c:if test="${!empty freeBoardList}">
		<c:forEach var="list" items="${freeBoardList}">
		<div>
			<a title="${list.subject}" href="/board/free/view?postSeq=${list.postSeq}">${fn:replace(fn:escapeXml(list.subject), s, "'")}</a>
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
</div>

<div id="pds_board_list" class="main_board_area">
	<h3>
		<a class="board_title_color" href="/board/pds/list">자료실</a>
	</h3>
	
	<div class="table type_01">
		
		<c:if test="${empty pdsBoardList}">
		<div class="non_data center">작성된 글이 없습니다.</div>
		</c:if>
		
		<c:if test="${!empty pdsBoardList}">
		<c:forEach var="list" items="${pdsBoardList}">
		<div>
			<a title="${list.subject}" href="/board/pds/view?postSeq=${list.postSeq}">
			<c:out escapeXml="true" value="${list.subject}"/>
			<c:if test="${list.attachCnt != 0}">
			/${list.fullFileName} 
			<c:if test="${list.attachCnt > 1}">
			외 ${list.attachCnt-1}
			</c:if>
			</c:if>
			</a>
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
</div>

