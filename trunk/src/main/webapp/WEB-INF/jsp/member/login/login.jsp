<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<h1>login</h1>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>

<script>

function LoginCheck(){

	var rtn = false;
	
	if($("#userId").val() == ""){
		alert("���̵� �Է����ּ���")
		return false;
	}
	if($("#userPw").val() == ""){
		alert("��й�ȣ�� �Է����ּ���")
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
				alert("�α��� ����")
			}
			if(document.frm.loginCheck.value == 1){
				alert("�α��� ����")
				rtn = true;
			}	
			
		}
	})
	return rtn;
};
</script>


<form name="frm" id="frm" action="/member/login/main" onSubmit="return LoginCheck()">
	���̵� : <input type="text" name="userId" id="userId"/><br/>
	��й�ȣ : <input type="password" name="userPw" id="userPw"/><br/>
	<input type="hidden" name="loginCheck"/>
	<input type="submit" value="�α���"/>
</form>
