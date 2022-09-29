 <%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!-- Header -->
<jsp:include page="../common/header.jsp" flush="false"/>


<script>
$(document).ready(function(){
	$("#loginbtn").click(function(){	
		if($("#userID").val() == '' || $("#userID").val() == null) {
			alert("id�� �Է��ϼ���.");
			return;
		}
		
		if($("#password").val() == '' || $("#password").val() == null) {
			alert("��й�ȣ�� �Է��ϼ���.");
			return;
		}
		var json = {
			userId : $("#userID").val(),
			userPw : $("#password").val()
		};
		
		 $.ajax({
			type : "post",
			url : "/login/login",
			data : json,
			success : function(data) {
				switch (Number(data)) {
				case 0:
					alert("���̵� �Ǵ� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
					break;
				case 1:
					window.location.href = "/main";

				default:
					break;
				}
			},
			error : function(error) {
				alert("�ٽ� �õ����ּ���"+ error);
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
                          <input id="userID" type="text" name="userID" placeholder="ID�� �Է����ּ���">                      
                      </div>
                      
                      <div class="area-login">
                          <label for="password">Password</label>
                          <input id="password" type="password" name="password" placeholder="��й�ȣ�� �Է����ּ���">
                      </div>
                      
                      <input type="button" id="loginbtn" class="input-button" value="Login">
                      
                      
                  </form>
               </div>
           </div>
      </div>

<!-- Footer -->
<jsp:include page="../common/footer.jsp" flush="false"/>