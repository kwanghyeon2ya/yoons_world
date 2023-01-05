$(document).ready(function(){
	getBoardList();
	
	/*
	var currentPosition = parseInt($(".rank_from_readcnt").css("top"));
	$(window).scroll(function(){
		var position = $(window).scrollTop();
	    $(".rank_from_readcnt").stop().animate({"top":position+currentPosition+"px"},10000);
	});
	*/
	
	$('#rank_more_btn').click(function() {
		$('.rank_area').css('height', 'auto');
		$('#rank_more_btn').hide();
	});
	
	
/*	//검은 막 띄우기
    $('.show_modal').click(function(e){
        e.preventDefault();
        wrapWindowByMask();
    });
*/
    //닫기 버튼을 눌렀을 때
   /* $('.close_modal').click(function (e) {  
        //링크 기본동작은 작동하지 않도록 한다.
        e.preventDefault();  
        $('.window, .popup').hide();
        background.classList.toggle('show');
    });       */

    //검은 막을 눌렀을 때
   /* $('.window').click(function () {  
    	window.close();
    });*/
  //공유하기 팝업 외에 영역 클릭
	
});




function changePwForm(){ //메인페이지 비밀번호 변경 ajax
	var password_confirm = RegExp(/^[a-zA-Z0-9]{4,12}$/);
	var param = {userPw : $("#user_pw").val(),
				 changeUserPw : $("#change_user_pw").val()}
	
	if($("#user_pw").val() == ""){
		alert("기존 비밀번호를 입력하세요");
		$("#user_pw").focus();
		return false;
	}
	if($("#change_user_pw").val() == ""){
		alert("변경할 비밀번호를 입력하세요");
		$("#change_user_pw").focus();
		return false;
	}
	if(!password_confirm.test($("#change_user_pw").val())){
		alert("비밀번호는 영문과 숫자의 조합으로 4-12자 이내로 작성해주세요 ");
		$("#change_user_pw").val("");
		$("#change_user_pw").focus();
		return false;
	}
	if($("#change_user_pw2").val() == ""){
		alert("비밀번호 확인란을 입력하세요");
		$("#change_user_pw2").focus();
		return false;
	}
	
	if($("#change_user_pw").val() != $("#change_user_pw2").val()){
		alert("비밀번호가 일치하지 않습니다");
		$("#change_user_pw").val("");
		$("#change_user_pw2").val("");
		$("#change_user_pw").focus();
		return false;
	}
	
	$.ajax({
		url : '/main/changePwProc',
		type : 'POST',
		data : param , 
		anync : true ,
		success : function(data){
			switch(Number(data)){
				case 0 :
					alert("기존 비밀번호가 잘못되었습니다.");
					break;
				case 1 :
					alert("비밀번호가 변경되었습니다. 다시 로그인해주세요.");
					location.href="/login/logout";
					window.close();
					break;
				case 9999 : 
					alert("잘못된 요청입니다. 로그인 화면으로 돌아갑니다");
					opener.parent.location="/login/loginView";
					window.close();
				default :
					break;
			}
		}
						
	})
	
}


/*function show() {
    document.querySelector(".background").className = "background show";
    document.querySelector(".background").className = "window show";
  }

  function close() {
    document.querySelector(".background").className = "background";
  }*/


/*function wrapWindowByMask(){
    //화면의 높이와 너비를 구한다.
    var maskHeight = $(document).height();  
    var maskWidth = $(window).width();  
	
    //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
	
    //애니메이션 효과
    $('.window').fadeIn(1000);      
    $('.window').fadeTo("slow",0.8);    
}*/


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