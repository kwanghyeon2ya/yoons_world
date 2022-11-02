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

<!-- Header -->
<jsp:include page="../../common/header.jsp" flush="false"/>

<c:if test="${sessionScope.sessionIdForUser == null}">
	<script>
	alert("로그인화면으로 이동합니다");
	location.href="/login/loginView";
	</script>
</c:if>

<script>
function MoveAction(){
	var url = "/board/notice/list";
	document.getElementById("board_type").value = 1;
	modBoardCheck(url);
}

function DeleteFileCheck(index){
	if(window.confirm("첨부파일을 삭제하시겠습니까?")){
		$("#file_uuid_"+index).removeAttr('disabled');
		$("#delete_word_"+index).html("글 수정시 삭제될 파일입니다");
		$("#delete_word_"+index).attr("color","red");
	}
}
</script>


<!-- Main -->
<div id="main">
	<div class="container">
		<div class="col-12">
		
			<div class="title-page">
				<h3>공지사항</h3>
			</div>
			
			<div class="board_write">
				<form id="modify_form" name="modify_form" action="/board/notice/list" method="POST" class="board-inline" enctype="multipart/form-data">
					<input type="hidden" name="postSeq" value="${vo.postSeq}"/>
					<input type="hidden" id="regrSeq" name="regrSeq" value="${vo.regrSeq}"/>
					<input type="hidden" id="board_type" name="boardType" value="0"/>
						
					<textarea name="content" id="content" style="display:none;"></textarea>
									
					<div class="area-board">
                    	<!-- <span>작성자 : <c:out value="${vo.writerName}"/></span> -->
                        <input type="text" id="subject" name="subject" value="<c:out value='${vo.subject}'/>"/>
                    </div>
                    
					<div class="area-board-cont">
                       	<textarea id="summernote" name="editordata"><c:out escapeXml="true" value="${vo.content}"/></textarea>
					</div>
					
					<div class="area-board-attach">
						<span id="word_count"></span>
					</div>
					
					<div class="area-board-mod-attach">
	                   	<details open>
							<summary>첨부파일</summary>
								<ul>
								<c:forEach var="anlist" items="${anlist}" varStatus="loop">
									<li>
										<input type="hidden" id="file_uuid_${loop.index}" name="fileUuidArray" value="${anlist.fileUuid}" disabled/>
										${anlist.fileName}.${anlist.fileType}
<%-- 										<button type="button" onclick="DeleteFileCheck(${loop.index})">삭제하기</button> --%>
										<span style="cursor:pointer;" onclick="DeleteFileCheck(${loop.index})">&nbsp;&nbsp;[삭제]</span>
										<span id="delete_word_${loop.index}"></span>
									</li>
								</c:forEach>
								</ul>
						</details>
					</div>
					
					<input type="file" id="file" name="file" multiple/>
					
					
						
					<div class="area-button">
						<button type="button" id="move_action_button" onclick="MoveAction()">수정</button>
						<button type="button" onclick="history.go(-1)">취소</button>
					</div>
					
                </form>
                
			</div>
			
		</div>
	</div>
</div>

<script>
	$('#summernote').summernote({
	  /*placeholder: '내용을 입력해주세요',*/
	  tabsize: 2,
	  height: 300,
	  lang: 'ko-KR',
	  toolbar: [
	  	['style', ['style']],
		['font', ['bold', 'underline', 'clear']],
	 	/* ['insert', ['link', 'picture', 'video']] */
		/*['style', ['style']],
		['font', ['bold', 'underline', 'clear']],
		['color', ['color']],
		['para', ['ul', 'ol', 'paragraph']],
		['table', ['table']],								
		['view', ['fullscreen', 'codeview', 'help']]*/
		]
	});
</script>

<script>
	$("#nav a").removeClass("current-page-item");
	$("#nav").find('a[href*="/notice"]').addClass("current-page-item");
</script>
<!-- Footer -->
<jsp:include page="../../common/footer.jsp" flush="false"/>
