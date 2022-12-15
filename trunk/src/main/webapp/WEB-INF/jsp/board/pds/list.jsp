<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/inc/import.jsp" flush="false" />
<jsp:include page="/WEB-INF/jsp/inc/boardImport.jsp" flush="false" />

<link rel="stylesheet" type="text/css" href="/css/board/board.css">

<c:if test="${sessionScope.sessionSeqForUser == null}">
	<script>
		alert("로그인이 필요합니다");
		window.location.href = "/login/loginView";
	</script>
</c:if>

	<script>
	$(document).ready(function() {
		$("#search_frm").submit(function(){
			if ($("#search_text").val().trim().length == 0) {
				alert("검색창에 내용을 입력하세요");
				return false;
			};
		});
	});
	</script>

</head>
<body>
	<div id="page-wrapper">

		<!-- Header -->
		<%-- <c:if test="${count > 0}">
    <c:if test="${searchCheck != null && searchCheck != ''}">
    검색된 키워드 "${keyword}"<br/>
    </c:if>
</c:if> --%>

		<!-- Header -->
		<jsp:include page="/WEB-INF/jsp/common/header2.jsp" flush="false" />

		<%-- <c:if test="">  --%>
		<%-- </c:if>  --%>
		<!-- Main -->
		<div id="container">
			<div class="content">

				<h2>자료실</h2>

					<div class="search_area right">
						<form id="search_frm" action="/board/pds/list" method="get" onSubmit="return searchCheck();">
							<input type="hidden" id="keyword_check" value="${keyword}" />
							<input type="hidden" id="search_check" value="${search}" />
							<input type="hidden" name="boardType" value="2" />
							<input type="hidden" name="searchCheck" value="1" />
							
							<select id="search" name="search">
								<option value="subject_content" ${search == 'subject_content'?'selected="selected"':''}>제목+내용</option>
								<option value="comments" ${search == 'comments'?'selected="selected"':''}>댓글</option>
								<option value="attach_file" ${search == 'attach_file' ? 'selected="selected"' :''}>첨부파일</option>
							</select>
							<input type="text" id="search_text" class="size_s" name="keyword" value="${keyword}"></input>
							<button type="submit" id="submit_button" class="btn type_02 size_s bg_purple">검색</button>
						</form>
					</div>

					<div class="list_area">
						<div class="pds_board table type_03">
							<div class="th">번호</div>
							<div class="th">제목</div>
							<div class="th">첨부파일</div>
							<div class="th">글쓴이</div>
							<div class="th">작성일</div>
							<div class="th">조회수</div>
							
							<c:if test="${count == 0}">
								<div class="non_data">작성된 글이 없습니다.</div>
							</c:if>

							<c:if test="${count > 0}">
								<!-- 일반 글 리스트 -->
								<c:forEach var="list" items="${boardList}">
									<div>${list.postNum}</div>
									<div>
										<a href="/board/pds/view?postSeq=${list.postSeq}">
											<span><c:out escapeXml="true" value="${list.subject}" /></span>
											<span class="txt_purple">${list.commentsCnt > 0 ? [list.commentsCnt] : ''}</span>
										</a>
									</div>
									<c:if test="${list.attachCnt eq 0}">
									<div class="no_file">&nbsp;</div>
									</c:if>
									<c:if test="${list.attachCnt ne 0}">
									<div>${list.fullFileName}<c:if test="${list.attachCnt > 1}"> 외 ${list.attachCnt-1}</c:if></div> <!-- 첨부파일 -->
									</c:if>
									
									<div>${list.writerName}</div>
									<div>
										<c:if test="${list.firstInsertDt >= list.lastUpdateDt}">
											<fmt:formatDate value="${list.firstInsertDt}" type="date" pattern="yyyy-MM-dd" />
										</c:if>
										<c:if test="${list.firstInsertDt < list.lastUpdateDt}">
											<fmt:formatDate value="${list.lastUpdateDt}" type="date" pattern="yyyy-MM-dd" />
											<!--수정필요-->
										</c:if>
									</div>
									<div>${list.readCnt}</div>
								</c:forEach>
							</c:if>

						</div>
					</div>

					<div class="btn_area right">
						<button class="btn type_02 size_s bg_purple" onclick="window.location='/board/pds/write'">글쓰기</button>
					</div>


					<div class="paging_area">
						<c:if test="${count > 0}">
							<c:set var="pageCount" value="${count / pageSize + (count % pageSize == 0 ? 0 : 1)}" />
							<fmt:parseNumber var="result" value="${((currentPage-1)/10)}" integerOnly="true" />
							<fmt:parseNumber var="pageCount" value="${pageCount}" integerOnly="true" />
							<c:set var="startPage" value="${result*10+1}" />
							<c:set var="pageBlock" value="${10}" />
							<c:set var="endPage" value="${startPage + pageBlock - 1}" />

							<c:if test="${endPage > pageCount}">
								<c:set var="endPage" value="${pageCount}" />
							</c:if>

							<c:if test="${startPage > 10}">
								<a href="/board/pds/list?boardType=2&pageNum=${startPage - 10}&search=${search}&keyword=${keyword}&searchCheck=${searchCheck}">&lt;</a>
							</c:if>

							<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
								<c:if test="${currentPage eq i}">
									<a class="bg_purple txt_white" href="/board/pds/list?search=${search}&keyword=${keyword}&searchCheck=${searchCheck}&boardType=2&pageNum=${i}&">${i}</a>
								</c:if>
								<c:if test="${currentPage ne i}">
									<a href="/board/pds/list?search=${search}&keyword=${keyword}&searchCheck=${searchCheck}&boardType=2&pageNum=${i}&">${i}</a>
								</c:if>
							</c:forEach>

							<c:if test="${endPage < pageCount}">
								<a href="/board/pds/list?search=${search}&keyword=${keyword}&searchCheck=${searchCheck}&boardType=2&pageNum=${startPage + 10}">&gt;</a>
							</c:if>
						</c:if>
					</div>
				</div>
			</div>

		<!-- Footer -->
		<jsp:include page="/WEB-INF/jsp/common/footer.jsp" flush="false"/>

	</div>
</body>
</html>

