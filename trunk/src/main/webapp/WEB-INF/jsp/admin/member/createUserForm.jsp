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

<!-- Header -->
<jsp:include page="../../common/header.jsp" flush="false"/>

<script type="text/javascript">
		$(document).ready(function(){
			
			$("#insertbtn").on("click", function(){
				if($("#userId").val()==""){
					alert("아이디를 입력해주세요.");
					$("#userId").focus();
					return false;
				}
				if($("#userPw").val()==""){
					alert("비밀번호를 입력해주세요.");
					$("#userPw").focus();
					return false;
				}
				if($("#userName").val()==""){
					alert("이름을 입력해주세요.");
					$("#userName").focus();
					return false;
				}
				
				if($("#email").val()==""){
					alert("이메일을 입력해주세요.");
					$("#email").focus();
					return false;
				}
				
				if($("#userSeq").val()==""){
					alert("회원번호를 입력해주세요.");
					$("#userSeq").focus();
					return false;
				}
			});
			
		})
</script>


<!-- Main -->
<div id="main">
	<div class="container">
		<div class="col-12">
		
			<div class="title-page">
				<h3>회원등록</h3>
			</div>
			
			<form action="/admin/member/createUser" method="post">
       			아이디 : <input type="text" name="userId" id="userId" placeholder="아이디" maxlength="15"/><br> 
        		암호 : <input type="password" name="userPw" id="userPw" placeholder="암호" maxlength="20"/><br> 
        		이름 : <input type="text" name="userName" id="userName" placeholder="이름" maxlength="20"/><br>
        		이메일 : <input type="text" name="email" id="email" placeholder="이메일" /><br>  
        		회원번호 : <input type="text" name="userSeq" id="userSeq" placeholder="회원번호" /><br>
       			<input type="submit" id="insertbtn" value="회원 등록"/>
    		</form>
			
			
		</div>
	</div>
</div>


<!-- Footer -->
<jsp:include page="../../common/footer.jsp" flush="false"/>