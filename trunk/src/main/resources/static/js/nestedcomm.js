/**
 * 
 */
function CocoBox(){
	
	var commDisplay = document.getElementById("frm2").style.display == "none";
	
	if(commDisplay){
		document.getElementById("frm2").style.display = "block";
	}else{
		document.getElementById("frm2").style.display = "none";
	}
	
}

function CocoCheck(){
	
	var commSeq = $("#commSeq").val();
	var commContent2 = $("#commContent2").val();
	var postSeq2 = $("#postSeq2").val();
	var commGroup = $("#commGroup").val();
	
	var param = {commSeq : commSeq,
				commContent : commContent2,	
				postSeq : postSeq2,
				commGroup : commGroup
				};
	
	if(commContent2 == ""){
		alert("write content!!");
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
				alert("cocoments is not written");
				break;
			case 1:
				alert("cocoments written");
				location.reload(true);
			default:
				break;
			}
		}
		
	})
	
	
	
}