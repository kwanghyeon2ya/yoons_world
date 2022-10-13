/**
 * 
 */

function writeCommentsCheck(){
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
					$("#reloadDivParent").load(' #reloadDiv');
					break;
				default:
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
		dataType : "json",
		async : false,
	/* processData: false, */
		/* contentType: false, */
	 	success : function(data){
				switch (Number(data)) {
				case 0:
					alert("댓글이 수정되지 않았습니다");
					break;
				case 1:
					alert("댓글이 수정되었습니다");
					$("#reloadDivParent").load(' #reloadDiv');
					break;
				default:
					break;
				}
			}
	})
}




	
	
	
