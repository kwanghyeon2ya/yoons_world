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
	
	/* 
	 첨부 파일명 리스트 가져오기	
	*/
	function getFileList(){ /* file태그 onchange function호출함 */
			
		var fileTarget = $("input[name=file]"); // 파일
		var fileLength = $("input[name=file]")[0].files.length; // 파일 갯수
		var files = $("input[name=file]")[0].files;
		
		/* const dataTransfer = new DataTransfer(); // input file의 FileList를 컨트롤할 예정
		Array.from(files)
       .filter(file => fileTarget[0].files.size > 10000000)
       .forEach(file => {
   		dataTransfer.items.add(file);
		}); 
		
		files = dataTransfer.files;
		for(var i = 0;i<files.size;i++){
			bigFileNameList += '['+(i+1)+'].'+files.name;
			console.log("bigFileNameList 목록 :"+bigFileNameList);
		} */
		
		console.log(fileTarget);
		console.log(fileLength);
		
		var fileList = "";
		var bigFileNameList = "";
		
		for(var i = 0;i<fileLength;i++){
			if(fileTarget[0].files[i].size > 10000000){
				console.log("용량초과 첨부파일 이름 : "+fileTarget[0].files[i].name);
				console.log("용량초과 첨부파일 고유번호 : "+fileTarget[0].files[i].lastModified);
				bigFileNameList += fileTarget[0].files[i].name;				
				deleteFile(fileTarget[0].files[i].lastModified);
			}else{
				console.log("이름 붙이기 "+(i+1)+"번 째 진행중");
				fileList += '<li class="temp_file">';
				fileList += '	<span class="file_name">'+fileTarget[0].files[i].name+'</span>';
				fileList += '	<img class="del_btn" src="/img/board/icon_close.png" onclick="deleteFile('+fileTarget[0].files[i].lastModified+');" alt="x">';
				fileList += '</li>';
			}
		}
		
		
		console.log("bigFileNameList 목록 : "+bigFileNameList);
		
		if(bigFileNameList != ""){
			alert("첨부파일은 10MB를 초과할 수 없습니다.");
		}
			
		if(fileList == ""){
			fileLength = 0;
		}
		
		console.log("fileList : "+fileList);
		console.log("fileLength 재확인 : "+fileLength);
		if(fileLength > 0){
			console.log("block 진입");
			$(".file_list").find('.temp_file').remove();
			$(".file_list").show(0);
			$(".file_list").append(fileList);
		}else{
			console.log("fileList");
			console.log("none 진입");
			$(".file_list").find('.temp_file').remove();
			$(".file_list").hide(0);
		}
				
	}
	
	
	function deleteFile(file_number){
		
		const files = $("input[name=file]")[0].files;
		const dataTransfer = new DataTransfer();
		
		Array.from(files)
			.filter(file => file.lastModified != file_number)
			.forEach(file => {
				dataTransfer.items.add(file);
		})
		
		$("input[name=file]")[0].files = dataTransfer.files;
		
		getFileList();
		
	}
	
	function MoveAction(){
		var url = "/board/pds/list";
		document.getElementById("board_type").value = 2;
		WriteBoardCheck(url);
	}
	</script>
</head>
<body>
<!-- Main -->
<div id="page-wrapper">
		
		<!-- Header -->
		<jsp:include page="/WEB-INF/jsp/common/header2.jsp" flush="false"/>
		
		<!-- Container -->
		<div id="container">
		
			<div class="content">
			
			<h3>자료실</h3>
			
			<form id="insert_board_form" name="insert_board_form" method="POST" class="board-inline">
					<input type="hidden" name="boardType" id="board_type"/>
					
					<div class="input_area">
						<input type="text" id="subject" name="subject" class="size_full" placeholder="제목을 입력하세요" />
					</div>
					
					<div class="editor_area">
                       	<textarea id="summernote" name="editordata"></textarea>
                       	<textarea name="content" id="content" style="display:none;"></textarea>
					</div>
					<div id="word_count">[0/4000자]</div>
					
					<div class="input_area">
						<h4>첨부 파일</h4>
						<span style="font-size:10px;">※첨부파일은 10MB이상 업로드 할 수 없습니다</span>
						<ul class="file_list" style="display:none">
						
						
						<!-- 첨부파일 목록이 추가 될 곳 -->
								
								
						</ul>
						<input type="file" name="file" id="file" class="size_full" onchange="getFileList()" multiple="multiple"/>
					</div>
					
					<div class="btn_area right">
						<c:if test="${sessionScope.sessionSeqForAdmin ne null}">
						<button type="button" id="move_action_button" class="btn type_02 size_s bg_purple" onclick="MoveAction();">등록</button>
						</c:if>
						<button type="button" class="btn type_02 size_s bg_aaa" onclick="location.href='/board/notice/list'">취소</button>
					</div>
					
                </form>
				
			</div>
		</div>
		
		<!-- Footer -->
		<jsp:include page="/WEB-INF/jsp/common/footer.jsp" flush="false"/>
		
	</div>
</body>
</html>