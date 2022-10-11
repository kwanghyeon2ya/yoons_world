/**
 * 
 */

function writeCommentsCheck(){
	var param = $("#commInsertForm").serialize();
	
	if($("#commContent").val().length == ""){
		alert("댓글 내용을 작성해주세요");
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
					location.reload(true);
					break;
				default:
					break;
				}
			}
	})
}




function modifyCommentsCheck(index){

	var regrSeqValue = $("#modRegrSeq_"+index).val();
	var postSeqValue = $("#modPostSeq_"+index).val();
	var commSeqValue = $("#modCommSeq_"+index).val();
	var modCommGroupValue = $("#modCommGroup_"+index).val();
	var commContentValue = $("#modCommContent_"+index).val();
	
	
	var param = {regrSeq : regrSeqValue,postSeq : postSeqValue,
				 commSeq : commSeqValue,commContent : commContentValue,
				 commGroup : modCommGroupValue};
	
	if($("#modCommContent_"+index).val() == ""){
		alert("댓글 내용을 작성해주세요");
		$("#modCommContent_").focus();
		return false;
	}
	if($("#modCommContent_"+index).val().length > 500){
		alert("댓글 내용은 500자를 넘길 수 없습니다");
		$("#modCommContent_"+index).focus();
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
					$("#reloadDiv").load(' #reloadDiv');
					break;
				default:
					break;
				}
			}
	})
}




	
	
	
