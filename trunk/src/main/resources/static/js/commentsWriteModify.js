/**
 * 
 */

function writeCommentsCheck(post_seq){
	var param = $("#comm_insert_form").serialize();
	
	if($("#commContent").val() == ""){
		alert("댓글 내용을 작성해주세요");
		$("#commContent").focus();
		return false;
	}
	if($("#commContent").val().trim().length == 0){
		alert("공백만으로 댓글을 작성할 수 없습니다");
		$("#commContent").val() = "";
		$("#commContent").focus();
		return false;
	}
	if($("#commContent").val().length > 500){
		alert("댓글 내용은 500자를 넘길 수 없습니다");
		$("#commContent").focus();
		return false;
	}
	$.ajax({
		url : '/board/insertCommentsProc',
		type : 'POST',
		data : param,
		contentType: 'application/x-www-form-urlencoded; charset=utf-8',
		dataType : "json",
		async : false,
	/* processData: false, */
		/* contentType: false, */
	 	success : function(data){
				switch (Number(data)) {
				case 0:
					alert("댓글이 작성되지 않았습니다");
					break;
				case 1:
					alert("댓글이 작성되었습니다");
					$("write_comments").attr("disabled",true);
					$("#reload_div_parent").load('/board/comments ',{postSeq:post_seq});
					break;
				default:
					alert("댓글이 작성되지 않았습니다");
					break;
				}
			}
	})
}




function modifyCommentsCheck(index){

	var regr_seq_value = $("#mod_regr_seq_"+index).val();
	var post_seq_value = $("#mod_post_seq_"+index).val();
	var comm_seq_value = $("#mod_comm_seq_"+index).val();
	var mod_comm_group_value = $("#mod_comm_group_"+index).val();
	var mod_comm_content_value = $("#mod_comm_content_"+index).val();
	
	console.log("content : " + mod_comm_content_value);
	console.log("commSeq : " + comm_seq_value);
	console.log("regr_seq : " + regr_seq_value);
	console.log("postSeq : "+ post_seq_value);
	
	var param = {regrSeq : regr_seq_value,postSeq : post_seq_value,
				 commSeq : comm_seq_value,commContent : mod_comm_content_value,
				 commGroup : mod_comm_group_value};
	
	if($("#mod_comm_content_"+index).val() == ""){
		alert("댓글 내용을 작성해주세요");
		$("#mod_comm_content_"+index).focus();
		return false;
	}
	if($("#mod_comm_content_"+index).val().trim().length == 0){
		alert("공백만으로 댓글을 작성할 수 없습니다");
		$("#mod_comm_content_"+index).val() = "";
		$("#mod_comm_content_"+index).focus();
		return false;
	}
	if($("#mod_comm_content_"+index).val().length > 500){
		alert("댓글 내용은 500자를 넘길 수 없습니다");
		$("#mod_comm_content_"+index).focus();
		return false;
	}
	$.ajax({
		url : '/board/modifyCommentProc',
		type : 'POST',
		data : param,
		contentType: 'application/x-www-form-urlencoded; charset=utf-8',
		dataType : "html",
		async : false,
	/* processData: false, */
		/* contentType: false, */
	 	success : function(data){
					if(data == '') {
						alert("댓글이 수정되지 않았습니다");
					}else if(data == "4444"){
						alert("글자 수가 너무 많습니다");
					}else if(data == "9999"){
						alert("잘못된 요청입니다 로그인 페이지로 이동합니다");
						location.href="/login/logout";
					}else{
						alert("댓글이 수정되었습니다");
						console.log("data : "+data);
						/*$('.reload_comment_parent_'+index).html();*/
						var str = data;
						console.log("str before : "+str);
						
						str = str.replace(/\r\n/ig, '<br>');
			            str = data.replace(/\n/ig, '<br>');
			            console.log("str after : "+str);
						$("#ptag_commContent_"+index).html(str);
						/*$("#ptag_commContent_"+index).html("<p><c:out escaperXml='false' value="+data+"/>"+data+"</p>");*/
						$("#comment_mod_form_"+index).css("display","none");
					}
				}
	})
}


	
