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
			
			<c:if test="${userVO.emailPart2 eq 'self_writing'}">
				$("#email_part3").css("display","block");
			</c:if>
			
			var name_confirm = RegExp(/^[가-힣]{2,5}$/);
			var id_confirm = RegExp(/^[a-zA-Z0-9]{4,15}$/);
			var password_confirm = RegExp(/^[a-zA-Z0-9]{4,12}$/);
			var email_confirm = RegExp(/^[A-Za-z0-9]+$/);
			
			$("#updatebtn").on("click", function(){


				if($("#userName").val()==""){
					alert("이름을 입력해주세요.");
					$("#userName").focus();
					return false;
				};
				
				if(!name_confirm.test($("#userName").val())){
					alert("이름은 2~5글자 이내의 한글로만 작성할 수 있습니다");
					$("#userName").val("");
					$("#userName").focus();
					return false;
				};
				
				if($("#userId").val()==""){
					alert("아이디를 입력해주세요.");
					$("#userId").focus();
					return false;
				};
				
				if(!id_confirm.test($("#userId").val())){
					alert("아이디는 영문과 숫자의 조합으로 4-15자 이내로 작성해주세요");
					$("#userId").val("");
					$("#userId").focus();
					return false;
				};
				
				if($("#userPw").val()==""){
					alert("비밀번호를 입력해주세요.");
					$("#userPw").focus();
					return false;
				};
			
				if(!password_confirm.test($("#userPw").val())){
					alert("비밀번호는 영문과 숫자의 조합으로 4-12자 이내로 작성해주세요");
					$("#userPw").val("");
					$("#userPw").focus();
					return false;
				};
				
				if($("#userPw2").val()==""){
					alert("비밀번호를 확인해주세요.");
					$("#userPw").focus();
					return false;
				};
				
				if(!($("#userPw").val() == $("#userPw2").val())){
					alert("비밀번호가 일치하지 않습니다");
					$("#userPw").val("");
					$("#userPw2").val("");
					$("#userPw").focus();
					return false;
				};
				
				if($("#email_part1").val()==""){
					alert("이메일을 입력해주세요.");
					$("#email").focus();
					return false;
				};
				
				if(!email_confirm.test($("#email_part1").val())){
					alert("이메일은 영문과 숫자로만 작성할 수 있습니다.");
					$("#email_part1").val("");
					$("#email_part1").focus();
					return false;
				};
				
				console.log("email.part2 : "+$("#email_part2 option:selected").val());
				
				if($("#email_part2 option:selected").val() == 'self_writing'){
					
					if($("#email_part3").val()==""){
						alert("이메일을 입력해주세요.");
						$("#email").focus();
						return false;
					};
					
					if(!email_confirm.test($("#email_part3").val())){
						alert("이메일은 영문과 숫자로만 작성할 수 있습니다.");
						$("#email_part3").val("");
						$("#email_part3").focus();
						return false;
					};
				};
			});
			
		});
		
		function noSpaceForm(obj){
				var str_space = /\s/;
				console.log(str_space.exec(obj.value));
				if(str_space.exec(obj.value)){  //
					alert("공백을 사용할 수 없습니다");
					obj.focus();
					obj.value = obj.value.replace(' ','');
					return false
				}
				
			}
		
		function selectedSelfWriting(value){
			if(value == 'self_writing'){
				$("#email_part3").css("display","block");
			}else{
				$("#email_part3").css("display","none");
				$("#email_part3").val("");
			};
		};
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
					<input id="userName" name="userName" type="text" maxlength="5" value="${userVO.userName}" onkeyup="noSpaceForm(this)"/>
				</div>
				

				<div class="area-input-info">
					<label for="userSeq" >회원번호</label>
					<input id="userSeq" name="userSeq" type="text" value="${userVO.userSeq}" readonly="readonly" onkeyup="noSpaceForm(this)"/>
				</div>
				

				<div class="area-input-info">
					<label for="userId" >아이디</label>
					<input id="userId" name="userId" type="text" value="${userVO.userId}" onkeyup="noSpaceForm(this)" readonly="readonly"/>
				</div>
				
				<div class="area-input-info">
					<label for="userPw" >패스워드</label>
					<input id="userPw" name="userPw" type="password" maxlength="12" onkeyup="noSpaceForm(this)"/>
				</div>
				
				<div class="area-input-info">
					<label for="userPw2" >패스워드 확인</label>
					<input id="userPw2" name="userPw2" type="password" maxlength="12" onkeyup="noSpaceForm(this)"/>
				</div>
				
				<div class="area-input-info">
					<label for="email_part1">이메일</label>
					<input id="email_part1" style="max-width:100px" name="emailPart1" type="text" value="${userVO.emailPart1}" maxlength="30" onkeyup="noSpaceForm(this)"/>
					@
					<input type="text" name="emailPart3" id="email_part3" value="${userVO.emailPart3}" style="display:none;max-width:100px;"/>
					<select style="max-width:100px" name="emailPart2" id="email_part2" onchange="selectedSelfWriting(this.value)">
						<option value="naver.com" ${userVO.emailPart2 eq 'naver.com'?'selected="selected"':''}>naver.com</option>
						<option value="daum.net" ${userVO.emailPart2 eq 'daum.net'?'selected="selected"':''}>daum.net</option>
						<option value="gmail.com" ${userVO.emailPart2 eq 'gmail.com'?'selected="selected"':''}>gmail.com</option>
						<option value="hanmail.com" ${userVO.emailPart2 eq 'hanmail.com'?'selected="selected"':''}>hanmail.com</option>
						<option value="yahoo.co.kr" ${userVO.emailPart2 eq 'yahoo.co.kr'?'selected="selected"':''}>yahoo.co.kr</option>
						<option value="self_writing" ${userVO.emailPart2 eq 'self_writing'?'selected="selected"':''}>직접입력</option>
					</select>
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

<script>

	$("#nav a").removeClass("current-page-item");
	$("#nav").find('a[href*="/member"]').addClass("current-page-item");
</script>

<!-- Footer -->
<jsp:include page="../../common/footer.jsp" flush="false"/>
