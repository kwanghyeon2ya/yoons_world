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

<!-- Header -->
<jsp:include page="../../common/header.jsp" flush="false"/>

<%-- <c:if test="">  --%>
<%-- </c:if>  --%>
<!-- Main -->
<div id="main">
	<div class="container">
		<div class="col-12">
		
			<div class="title-page">
				<h3>자료실</h3>
			</div>
						
			<form action="/board/pds/list" method="get">
			<input type="hidden" id="keyword_check" value="${keyword}"/>
			<input type="hidden" id="search_check" value="${search}"/>
			<input type="hidden" name="boardType" value="2"/>
			<input type="hidden" name="searchCheck" value="1"/>
				<div class="area-search">
					<select id="search" name="search">
						<option value="subject_content" ${search == 'subject_content'?'selected="selected"':''}>제목+내용</option>
						<option value="comments" ${search == 'comments'?'selected="selected"':''}>댓글</option>
						<option value="attach_file" ${search == 'attach_file' ? 'selected="selected"' :''}>첨부파일</option>
					</select>
					<input id="search_text" type="text" name="keyword" value="${keyword}"></input>
					<button id="submit_button" type="submit">검색</button>
				</div>					
			</form>
			
			<div class="board_list">
				<div class="top">
					<div class="num">번호</div>
					<div class="title">제목</div>
					<div class="writer">글쓴이</div>
					<div class="date">작성일</div>
					<div class="count">조회</div>
				</div>
				
				<c:if test="${count == 0}">
					<div style="width:100%; text-align:center;">
						<div>작성된 글이 없습니다</div>
					</div>
				</c:if>
				
				<c:if test="${count > 0}">
					<c:forEach var="list" items="${boardList}">
						<div>
							<div class="num">${list.postNum}</div>
							<div class="title"><a href="/board/pds/view?postSeq=${list.postSeq}"><c:out value="${list.subject}"/> &nbsp; <span style="color:#81c147">${list.commentsCnt > 0 ? [list.commentsCnt] : ''}</span>
								<c:if test="${list.attachCnt != 0}">
								/${list.fullFileName} 
									<c:if test="${list.attachCnt > 1}">
									외 ${list.attachCnt-1}
									</c:if>
								</c:if>
							</a></div>
							<div class="writer">${list.writerName}</div>
							<div class="date">
								<c:if test="${list.firstInsertDt >= list.lastUpdateDt}">
									<fmt:formatDate value="${list.firstInsertDt}" type="date" pattern="yyyy-MM-dd" />
								</c:if>
								<c:if test="${list.firstInsertDt < list.lastUpdateDt}">
									<fmt:formatDate value="${list.lastUpdateDt}" type="date" pattern="yyyy-MM-dd" />&nbsp <!--수정필요-->
								</c:if>
							</div>
							<div class="count">${list.readCnt}</div>
						</div>
					</c:forEach>
				</c:if>
			</div>
							
			<div class="area-button">
				<button onclick="window.location='/board/pds/write'">글쓰기</button>
			</div>
			
			
			<div class="board_page">
				<c:if test="${count > 0}">
					<c:set var="pageCount" value="${count / pageSize + (count % pageSize == 0 ? 0 : 1)}"/>
					<fmt:parseNumber var="result" value="${((currentPage-1)/10)}" integerOnly="true" />
					<fmt:parseNumber var="pageCount" value="${pageCount}" integerOnly="true" />
					<c:set var="startPage" value="${result*10+1}"/>
					<c:set var="pageBlock" value="${10}"/>
					<c:set var="endPage" value="${startPage + pageBlock - 1}"/>
					
					<c:if test="${endPage > pageCount}">
						<c:set var="endPage" value="${pageCount}"/>
					</c:if>
					
					<c:if test="${startPage > 10}">
						<a class="num" href="/board/pds/list?boardType=2&pageNum=${startPage - 10}&search=${search}&keyword=${keyword}&searchCheck=${searchCheck}"> < </a>
					</c:if>
					
					<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
						<a class="num" href="/board/pds/list?search=${search}&keyword=${keyword}&searchCheck=${searchCheck}&boardType=2&pageNum=${i}&">
						<c:if test="${currentPage eq i}"><span style="font-weight:bold">${i}</span></c:if>
						<c:if test="${currentPage ne i}">${i}</c:if>
						</a>
					</c:forEach> 
					
					<c:if test="${endPage < pageCount}">
						<a class="num" href="/board/pds/list?search=${search}&keyword=${keyword}&searchCheck=${searchCheck}&boardType=2&pageNum=${startPage + 10}"> > </a>
					</c:if>
				</c:if>
			</div>
						
		</div>
	</div>
</div>

<script>
	$("#nav a").removeClass("current-page-item");
	$("#nav").find('a[href*="/pds"]').addClass("current-page-item");
</script>

<!-- Footer -->
<jsp:include page="../../common/footer.jsp" flush="false"/>


