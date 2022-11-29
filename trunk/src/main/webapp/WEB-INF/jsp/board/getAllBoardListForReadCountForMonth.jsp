<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="table type_02">
	<div class="th">순위</div>
	<div class="th">제목</div>
	<div class="th">조회수</div>
	
	<c:if test="${empty boardList}">
	<div class="non_data center">작성된 글이 없습니다.</div>
	</c:if>
	
	<c:if test="${!empty boardList}">
	<c:forEach var="list" items="${boardList}" varStatus="status">
	<c:set var="boardUrl" value="${list.boardType eq 0 ? '/board/free/view' : list.boardType eq '1' ? '/board/notice/view':'/board/pds/view'}"/>
	
	<div class="center">
		<c:if test="${status.index < 5}">
		<span class="rank_num bg_purple">${status.count}</span>
		</c:if>
		<c:if test="${status.index >= 5}">
		<span class="rank_num bg_aaa">${status.count}</span>
		</c:if>
	</div>
	<div>
		<a href="${boardUrl}?postSeq=${list.postSeq}" title="${list.subject}"><c:out value="${list.subject}"/></a>
	</div>
	<div class="center">${list.readCnt}</div>
	
	</c:forEach>
	</c:if>
</div>