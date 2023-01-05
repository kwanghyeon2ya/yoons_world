
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
<jsp:include page="/WEB-INF/jsp/inc/import.jsp" flush="false" />
<jsp:include page="/WEB-INF/jsp/inc/boardImport.jsp" flush="false" />

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<link rel="stylesheet" type="text/css" href="/css/board/board.css">
<link rel="stylesheet" type="text/css" href="/css/main/main.css">

<c:if test="${sessionScope.sessionSeqForAdmin == null}">
	<c:redirect url="/login/loginView" />
</c:if>
	<script>
	
		/* function changePwForm(){
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
							opener.parent.location="/login/loginView";
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
			
		} */
		
		$(document).ready(function(){
		
			/* const modal = $(".modal");
			const btnOpenPopup = $(".btn_open_popup");
			
				modal.css("display","block");
				body.style.overflow = 'hidden';
				/* modal.classList.toggle('show'); */
			
		});
		
		
		
	</script>
</head>
<body>
	
	<%-- <div class="modal .show">
		<div class="modal_body">
		
			<form method="post" id="change_pw_frm" style="text-align:center;" onSubmit="return false;">
				<table border=1>
					<tbody style="text-align:center;">
						<tr>
							<th><span style="font-size:1.5rem;"><label for="user_pw">기존 비밀번호</label></span></th>
							<td><input type="password" name="userPw" id="user_pw"></td>
						</tr>
						<tr>
							<th><span style="font-size:1.5rem;"><label for="change_user_pw">변경할 비밀번호</label></span></th>
							<td><input type="password" name="changeUserPw" id="change_user_pw" placeholder="4-12자 영문과 숫자의 조합"></td>
						</tr>
						<tr>
							<th><span style="font-size:1.5rem;"><label for="change_user_pw2">비밀번호 확인</label></span></th>
							<td><input type="password" id="change_user_pw2"></td>
						</tr>
					</tbody>
				</table>
				<button type="submit" class="btn type_02 bg_purple" style="width:40rem;" onclick="changePwForm()">변경</button>
				<button type="button" class="btn type_02 bg_aaa" style="width:5rem;" onclick="window.close()">취소</button>
				<c:if test="${pwCheck eq 0}">
					<br><span style="font-size:0.5rem;color:red">보안을 위해 초기 비밀번호를 꼭 변경하세요</span>
				</c:if>
			</form>
		
		</div>
	</div>
	<button class="btn_open_popup">비밀번호 변경</button> --%>
	
	<%-- <form method="post" id="change_pw_frm" style="text-align:center;" onSubmit="return false;">
		<table border=1>
			<tbody style="text-align:center;">
				<tr>
					<th><label for="user_pw">기존 비밀번호</label></th>
					<td><input type="password" name="userPw" id="user_pw"></td>
				</tr>
				<tr>
					<th><label for="change_user_pw">변경할 비밀번호</label></th>
					<td><input type="password" name="changeUserPw" id="change_user_pw" placeholder="4-12자 영문과 숫자의 조합"></td>
				</tr>
				<tr>
					<th><label for="change_user_pw2">비밀번호 확인</label></th>
					<td><input type="password" id="change_user_pw2"></td>
				</tr>
			</tbody>
		</table>
		<button type="submit" class="btn type_02 bg_purple" style="width:40rem;" onclick="changePwForm()">변경</button>
		<button type="button" class="btn type_02 bg_aaa" style="width:5rem;" onclick="window.close()">취소</button>
		<c:if test="${pwCheck eq 0}">
			<br><span style="font-size:0.5rem;color:red">보안을 위해 초기 비밀번호를 꼭 변경하세요</span>
		</c:if>
	</form> --%>
</body>