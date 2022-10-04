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
	
	if(window.confirm("delete Confirm")){
		console.log(seqParam);
		console.log("asdasd"+JSON.stringify(seqParam));
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
								alert("delete not done")
								break;
							case 1 :
								alert("delete complete")
								window.location.href = "/board/free/list";
							
							default:
								break;
							}
				 		}
				})
	}
}