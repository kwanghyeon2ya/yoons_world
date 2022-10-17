/**
 * 
 */

function showHideCocoForm(index){ //대댓글폼 보이기 js
	
	
	if(document.getElementById("coco_insert_form_"+index).style.display == "none"){
		document.getElementById("coco_insert_form_"+index).style.display = "block";
		document.getElementById("coco_comm_content_"+index).focus();
		/*document.getElementById("close_coco_form_word_"+index).style.display = "block";
		document.getElementById("open_coco_form_word_"+index).style.display = "none";*/
	}else{
		document.getElementById("coco_insert_form_"+index).style.display = "none";
		/*document.getElementById("close_coco_form_word_"+index).style.display = "none";
		document.getElementById("open_coco_form_word_"+index).style.display = "block";*/
		
	}
	
	if(document.getElementById('comment_mod_form_'+index).style.display == "block"){ //댓글수정폼이 열려있다면 true
		document.getElementById('comment_mod_form_'+index).style.display = "none"; //수정폼을 닫음
	}
	
	
}

function modCommFormShowHide(index){ //댓글 수정폼 보이기 js
	
	if(document.getElementById('comment_mod_form_'+index).style.display == "none"){
		document.getElementById('comment_mod_form_'+index).style.display = "block";
		document.getElementById('mod_comm_content_'+index).focus();
		/*document.getElementById('close_comm_mod_comm_word_'+index).style.display = "block";
		document.getElementById('open_comm_mod_comm_word__'+index).style.display = "none";*/
	}else{
		document.getElementById('comment_mod_form_'+index).style.display = "none";
		/*document.getElementById('close_comm_mod_comm_word_'+index).style.display = "none";
		document.getElementById('open_comm_mod_comm_word__'+index).style.display = "block;
*/	}
	
	if(document.getElementById("coco_insert_form_"+index).style.display == "block"){ //대댓글 폼이 열려있다면 true
		document.getElementById("coco_insert_form_"+index).style.display = "none"; //대댓글폼을 닫음
	}
	
}



	
	
	
