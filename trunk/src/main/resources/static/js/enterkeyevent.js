/**
 * 
 */

  /*$(document).on("keyup", "#commContent" , function() {
	  console.log("댓글 진입성공");
        });*/

/*window.onload = function(){*/

  $(document).ready(function(){ //4번씩 작동(이벤트 버블링)
  
	  $("#commContent").keyup(function(e){
//	console.log("onload");
//	console.log("commcont : "+$("#commContent"));
//		console.log("댓글 진입성공");
		if(e.keyCode == 13){
			$("#write_comments").click();
		}
	  });
	  
	  $(".comm_textarea").keyup(function(e){
		if(e.keyCode == 13){
			
		}  
	  })
		
	  
	  $(".note-editable").keyup(function(e){
		  if(e.keyCode == 13){
			  $("#move_action_button").click();
		  }
	  });
	  
	  /*$(".note-editable").keyup(function(e){
		  if(e.keyCode == 13){
			  $("#move_action_button").click();
		  }
	  });*/
	  
	  
	$("#search_text").keyup(function(e){ // 검색창 작성시
		console.log("검색 진입성공");
		if(e.keyCode == 13){
			$("#submit_button").click();
		}
	});
	
	$("#subject").keyup(function(e){ // 글 제목 작성시 
		console.log("댓글 진입성공");
		if(e.keyCode == 13){
			if(($("#subject").val() == "" && $("#subject").val().trim().length == 0)){
				alert("공백만으로 제목을 작성할 수 없습니다");
				$("#subject").focus();
			}else{
				$('.note-editable').focus();
			}
			
		}
		
	});
	
	$("#userID").keyup(function(e){ // 아이디 입력창 작성시
		console.log("검색 진입성공");
		if(e.keyCode == 13){
			if($("#userID").val() == '' || $("#userID").val() == null) {
				alert("id를 입력하세요.");
				$("#userID").focus();
			}else{
				$("#password").focus();
			}
		}
	});
	
	$("#password").keyup(function(e){ // 비밀번호 입력창 작성시
		console.log("검색 진입성공");
		if(e.keyCode == 13){
			$("#loginbtn").click();
		}
	});
	
 });
/*$("#commContent").on("keyup",function(e){ // 글작성시 
	console.log("댓글 진입성공");
	if(e.keyCode == 13){
		writeCommentsCheck();
	}
	
})*/

