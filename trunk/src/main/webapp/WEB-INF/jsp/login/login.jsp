 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/WEB-INF/jsp/inc/import.jsp" flush="false" />
	
	<link rel="stylesheet" type="text/css" href="/css/login/login.css">

	<script>
		$(document).ready(function(){
			$("#login_btn").click(function(){
				//console.log($("#userId").val());	
				login();
			});
			
			$("#userID").keypress(function(e){
				if(e.keyCode == 13) {
					login();
				}
			});
			
			$("#password").keypress(function(e){
				if(e.keyCode == 13) {
					login();
				}
			});
			
		});
		
		// 로그인
		function login() {
			
			var checkTokenValue = "N";
			
			if($("#userID").val() == '' || $("#userID").val() == null) {
				alert("id를 입력하세요.");
				return;
			}
			
			if($("#password").val() == '' || $("#password").val() == null) {
				alert("비밀번호를 입력하세요.");
				return;
			}
			
			if($("input:checkbox[id='checkTokenYn']").is(":checked") == true){
				checkTokenValue = "Y";
			}
			
			var json = {
				userId : $("#userID").val(),
				userPw : $("#password").val(),
				checkTokenYn : checkTokenValue
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
						//alert($("#userID").val()+" 님 환영합니다.");
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
		}
	</script>

</head>
<body>
	<div id="page-wrapper">
		
		<!-- Header -->
		<jsp:include page="/WEB-INF/jsp/common/header2.jsp" flush="false"/>
		
		<!-- Container -->
		<div id="container">
			
			<div class="login_content">
				<div class="login_area">
					<form action="/main" method="POST">
						<h1>로그인</h1>
						<p>Yoons World에 오신것을 환영합니다.</p>
						<div class="login_info">
							<input type="text" id="userID" class="size_full" name="userID" placeholder="아이디">
							<input type="password" id="password" class="size_full" name="password" placeholder="비밀번호">
						</div>
						<div>
							<input type="checkbox" id="checkTokenYn" name="checkTokenYn" value="Y"/>
							<label for="checkTokenYn">
								<span>로그인 기억</span>
							</label>
						</div>
						<button type="button" id="login_btn" class="btn type_01 size_full bg_purple" value="Login">Login</button>
						<div>
							<span style="font-size:1.5rem;display:flex;justify-content: flex-end;"><a href="/member/signUp">회원가입</a></span>
						</div>
					</form>
				</div>
			</div>
			
		</div>
		
		<!-- Footer -->
		<%-- <jsp:include page="/WEB-INF/jsp/common/footer.jsp" flush="false"/> --%>
		
	</div>
</body>
</html>