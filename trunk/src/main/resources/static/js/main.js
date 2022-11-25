$(document).ready(function(){
	getBoardList();
	
	var currentPosition = parseInt($(".rank_from_readcnt").css("top"));
	$(window).scroll(function(){
		var position = $(window).scrollTop();
	    $(".rank_from_readcnt").stop().animate({"top":position+currentPosition+"px"},10000);
	});
	
});

function getBoardList(){
	
	$.ajax({ // 3개의 리스트를 전부 가져와 jsp한페이지에 뿌려줄 ajax
		url : '/board/getListForMain',
		type : 'GET',
		contentType: 'application/x-www-form-urlencoded; charset=utf-8',
		dataType : "html",
		async : true,
	 	success : function(data){
			$('#main_board_list').html(data);
		}
	})
	
	$.ajax({// 한달간 모든 게시판 조회수 순
		url : '/board/getAllBoardListForReadCountForMonth',
		type : 'GET',
		contentType: 'application/x-www-form-urlencoded; charset=utf-8',
		dataType : "html",
		async : true,
	 	success : function(data){
			$('#rank_board_list').append(data);
		}
	})
	
}