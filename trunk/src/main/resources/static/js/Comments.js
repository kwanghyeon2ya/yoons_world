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
					window.location.href='/board/free/view';
					rtn = true;
				}
			}
	})
		return rtn;
}

function DeleteCheck(){
	var rtn = false;
	var regrSeq = document.getElementById("regrSeq").value
	var wregrSeq = document.getElementById("wregrSeq").value
	if(window.confirm("정말로 삭제하시겠습니까?")){
		if(regrSeq == wregrSeq){
				$.ajax({
					url : '/board/deleteProc,
					type : 'POST',
					data : $("#frm").serialize(),
					dataType : "json",
					async : false,
				/* processData: false, */
					/* contentType: false, */
				 	success : function(data){
						document.frm.delCheck.value = data;
							if(document.frm.delCheck.value == 0){
								alert("no")
								rtn = false;
							}
							if(document.frm.delCheck.value == 1){
								alert("delete complete")
								window.location.href='/board/free/list';
								rtn = true;
							}
						}
				})
			return rtn;
			}else{
				alert("작성자가일치하지 않습니다")
			}
		}else{
			console.log("삭제 취소")
	}
}