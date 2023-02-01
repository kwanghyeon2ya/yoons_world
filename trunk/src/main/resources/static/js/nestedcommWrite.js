/**
 * 
 */

$("text")

function insertCocoCheck(index){
	
//	var frm2 = 'cocoInsertForm_'+index;
/*	var commSeq = 'coco_comm_seq_'+index;
	var commGroup = 'coco_comm_group_'+index;
	var commContent2 = 'coco_comm_content_'+index;
	var postSeq2 = 'coco_post_seq_'+index;*/
	
	var comm_seq = document.getElementById('coco_comm_seq_'+index);
	var comm_group = document.getElementById('coco_comm_group_'+index);		
	var comm_content = document.getElementById('coco_comm_content_'+index);
	var post_seq = document.getElementById('coco_post_seq_'+index);
	 
	var param = {commSeq : comm_seq.value,
				commGroup : comm_group.value,
				commContent : comm_content.value,	
				postSeq : post_seq.value
				};
	
	if(comm_content.value == ""){
		alert("댓글을 작성해주세요");
		comm_content.focus();
		return false;
	}
	if(comm_content.value.trim().length == 0){
		alert("공백만으로 댓글을 작성할 수 없습니다");
		comm_content.value = "";
		comm_content.focus();
		return false;
	}
	if(comm_content.value.length > 500){
		alert("댓글은 500자를 넘길 수 없습니다");
		comm_content.focus();
		return false;
	}
	
	$.ajax({
		url : '/board/insertCommentsProc',
		data : param,
		type : 'POST',
		async : false,
		success : function(data){
			switch(Number(data)){
			case 0:
				alert("대댓글이 작성되지 않았습니다");
				break;
			case 1:
				alert("대댓글이 작성되었습니다");
				$("#insert_coco_"+index).attr("disabled",true);
				$("#reload_div_parent").load('/board/comments ',{postSeq:post_seq.value});
				break;
			default:
				break;
			}
		}
		
	})
}