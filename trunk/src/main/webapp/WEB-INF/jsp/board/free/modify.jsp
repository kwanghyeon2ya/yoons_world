<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>modify.jsp</h1>


<jsp:include page="/WEB-INF/jsp/board/postValidation.jsp"/>

<form id="Frm" name="Frm" action="/board/free/list" method="post" onSubmit="return ModCheck()">
	<input type="hidden" name="regrSeq" value="${sessionScope.sid}"/>
	<input type="hidden" name="writerName" value="${sessionScope.sname}"/>
	<input type="hidden" name="boardType" value="0"/>
	<input type="hidden" name="modCheck" id="modCheck" value="0"/>
	
		<table border=1 style="background-color:powderblue;">
					
			<tr><td>제목 : <input type="text" name="subject" id="subject" value="${vo.subject}"/></td></tr>
			<!-- <tr><td>이미지 : <input type="file" name="file" id="file"/> -->
			<tr><td>내용 : <textarea name="content" id="content" style="width:500px;height:500px">${vo.content}</textarea></td></tr>
				
		</table>
		<input type="submit" value="작성완료"/>
</form>
