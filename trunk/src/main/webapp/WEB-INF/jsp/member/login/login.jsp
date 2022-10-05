<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>login</h1>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>

<script>

function LoginCheck(){

	var rtn = false;
	
	if($("#userId").val() == ""){
		alert("아이디를 입력해주세요")
		return false;
	}
	if($("#userPw").val() == ""){
		alert("비밀번호를 입력해주세요")
		return false;
	}

$.ajax({
	url : '/member/loginPro',
	type : 'POST',
	data : $("#frm").serialize(),
	dataType : "json",
	async : false,
/* processData: false, */
	/* contentType: false, */
 	success : function(data){
		document.frm.loginCheck.value = data;
			if(document.frm.loginCheck.value == 0){
				alert("로그인 실패")
			}
			if(document.frm.loginCheck.value == 1){
				alert("로그인 성공")
				rtn = true;
			}	
			
		}
	})
	return rtn;
};
</script>


<form name="frm" id="frm" action="/member/login/main" onSubmit="return LoginCheck()">
	아이디 : <input type="text" name="userId" id="userId"/><br/>
	비밀번호 : <input type="password" name="userPw" id="userPw"/><br/>
	<input type="hidden" name="loginCheck"/>
	<input type="submit" value="로그인"/>
</form>
