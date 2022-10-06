/**
 * 
 */
function CocoShowHide(index){
	
	var frm2 = 'frm2_'+index;
	
	var commDisplay = document.getElementById(frm2).style.display == "none";
	
/*	var frmIndex = document.getElementById(frm2).split("_")[1];*/
	
	console.log(frm2);
	
	if(commDisplay){
		document.getElementById(frm2).style.display = "block";
	}else{
		document.getElementById(frm2).style.display = "none";
	}
	
}

function CocoCheck(index){
	
	var frm2 = 'frm2_'+index;
	var commSeq = 'commSeq_'+index;
	var commGroup = 'commGroup_'+index;
	var commContent2 = 'commContent2_'+index;
	var postSeq2 = 'postSeq2_'+index;
	
	commSeq = document.getElementById(commSeq);
	commContent2 = document.getElementById(commContent2);
	postSeq2 = document.getElementById(postSeq2);
	commGroup = document.getElementById(commGroup);
	
	var param = {commSeq : commSeq.value,
				commContent : commContent2.value,	
				postSeq : postSeq2.value,
				commGroup : commGroup.value
				};
	
	if(commContent2.value == ""){
		alert("댓글을 작성해주세요");
		commContent2.focus();
		return false;
	}
	if(commContent2.value.length > 500){
		alert("댓글은 500자를 넘길 수 없습니다");
		commContent.focus();
		return false;
	}
	
	$.ajax({
		url : '/board/commentsProc',
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
				location.reload(true);
				break;
			default:
				break;
			}
		}
		
	})
}