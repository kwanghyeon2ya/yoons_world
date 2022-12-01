<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.io.File"%>
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
	function getFileList(file_number,file_name_for_del){ /* file태그 onchange function호출함 */
		
		var fileTarget = $("input[name=file]"); // 파일
		var fileLength = $("input[name=file]")[0].files.length; // 파일 갯수
		const dataTranster = new DataTransfer(); // input file의 FileList를 컨트롤할 예정
		
		console.log("file_number : "+file_number);
		
		if(file_number != null){
			console.log("삭제-> 리스트 진입");
		}
		
		console.log(fileTarget);
		console.log(fileLength);
		
		var fileList = "";
		
		for(var i = 0;i<fileLength;i++){
			var fileName = fileTarget[0].files[i].name;
			
			if(file_number != null && fileName == file_name_for_del){
				console.log("파일명같음 진입 : "+$("input[name=file]")[0].files[i]);
				// 삭제버튼 누른 파일명 및 input file값 삭제 예정자리
			}
			
			console.log("fileName : "+fileName);
			console.log("file_name_for_del : "+file_name_for_del);
			if(fileName != file_name_for_del){
				console.log("이름 붙이기 "+(i+1)+"번 째 진행중");
				fileList += fileName + '&nbsp; <img class="delete_file" src="/img/board/x_icon.png" style="cursor:pointer;position:relative;top:3.5px;" onclick="deleteFile('+i+', \''+fileName+'\');" alt="x">' + '<br>';
				//삭제 버튼 누른 파일은 안붙도록 처리해야함
			}
		}
		console.log("fileList : "+fileList);
		console.log("fileLength 재확인 : "+fileLength);
		if(fileLength > 0){
			console.log("block 진입");
			$("#multi_file_list").css("display","block");
			$("#show_files").html(fileList);
		}else{
			console.log("fileList");
			console.log("none 진입");
			$("#multi_file_list").css("display","none");
			$("#show_files").empty();
		}
		
	}
	
	
	function deleteFile(file_number,file_name_for_del){ // 파일 삭제 버튼을 누를시에 호출 - 인자를 getFileList(첨부파일명 리스트호출 메서드)에 넣으며 호출
		
		console.log("deleteFile 메서드 진입");
		console.log("file_name_for_del : "+file_name_for_del);
		console.log("file_number : "+file_number);
		console.log("파일삭제 버튼  : "+$("input[name=file]"));

		getFileList(file_number,file_name_for_del);
		/* fileArray.splice(file_number,1); */
	}
	

	
	/* $(document).ready(function(){
		const dataTransfer = new DataTransfer();	
		$("input[name=file]").change(function(){
			var fileTarget = $("input[name=file]");
			var fileLength = $("input[name=file]")[0].files.length;
			var fileArray = Array.from(fileTarget);
			
			console.log("fileArray : "+fileArray);
			console.log("fileArray[0] : "+fileArray[0]);
			console.log(fileTarget);
			console.log(fileLength);
			
			var fileList = "";
			for(var i = 0;i<fileLength;i++){
				fileList += fileTarget[0].files[i].name +'&nbsp; <img id="delete_file" src="/img/board/x_icon.png" style="cursor:pointer;position:relative;top:3.5px;" onclick="deleteFile" alt="x">' + '<br>';
			}
			console.log(fileList);
			if(fileLength > 0){
				$("#multi_file_list").css("display","block");
				$("#show_files").html(fileList);
			}else{
				$("#multi_file_list").css("display","none");
				$("#show_files").empty();
			}
		})
		
	}) */
	
		/* $(document).on('change',"input[name=file]",function(){
			
		$("input[name=file]").on()
			var fileTarget = $("input[name=file]");
			
			console.log("fileTarget.files : "+fileTarget.files);
			
			var fileList = "";
			for(var i = 0;i<fileTarget.files.length;i++){
				fileList += fileTarget.files[i].name + '<br>';
			}
			var showFile = $("#showFiles");
			showFile.html(+fileList);
		}); */
	
	/* window.onload = function(){
		target = document.getElementById('file');
		target.addEventListener('change',function(){
			fileList = "";
			for(var i = 0;i<target.files.length;i++){
				fileList += target.files[i].name +'<br>';
			}
			showFile = document.getElementById('showFiles');
			showFile.innerHTML = fileList;
		})
	} */
	
	function MoveAction(){
		var url = "/board/free/list";
		if(document.getElementById("hide_name_check").checked){
		makeRandomName();
		}
		document.getElementById("board_type").value = 0;
		WriteBoardCheck(url);
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
				
				<h3>자유게시판</h3>
			
				<form id="insert_board_form" name="insert_board_form" method="POST" class="board-inline" onsubmit="return false">
					<input type="hidden" name="boardType" id="board_type"/>
					
					<div class="input_area">
						<input type="text" id="subject" name="subject" class="size_full" placeholder="제목을 입력하세요" />
					</div>
					<div class="input_area">
							<input type="hidden" id="hide_name" name="hideName"/>
							<input type="checkbox" id="hide_name_check" name="hideCheck" value="0" onclick="makeRandomName()"/>
							<label for="hide_name_check">
								<span>익명</span>
							</label>
					</div>

					<div class="editor_area">
                       	<textarea id="summernote" name="editordata"></textarea>
                       	<textarea name="content" id="content" style="display:none;"></textarea>
					</div>
					<div id="word_count">[0/4000자]</div>
					
					<div class="input_area">
						<h4>첨부 파일</h4>
						<input type="file" name="file" id="file" class="size_full" onchange="getFileList()" multiple="multiple"/>
					</div>
					
					<div class="btn_area right">
						<c:if test="${sessionScope.sessionSeqForAdmin ne null}">
						<button type="button" id="move_action_button" class="btn type_02 size_s bg_purple" onclick="MoveAction();">등록</button>
						</c:if>
						<button type="button" class="btn type_02 size_s bg_aaa" onclick="location.href='/board/notice/list'">취소</button>
					</div>
					
                </form>
                
                <div id="multi_file_list" style="display:none">
                	<span style="font-size:15px;color:rgb(159, 126, 209);">첨부된 파일 목록</span>
                </div>
				<div id="show_files"></div>
			</div>
		</div>
		
		<!-- Footer -->
		<jsp:include page="/WEB-INF/jsp/common/footer.jsp" flush="false"/>
		
	</div>
</body>
</html>