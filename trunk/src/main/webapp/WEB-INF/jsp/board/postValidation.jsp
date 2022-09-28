<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>


<script>
function WriteCheck(){
	
	var form = $('#frm')[0];
	var rtn = false;
	var formData = new FormData(form);
	var file = document.getElementById('file').files[0];
	formData.append("file", file);
	/* $("#frm").serialize(); */
	
	var rtn = false;
	
	if($("#subject").val() == ""){
		alert("제목을 입력해주세요!!")
		return false;
	}
	if($("#content").val() == ""){
		alert("내용을 입력해주세요")
		return false;
	}
	
	  $.ajax({
		url : '/board/writeProc',
		type : 'POST',
		enctype : 'multipart/form-data',
		data : formData,
		dataType : "json",
		cache : false,
		async : false,
		processData: false,
		contentType: false,
	 	success : function(data){
			document.frm.writeCheck.value = data;
				if(document.frm.writeCheck.value == 0){
					alert("글이 등록되지않았습니다")
					rtn = false;
				}
				if(document.frm.writeCheck.value == 1){
					alert("글이 등록되었습니다")
					rtn = true;
				}
				
			},
			error : function (a1, a2, a3){
				console.log(a1, a2, a3);
			}
		});  
		console.log("form :"+form)
	return rtn;	
}

/* $("#btnSubmit").click(function (event) {
	var form = $('#frm')[0];
	var rtn = false;
	var formData = new FormData(form);
	var file = document.getElementById('file').files[0];
	formData.append("file", file);

	$().ajax({
		url : '/board/writeProc',
		type : 'POST',
		enctype : 'multipart/form-data',
		data : formData,
		dataType : "json",
		cache : false,
		async : false,
	processData: false,
		contentType: multipart/form-data,
	 	success : function(data){
			document.frm.writeCheck.value = data;
				if(document.frm.writeCheck.value == 0){
					alert("글이 등록되지않았습니다")
					rtn = false;
				}
				if(document.frm.writeCheck.value == 1){
					alert("글이 등록되었습니다")
					rtn = true;
				}
				
			}
	})
		return rtn;
}) */


function ModCheck(){
	
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
		url : '/board/modifyProc',
		type : 'POST',
		data : $("#frm").serialize(),
		dataType : "json",
		async : false,
	/* processData: false, */
		/* contentType: false, */
	 	success : function(data){
			document.frm.modCheck.value = data;
				if(document.frm.modCheck.value == 0){
					alert("글이 수정 되지않았습니다")
					rtn = false;
				}
				if(document.frm.modCheck.value == 1){
					alert("글이 수정되었습니다")
					rtn = true;
				}
			}
	})
		return rtn;
}
</script>
