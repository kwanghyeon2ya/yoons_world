/**
 * 
 */

function CommentsCheck(){
	var param = $("#frm").serialize();
	
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
		url : '/board/commentsProc',
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
					
				default:
					break;
				}
			}
	})
}