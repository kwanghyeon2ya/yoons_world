/**
 * 
 */
function WriteBoardCheck(url){

	$("#content").val($('#summernote').summernote('code'));
	/*$("#content").val($('.note-editable').summernote('code'));*/
	var insert_board_form = $('#insert_board_form')[0];
	var rtn = false;
	var form_data = new FormData(insert_board_form);
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
	if($("#content").val() == ""){
		alert("본문을 작성해주세요");
		$("#summernote").focus();
		return false;
	}
	if($('.note-editable').text().trim().length == 0){
		alert("공백만으로 내용을 작성할 수 없습니다.");
		return false;
	}
	if($("#content").val().length > 4000){
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
	$("#content").val($('#summernote').summernote('code'));
	/*$("#content").val($('#summernote').text());*/
	
//	<p>test &lt;script&gt;dfjksalkdjls</script>"
	
	var rtn = false;
	var modify_form = $("#modify_form")[0];
	var mod_form_data = new FormData(modify_form);
	var file_uuid_array = document.getElementsByName("fileUuidArray").value
	
	console.log("uuidArray :" + file_uuid_array);
	console.log("modify_form : "+modify_form);
	console.log("mod_form_data : "+mod_form_data);
	
	
	if($("#subject").val() == ""){
		alert("제목을 작성해주세요");
		return false;
	}
	if($("#content").val() == ""){
		alert("본문 내용을 작성해주세요");
		return false;
	}
	if($('.note-editable').text().trim().length == 0){
		alert("공백만으로 내용을 작성할 수 없습니다.");
		return false;
	}
	if($("#content").val().length > 4000){
		alert("본문은 4000자 이상 작성할 수 없습니다");
		$("#content").focus();
		return false;
	}
		
	$.ajax({
		url : '/board/modifyViewProc',
		type : 'POST',
		enctype : 'multipart/form-data',
		data : mod_form_data,
		dataType : "json",
		async : false,
		cache : false,
		contentType : false,
		processData: false,
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





$(document).ready(function(){
	$(".note-editable").keyup(function() {
		
		/*var chk = "`!#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~ ` ";*/
		//내 오라클은 한글 2BYTE 확인
		$("#content").val($('.note-editable').text());
		var content_len = $("#content").val().length;
		var length = 0;
		
		console.log("content value :"+ $("#content").val());
		console.log("content_len :"+ content_len);
		/*for(var i = 0;i < content_len;i++){
			if(chk.indexOf($("#content").val().charAt(i)) >=0){
				length++
			}else{
				length += 2
			}
		}*/
		var str = "["+content_len+"자/4000]";
		
		if(content_len > 4000){
			
			$("#word_count").html(str);
			$("#word_count").attr("color","red");
			
			/*alert("더이상 입력하실 수 없습니다");*/
//			$('.note-editable').text().substring(0,3999);
			$("#content").val($("#content").val().substring(0,3999));
			
		}else{
			
			$("#word_count").html(str);
			$("#word_count").attr("color","green");
		
		}
	})
});


function getBoardList(){
	
	$.ajax({ // 자유게시판 AJAX
		url : '/board/free/list',
		type : 'GET',
		contentType: 'application/x-www-form-urlencoded; charset=utf-8',
		dataType : "html",
		async : true,
	 	success : function(data){
					$('#free_list').append($(data).find(".board_list"));
		}
	})
	
	$.ajax({// 공지사항 게시판 AJAX
		url : '/board/notice/list',
		type : 'GET',
		contentType: 'application/x-www-form-urlencoded; charset=utf-8',
		dataType : "html",
		async : true,
	 	success : function(data){
					$('#notice_list').append($(data).find(".board_list"));
		}
	})
	
	$.ajax({// 자료실 게시판 AJAX
		url : '/board/pds/list',
		type : 'GET',
		contentType: 'application/x-www-form-urlencoded; charset=utf-8',
		dataType : "html",
		async : true,
	 	success : function(data){
					$('#pds_list').append($(data).find(".board_list"));
		}
	})
}