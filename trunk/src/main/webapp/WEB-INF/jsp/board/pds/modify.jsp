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
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/WEB-INF/jsp/inc/import.jsp" flush="false" />
	<jsp:include page="/WEB-INF/jsp/inc/boardImport.jsp" flush="false" />
	
	<link rel="stylesheet" type="text/css" href="/css/board/board.css">

	<c:if test="${sessionScope.sessionSeqForUser == null}">
	<script>
		alert("로그인화면으로 이동합니다");
		location.href="/login/loginView";
	</script>
	</c:if>

	<script>
		function MoveAction(){
			var url = "/board/pds/list";
			document.getElementById("board_type").value = 2;
			modBoardCheck(url);
		}
		
		function DeleteFileCheck(index){
			if(window.confirm("첨부파일을 삭제하시겠습니까?")){
				$("#file_uuid_"+index).removeAttr('disabled');
				$("#delete_word_"+index).html("글 수정시 삭제될 파일입니다");
				$("#delete_word_"+index).attr("color","red");
			}
		}
		
		function cancelDeleteFile(index) {
			$("#file_uuid_"+index).prop('disabled', true);
			$("#file_"+index).find(".file_name").css("text-decoration", "").css("color", "");
			$("#file_"+index).find(".cancel_btn").hide();
			$("#file_"+index).find(".del_btn").show();
		}
	</script>
</head>
<body>
	<div id="page-wrapper">
		
		<!-- Header -->
		<jsp:include page="/WEB-INF/jsp/common/header2.jsp" flush="false"/>
		
		<!-- Container -->
		<div id="container">
			<div class="content">
		
				<h3>자료실</h3>
			
				<form id="modify_form" name="modify_form" action="/board/notice/list" method="POST" class="board-inline" enctype="multipart/form-data">
					<input type="hidden" name="postSeq" value="${vo.postSeq}"/>
					<input type="hidden" id="regrSeq" name="regrSeq" value="${vo.regrSeq}"/>
					<input type="hidden" id="board_type" name="boardType" value="2"/>
						
					<div class="input_area">
						<input type="text" id="subject" name="subject" class="size_full" placeholder="제목을 입력하세요" value="<c:out value='${vo.subject}'/>" />
					</div>
									
					<div class="editor_area">
                       	<textarea id="summernote" name="editordata"><c:out escapeXml="true" value="${vo.content}"/></textarea>
                       	
                       	<textarea name="content" id="content" style="display:none;"></textarea>
						<div id="word_count">[0/4000자]</div>
					</div>
					
					<div class="input_area">
						<h4>첨부 파일</h4>
						<ul class="file_list">
							<c:forEach var="anlist" items="${anlist}" varStatus="loop">
							<li id="file_${loop.index}">
								<input type="hidden" id="file_uuid_${loop.index}" class="file_uuid" name="fileUuidArray" value="${anlist.fileUuid}" disabled/>
								<span class="file_name">${anlist.fileName}.${anlist.fileType}</span>
								<img class="del_btn" title="삭제" src="/img/board/icon_close.png" onclick="DeleteFileCheck(${loop.index});" />
								<img class="cancel_btn" title="취소" src="/img/board/icon_undo.png" onclick="cancelDeleteFile(${loop.index});" style="display: none;" />
								<span id="delete_word_${loop.index}"></span>
							</li>
							</c:forEach>
						</ul>
						<input type="file" name="file" id="file" class="size_full" multiple="multiple"/>
					</div>
					
					<div class="btn_area right">
						<button type="button" id="move_action_button" class="btn type_02 size_s bg_purple" onclick="MoveAction()">수정</button>
						<button type="button" class="btn type_02 size_s bg_aaa" onclick="history.go(-1)">취소</button>
					</div>
					
                </form>
				
			</div>
		</div>
		
		<!-- Footer -->
		<jsp:include page="/WEB-INF/jsp/common/footer.jsp" flush="false"/>
		
	</div>
</body>
</html>