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
			  document.getElementById('hire_dt').value = new Date().toISOString().substring(0, 10);
		});
		
			function insertForm(){
				
				var insert_user_form = $("#insert_user_form").serialize();		
				var name_confirm = RegExp(/^[가-힣]{2,5}$/);
				var id_confirm = RegExp(/^[a-zA-Z0-9]{4,15}$/);
				var password_confirm = RegExp(/^[a-zA-Z0-9]{4,12}$/);
				var email_confirm = RegExp(/^[A-Za-z0-9]+$/);
				
				var user_name = $("#userName").val();
				var user_id = $("#userId").val();
				var user_pw = $("#userPw").val();
				var email_part1 = $("#email_part1").val();
				var email_part2 = $("#email_part2").val();
				var email_part3 = $("#email_part3").val();
				var hire_dt = $("#hire_dt").val();
				var user_type = $("input[name=userType]:checked").val();
				
				console.log("user_type : "+user_type);
				
				var param = {userName : user_name , userId : user_id , 
							 userPw : user_pw, emailPart1 : email_part1, 
							 emailPart2 : email_part2, emailPart3 : email_part3,
							 hireDt : hire_dt , userType : user_type};
				console.log("param : "+param);
				
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
				
				/* if($("#userId").val() == $("#userPw").val()){
					alert("아이디와 비밀번호는 같게 작성할 수 없습니다");
					$("#userPw").val("");
					$("#userPw2").val("");
					$("#userPw").focus();
					return false;
				}; */
				
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
				
				$.ajax({
					url : '/admin/member/createUser',
					type : 'POST',
					data : JSON.stringify(param), // 파라미터 데이터 json 문자열 변환 
					contentType: 'application/json; charset=utf-8', // 파라미터 데이터 타입 지정
					dataType  : "json", //리턴 데이터 타입 지정
					async : true,
					success : function(data){
						switch(Number(data)){
						case 0:
							alert("회원이 등록되지 않았습니다");
							break;
						case 1:
							alert("회원이 등록되었습니다");
							location.href="/admin/member/list";
							break;							
						case 2:
							alert("아이디의 중복을 확인해주세요");
							break;
						default : break; 
						}
					},error : function (a1, a2, a3){
						console.log(a1, a2, a3);
					}
										
				});
				
			};
			/* //DatePicker
			$("#userHireDt").datepicker();*/
		
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
		
		function DuplicatedIdCheck(){
			
			var id_confirm = RegExp(/^[a-zA-Z0-9]{4,15}$/);
			
			if($("#userId").val()==""){
				alert("아이디를 입력해주세요.");
				$("#userId").focus();
				return false;
			}
			if(!id_confirm.test($("#userId").val())){
				alert("아이디는 영문과 숫자의 조합으로 4-15자 이내로 작성해주세요");
				$("#userId").val("");
				$("#userId").focus();
				return false;
			}
			
			$.ajax({
				url : '/admin/member/duplicatedIdCheck?userId='+$("#userId").val(),
				type : 'GET',
				async : true,
				success : function(data){
					switch(Number(data)){
					case 0 :
						$("#dup_id").html("사용할 수 없는 아이디입니다");
						$("#dup_id").attr("color","red");
						break;
					case 1 :
						$("#dup_id").html("사용가능한 아이디입니다");
						$("#dup_id").attr("color","green");
						break;
					default :
						break;
					}
				},error : function (a1, a2, a3){
					console.log(a1, a2, a3);
				}			
			})				
		}
		
</script>



<!-- Main -->
<div id="main">
	<div class="container">
		<div class="col-12">
		
			<div class="title-page">
				<h3>회원등록</h3>
			</div>
			
			<form method="post" id="insert_user_form" onSubmit="return false">
    		
	    		<div class="area-input-info">
					<label for="userName" >이름</label>
					<input id="userName" name="userName" type="text" maxlength="5" onkeyup="noSpaceForm(this)"/>
				</div>
				<div class="area-input-info">
					<label for="userId" >아이디</label>
					<span id="dup_id"></span><button onclick="DuplicatedIdCheck()">중복확인</button>
					<input id="userId" name="userId" type="text" maxlength="15" onkeyup="noSpaceForm(this)"/>
				</div>
				
				<div class="area-input-info">
					<label for="userPw" >패스워드</label>
					<input id="userPw" name="userPw" type="password" maxlength="12" onkeyup="noSpaceForm(this)"/>
				</div>
				
				<div class="area-input-info">
					<label for="userPw2" >패스워드확인</label>
					<input id="userPw2" type="password" maxlength="12"/>
				</div>
				
				<div class="area-input-info">
					<label for="email">이메일</label>
					<input id="email_part1" style="max-width:100px" name="emailpart1" type="text" maxlength="30" onkeyup="noSpaceForm(this)"/>
					@
					<input type="text" name="emailpart3" id="email_part3" style="display:none;max-width:100px;"/>
					<select style="max-width:100px" name="emailpart2" id="email_part2" onchange="selectedSelfWriting(this.value)">
						<option value="naver.com">naver.com</option>
						<option value="daum.net">daum.net</option>
						<option value="gmail.com">gmail.com</option>
						<option value="hanmail.com">hanmail.com</option>
						<option value="yahoo.co.kr">yahoo.co.kr</option>
						<option value="self_writing">직접입력</option>
					</select>
				</div>
				
				<div class="area-input-info">
					<label for="hire_dt" >입사일</label>
					<input id="hire_dt" type="date" name="hireDt"/>
				</div>
				
				<div class="area-input-info">
					<label for="userType" >회원 구별</label>
				</div>
				일반 회원<input type="radio" name="userType" value="0" checked/>
				관리자<input type="radio" name="userType" value="1"/>
				
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
					<button type="button" id="insertbtn" onclick="insertForm()">등록 완료</button>
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
