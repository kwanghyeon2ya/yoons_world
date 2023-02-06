$(document).ready(function(){
	getMyListByLike();
	getMyListByComments();
	getMyBoardList();
})


function getMyListByLike(){
	
	var length = $(".myListByLikeCount").length;
	var page_num = (length+5)/5;
	console.log($(".myListByLikeCount").length);
	console.log("갯수 ~"+document.getElementsByClassName("myListByLikeCount").length);
	console.log("pageNum : "+page_num);
	$.ajax({ // 내가 좋아요 누른 게시글 불러옴
		url : '/board/getMyListByLike?pageNum='+page_num,
		type : 'GET',
		contentType: 'application/x-www-form-urlencoded; charset=utf-8',
		dataType : "html",
		async : true,
	 	success : function(data){
	 		if(page_num != 1){
	 			$(".more_myListByLike_btn").remove();
	 			$('#my_list_by_like').append(data); // 마이페이지 div에 붙임
	 			$(".main_board_area").removeProp("margin-top");
	 		}else{
	 			$('#my_list_by_like').append(data);	
	 		}
			
		}
	})
}

function getMyListByComments(){
	
	var length = $(".myListByCommentsCount").length;
	var page_num = (length+5)/5;
	console.log("갯수 :"+$(".myListByCommentsCount").length);
	console.log("갯수 ~"+document.getElementsByClassName("myListByCommentsCount").length);
	
	$.ajax({ // 내가 좋아요 누른 게시글 불러옴
		url : '/board/getMyListByComments?pageNum='+page_num,
		type : 'GET',
		contentType: 'application/x-www-form-urlencoded; charset=utf-8',
		dataType : "html",
		async : true,
	 	success : function(data){
	 		if(page_num != 1){
	 			$(".more_mylistByComm_btn").remove();
	 			$('#my_list_by_comments').append(data);
	 			$(".main_board_area").removeProp("margin-top");
	 		}else{
	 			$('#my_list_by_comments').append(data);
	 		}
	 		
			
		}
	})
}

function getMyBoardList(){
	
	var length = $(".myBoardListCount").length;
	var page_num = (length+5)/5;
	console.log("갯수 :"+$(".myBoardListCount").length);
	console.log("갯수 ~"+document.getElementsByClassName("myBoardListCount").length);
	$.ajax({ // 내가 좋아요 누른 게시글 불러옴
		url : '/board/getMyBoardList?pageNum='+page_num,
		type : 'GET',
		contentType: 'application/x-www-form-urlencoded; charset=utf-8',
		dataType : "html",
		async : true,
	 	success : function(data){
	 		if(page_num != 1){
	 			$(".more_myBoardlist_btn").remove();
	 			$('#my_boardList').append(data).find(".main_board_area").removeProp("margin-top");
	 			$(".main_board_area").removeProp("margin-top");
	 		}else{
	 			$('#my_boardList').append(data);
	 		}
	 		
			
		}
	})
}
	
