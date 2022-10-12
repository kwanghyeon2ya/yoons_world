/**
 * 
 */
/**
 * 
 */
function deleteViewCheck(url){ //게시글 삭제
	console.log(url);
	alert(url);
	var rtn = false;
	var post_seq = document.getElementById("post_seq").value;
	var view_regr_seq = document.getElementById("view_regr_seq").value;
	var param = {postSeq : post_seq,regrSeq : view_regr_seq};
	if(window.confirm("게시글을 삭제하시겠습니까?")){
		
		$.ajax({
			url : '/board/deleteViewProc',
			data : param,
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
						location.href = url;
						break;
					default:
						alert("삭제되지않았습니다");
						break;
	 			}
		 	}
		})
	}
}