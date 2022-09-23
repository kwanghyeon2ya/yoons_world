<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h1>view.jsp</h1>
<c:if test="${sessionScope.sid == null}">
	<script>
		alert("로그인이 필요합니다")
	</script>
	<c:redirect url="/member/login/login.jsp"/>
</c:if>

<table border=1>
	<tr>
	<td>
	<div id="header">
		<h1>제목 : ${vo.subject}</h1>	
		<h3 align="right">작성자 : ${vo.writerName}</h3>
			<c:if test="${sessionScope.sseq == vo.regrSeq}">
				<div align="right">
				<button type="button" onclick="window.location='/board/free/modify?postSeq=${vo.postSeq}&subject=${vo.subject}&content=${vo.content}'">[수정]</button> &nbsp
				<button type="button" onclick="window.location='/board/free/delete?postSeq=${vo.postSeq}'">[삭제]</button>
				</div>
			</c:if>
	</div>
	</td>
	</tr>
	<tr>
	<td>
	<div id="body" style="color:skyblue;width:500px;height:500px">
		${vo.content}
	</div>
	</td>
	</tr>
	<tr>
	<td>
	<div id="footer">
		댓글창
	</div>
	</td>
	</tr>
	
</table>