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

<c:if test="${sessionScope.sessionSeqForUser == null}">
	<script>
	alert("로그인화면으로 이동합니다");
	location.href="/login/loginView";
	</script>
</c:if>

<script>
function MoveAction(){
	var url = "/board/free/list";
	if(document.getElementById("hide_name_check").checked){
	makeRandomName();
	}
	document.getElementById("board_type").value = 0;
	WriteBoardCheck(url);
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
				<form id="insert_board_form" name="insert_board_form" method="POST" class="board-inline">
					<input type="hidden" name="boardType" id="board_type"/>
 					<textarea name="content" id="content" style="display:none;"></textarea>
					
					
					<div class="area-board">
                    	<span>작성자 : ${sessionScope.sessionNameForUser}</span>
						<div class="area-board-n">
						
						<div style="display:inline;text-align:right">
							<!-- script연습예정 -->
						</div>
							<input type="hidden" id="hide_name" name="hideName"/>
							<input type="checkbox" id="hide_name_check" name="hideCheck" value="0" onclick="makeRandomName()"/>
							<label for="hide_name_check">익명</label>
						</div>
						<input type="text" id="subject" name="subject" placeholder="제목을 입력하세요"/>								
                    </div>

                        


					<div class="area-board-cont">
                       	<textarea id="summernote" name="editordata"></textarea>
					</div>
					
					<span id="word_count"></span>
					
					<input type="file" name="file" id="file" multiple="multiple"/>
					
					<div class="area-button">
						<!--button type="submit">등록</button-->
						<button type="button" onclick="MoveAction();">등록</button>
						<!-- <a href="javascript:WriteBoardCheck();">등록</a> -->
						<button type="button" onclick="location.href='/board/free/list'">취소</button>
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
		['font', ['bold', 'underline', 'clear']]
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


<!-- Footer -->
<jsp:include page="../../common/footer.jsp" flush="false"/>
