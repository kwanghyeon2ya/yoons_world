<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	
<script>

function WriteCheck(){

	var rtn = false;
	
	if($("#subject").val() == ""){
		alert("내용을 입력해주세요")
		return false;
	}
	if($("#content").val() == ""){
		alert("내용을 입력해주세요")
		return false;
	}
$.ajax({
	url : "/member/free/writePro",
	type : "POST",
	dataType : "json",
	async : false,
	data : $("#frm").serialize(),
	success : function(data){
		document.getElementsByName("writeCheck").value = data;
			if($("#writeCheck").val() == 0){
				alert("글이 등록되지않았습니다")
				return rtn;
			}else{
				alert("글이 등록되었습니다")
				rtn = true;
				<c:redirect url="/board/free/list"/>
			}	
			
		}
	}
	
)

};

</script>
