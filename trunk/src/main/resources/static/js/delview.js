/**
 * 
 */
/**
 * 
 */
function DeleteCheck(){
	var rtn = false;
	var postSeq1 = document.getElementById("postSeq").value;
	var wregrSeq = document.getElementById("wregrSeq").value;
	var seqParam = {postSeq : postSeq1,	regrSeq : wregrSeq};
	if(window.confirm("댓글을 삭제하시겠습니까?")){
		
		$.ajax({
			url : '/board/deleteProc',
			data : seqParam,
			type : 'POST',
			async : false,
			/* processData: false, */
			/* contentType: false, */
		 	success : function(data){
	 			switch (Number(data)){
					case 0 :
						alert("삭제되지않았습니다");
						break;
					case 1 :
						alert("삭제되었습니다");
						window.location.href = "/board/free/list";
						break;
					default:
						alert("삭제되지않았습니다");
						break;
	 			}
		 	}
		})
	}
}