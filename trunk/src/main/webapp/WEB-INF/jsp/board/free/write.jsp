<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	
<script>

function WriteCheck(){

	var rtn = false;
	var param = $("#frm").serialize();
	
	
	if($("#subject").val() == ""){
		alert("제목을 입력해주세요")
		return false;
	}
	if($("#content").val() == ""){
		alert("내용을 입력해주세요")
		return false;
	}

$.ajax({
	url : '/board/free/writePro',
	type : 'POST',
	data : $("#frm").serialize(),
	dataType : "json",
	async : false,
	processData: false,
	contentType: false,
	success : function(data){
		document.frm.writeCheck.value = data;
			if(document.frm.writeCheck.value == 0){
				alert("글이 등록되지않았습니다")
			}
			if(document.frm.writeCheck.value == 1){
				alert("글이 등록되었습니다")
				rtn = true;
			}	
			
		}
	})
	return rtn;
};
</script>

<h1>write.jsp</h1>

	
<form id="frm" name="frm" action="/board/free/list" method="post" enctype="multipart/form-data" onSubmit="return WriteCheck()">
	<%-- <input type="hidden" name="regrSeq" value="${sessionScope.sseq}"/>
	<input type="hidden" name="writerName" value="${sessionScope.sid}"/> --%>
	<input type="hidden" name="regrSeq" value="123126666"/>
	<input type="hidden" name="writerName" value="하하하"/>
	<input type="hidden" name="boardType" value="0"/>
	<input type="hidden" name="writeCheck" id="writeCheck" value="0"/>
	
		<table border=1 style="background-color:powderblue;">
					
			<tr><td>제목 : <input type="text" name="subject" id="subject"/></td></tr>
			<tr><td>이미지 : <input type="file" name="file" id="file"/>
			<tr><td>내용 : <textarea name="content" id="content" style="width:500px"></textarea></td></tr>
				
		</table>
		<input type="submit" value="작성완료"/>
</form>
