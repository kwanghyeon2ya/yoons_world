<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<jsp:include page="/WEB-INF/jsp/board/postValidation.jsp"/>


<h1>write.jsp</h1>
	

<form id="frm" name="frm" action="/board/free/list" method="post" onSubmit="return WriteCheck()">
	<%-- <input type="hidden" name="regrSeq" value="${sessionScope.sseq}"/>
	<input type="hidden" name="writerName" value="${sessionScope.sid}"/> --%>
	<input type="hidden" name="regrSeq" value="${sessionScope.sseq}"/>
	<input type="hidden" name="writerName" value="${sessionScope.sname}"/>
	<input type="hidden" name="boardType" value="0"/>
	<input type="hidden" name="writeCheck" id="writeCheck" value="0"/>
	<input type="hidden" name="modCheck" id="modCheck" value="0"/>
	
		<table border=1 style="background-color:powderblue;">
					
			<tr><td>제목 : <input type="text" name="subject" id="subject"/></td></tr>
			<!-- <tr><td>이미지 : <input type="file" name="file" id="file"/> -->
			<tr><td>내용 : <textarea name="content" id="content" style="width:500px;height:500px"></textarea></td></tr>
				
		</table>
		<input type="submit" value="작성완료"/>
</form>
