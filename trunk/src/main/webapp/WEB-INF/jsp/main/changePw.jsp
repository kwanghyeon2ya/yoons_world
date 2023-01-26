
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/inc/boardImport.jsp" flush="false" />

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<!-- <link rel="stylesheet" type="text/css" href="/css/board/board.css"> -->
<link rel="stylesheet" type="text/css" href="/css/main/main.css">

	<script>
	
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
	
		/* function modal_close(){ // 모달창 닫기
			document.body.style.overflow = 'auto';
			/*window.close();
			$(".background").removeClass('show');
			$("#page-wrapper").toggleClass('blur_page');
		} */
		
		$(document).ready(function(){
			const background = $(".background");
			const window = $(".window");
			
			/* $(".show_modal").on("click",function(){ // 모달창 켜기
				background.css("display","block");
				document.body.style.overflow = 'hidden';
				$(".background").fadeIn('fast');
				background.toggleClass('show');
				$("#container").toggleClass('blur_page');
			});
			<c:if test="${sessionScope.sessionPwCheck eq 1}"> // 초기비번 바꾼사람들에 한 해 검은색 화면 눌러도 모달꺼지게 기능구현
				$(".background").mouseup(function(e){
					console.log("클릭 진입");
					console.log(e.target); //누른곳의 요소가 다나옴
					console.log(e.target.length);
					console.log("팝업 length : "+$(".popup").has(e.target).length);//클릭 하면 요솟 수 / 딴데누르면 요소가 아니라서 0
					if($(".popup").has(e.target).length == 0){
						$(".background").removeClass('show');
						document.body.style.overflow = 'auto';
						$("#container").toggleClass('blur_page');
					}
				});
			
			</c:if> */
			
			<c:if test="${sessionScope.sessionSeqForUser != null && sessionScope.sessionPwCheck eq 0}">
				/* window.open('/main/changePw','비밀번호 변경','width=500,height=270,scrollbars=no, toolbars=no, menubar=no'); */
				document.body.style.overflow = 'hidden';
				$(".background").fadeIn('fast');
				background.toggleClass('show');
				$("#container").toggleClass('blur_page');
			</c:if>
		});
		
		
		
	</script>
</head>
<body>
	<div class="background">
		<div class="window">
			<div class="popup">
				<!-- <a href="javascript:void(0)" class="close_modal">X</a> -->

				<form method="post" id="change_pw_frm" style="text-align: center;" onSubmit="return false;">
					<table border=1 style="margin: 0 auto;width:100%;">
						<tbody>
							<tr>
								<th><span style="font-size: 1.5rem;"><label for="user_pw">기존 비밀번호</label></span></th>
								<td><input type="password" name="userPw" id="user_pw"></td>
							</tr>
							<tr>
								<th><span style="font-size: 1.5rem;"><label for="change_user_pw">변경할 비밀번호</label></span></th>
								<td><input type="password" name="changeUserPw" id="change_user_pw" placeholder="4-12자 영문과 숫자 조합"></td>
							</tr>
							<tr>
								<th><span style="font-size: 1.5rem;"><label for="change_user_pw2">비밀번호 확인</label></span></th>
								<td><input type="password" id="change_user_pw2"></td>
							</tr>
						</tbody>
					</table>
					<button type="submit" class="btn type_02 bg_purple"
					 ${pwCheck eq 1?'style="width: 24rem;"':'style="width: 30.5rem;"'} 
					 onclick="changePwForm()">변경</button>
					<c:if test="${sessionScope.sessionPwCheck eq 0}">
						<br>
						<span style="font-size: 1rem; color: red">보안을 위해 초기 비밀번호를 꼭 변경하세요</span>
					</c:if>
				</form>

			</div>
			<div>
				<div></div>
			</div>
		</div>
	</div>
</body>