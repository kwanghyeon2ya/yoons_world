<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<h1>자유게시판</h1>

<c:if test="${sessionScope.sid == null}">
	<script>
		alert("로그인이 필요합니다")
	</script>
	<c:redirect url="/member/login/login"/>	
</c:if>
<title>자유게시판</title>

<c:if test="${count == 0}">
	<h1>작성된 글이 없습니다</h1>
	<button type="button" onclick="history.go(-1)">되돌아가기</button> &nbsp 
	<button type="button" onclick="window.location='/board/free/write'">글쓰기</button> &nbsp 
	<button type="button" onclick="window.location='/member/login/main'">메인메뉴</button>
</c:if>
<c:if test="${count > 0}">
<c:if test="${searchCheck != null && searchCheck != ''}">
검색된 키워드 "${keyword}"<br/>
</c:if>
글 갯수 : ${count}


<table border=1>
	<tr>
		<th>글번호</th>
		<th>작성자</th>
		<th>제목</th>
		<th>작성일</th>
		<th>조회수</th>
	</tr>
	
		<c:forEach var="list" items="${boardList}">
		<tr>
			<td>${list.postNum}</td>
			<td>${list.writerName}</td>
			<td><a href="/board/free/view?postSeq=${list.postSeq}">${list.subject}</a></td>
			<td><fmt:formatDate value="${list.firstInsertDt}" type="date"/></td>
			<td>${list.readCnt}</td>
		</tr>
		</c:forEach>
</table>
	<form action="/board/free/list" method="get">
	<input type="hidden" name="searchCheck" value="1"/>
	<select name="search">
		<option value="">==검색==</option>
		<option value="subject_content">제목+내용</option>
		<option value="comments">댓글</option>
	</select>
	<input type="text" name="keyword"/>
	<input type="submit" value="검색"/>
</form>
<button type="button" onclick="window.location='/board/free/write'">글쓰기</button> &nbsp 
<button type="button" onclick="window.location='/member/login/main'">메인메뉴</button>
</c:if>	<br/>

<c:if test="${count > 0}">
	<c:set var="pageCount" value="${count / pageSize + (count % pageSize == 0 ? 0 : 1)}"/>
	<fmt:parseNumber var="result" value="${(currentPage/10)}" integerOnly="true" />
	<c:set var="startPage" value="${result*10+1}"/>
	<c:set var="pageBlock" value="${10}"/>
	<c:set var="endPage" value="${startPage + pageBlock - 1}"/>
	
	<c:if test="${endPage > pageCount}">
		<c:set var="endPage" value="${pageCount}"/>
	</c:if>
	
	<c:if test="${startPage > 10}">
		<a href="/board/free/list?boardType=0&pageNum=${startPage - 10}&search=${search}&keyword=${keyword}&searchCheck=${searchCheck}">[이전]</a>
	</c:if>
	
	<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
		<a href="/board/free/list?search=${search}&keyword=${keyword}&searchCheck=${searchCheck}&boardType=0&pageNum=${i}&">[${i}]</a>
	</c:forEach> 
	
	<c:if test="${endPage < pageCount}">
		<a href="/board/free/list?boardType=0&pageNum=${startPage + 10}&search=${search}&keyword=${keyword}&searchCheck=${searchCheck}">[다음]</a>
	</c:if>
</c:if>



