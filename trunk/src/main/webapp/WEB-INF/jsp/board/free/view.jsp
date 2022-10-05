<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.List"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>
<!-- Header -->
<jsp:useBean id="today" class="java.util.Date" />
<jsp:include page="../../common/header.jsp" flush="false" />


<!-- Main -->
<div id="main">
	<div class="container">
		<div class="col-12">

			<div class="title-page">
				<h3>자유게시판</h3>
			</div>

			<div class="board_write">

				<div class="area-board-title">
					제목 : <span>${vo.subject}</span>
				</div>

				<div class="area-board-info">
					<input type="hidden" name="wregrSeq" id="wregrSeq" value="${vo.regrSeq}"/>
					<p>작성자 : ${vo.writerName}</p>
					
						<c:if test="${vo.firstInsertDt >= vo.lastUpdateDt}">
							<fmt:formatDate value="${vo.firstInsertDt}" type="date"
								pattern="yyyy-MM-dd HH:mm" />
								&nbsp;&nbsp; 조회 ${vo.readCnt}
						</c:if>
						<c:if test="${vo.firstInsertDt < vo.lastUpdateDt}">
							원글작성일 : <fmt:formatDate value="${vo.firstInsertDt}" type="date"
								pattern="yyyy-MM-dd" /> &nbsp; /
							<p>수정된 작성일 : <fmt:formatDate value="${vo.lastUpdateDt}" type="date"
								pattern="yyyy-MM-dd" /></p>
								&nbsp;&nbsp; 조회 ${vo.readCnt}
						</c:if>
							</div>
							
						<c:if test="${!empty anlist}">
							<details open>
							    <summary>첨부파일</summary>
								<c:forEach var="dlist" items="${anlist}">
									<a href="http://localhost:8080/files/${dlist.fullPath}" download>${dlist.fileName}.${dlist.fileType}</a><br/>			
								</c:forEach> 
							</details>
						</c:if>
						
				</div>

				<div class="area-board-btn">
					<c:if test="${sessionScope.sseq == vo.regrSeq}">
						<button type="button"
							onclick="window.location='/board/free/modify?postSeq=${vo.postSeq}&subject=${vo.subject}&content=${vo.content}&regrSeq=${vo.regrSeq}&writerName=${vo.writerName}'">수정</button>
						<button type="button"
							onclick="DeleteCheck()">삭제</button>
					</c:if>
				</div>
				
				<div class="area-board-cont">${vo.content}</div>

				<h4>댓글 수 : ${count}</h4>

				<div class="area-board-comm">
					<c:if test="${count > 0}">
						<c:forEach var="clist" items="${clist}">
						<hr align="left" style="border:solid 1px black; width:150px;">
							
							[작성자] : ${clist.regrSeq}<br/>
							${clist.commContent}<br/>
							<h5>
								작성시간 :
								<fmt:formatDate value="${clist.firstInsertDt}" type="date" pattern="yyyy-MM-dd" />
							</h5>
								<a href="javascript:void(0)" onclick="CocoBox()">댓글 남기기</a>
							<br />
						
						<div class="area-board-comm">
									<form id="frm2" method="get" style="display:none">
											<input type="hidden" id="commSeq" value="${clist.commSeq}"/>
											<input type="text" name="commContent2" id="commContent2"
											placeholder="댓글의 의견을 남겨보세요" />
										<div class="area-board-comm-btn">
											<input type="hidden" name="postSeq2" id="postSeq2" value="${vo.postSeq}" />
											<button type="button" onClick="CocoCheck()">등록</button>
										</div> 
									</form>
								</div>
						</c:forEach>
					</c:if>
					
					
					<div class="area-board-comm-btn">
						<button type="button">댓글</button>
					</div>


					<c:if test="${count > 0}">
						<c:set var="pageCount"
							value="${count / pageSize + (count % pageSize == 0 ? 0 : 1)}" />
						<fmt:parseNumber var="result" value="${((currentPage-1)/10)}"
							integerOnly="true" />
						<c:set var="startPage" value="${result*10+1}" />
						<c:set var="pageBlock" value="${10}" />
						<c:set var="endPage" value="${startPage + pageBlock - 1}" />

						<c:if test="${endPage > pageCount}">
							<c:set var="endPage" value="${pageCount}" />
						</c:if>

						<c:if test="${startPage > 10}">
							<a class="num"
								href="/board/free/view?postSeq=${vo.postSeq}&pageNum=${startPage - 10}">
								< </a>
						</c:if>

						<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
							<a class="num"
								href="/board/free/view?postSeq=${vo.postSeq}&pageNum=${i}&">[${i}]</a>
						</c:forEach>

						<c:if test="${endPage < pageCount}">
							<a class="num"
								href="/board/free/view?postSeq=${vo.postSeq}&pageNum=${startPage + 10}">
								> </a>
						</c:if>
					</c:if>


				</div>



				<div class="area-board-comm">
					<form id="frm" method="get">
						<input type="text" name="commContent" id="commContent"
							placeholder="새로운 댓글을 등록해보세요" />
						<div class="area-board-comm-btn">
							<input type="hidden" name="postSeq" id="postSeq" value="${vo.postSeq}" />
							<button type="button" onClick="CommentsCheck()">등록</button>
						</div>
					</form>
				</div>

				<div class="area-button">
					<button onclick="window.location='/board/free/list'">목록</button>
				</div>
			</div>
		</div>
	</div>
</div>


<!-- Footer -->
<jsp:include page="../../common/footer.jsp" flush="false" />