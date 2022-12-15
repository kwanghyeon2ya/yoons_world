/**
 * 
 */

function deleteCommentsCheck(index){
	
	var comm_seq_value = $("#mod_comm_seq_"+index).val();
	var post_seq_value = $("#mod_post_seq_"+index).val();
	var param = {commSeq : comm_seq_value , postSeq : post_seq_value};
	
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
					$('.reload_comment_parent_'+index).load('/board/comments .reload_comment_'+index,{postSeq:post_seq_value});					
					/*$("#reload_div_parent").load('/board/comments ',{postSeq:post_seq_value});*/
					break;
				default:
					alert("댓글이 삭제되지 않았습니다");
					break;
				}
			}
		})
	}
}