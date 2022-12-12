
/**
 * 
 */

function showHideCocoForm(index){ //대댓글폼 보이기 js
	
	
	if(!$("#coco_insert_form_"+index).is(':visible')){
		$("#coco_insert_form_"+index).show();
		$("#coco_comm_content_"+index).focus();
		/*document.getElementById("close_coco_form_word_"+index).style.display = "block";
		document.getElementById("open_coco_form_word_"+index).style.display = "none";*/
	}else{
		$("#coco_insert_form_"+index).hide();
		/*document.getElementById("close_coco_form_word_"+index).style.display = "none";
		document.getElementById("open_coco_form_word_"+index).style.display = "block";*/
		
	}
	
	if($('#comment_mod_form_'+index).is(':visible')){ //댓글수정폼이 열려있다면 true
		$('#comment_mod_form_'+index).hide(); //수정폼을 닫음
	}
	
	
}

function modCommFormShowHide(index){ //댓글 수정폼 보이기 js
	
	if(!$('#comment_mod_form_'+index).is(':visible')){
		$('#comment_mod_form_'+index).show();
		$('#mod_comm_content_'+index).focus();
		/*document.getElementById('close_comm_mod_comm_word_'+index).style.display = "block";
		document.getElementById('open_comm_mod_comm_word__'+index).style.display = "none";*/
	}else{
		$('#comment_mod_form_'+index).hide();
		/*document.getElementById('close_comm_mod_comm_word_'+index).style.display = "none";
		document.getElementById('open_comm_mod_comm_word__'+index).style.display = "block;
*/	}
	
	if($("#coco_insert_form_"+index).is(':visible')){ //대댓글 폼이 열려있다면 true
		$("#coco_insert_form_"+index).hide(); //대댓글폼을 닫음
	}
	
}

function showHideNestedCocoList(index,comm_seq){ // 다시짜야할듯 ..
		/*
		var coco_list_hidden_div_class = document.getElementsByClassName("coco_list_hidden_div_class");
		let coco_group_arr = Array.from(document.getElementsByName("coco_group"));
		*/
		
		
		/*console.log("index : " +index);
		
		console.log("coco_group_arr : "+coco_group_arr);
		
		console.log("coco_list_hidden_div_class :"+coco_list_hidden_div_class);
		
		console.log("coco_group_arr[] :"+coco_group_arr[0].value);
		
		console.log("coco_group_arr[0].value : "+coco_group_arr[0].value);
		console.log("coco_group_index : "+coco_group);
		
		console.log("document.getElementById(coco_list_hidden_div_+index).style.display == none "+document.getElementById("coco_list_hidden_div_"+index));*/
		
		
		/*
		for(var i in coco_list_hidden_div_class){ // 대댓글 div태그의 class 전체조회
			
			if(comm_seq == coco_group_arr[i].value){ // 매개변수 comm_seq(댓글고유번호)와 대댓글의 hidden처리된 group번호를 비교
												
				if(coco_list_hidden_div_class[i].style.display == "none"){
					coco_list_hidden_div_class[i].style.display = "block";
				}else{
					coco_list_hidden_div_class[i].style.display = "none";
				}
				
			}
		}
		*/
		
	if(!$(".coco_list_hidden_div_"+comm_seq).is(':visible')){
		$(".coco_list_hidden_div_"+comm_seq).show();
	}else{
		$(".coco_list_hidden_div_"+comm_seq).hide();
	}
}

function getCommentsList(post_seq){
	
	$.ajax({
		url : '/board/comments?postSeq='+post_seq,
		type : 'POST',
		contentType: 'application/x-www-form-urlencoded; charset=utf-8',
		dataType : "html",
		async : false,
	 	success : function(data){
					$('#reload_div_parent').append(data);
		}
	})
}


function showMoreComments(post_seq){ //댓글 더보기 추가
			
	var more_comments_div = Array.from(document.getElementsByClassName("more_comments_div"));
	var coco_count = document.getElementsByClassName("coco_count_check").length;
	console.log("coco_count : "+coco_count); // 더보기 누르고 추가되는 것이기 떄문에 순서 생각
	var start_index = coco_count + 1;
	var end_index = coco_count + 10;
	
	console.log("start_index : "+start_index);
	console.log("end_index : "+end_index);
	
	var param = {postSeq:post_seq,startIndex:start_index,endIndex:end_index,cocoCount:coco_count};
	
	$.ajax({
		url : '/board/comments',
		type : 'GET',
		contentType: 'application/x-www-form-urlencoded; charset=utf-8',
		data : param,
		dataType : "html",
		async : false,
	 	success : function(data){
	 		
	 					$("#more_comments_list").remove();
	 				
	 				$('#reload_div_parent').append($(data).find("#comments_div"));
					+$("#more_comments_page").val() + 1;
					console.log("after plus : "+$("#more_comments_page").val());
		}
	})
	}