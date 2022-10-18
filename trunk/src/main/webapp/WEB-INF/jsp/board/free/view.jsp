<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<c:if test="${sessionScope.sessionSeqForUser == null}">
	<script>
	alert("로그인화면으로 이동합니다");
	location.href="/login/loginView";
	</script>
</c:if>

<script>
function deleteMoveAction(){
	var url = "/board/free/list";
	deleteViewCheck(url);
}
</script>

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
					<input type="hidden" id="view_regr_seq" value="${vo.regrSeq}"/>
					<input type="hidden" id="post_seq" value="${vo.postSeq}"/>
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
									<a href="<%=File.separator%>yoons_world<%=File.separator%>files${dlist.fullPath}" download>${dlist.fileName}.${dlist.fileType}</a><br/>			
								</c:forEach> 
							</details>
						</c:if>
						
				</div>

				<div class="area-board-btn">
					<c:if test="${sessionScope.sessionSeqForUser == vo.regrSeq}">
						<button type="button"
							onclick="window.location='/board/free/modify?postSeq=${vo.postSeq}&subject=${vo.subject}&content=${vo.content}&regrSeq=${vo.regrSeq}&writerName=${vo.writerName}'">수정</button>
							<!-- 게시글 수정 -->
						<button type="button"
							onclick="deleteMoveAction()">삭제</button> <!-- 게시글 삭제 -->
					</c:if>
				</div>
				
				<div class="area-board-cont">${vo.content}</div>

				<h4>댓글 수 : ${existCount}</h4>
				<div id="reloadDivParent" class="area-board-comm">
					<div id="reloadDiv">
						<c:forEach var="clist" items="${clist}" varStatus="loop">
						<hr align="left" style="border:solid 1px black; width:150px;">
						
						<c:if test="${clist.commLevel != 0}">
						<span style="padding-left:5px">ㄴ</span>
						</c:if>
							<c:if test="${clist.status == 0}">
							[작성자] : ${clist.commId}<br/>
							<em>삭제된 댓글입니다</em>
							</c:if>
							<c:if test="${clist.status == 1}">
								<div style="width:100px; display:inline-block;">
								[작성자] : ${clist.commId}<br/>
								${clist.commContent}
								<h5>
									작성시간 :
									<fmt:formatDate value="${clist.firstInsertDt}" type="date" pattern="yyyy-MM-dd" />
								</h5>
									<a href="javascript:showHideCocoForm(${loop.index})" id="showHideButton_${loop.index}">[댓글]</a> 
									&nbsp
									&nbsp
									&nbsp
									<c:if test="${sessionScope.sessionSeqForUser == clist.regrSeq}">
									<a href="javascript:void(0)" id="modifyCommButton_${loop.index}" onclick="modCommFormShowHide(${loop.index})">[수정]</a> <!-- 댓글수정폼 보이기 -->
									<a href="javascript:void(0)" id="deleteCommButton_${loop.index}" onclick="deleteCommentsCheck(${loop.index})">[삭제]</a> <!-- 댓글삭제 -->
									</c:if>
								<br />
								</div>
							
								<div class="area-board-comm">
									<form id="coco_insert_form_${loop.index}" method="post" style="display:none">
											<input type="hidden" id="coco_comm_seq_${loop.index}" value="${clist.commSeq}"/>
											<input type="hidden" id="coco_comm_group_${loop.index}" value="${clist.commGroup}"/>
											<input type="text" id="coco_comm_content_${loop.index}" 
											placeholder="댓글에 대한 의견을 남겨보세요" />
										<div class="area-board-comm-btn">
											<input type="hidden" id="coco_post_seq_${loop.index}" value="${vo.postSeq}" />
											<button type="button" id="insert_coco_${loop.index}" onclick="insertCocoCheck(${loop.index})">등록</button>
										</div> 
									</form>
									
									<form id="comment_mod_form_${loop.index}" method="post" style="display:none"><!-- 댓글 수정폼 -->
											<input type="hidden" id="mod_regr_seq_${loop.index}" value="${clist.regrSeq}"/>
											<input type="hidden" id="mod_comm_seq_${loop.index}" value="${clist.commSeq}"/>
											<input type="hidden" id="mod_comm_group_${loop.index}" value="${clist.commGroup}"/>
											<textarea id="mod_comm_content_${loop.index}" placeholder="수정할 댓글 내용을 작성해주세요" style="width:300px;height:200px;resize:vertical;">${clist.commContent}</textarea>
										<div class="area-board-comm-btn">
											<input type="hidden" id="mod_post_seq_${loop.index}" value="${vo.postSeq}"/>
											<button type="button" id="modify_comments_check_${loop.index}" onclick="modifyCommentsCheck(${loop.index})">등록</button>
										</div> 
									</form>
								</div>
							</c:if>
						</c:forEach>
						<br/>
						
				<!-- 	<div class="area-board-comm-btn">
						<button type="button">댓글</button>
					</div> -->
					<c:if test="${allCount != 0}">
					
						<c:set var="pageCount"
							value="${allCount / pageSize + (allCount % pageSize == 0 ? 0 : 1)}" />
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
					
			


				<div class="area-board-comm">
					<form id="comm_insert_form" method="post">
						<input type="text" name="commContent" id="commContent"
							placeholder="새로운 댓글을 등록해보세요" />
						<div class="area-board-comm-btn">
							<input type="hidden" name="postSeq" id="postSeq" value="${vo.postSeq}" />
							<button type="button" onClick="writeCommentsCheck()">등록</button>
						</div>
					</form>
				</div>
				
				</div><!-- reloadDiv  -->
			</div>
			
				<div class="area-button">
					<button onclick="window.location='/board/free/list'">목록</button>
				</div>
			</div>
		</div>
	</div>


<!-- Footer -->
<jsp:include page="../../common/footer.jsp" flush="false" />