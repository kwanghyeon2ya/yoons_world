<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>

<c:if test="${sessionScope.sid == null}">
	<script>
		alert("�α����� �ʿ��մϴ�")
	</script>
	<c:redirect url="/member/login/login"/>	
</c:if>

<%-- <c:if test="${count > 0}">
    <c:if test="${searchCheck != null && searchCheck != ''}">
    �˻��� Ű���� "${keyword}"<br/>
    </c:if>
</c:if> --%>

<!-- Header -->
<jsp:include page="../../common/header.jsp" flush="false"/>

<!-- Main -->
<div id="main">
	<div class="container">
		<div class="col-12">
		
			<div class="title-page">
				<h3>��������</h3>
			</div>
			
			<form action="/board/free/list" method="get">
			<input type="hidden" name="searchCheck" value="1"/>
				<div class="area-search">
					<select name="search">
						<option value="subject_content">����+����</option>
						<option value="comments">���</option>
					</select>
					<input type="text" name="keyword" value="${keyword}"></input>
					<button type="submit">�˻�</button>
				</div>					
			</form>
				
			
			<div class="board_list">
				<div class="top">
					<div class="num">��ȣ</div>
					<div class="title">����</div>
					<div class="writer">�۾���</div>
					<div class="date">�ۼ���</div>
					<div class="count">��ȸ</div>
				</div>
				
				<c:if test="${count == 0}">
					<div style="width:100%; text-align:center;">
						<div>�ۼ��� ���� �����ϴ�</div>
					</div>
				</c:if>
				
				<c:if test="${count > 0}">
					<c:forEach var="list" items="${boardList}">
						<div>
							<div class="num">${list.postNum}</div>
							<div class="title"><a href="/board/free/view?postSeq=${list.postSeq}">${list.subject}</a></div>
							<div class="writer">${list.writerName}</div>
							<div class="date">
								<c:if test="${list.firstInsertDt >= list.lastUpdateDt}">
									<fmt:formatDate value="${list.firstInsertDt}" type="date" pattern="yyyy-MM-dd" />
								</c:if>
								<c:if test="${list.firstInsertDt < list.lastUpdateDt}">
									<fmt:formatDate value="${list.lastUpdateDt}" type="date" pattern="yyyy-MM-dd" />
								</c:if>
							</div>
							<div class="count">${list.readCnt}</div>
						</div>
					</c:forEach>
				</c:if>
			</div>
							
			<div class="area-button">
				<button onclick="window.location='/board/free/write'">�۾���</button>
			</div>
			
			
			<div class="board_page">
				<c:if test="${count > 0}">
					<c:set var="pageCount" value="${count / pageSize + (count % pageSize == 0 ? 0 : 1)}"/>
					<fmt:parseNumber var="result" value="${((currentPage-1)/10)}" integerOnly="true" />
					<c:set var="startPage" value="${result*10+1}"/>
					<c:set var="pageBlock" value="${10}"/>
					<c:set var="endPage" value="${startPage + pageBlock - 1}"/>
					
					<c:if test="${endPage > pageCount}">
						<c:set var="endPage" value="${pageCount}"/>
					</c:if>
					
					<c:if test="${startPage > 10}">
						<a class="num" href="/board/free/list?boardType=0&pageNum=${startPage - 10}&search=${search}&keyword=${keyword}&searchCheck=${searchCheck}"> < </a>
					</c:if>
					
					<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
						<a class="num" href="/board/free/list?search=${search}&keyword=${keyword}&searchCheck=${searchCheck}&boardType=0&pageNum=${i}&">${i}</a>
					</c:forEach> 
					
					<c:if test="${endPage < pageCount}">
						<a class="num" href="/board/free/list?search=${search}&keyword=${keyword}&searchCheck=${searchCheck}&boardType=0&pageNum=${startPage + 10}"> > </a>
					</c:if>
				</c:if>
			</div>
						
		</div>
	</div>
</div>

<!-- Footer -->
<jsp:include page="../../common/footer.jsp" flush="false"/>


