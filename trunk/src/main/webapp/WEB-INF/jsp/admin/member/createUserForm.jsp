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

<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/inc/import.jsp" flush="false" />
<jsp:include page="/WEB-INF/jsp/inc/boardImport.jsp" flush="false" />

<link rel="stylesheet" type="text/css" href="/css/board/board.css">

<c:if test="${sessionScope.sessionSeqForAdmin == null}">
	<c:redirect url="/login/loginView" />
</c:if>

	<script>
		$(document).ready(function(){
			  document.getElementById('hire_dt').value = new Date().toISOString().substring(0, 10);
		});
		
			function insertForm(){
				
				var insert_user_form = $("#insert_user_form").serialize();		
				var name_confirm = RegExp(/^[가-힣]{2,5}$/);
				var id_confirm = RegExp(/^[a-zA-Z0-9]{4,15}$/);
				var password_confirm = RegExp(/^[a-zA-Z0-9]{4,12}$/);
				var email_confirm = RegExp(/^[A-Za-z0-9]+$/);
				var phone1_confirm = RegExp(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})$/);
			    var phone2_confirm = RegExp(/^[0-9]{3,4}$/);
			    var phone3_confirm = RegExp(/^[0-9]{4}$/);
			    
				var user_name = $("#userName").val();
				var user_id = $("#userId").val();
				var user_pw = $("#userPw").val();
				var email_part1 = $("#email_part1").val();
				var email_part2 = $("#email_part2").val();
				var email_part3 = $("#email_part3").val();
				var hire_dt = $("#hire_dt").val();
				var user_type = $("input[name=userType]:checked").val();
				var phone1 = $("#phone1").val();
				var phone2 = $("#phone1").val();
				var phone3 = $("#phone1").val();
				var extension = $("#extension").val();
				var dep_seq = $("#dep_seq").val();
				
				var param = {userName : user_name , userId : user_id , 
							 userPw : user_pw, emailPart1 : email_part1, 
							 emailPart2 : email_part2, emailPart3 : email_part3,
							 hireDt : hire_dt , userType : user_type,
							 phone1 : phone1 , phone2 : phone2, 
							 phone3 : phone3 , extension : extension,
							 depSeq : dep_seq};
				
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
				
				//번호 유효성 검사
		        if($("#phone1").val() == ""){
		        	alert("전화번호를 비워둘 수 없습니다.")
		        	$("#phone1").focus();
		        	return false;
		        }
		        if(!phone1_confirm.test($("#phone1").val())){
		        	alert("전화번호를 정확히 입력해주세요.")
		        	$("#phone1").val("");
		        	$("#phone1").focus();
		        	return false;
		        }
		        if($("#phone2").val() == ""){
		        	alert("전화번호를 비워둘 수 없습니다.")
		        	$("#phone2").focus();
		        	return false;
		        }
		        if(!phone2_confirm.test($("#phone2").val())){
		        	alert("전화번호를 정확히 입력해주세요.")
		        	$("#phone2").val("");
		        	$("#phone2").focus();
		        	return false;
		        }
		        if($("#phone3").val() == ""){
		        	alert("전화번호를 비워둘 수 없습니다.")
		        	$("#phone3").focus();
		        	return false;
		        }
		       	if(!phone3_confirm.test($("#phone3").val())){
		       		alert("전화번호를 정확히 입력해주세요");
		       		$("#phone3").val("");
		       		$("#phone3").focus();
		       		return false;
		       	}
		       	if($("#extension").val() == ""){
		        	alert("내선번호를 비워둘 수 없습니다.")
		        	$("#extension").focus();
		        	return false;
		        }
		       	if(!phone3_confirm.test($("#extension").val())){
		       		alert("내선번호를 정확히 입력해주세요.");
		       		$("#extension").val("");
		       		$("#extension").focus();
		       	}
			
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
				$("#email_part3").focus();
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

</head>


