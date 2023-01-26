/**
 * 
 */

function deleteCommentsCheck(index,group_number){
	
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
					if(index == group_number){
						console.log("댓글 삭제 진입");
						$('.reload_comment_parent_'+index).load('/board/comments .reload_comment_'+index,{postSeq:post_seq_value});
					}else{
						console.log("대댓글 삭제 진입");
						$('.cocoList_div_'+group_number).load('/board/comments .cocoList_div_'+group_number,{postSeq:post_seq_value});
					} // 대충이런식으로 낼짜자
					/*$("#reload_div_parent").load('/board/comments ',{postSeq:post_seq_value});*/
					break;
				case 9999:
					alert("잘못된 요청입니다. 로그인 화면으로 돌아갑니다");
					location.href="/login/logout";
					break;
				default:
					alert("댓글이 삭제되지 않았습니다");
					break;
				}
			}
		})
	}
}