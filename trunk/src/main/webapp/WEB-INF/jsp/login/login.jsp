 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Header -->
<jsp:include page="../common/header.jsp" flush="false"/>


<script>

$(document).ready(function(){
	
	$("#loginbtn").click(function(){
	var checkTokenValue = "N";
	
	console.log($("#userId").val());	
	if($("#userID").val() == '' || $("#userID").val() == null) {
		alert("id를 입력하세요.");
		return;
	}
	
	if($("#password").val() == '' || $("#password").val() == null) {
		alert("비밀번호를 입력하세요.");
		return;
	}
	if($("input:checkbox[id='checkToken']").is(":checked") == true){
		checkTokenValue = "Y";
	}
		
		var json = {
			userId : $("#userID").val(),
			userPw : $("#password").val(),
			checkToken : checkTokenValue
		};
		
		 $.ajax({
			type : "post",
			url : "/login/login",
			data : json,
			success : function(data) {
				switch (Number(data)) {
				case 0:
					alert("아이디 또는 비밀번호가 일치하지 않습니다.");
					break;
				case 1:
					alert($("#userID").val()+" 님 환영합니다.");
					window.location.href = "/main";
					break;
				case 2:
					alert("아이디가 정지되었습니다. 자신을 되돌아 보는 시간을 가지길 바랍니다");
					break;
				default:
					break;
				}
			},
			error : function(error) {
				alert("아이디 또는 비밀번호가 일치하지 않습니다.");
				console.log(error);
			}
		});
	});
	
});
</script>

<!-- Content -->
<div id="main">
	<div class="container">
		<div class="input-wrap">
                   <form action="/main" method="POST">
                  
                      <div class="area-login">
                          <label for="userID">ID</label>
                          <input id="userID" type="text" name="userID" placeholder="ID를 입력해주세요">                      
                      </div>
                      
                      <div class="area-login">
                          <label for="password">Password</label>
                          <input id="password" type="password" name="password" placeholder="비밀번호를 입력해주세요">
                      </div>
	          	          <span>자동로그인</span><input type="checkbox" id="checkToken" name="checkToken" value="Y"/>
                      <button type="button" id="loginbtn" class="input-button" value="Login">Login</button>
                      
                  </form>
               </div>
           </div>
      </div>
<script>
	$("#nav a").removeClass("current-page-item");
	$("#nav").find('a[href*="/login"]').addClass("current-page-item");
</script>
<!-- Footer -->
<jsp:include page="../common/footer.jsp" flush="false"/>