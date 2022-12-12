/**
 * 
 */

  /*$(document).on("keyup", "#commContent" , function() {
	  console.log("댓글 진입성공");
        });*/

/*window.onload = function(){*/

/*function cocoKeyup(e,cocoSeq){//대댓글 작성 시 작동
	console.log("e :"+e.keyCode);
	console.log("e value:"+e.value);
	if(event.keyCode == 13){//대댓글 작성 후  엔터시 진입
		e.stopPropagation();
		alert("엔터누름 - 키코드"+event.keyCode);
		insertCocoCheck(cocoSeq);//대댓글 작성 function 호출
		event.keyCode = 0; //enterkey 무력화 
		console.log("버튼과 cocoSeq 결합 - 엔터누른뒤 : "+$("#coco_comm_content_"+cocoSeq));
		$("#insert_coco_"+cocoSeq).click(); //대댓글 작성 버튼 클릭
		$("#coco_comm_content_"+cocoSeq).off().on("click", function(){
			  //click 시 수행할 동작
		});
	}
}*/

/*function cocoKeyup(e,cocoSeq){//대댓글 작성 시 작동
	console.log("e :"+e.keyCode);
	console.log("e value:"+e.value);
	if(event.keyCode == 13){//대댓글 작성 후  엔터시 진입
		e.stopPropagation();
		alert("엔터누름 - 키코드"+event.keyCode);
		insertCocoCheck(cocoSeq);//대댓글 작성 function 호출
		event.keyCode = 0; //enterkey 무력화 
		console.log("버튼과 cocoSeq 결합 - 엔터누른뒤 : "+$("#coco_comm_content_"+cocoSeq));
		
	}
}*/


  $(document).ready(function(){ //4번씩 작동(이벤트 버블링)
  
	  /*$("#commContent").keyup(function(e){
		console.log("e :"+e);
		console.log("e"+e.keyCode);
//	console.log("commcont : "+$("#commContent"));
//		console.log("댓글 진입성공");
		if(e.keyCode == 13){
			$("#write_comments").click();
		}
	  });
	  
	  $(".note-editable").keyup(function(e){
		  if(e.keyCode == 13){
			  $("#move_action_button").click();
		  }
	  });
	  
	  $(".note-editable").keyup(function(e){
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

