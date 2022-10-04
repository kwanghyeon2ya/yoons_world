/**
 * 
 */
function DeleteCheck(){
	var rtn = false;
	var postSeq1 = document.getElementById("postSeq").value;
	var regrSeq1 = document.getElementById("regrSeq").value;
	var wregrSeq = document.getElementById("wregrSeq").value;
	var seqParam = {postSeq : postSeq1,
					regrSeq : regrSeq1
					};
	console.log("postSeq" : postSeq);
	
	if(window.confirm("정말로 삭제하시겠습니까?")){
		if(regrSeq1 == wregrSeq){
				$.ajax({
					url : '/board/deleteProc,
					data : seqParam,
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
					})
				}else{
					alert("작성자가일치하지 않습니다")
				}
			}else{
				console.log("삭제 취소")
		}
	}
}