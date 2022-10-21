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
					제목 : <span><c:out escapeXml="" value="${vo.subject}"/></span>
				</div>

				<div class="area-board-info">
					<input type="hidden" id="view_regr_seq" value="${vo.regrSeq}"/>
					<input type="hidden" id="post_seq" value="${vo.postSeq}"/>
					<p>작성자 : <c:out value="${vo.writerName}"/> &nbsp;&nbsp;
					
						<c:if test="${vo.firstInsertDt >= vo.lastUpdateDt}">
							<fmt:formatDate value="${vo.firstInsertDt}" type="date" pattern="yyyy-MM-dd HH:mm" />
								&nbsp;&nbsp; 조회 ${vo.readCnt}
						</c:if>
						
					</p>
					
						<c:if test="${vo.firstInsertDt < vo.lastUpdateDt}">
							원글작성일 : <fmt:formatDate value="${vo.firstInsertDt}" type="date"
								pattern="yyyy-MM-dd" /> &nbsp; /
							<p>수정된 작성일 : <fmt:formatDate value="${vo.lastUpdateDt}" type="date"
								pattern="yyyy-MM-dd" /></p>
								&nbsp;&nbsp; 조회 ${vo.readCnt}
						</c:if>
							</div>
							
						
						
				</div>

				<div class="area-board-btn">
					<c:if test="${sessionScope.sessionSeqForUser == vo.regrSeq}">
						<button type="button"
							onclick="window.location='/board/free/modify?postSeq=${vo.postSeq}'">수정</button>
							<!-- 게시글 수정 -->
						<button type="button"
							onclick="deleteMoveAction()">삭제</button> <!-- 게시글 삭제 -->
					</c:if>
				</div>
				
				<div class="area-board-cont">
					<!-- 첨부파일 영역 -->
					<div class="area-board-attach">
						<c:if test="${!empty anlist}">
							<details>
							    <summary>첨부파일</summary>
							    <ul>
								<c:forEach var="dlist" items="${anlist}">
									<a href="<%=File.separator%>yoons_world<%=File.separator%>files${dlist.fullPath}" download>
										<li>${dlist.fileName}.${dlist.fileType}</li>
									</a>	
								</c:forEach>
								</ul>
							</details>
						</c:if>
					</div>
				
					<!-- 게시글 본문 영역 -->
					${vo.content}
					
				</div>
				
				<!-- 댓글 영역 -->
				<div id="reloadDivParent">
					<h4>댓글 <c:out value="${existCount}"/></h4>
					
					<div id="reloadDiv">
						
						<c:forEach var="clist" items="${clist}" varStatus="loop">
						
							<c:if test="${clist.status == 0}">
								<div class="area-board-comm">
									<p>작성자 : <c:out value="${clist.commId}"/></p>
									<p>삭제된 댓글입니다</p>
								</div>
							</c:if>
								
							
							
							<c:if test="${clist.status == 1}">
								<div class="area-board-comm <c:if test='${clist.commLevel != 0}'> reply</c:if>">
									<p>작성자 : <c:out value="${clist.commId}"/></p>
									<p><c:out value="${clist.commContent}"/></p>
									<p>
										<fmt:formatDate value="${clist.firstInsertDt}" type="date" pattern="yyyy-MM-dd hh:mm"/> &nbsp;
										
										<c:if test="${clist.commLevel == 0}"> <!-- level 존재 여부에 따라 본댓글, 대댓글 -->
											<a href="javascript:showHideCocoForm(${loop.index})" id="showHideButton_${loop.index}">답글쓰기</a>&nbsp;
										</c:if>
										
										<c:if test="${sessionScope.sessionSeqForUser == clist.regrSeq}">
											<a href="javascript:void(0)" id="modifyCommButton_${loop.index}" onclick="modCommFormShowHide(${loop.index})">수정</a>&nbsp; <!-- 댓글수정폼 보이기 -->
											<a href="javascript:void(0)" id="deleteCommButton_${loop.index}" onclick="deleteCommentsCheck(${loop.index})">삭제</a> <!-- 댓글삭제 -->
										</c:if>
									</p>
								
									<div class="area-board-comm-mod">
										<form id="coco_insert_form_${loop.index}" method="post" style="display:none">
												<input type="hidden" id="coco_comm_seq_${loop.index}" value="${clist.commSeq}"/>
												<input type="hidden" id="coco_comm_group_${loop.index}" value="${clist.commGroup}"/>
												<input type="text" id="coco_comm_content_${loop.index}" placeholder="댓글에 대한 의견을 남겨보세요" />
											<div class="area-board-comm-btn">
												<input type="hidden" id="coco_post_seq_${loop.index}" value="${vo.postSeq}" />
												<button type="button" id="insert_coco_${loop.index}" onclick="insertCocoCheck(${loop.index})">등록</button>
											</div> 
										</form>
										
										<form id="comment_mod_form_${loop.index}" method="post" style="display:none"><!-- 댓글 수정폼 -->
											<input type="hidden" id="mod_regr_seq_${loop.index}" value="${clist.regrSeq}"/>
											<input type="hidden" id="mod_comm_seq_${loop.index}" value="${clist.commSeq}"/>
											<input type="hidden" id="mod_comm_group_${loop.index}" value="${clist.commGroup}"/>
											<textarea id="mod_comm_content_${loop.index}" placeholder="수정할 댓글 내용을 작성해주세요">${clist.commContent}</textarea>
											<div class="area-board-comm-btn">
												<input type="hidden" id="mod_post_seq_${loop.index}" value="${vo.postSeq}"/>
												<button type="button" id="modify_comments_check_${loop.index}" onclick="modifyCommentsCheck(${loop.index})">등록</button>
											</div> 
										</form>
									</div>
								
								
								
								</div>
							
								
								
							</c:if>
							
						</c:forEach>
						
					
			


				<div class="area-board-comm">
					<form id="comm_insert_form" method="post">
						
						<input type="textarea" name="commContent" id="commContent" placeholder="새로운 댓글을 등록해보세요" />
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