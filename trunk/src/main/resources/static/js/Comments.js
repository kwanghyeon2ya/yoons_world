/**
 * 
 */

function CommentsCheck(){
	var rtn = false;
	var param = $("#frm").serialize();
	
	if($("#commContent").val() == ""){
		alert("write content!!");
		return false;
	}
	$.ajax({
		url : '/board/commentsProc',
		type : 'GET',
		data : $("#frm").serialize(),
		dataType : "json",
		async : false,
	/* processData: false, */
		/* contentType: false, */
	 	success : function(data){
			document.frm.comCheck.value = data;
				if(document.frm.comCheck.value == 0){
					alert("no")
					rtn = false;
				}
				if(document.frm.comCheck.value == 1){
					alert("yes")
					rtn = true;
				}
			}
	})
		return rtn;
}