<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	
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
