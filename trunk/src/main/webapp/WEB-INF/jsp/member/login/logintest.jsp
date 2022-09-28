<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<h1>login</h1>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>

<script>

$(document).ready(function() {
	$("#loginSubmit").click(function() {
		var form_data = {
			user_id : $("#user_id").val(),
			user_pwd: $("#user_pwd").val()
		};
		$.ajax({
			type: "POST",
			url: "/login/loginCheck",
			data: form_data,
			beforeSend : function(xhr){
				xhr.setRequestHeader("AJAX", "true"); 
				xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			},
			
			success: function(msg, textStatus, xhr) {
				if(msg == 'true') {
					alert("로그인이 성공하였습니다!!");
					window.location.replace("로그인 후 url");
				} else {
					alert("아이디 또는 비밀번호가 잘못되었습니다!!");
				}
			},
			error:function(request, status, error){
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
		return false;
	});
});
</script>


<form name="frm" id="frm" action="/member/login/main" onSubmit="return LoginCheck()">
	아이디 : <input type="text" name="userId" id="userId"/><br/>
	비밀번호 : <input type="password" name="userPw" id="userPw"/><br/>
	<input type="hidden" name="loginCheck"/>
	<input type="submit" value="로그인"/>
</form>
