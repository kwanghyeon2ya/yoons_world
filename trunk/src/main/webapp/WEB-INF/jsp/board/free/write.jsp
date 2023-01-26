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
	function getFileList(){ /* file태그 onchange function호출함 */
		
		var fileTarget = $("input[name=file]"); // 파일
		var fileLength = $("input[name=file]")[0].files.length; // 파일 갯수
		var files = $("input[name=file]")[0].files;
		
		console.log(fileTarget);
		console.log("for문 밖 파일 갯수 확인 : "+fileLength);
		
		var fileList = "";
		var bigFileNameList = "";
		var forExList = ""; 
		var forbidden_extension = ["jsp","zip","ade","adp","apk","appx","appxbundle","bat","cab","chm","cmd","com","cpl","diagcab","diagcfg","diagpack","dll","dmg","ex","ex_","exe","hta","img","ins","iso","isp","jar","jnlp","js","jse","lib","lnk","mde","msc","msi","msix","msixbundle","msp","mst","nsh","pif","ps1","scr","sct","shb","sys","vb","vbe","vbs","vhd","vxd","wsc","wsf","wsh","xll","%00","0x00"];
		/* try{ */
		for(var i = 0;i<fileLength;i++){
			if(fileTarget[0].files[i] == undefined){
				console.log("언디파인드 진입확인");
				break; 
			} 
			console.log("반복 진행 상황 : "+i+"/"+fileLength);
			console.log("몇번째 파일인지 : "+fileTarget[0].files[i]);
			
			var nameLength = fileTarget[0].files[i].name.length;
			console.log("파일 갯수 로그 : "+fileLength);
			var fileDot = fileTarget[0].files[i].name.lastIndexOf(".");
			var fileType = fileTarget[0].files[i].name.substring(fileDot+1,nameLength).toLowerCase();
			console.log("파일 타입 로그 : "+fileType);
			
			if(fileTarget[0].files[i].size > 10000000 || forbidden_extension.includes(fileType)){
				if(forbidden_extension.includes(fileType)){
					console.log("확장자 제한 첨부파일 이름 : "+fileTarget[0].files[i].name);
					console.log("확장자 제한 첨부파일 고유번호 : "+fileTarget[0].files[i].lastModified);
					forExList += fileTarget[0].files[i].name+"\n";
					filterFile(fileTarget[0].files[i].lastModified);
					i -=1;
					fileLength -=1;
					/* $("input[name=file]").val(""); */
				}else{
					console.log("용량초과 첨부파일 이름 : "+fileTarget[0].files[i].name);
					console.log("용량초과 첨부파일 고유번호 : "+fileTarget[0].files[i].lastModified);
					bigFileNameList += fileTarget[0].files[i].name+"\n";				
					filterFile(fileTarget[0].files[i].lastModified);
					i -=1;
					fileLength -=1;
					/* $("input[name=file]").val(""); */ 
				}
			}else{
				fileList += '<li class="temp_file">';
				fileList += '	<span class="file_name">'+fileTarget[0].files[i].name+'</span>';
				fileList += '	<img class="del_btn" src="/img/board/icon_close.png" onclick="return deleteFile('+fileTarget[0].files[i].lastModified+');" alt="x">';
				fileList += '</li>';
			}
		}
		/* }catch(e){
			console.log("에러메세지 : ${e.message} , ${e.name}");
			breakCheck = 1;
		} */
		
		
		if(fileList == ""){
			fileLength = 0;
		}
		
		console.log("bigFileNameList : "+bigFileNameList);
		console.log("forExList : "+forExList);
		console.log("for문 후 파일확인 : ");
		console.log(fileTarget);
		
		if(bigFileNameList != ""||forExList != ""){
			alert("확장자 및 용량(10MB)문제로 아래의 첨부파일은 제외되었습니다. \n"+forExList+bigFileNameList);
		}
		
	/* 	if(forExList != ""){
			alert("허용되지 않은 확장자입니다."+forExList);
		} */
		
		console.log("fileList : "+fileList);
		console.log("fileLength 재확인 : "+fileLength);
		if(fileLength > 0){
			console.log("block 진입 - function작동 끝");
			$(".file_list").find('.temp_file').remove();
			$(".file_list").show(0);
			$(".file_list").append(fileList);
		}else{
			console.log("fileList");
			console.log("none 진입");
			$(".file_list").find('.temp_file').remove();
			$(".file_list").hide(0);
		}
		return false;	
		event.preventDefault();
	}
	
	function filterFile(file_number){
		console.log("filterFile 호출 확인");
		const files = $("input[name=file]")[0].files;
		const dataTransfer = new DataTransfer();
		
		Array.from(files)
			.filter(file => file.lastModified != file_number)
			.forEach(file => {
				dataTransfer.items.add(file);
		})
		
		$("input[name=file]")[0].files = dataTransfer.files;
	}
	
	
	function deleteFile(file_number){//x버튼 누를시
		console.log("deleteFile 호출 확인");
		const files = $("input[name=file]")[0].files;
		const dataTransfer = new DataTransfer();
		
		Array.from(files)
			.filter(file => file.lastModified != file_number)
			.forEach(file => {
				dataTransfer.items.add(file);
		})
		
		$("input[name=file]")[0].files = dataTransfer.files;
		
		getFileList();
		return false;
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
                       	<!-- <textarea id="summernote" name="editordata"></textarea> -->
                       	<textarea name="content" id="content" class="board_content"></textarea>
					</div>
					<div id="word_count">[0/900자]</div>
					
					<div class="input_area">
						<h4>첨부 파일</h4> 
						<span style="font-size:12px;">※첨부파일은 10MB이상 업로드 할 수 없습니다</span>
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