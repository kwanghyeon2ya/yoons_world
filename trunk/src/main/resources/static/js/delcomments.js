/**
 * 
 */

function deleteCommentsCheck(index){
	
	var commSeqValue = $("#commSeq_"+index).val();
	var regrSeqValue = $("#cregrSeq_"+index).val();
	var param = {commSeq : commSeqValue, regrSeq : regrSeqValue};
	
	if(window.confirm("댓글을 삭제하시겠습니까?")){
		$.ajax({
			url : '/board/deleteCommentsProc',
			data : param,
			type : 'POST',
			async : false,
			success : function(data){
				switch(Number(data)){
				case 0:
					alert("댓글이 삭제되지 않았습니다");
					break;
				case 1:
					alert("댓글이 삭제되었습니다");
					location.reload(true);
					break;
				default:
					alert("댓글이 삭제되지 않았습니다");
					break;
				}
			}
		})
	}
}