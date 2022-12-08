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
				//fileList +='<span style="font-size:10px;color:#9900CC;">(추가 등록)</span> '+fileTarget[0].files[i].name + ' &nbsp; <img class="del_btn" src="/img/board/icon_close.png" onclick="deleteFile('+fileTarget[0].files[i].lastModified+');" alt="x">' + '<br>';
				fileList += '<li class="temp_file">';
				fileList += '	<span class="new_txt txt_purple">(추가 등록)</span>';
				fileList += '	<span class="file_name">'+fileTarget[0].files[i].name+'</span>';
				fileList += '	<img class="del_btn" src="/img/board/icon_close.png" onclick="deleteFile('+fileTarget[0].files[i].lastModified+');" alt="x">';
				fileList += '</li>';
			}
		}
		
		if(bigFileNameList != ""){
			alert("첨부파일은 10MB를 초과할 수 없습니다.");
		}
		
		if(fileList == ""){
			fileLength = 0;
		}
		if(fileLength > 0 && $("#anlist_check").val() == 1){
			$(".file_list").show(0);
		}
		
		if(fileLength == 0 && ($("#anlist_check").val() == 1)){
			$(".file_list").hide(0);
		}
			
		$(".file_list").find('.temp_file').remove();
		$(".file_list").append(fileList);
	}
		
		
	function deleteFile(file_number){ // 파일 삭제 버튼을 누를시에 호출 - 인자를 getFileList(첨부파일명 리스트호출 메서드)에 넣으며 호출
		
		console.log("deleteFile 메서드 진입");
		console.log("file_number : "+file_number);
		console.log("파일삭제 버튼  : "+$("input[name=file]"));

		const files = $("input[name=file]")[0].files;
		const dataTransfer = new DataTransfer(); // input file의 FileList를 컨트롤할 예정

		Array.from(files)
	        .filter(file => file.lastModified != file_number)
	        .forEach(file => {
        	dataTransfer.items.add(file);
     	});
		
		$("input[name=file]")[0].files = dataTransfer.files;
		
		getFileList(); // input의 file에 들어가 있는 파일 변경후 파일 목록 변화를 위해 메서드를 호출
		//파일선택을 직접적으로 누르지 않기때문에 onchange 작동안하기때문
		
		
		
		/* fileArray.splice(file_number,1); */
	}

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
			
				<form id="modify_form" name="modify_form" action="/board/pds/list" method="POST" class="board-inline" enctype="multipart/form-data">
					<input type="hidden" name="postSeq" value="${vo.postSeq}"/>
					<input type="hidden" id="regrSeq" name="regrSeq" value="${vo.regrSeq}"/>
					<input type="hidden" id="board_type" name="boardType" value="2"/>
						
					<div class="input_area">
						<input type="text" id="subject" name="subject" class="size_full" placeholder="제목을 입력하세요" value="<c:out value='${vo.subject}'/>" />
					</div>
									
					<div class="editor_area">
                       	<textarea id="summernote" name="editordata"><c:out escapeXml="true" value="${vo.content}"/></textarea>
                       	
                       	<textarea name="content" id="content" style="display:none;"></textarea>
					</div>
					<div id="word_count">[0/4000자]</div>
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