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
	var seqParam = {postSeq : postSeq1,
					regrSeq : wregrSeq
					};
	
	if(window.confirm("정말로 삭제하시겠습니까?")){
				$.ajax({
					url : '/board/deleteProc,
					contentType: "application/json; charset=EUC-KR",
					data : JSON.stringify(seqParam),
					type : 'POST',
					async : false,
				/* processData: false, */
					/* contentType: false, */
					
				 	success : function(data){
							switch (Number(data)){
							case 0 :
								alert("delete not done")
								break;
							case 1 :
								alert("delete complete")
								window.location.href = "/board/free/list";
							
							default:
								break;
							}
				 		}
				)}
	}
}