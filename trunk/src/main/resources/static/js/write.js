/**
 * 
 */
function WriteCheck(){
	$("#content").val($(".note-editable p").text());
	var form = $('#frm')[0];
	var rtn = false;
	var formData = new FormData(form);
	var file = document.getElementById('file').files[0];
	
	var rtn = false;
	//임시 사용
	

	if($("#subject").val() == ""){
		alert("제목이 없습니다");
		return false;
	}
	if($("#content").val() == ""){
		alert("내용을 입력해주세요");
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
					alert("0")
					rtn = false;
				}
				if(document.frm.writeCheck.value == 1){
					alert("1")
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
					alert("湲��� �깅���吏������듬����")
					rtn = false;
				}
				if(document.frm.writeCheck.value == 1){
					alert("湲��� �깅������듬����")
					rtn = true;
				}
				
			}
	})
		return rtn;
}) */


function ModCheck(){
	$("#content").val($(".note-editable").text());
	var rtn = false;
	var param = $("#frm").serialize();
	
	if($("#subject").val() == ""){
		alert("write subject");
		return false;
	}
	if($("#content").val() == ""){
		alert("write content");
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
					alert("0")
					rtn = false;
				}
				if(document.frm.modCheck.value == 1){
					alert("1")
					rtn = true;
				}
			}
	})
		return rtn;
}