<!-- Main -->
<body>

	<div id="page-wrapper">
		<!-- Header -->
		<jsp:include page="/WEB-INF/jsp/common/header2.jsp" flush="false" />

		<div id="container">
			<div class="content">
			
			<h3 class="page_title">회원등록</h3>
			
			<form method="post" id="insert_user_form" class="board-inline" onSubmit="return false">

					<table border=1>
						<tbody>
							<tr>
								<th><label for="userName">이름</label></th>
								<td><input id="userName" name="userName" type="text" maxlength="5" onkeyup="noSpaceForm(this)" /></td>
							</tr>
							<tr>
								<th><label for="userId">아이디</label></th> 
								<td><input id="userId" name="userId" type="text" maxlength="15" onkeyup="noSpaceForm(this)" />
								<button class="btn type_02 bg_purple" onclick="DuplicatedIdCheck()">중복확인</button></td>
								<td><p id="dup_id"></p></td>
							</tr>
							<tr>
								<th><label for="userPw">패스워드</label></th>
								<td><input id="userPw" name="userPw" type="password" maxlength="12" onkeyup="noSpaceForm(this)" /></td>
							</tr>
							<tr>
								<th><label for="userPw2" style="margin-right: 7px;">패스워드확인</label></th>
								<td><input id="userPw2" type="password" maxlength="12" /></td>
							</tr>
							<tr>
								<th><label for="email">이메일</label></th> 
								<td>
								
								<input id="email_part1" class="email" name="emailpart1" type="text" maxlength="30" onkeyup="noSpaceForm(this)" /> 
								@
								<select class="email" name="emailpart2" id="email_part2" onchange="selectedSelfWriting(this.value)">
									<option value="naver.com">naver.com</option>
									<option value="daum.net">daum.net</option>
									<option value="gmail.com">gmail.com</option>
									<option value="hanmail.com">hanmail.com</option>
									<option value="yahoo.co.kr">yahoo.co.kr</option>
									<option value="self_writing">직접입력</option>
								</select>
								
								</td>
							</tr>
							<tr>
								<td>
								</td>
								<td><input type="text" name="emailpart3" id="email_part3" style="display: none;"/><td>
							</tr>
							<tr>
	<!-- 						<th><label for="userType">권한설정</label></th> -->
								<th>
								<label for="user_type_0">일반회원</label>
								<input type="radio" id="user_type_0" name="userType" value="0" checked/></th>
								<th style="text-align:left;">
								<label for="user_type_1">관리자</label>
								<input type="radio" id="user_type_1" name="userType" value="1" />
								</th>
							</tr>
							<tr>
								<th><label for="hire_dt">입사일</label></th>
								<td><input id="hire_dt" type="date" name="hireDt" /></td>
							</tr>
							<tr>
								<th><label for="phone1">핸드폰 번호</label></th>
								<td>
								<input id="phone1" name="phone1" type="text" maxlength="3" onkeyup="noSpaceForm(this)" style="width:5rem;"/>-
								<input id="phone2" name="phone2" type="text" maxlength="4" onkeyup="noSpaceForm(this)" style="width:5rem;"/>-
								<input id="phone3" name="phone3" type="text" maxlength="4" onkeyup="noSpaceForm(this)" style="width:5rem;"/>
								</td>
							</tr>
							<tr>
								<th><label for="extension">내선 번호</label></th>
								<td><input id="extension" name="extension" type="text" maxlength="4" onkeyup="noSpaceForm(this)" /></td>
							</tr>
							<tr>
								<th>부서 고유번호</th>
								<td><select name="depSeq" id="dep_seq" style="width:17rem;margin-right:0.5rem;">
									<option value="A1">기술지원팀</option>
									<option value="A2">기술개발팀</option>
									<option value="A3">기술기획팀</option>
									<option value="B1">총무팀</option>
									<option value="B2">라이브팀</option>
									<option value="B3">방송팀</option>
								</select>
								</td>
							</tr>
						</tbody>
					</table>
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
				<div id="create_form_btn">
					<button class="btn type_02 bg_purple" type="button" id="insertbtn" onclick="insertForm()">등록 완료</button>
					<button class="btn type_02 bg_purple" id="cancelbtn" type="button" onclick="location.href='/admin/member/list'">취소</button>
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
<jsp:include page="/WEB-INF/jsp/common/footer.jsp" flush="false" />

</body>
</html>
