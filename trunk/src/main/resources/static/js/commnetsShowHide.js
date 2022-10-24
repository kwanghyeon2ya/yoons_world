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


function showHideNestedCocoList(index,comm_seq){ // 다시짜야할듯 ..
	
		var coco_list_hidden_div_class = document.getElementsByClassName("coco_list_hidden_div_class");
		let coco_group_arr = Array.from(document.getElementsByName("coco_group"));
		
		/*console.log("index : " +index);
		
		console.log("coco_group_arr : "+coco_group_arr);
		
		console.log("coco_list_hidden_div_class :"+coco_list_hidden_div_class);
		
		console.log("coco_group_arr[] :"+coco_group_arr[0].value);
		
		console.log("coco_group_arr[0].value : "+coco_group_arr[0].value);
		console.log("coco_group_index : "+coco_group);
		
		console.log("document.getElementById(coco_list_hidden_div_+index).style.display == none "+document.getElementById("coco_list_hidden_div_"+index));*/
		
		for(var i in coco_list_hidden_div_class){ // 대댓글 div태그의 class 전체조회
			
			if(comm_seq == coco_group_arr[i].value){ // 매개변수 comm_seq(댓글고유번호)와 대댓글의 hidden처리된 group번호를 비교
												
				if(coco_list_hidden_div_class[i].style.display == "none"){
					coco_list_hidden_div_class[i].style.display = "block";
				}else{
					coco_list_hidden_div_class[i].style.display = "none";
				}
				
			}
		}
}

		/*coco_list_hidden_div_class_values.forEach(function(class_value) {
		    console.log(class_value);
		});
		
		coco_list_hidden_div_name_values.forEach(function(name_value) {
		    console.log(name_value);
		});*/
		
		/*for(var name_value of Object.entries(coco_list_hidden_div_name_values)){
			console.log("name : "+name_value);
		}
		
		for(var class_value of Object.entries(coco_list_hidden_div_class_values)){
			console.log("class : "+class_value);
		}*/
