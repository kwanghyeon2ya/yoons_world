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
					alert("�α����� �����Ͽ����ϴ�!!");
					window.location.replace("�α��� �� url");
				} else {
					alert("���̵� �Ǵ� ��й�ȣ�� �߸��Ǿ����ϴ�!!");
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
	���̵� : <input type="text" name="userId" id="userId"/><br/>
	��й�ȣ : <input type="password" name="userPw" id="userPw"/><br/>
	<input type="hidden" name="loginCheck"/>
	<input type="submit" value="�α���"/>
</form>
