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
			if(${empty anlist}){
				$(".file_list").hide(0);	
			}
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


	function MoveAction(){
		var url = "/board/free/list";
		document.getElementById("board_type").value = 0;
		modBoardCheck(url);
	}
	
	function DeleteFileCheck(index){
		if(window.confirm("첨부파일을 삭제하시겠습니까?")){
			$("#file_uuid_"+index).prop('disabled', false);
			$("#file_"+index).find(".file_name").css("text-decoration", "line-through").css("color", "#aaa");
			$("#file_"+index).find(".del_btn").hide();
			$("#file_"+index).find(".cancel_btn").show();
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
			
				<h3>자유게시판</h3>
			
			<form id="modify_form" name="modify_form" action="/board/notice/list" method="POST" class="board-inline" enctype="multipart/form-data">
					<input type="hidden" name="postSeq" value="${vo.postSeq}"/>
					<input type="hidden" id="regrSeq" name="regrSeq" value="${vo.regrSeq}"/>
					<input type="hidden" id="board_type" name="boardType" value="0"/>
						
					<div class="input_area">
						<input type="text" id="subject" name="subject" class="size_full" placeholder="제목을 입력하세요" value="<c:out value='${vo.subject}'/>" />
					</div>
									
					<div class="editor_area">
                       	<%-- <textarea id="summernote" name="editordata"><c:out escapeXml="true" value="${vo.content}"/></textarea> --%>
                    	<textarea name="content" id="content" class="board_content">${vo.content}</textarea>
					</div>
					<div id="word_count">[0/900자]</div>
					<h4>첨부 파일</h4>
					<span style="font-size:12px;">※첨부파일은 10MB이상 업로드 할 수 없습니다</span>
					<c:if test="${empty anlist}"> <!-- 첨부파일이 없을 때 파일첨부 -->
						<div class="input_area">
							<input type="hidden" id="anlist_check" value="1"/>
							<ul class="file_list" style="display:none">
							</ul>
						</div>
					</c:if>
					
					<c:if test="${!empty anlist}">
					<div class="input_area">
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
					</div>
					</c:if>
					
					<div class="input_area">
						<input type="file" name="file" id="file" class="size_full" onchange="getFileList()" multiple="multiple"/>
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