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


<!-- Main -->
<div id="main">
	<div class="container">
		<div class="col-12">
		
			<div class="title-page">
				<h3>공지사항</h3>
			</div>
			
			<div class="board_write">
				<form id="modifyForm" name="modifyForm" action="/board/free/list" method="POST" onSubmit="return modBoardCheck()" class="board-inline" enctype="multipart/form-data">
					<input type="hidden" name="postSeq" value="${vo.postSeq}"/>
					<input type="hidden" name="regrSeq" value="${vo.regrSeq}"/>
					<input type="hidden" name="boardType" value="0"/>
						
					<textarea name="content" id="content" style="display:none;"></textarea>
									
					<div class="area-board">
                    	<span>작성자 : ${vo.writerName}</span>
						<div class="area-board-n">
							
							<input type="checkbox" id="hidename" name="hidename" />
							<label for="hidename">익명</label>
							
						</div>								
                    </div>

					<div class="area-board">
                        <input type="text" id="subject" name="subject" value="${vo.subject}"/>
                        
                    </div>
                    <div style="width:100px;display:inline-block;">
                    	<details open>
								<summary>첨부파일 목록</summary>
							<c:forEach var="anlist" items="${anlist}">
								⊙${anlist.fileName}.${anlist.fileType}
							</c:forEach>	
						</details>
							<input type="file" id="files" name="files"/>				
					</div>
					<div class="area-board">
                       	<textarea id="summernote" name="editordata">${vo.content}</textarea>
					</div>
						
					<div class="area-button">
						<button type="submit">수정</button>
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


<!-- Footer -->
<jsp:include page="../../common/footer.jsp" flush="false"/>

