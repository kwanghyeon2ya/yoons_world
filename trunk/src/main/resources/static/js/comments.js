/**
 * 
 */

function CommentsCheck(){
	var param = $("#frm").serialize();
	
	if($("#commContent").val() == ""){
		alert("write content!!");
		return false;
	}
	$.ajax({
		url : '/board/commentsProc',
		type : 'POST',
		data : $("#frm").serialize(),
		dataType : "json",
		async : false,
	/* processData: false, */
		/* contentType: false, */
	 	success : function(data){
				switch (Number(data)) {
				case 0:
					alert("comments is not written");
					break;
				case 1:
					alert("written complete")
					location.reload(true);
	
				default:
					break;
				}
			}
	})
}