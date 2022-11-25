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

/* $(document).ready(function(){
	  document.getElementById('fix_start_day').value = new Date().toISOString().substring(0, 10);
	  document.getElementById('fix_end_day').value = new Date().toISOString().substring(0, 10);
}); */

function MoveAction(){
	var url = "/board/notice/list";
	document.getElementById("board_type").value = 1;
	WriteBoardCheck(url);
}

function boardFixDate(){
	
	if($("input:checkbox[id='board_fix_yn']").is(":checked") == true){
		
		console.log("시작일자임ㅋㅋ :"+$("#fix_start_dt").val());
		console.log("종료일자임ㅋㅋ :"+$("#fix_end_dt").val());
		
		if($("#fix_start_dt").val() > $("#fix_end_dt").val()){
			alert("시작일이 종료일보다 낮아야 합니다");
			$("#fix_start_dt").val("");
		}
	}
}

function checkBoardFixChkbx(){
	var startDate = new Date().toISOString().substring(0, 10);
	var endDate = new Date();
	endDate.setMonth(endDate.getMonth() + 1);
	console.log("고정 해제 날짜 : "+endDate.toISOString().substring(0, 10));
	
	if($("input:checkbox[id='board_fix_yn']").is(":checked") == false){
		
		$(".fix_date_div").css("display","none");
		$("#fix_start_dt").val("");
		$("#fix_end_dt").val("");
		console.log("체크박스 체크해제"+$("#fix_start_day").val());
		
	}else{
		
		$(".fix_date_div").css("display","block");
		$("#fix_start_dt").val(startDate);
		$("#fix_end_dt").val(endDate.toISOString().substring(0, 10));
		
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
				<form id="insert_board_form" name="insert_board_form" method="POST" class="board-inline">
					
					<input type="hidden" name="boardType" id="board_type"/>
 					<textarea name="content" id="content" style="display:none;"></textarea>
					
					
					<div class="area-board">
                    	<span>작성자 : ${sessionScope.sessionNameForUser}</span>
                    	
						<div class="area-board-n">
						
						<div class="fix_date_div" style="display:none">
							&nbsp;&nbsp;<h1 style="display:inline;">상단 고정 시작일</h1>&nbsp;&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;&nbsp;<h1 style="display:inline;">상단 고정 종료일</h1><br/>
							<input id="fix_start_dt" name="fixStartDt" onchange="boardFixDate()" style="width:120px;" type="date"/>
						 	  ~ 
							<input id="fix_end_dt" name="fixEndDt" onchange="boardFixDate()" style="width:120px;" type="date"/><br/> 
						</div>
						
						<input type="checkbox" onclick="checkBoardFixChkbx()" id="board_fix_yn" name="boardFixYn" value="Y"/>
						<label for="board_fix_yn">상단노출 고정</label>
						
						<div style="display:inline;text-align:right">
							<!-- script연습예정 -->
						</div>
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
						<c:if test="${sessionScope.sessionSeqForAdmin ne null}">
						<button id="move_action_button" type="button" onclick="MoveAction();">등록</button>
						</c:if>
						<!-- <a href="javascript:WriteBoardCheck();">등록</a> -->
						<button type="button" onclick="location.href='/board/notice/list'">취소</button>
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

<script>
	$("#nav a").removeClass("current-page-item");
	$("#nav").find('a[href*="/notice"]').addClass("current-page-item");
</script>

<!-- Footer -->
<jsp:include page="../../common/footer.jsp" flush="false"/>
