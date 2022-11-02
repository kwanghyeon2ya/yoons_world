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

<script src="/js/enterkeyevent.js"></script>


<!-- 댓글 입력창 -->

<h4>댓글 <c:out value="${existCount}"/></h4>

<div class="area-board-comm">
	<form id="comm_insert_form" method="post" onSubmit="return false">
	
		<input type="textarea" name="commContent" id="commContent" placeholder="새로운 댓글을 등록해보세요"/>
		
		<div class="area-board-comm-btn">
			<input type="hidden" name="postSeq" id="postSeq" value="${vo.postSeq}" />
			<button id="write_comments" type="button" onClick="writeCommentsCheck(${vo.postSeq})">등록</button>
		</div>
	</form>
</div>



<div id="comments_div_parent"><!-- 댓글전체div 부모 -->

	<div id="comments_div"><!-- 댓글전체div  -->
			
		<c:forEach var="clist" items="${clist}" varStatus="loop">
		
			<div class="reload_comment_parent_${clist.commSeq}"><!-- 낱개 댓글 div 부모 -->
			
				<div class="reload_comment_${clist.commSeq}"><!-- 낱개 댓글 div -->
					
					<input type="hidden" class="coco_count_check" value="0"/><!-- 대댓 갯수 확인용 -->
					
					<input type="hidden" class="coco_check_variable_${clist.commSeq}" value="0"/><!-- 대댓 확인용 --> 
					
					
					<!-- 스크롤 시작부분 -->
					<c:if test='${clist.commLevel eq 0}'> <!-- 게시글의 본 댓글 -->
						<div class="area-board-comm">
							<c:if test="${clist.status == 1}"> <!-- 살아있는글 -->
								<p>작성자 : <c:out value="${clist.commId}"/></p>
								<div id="ptag_commContent_${clist.commSeq}">
									<p><c:out value="${clist.commContent}"/></p>
								</div>
								<p>
									<fmt:formatDate value="${clist.firstInsertDt}" type="date" pattern="yyyy-MM-dd hh:mm"/> &nbsp;
									
									<c:if test="${clist.nestedCommentsCnt le 50}">
									<a href="javascript:showHideCocoForm(${clist.commSeq})" id="showHideButton_${clist.commSeq}">답글쓰기</a>&nbsp;
									</c:if>								
									<c:if test="${sessionScope.sessionSeqForUser == clist.regrSeq}">
										<a href="javascript:void(0)" id="modifyCommButton_${clist.commSeq}" onclick="modCommFormShowHide(${clist.commSeq})">수정</a>&nbsp; <!-- 댓글수정폼 보이기 -->
										<a href="javascript:void(0)" id="deleteCommButton_${clist.commSeq}" onclick="deleteCommentsCheck(${clist.commSeq})">삭제</a> <!-- 댓글삭제 -->
									</c:if>
								</p>
								
								<c:if test="${clist.nestedCommentsCnt != 0}">
									<a href="javascript:showHideNestedCocoList(${clist.commSeq},${clist.commSeq})" id="showHideNestedCocoList_${clist.commSeq}">답글 ${clist.nestedCommentsCnt}개 ▽</a>
								</c:if>
								
								<div class="area-board-comm-mod">
									<form id="coco_insert_form_${clist.commSeq}" method="post" style="display:none">
											<input type="hidden" id="coco_comm_seq_${clist.commSeq}" value="${clist.commSeq}"/>
											<input type="hidden" id="coco_comm_group_${clist.commSeq}" value="${clist.commGroup}"/>
											<input type="text" id="coco_comm_content_${clist.commSeq}" placeholder="댓글에 대한 의견을 남겨보세요" />
										<div class="area-board-comm-btn">
											<input type="hidden" id="coco_post_seq_${clist.commSeq}" value="${vo.postSeq}" />
											<button type="button" id="insert_coco_${clist.commSeq}" onclick="insertCocoCheck(${clist.commSeq})">등록</button>
										</div> 
									</form>
								</div>
								
								<div class="area-board-comm-mod">
													
									<form id="comment_mod_form_${clist.commSeq}" method="post" style="display:none"><!-- 댓글 수정폼 -->
										<input type="hidden" id="mod_regr_seq_${clist.commSeq}" value="${clist.regrSeq}"/>
										<input type="hidden" id="mod_comm_seq_${clist.commSeq}" value="${clist.commSeq}"/>
										<input type="hidden" id="mod_comm_group_${clist.commSeq}" value="${clist.commGroup}"/>
										<textarea id="mod_comm_content_${clist.commSeq}" placeholder="수정할 댓글 내용을 작성해주세요">${clist.commContent}</textarea>
										<div class="area-board-comm-btn">
											<input type="hidden" id="mod_post_seq_${clist.commSeq}" value="${vo.postSeq}"/>
											<button type="button" id="modify_comments_check_${clist.commSeq}" onclick="modifyCommentsCheck(${clist.commSeq})">등록</button>
										</div> 
									</form>
								</div>
							
							</c:if> 
					
							<c:if test="${clist.status == 0}"> <!-- 삭제된글 -->
								<p>작성자 : <c:out value="${clist.commId}"/></p>
								<p>삭제된 댓글입니다</p>
								
								<c:if test="${clist.nestedCommentsCnt != 0}">
									<a href="javascript:showHideNestedCocoList(${clist.commSeq},${clist.commSeq})" id="showHideNestedCocoList_${clist.commSeq}">답글 ${clist.nestedCommentsCnt}개 ▽</a>
								</c:if>
							</c:if>
						
					</div>
				</c:if>
					
					
					
					
					
					
				 <!-- 본 댓글의 대댓글 -->
					<c:if test="${clist.nestedCommentsCnt != 0}"><!-- 만약 대댓글에 대한 갯수 카운트가 있다면 -->
						<c:forEach var="cocoList" items="${clist.cocoList}" varStatus="loop"><!-- clist안의 cocoList객체 꺼냄 -->
						<c:if test="${cocoList.commGroup eq clist.commSeq}">
						
						<div id="coco_list_hidden_div_${cocoList.commSeq}" class="coco_list_hidden_div_class" style="display:none" value="${cocoList.commGroup}">
							<div class="area-board-comm reply">
						
								<c:if test="${cocoList.status == 1}"> <!-- 살아있는 댓글 -->
								
									<input type="hidden" name="coco_group" id="coco_group_${cocoList.commSeq}" class="coco_group_class" value="${cocoList.commGroup}"/>
									<p>작성자 : <c:out value="${cocoList.commId}"/></p>
									<p><c:out value="${cocoList.commContent}"/></p>
									<p>
										<fmt:formatDate value="${cocoList.firstInsertDt}" type="date" pattern="yyyy-MM-dd hh:mm"/> &nbsp;
										<c:if test="${sessionScope.sessionSeqForUser == cocoList.regrSeq}">
											<a href="javascript:void(0)" id="modifyCommButton_${cocoList.commSeq}" onclick="modCommFormShowHide(${cocoList.commSeq})">수정</a>&nbsp; <!-- 댓글수정폼 보이기 -->
											<a href="javascript:void(0)" id="deleteCommButton_${cocoList.commSeq}" onclick="deleteCommentsCheck(${cocoList.commSeq})">삭제</a> <!-- 댓글삭제 -->
										</c:if>
									</p>
										
								</c:if>
						
								<c:if test="${cocoList.status == 0}"> <!-- 삭제된 댓글 -->
									<input type="hidden" name="coco_group" id="coco_group_${cocoList.commSeq}" class="coco_group_class" value="${cocoList.commGroup}"/>
									<p>작성자 : <c:out value="${cocoList.commId}"/></p>
									<p>삭제된 댓글입니다</p>
								</c:if>	
							
							<div class="area-board-comm-mod">
								<form id="comment_mod_form_${cocoList.commSeq}" method="post" style="display:none"><!-- 댓글 수정폼 -->
									<input type="hidden" id="mod_regr_seq_${cocoList.commSeq}" value="${cocoList.regrSeq}"/>
									<input type="hidden" id="mod_comm_seq_${cocoList.commSeq}" value="${cocoList.commSeq}"/>
									<input type="hidden" id="mod_comm_group_${cocoList.commSeq}" value="${cocoList.commGroup}"/>
									<textarea id="mod_comm_content_${cocoList.commSeq}" placeholder="수정할 댓글 내용을 작성해주세요">${cocoList.commContent}</textarea>
									<div class="area-board-comm-btn">
										<input type="hidden" id="mod_post_seq_${cocoList.commSeq}" value="${vo.postSeq}"/>
										<button type="button" id="modify_comments_check_${cocoList.commSeq}" onclick="modifyCommentsCheck(${cocoList.commSeq})">등록</button>
									</div> 
								</form>
							</div>
							
							</div>
						</div>
						</c:if>
						</c:forEach>
					</c:if>
				
					
				</div><!-- reload_comment_index -->
				
			</div><!-- reload_comment_parent_index -->
			
			<div class="more_comments_div"></div>
		</c:forEach>
		


		
			<input type="hidden" id="page_count" value="1"/>
			
			<c:if test="${stopMoreCommentsButton == 0}">
			<div style="text-align:center; margin-top:10px;"><a href="javascript:showMoreComments(${vo.postSeq})" id="more_comments_list">댓글 더보기</a></div>
			</c:if>
			
			
		</div><!-- comments_div -->			
		
			
	
		
	
</div>
