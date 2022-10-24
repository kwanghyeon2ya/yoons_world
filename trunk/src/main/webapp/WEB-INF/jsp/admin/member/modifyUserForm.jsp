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
			
			$("#updatebtn").on("click", function(){
				if($("#userName").val()==""){
					alert("이름을 입력해주세요.");
					$("#userName").focus();
					return false;
				}
				if($("#userPw").val()==""){
					alert("비밀번호를 입력해주세요.");
					$("#userPw").focus();
					return false;
				}
				
				if($("#email").val()==""){
					alert("이메일을 입력해주세요.");
					$("#email").focus();
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
				<h3>회원정보수정</h3>
			</div>
			
			<form action="/admin/member/modifyUser" method="post">
    		
	    		<div class="area-input-info">
					<label for="userName" >이름</label>
					<input id="userName" name="userName" type="text" maxlength="20" value="${userVO.userName}"/>
				</div>
				

				<div class="area-input-info">
					<label for="userSeq" >회원번호</label>
					<input id="userSeq" name="userSeq" type="text" value="${userVO.userSeq}" readonly="readonly"/>
				</div>
				

				<div class="area-input-info">
					<label for="userId" >아이디</label>
					<input id="userId" name="userId" type="text" value="${userVO.userId}" readonly="readonly"/>
				</div>
				
				<div class="area-input-info">
					<label for="userPw" >패스워드</label>
					<input id="userPw" name="userPw" type="password" maxlength="20"/>
				</div>
				
				<div class="area-input-info">
					<label for="email" >이메일</label>
					<input id="email" name="email" type="text" value="${userVO.email}"/>
				</div>
				
<!-- 				<div class="area-input-info">
					<label for="userDep" >부서</label>
					<input id="userDep" type="text"/>
				</div>
				
				<div class="area-input-info">
					<label for="userStatus" >상태</label>
					<select id="userStatus" name="userStatus" >
						<option value="1" selected>활동</option>
						<option value="0">중단</option>
						<option value="2">탈퇴</option>
					</select>
				</div>
				
				<div class="area-input-info">
					<label for="userType" >구분</label>
					<select id="userType" name="userType">
						<option value="1" selected>일반회원</option>
						<option value="2">관리자</option>
					</select>
				</div>
				
				<div class="area-input-info">
					<label for="userHireDt" >입사일</label>
					<input id="userHireDt" type="text"/>
				</div> 
				 -->
				 
				<div class="area-button">
					<button type="submit" id="updatebtn">수정</button>
					<button type="button" onclick="location.href='/admin/member/list'">취소</button>
				</div>
			
			</form>
			
			
		</div>
	</div>
</div>


<!-- Footer -->
<jsp:include page="../../common/footer.jsp" flush="false"/>