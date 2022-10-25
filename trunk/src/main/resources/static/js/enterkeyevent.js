/**
 * 
 */
$(document).ready(function(){
	$(".note-editable").keyup(function(e){ // 글작성시 
		console.log("글 진입성공");
		if(e.keyCode == 13){
			MoveAction();
		}
		
	})
});

$(document).ready(function(){
	$("#commContent").keyup(function(e){ // 댓글작성시 
		console.log("댓글 진입성공");
		if(e.keyCode == 13){
			writeCommentsCheck();
		}
		
	})
});

/*$("#commContent").on("keyup",function(e){ // 글작성시 
	console.log("댓글 진입성공");
	if(e.keyCode == 13){
		writeCommentsCheck();
	}
	
})*/

/*$('.description').summernote({
  callbacks: {
    onKeyup: function(e) {
    	if(e.keyCode == 13){
    		MoveAction();
    	}
    }
  }
})*/