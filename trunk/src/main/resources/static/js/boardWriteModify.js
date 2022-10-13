/**
 * 
 */
function WriteBoardCheck(url){

	
	$("#content").val($(".note-editable p").text());
	var insert_board_form = $('#insert_board_form')[0];
	var rtn = false;
	var form_data = new FormData(insert_board_form);
	var rtn = false;
	//임시 사용
	
	
	if($("#subject").val() == ""){
		alert("제목을 작성해주세요");
		$("#subject").focus();
		return false;
	}
	
	if($("#subject").val().trim().length == 0){
		alert("공백만으로 제목을 작성할 수 없습니다");
		$("#subject").focus();
		return false;
	}
	if($("#subject").val().length >= 50){
		alert("제목은 50자를 넘길 수 없습니다");
		$("#subject").focus();
		return false;
	}
	if($("#summernote").val() == ""){
		alert("본문을 작성해주세요");
		$("#content").focus();
		return false;
	}
	if($("#summernote").val().trim().length == 0){
		alert("공백만으로 내용을 작성할 수 없습니다.");
		return false;
	}
	if($("#summernote").val().length > 4000){
		alert("본문은 4000자 이상 작성할 수 없습니다");
		$("#content").focus();
		return false;
	}
	
	  $.ajax({
		url : '/board/writeProc',
		type : 'POST',
		enctype : 'multipart/form-data',
		data : form_data,
		dataType : "json",
		cache : false,
		async : false,
		processData: false,
		contentType: false,
	 	success : function(data){
		 		switch(Number(data)){
		 		case 0:
		 			alert("게시글이 작성되지 않았습니다");
		 			break;
		 		case 1:
	 				alert("게시글이 작성되었습니다");
	 				location.href=url;
	 				rtn = true;
		 		default:
		 			break;
	 			}
	 		},
			error : function (a1, a2, a3){
				console.log(a1, a2, a3);
			}
		});  
		console.log("form :"+insert_board_form)
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


function modBoardCheck(url){
	console.log($("#regrSeq"));
	$("#content").val($(".note-editable").text());
	var rtn = false;
	var modify_form = $("#modify_form")[0];
	var param = $("#modify_form").serialize();
	
	if($("#subject").val() == ""){
		alert("제목을 작성해주세요");
		return false;
	}
	if($("#summernote").val() == ""){
		alert("본문 내용을 작성해주세요");
		return false;
	}
	if($("#summernote").val().trim().length == 0){
		alert("공백만으로 내용을 작성할 수 없습니다.");
		return false;
	}
	$.ajax({
		url : '/board/modifyViewProc',
		type : 'POST',
		data : param,
		dataType : "json",
		async : false,
		cache : false,
	/* processData: false, */
		/* contentType: false, */
	 	success : function(data){
		 		switch(Number(data)){
		 		case 0:
		 			alert("수정되지 않았습니다");
					break;
		 		case 1:
		 			alert("수정되었습니다");
		 			location.href=url;
		 			break;
		 		default:
		 			alert("수정되지 않았습니다");
		 			break;	
		 		}
		 		
			},
			error : function (a1, a2, a3){
				console.log(a1, a2, a3);
			}
		});  
		console.log("form :"+modify_form)
		return rtn;
}