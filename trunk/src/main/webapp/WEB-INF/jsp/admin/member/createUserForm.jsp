
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
				var phone1_confirm = RegExp(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})$/);
			    var phone2_confirm = RegExp(/^[0-9]{3,4}$/);
			    var phone3_confirm = RegExp(/^[0-9]{4}$/);
			    
				var user_name = $("#userName").val();
				var user_id = $("#userId").val();
				var user_pw = $("#userPw").val();
				
				if($("#email_part2 option:selected").val() == 'self_writing'){
					var email_confirm = RegExp(/^[A-Za-z0-9.-_]+[@]{1}[A-Za-z0-9]+[.]{1}[A-Za-z]+[.]?[A-Za-z]+$/);
				}else{
					var email_confirm = RegExp(/^[A-Za-z0-9.-_]+$/);
				}
				
				var email_part1 = $("#email_part1").val();
				var email_part2 = $("#email_part2").val();
				/* var email_part3 = $("#email_part3").val(); */
				var hire_dt = $("#hire_dt").val();
				var user_type = $("select[name=userType]").val();
				var phone1 = $("#phone1").val();
				var phone2 = $("#phone2").val();
				var phone3 = $("#phone3").val();
				var extension = $("#extension").val();
				var dep_seq = $("#dep_seq").val();
				
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
					if($("#email_part2 option:selected").val() == 'self_writing'){
						alert("올바른 이메일 형식으로 작성해주세요");
					}else{
						alert("이메일은 영문과 숫자 .-_의 특수문자로 작성할 수 있습니다.");
					}
					$("#email_part1").val("");
					$("#email_part1").focus();
					return false;
				};
			
				console.log("email.part2 : "+$("#email_part2 option:selected").val());
				
				/* if($("#email_part2 option:selected").val() == 'self_writing'){
					
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
					
				}; */
				
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
		       	
		       	var param = {userName : user_name , userId : user_id , 
							 userPw : user_pw, emailPart1 : email_part1, 
							 emailPart2 : email_part2,
							 hireDt : hire_dt , userType : user_type,
							 phone1 : phone1 , phone2 : phone2, 
							 phone3 : phone3 , extension : extension,
							 depSeq : dep_seq};
			
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
						case 9999:
							alert("잘못된 요청입니다. 로그인 화면으로 돌아갑니다");
							location.href="/login/loginView";
						default : 
							break; 
						}
					},error : function (result,code){
						console.log("result.status : "+result.status," code : "+code);
						alert(code+result.status+"잘못된 요청입니다. 로그인 화면으로 돌아갑니다.");
						location.href="/login/loginView";
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
			
		/* function selectedSelfWriting(value){
			if(value == 'self_writing'){
				$("#email_part3").css("display","block");
				$("#email_part3").focus();
			}else{
				$("#email_part3").css("display","none");
				$("#email_part3").val("");
			};
		}; */
		
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
					<div style="text-align: left;">
					<table border=1>
						<tbody>
							<tr class="tr_space">
								<th><label for="userName">이름</label></th>
								<td><input id="userName" name="userName" type="text" placeholder="2~5자 한글" maxlength="5" onkeyup="noSpaceForm(this)" /></td>
							</tr>
							<tr class="tr_space">
								<th><label for="userId">아이디</label></th> 
								<td><input id="userId" name="userId" type="text" placeholder="4-15자 영문과 숫자의 조합" maxlength="15" onkeyup="noSpaceForm(this)" />
								<button class="btn type_02 bg_purple" onclick="DuplicatedIdCheck()">중복확인</button>
								<p id="dup_id"></p></td>
							</tr>
							<tr class="tr_space">
								<th><label for="userPw">패스워드</label></th>
								<td><input id="userPw" name="userPw" type="password" placeholder="4-12자 영문과 숫자의 조합" maxlength="12" onkeyup="noSpaceForm(this)" /></td>
							</tr>
							<tr class="tr_space">
								<th><label for="userPw2" style="margin-right: 7px;">패스워드확인</label></th>
								<td><input id="userPw2" type="password" maxlength="12" /></td>
							</tr>
							<tr class="tr_space">
								<th><label for="email">이메일</label></th> 
								<td>
								
								<input id="email_part1" class="email" name="emailpart1" type="text" maxlength="30" onkeyup="noSpaceForm(this)" /> 
								<select class="email" name="emailpart2" id="email_part2">
									<option value="naver.com">@naver.com</option>
									<option value="daum.net">@daum.net</option>
									<option value="gmail.com">@gmail.com</option>
									<option value="hanmail.com">@hanmail.com</option>
									<option value="yahoo.co.kr">@yahoo.co.kr</option>
									<option value="self_writing">직접입력</option>
								</select>
								</td>
							</tr>
							<!-- <tr>
								<td>
								</td>
								<td><input type="text" name="emailpart3" id="email_part3" style="display: none;"/><td>
							</tr> -->
							<tr class="tr_space">
								<th><label for="hire_dt">입사일</label></th>
								<td><input id="hire_dt" type="date" name="hireDt" /></td>
							</tr>
							<tr class="tr_space">
								<th><label for="phone1">핸드폰 번호</label></th>
								<td>
								<input id="phone1" class="phone_text" name="phone1" type="text" maxlength="3" onkeyup="noSpaceForm(this)"/>-
								<input id="phone2" class="phone_text" name="phone2" type="text" maxlength="4" onkeyup="noSpaceForm(this)"/>-
								<input id="phone3" class="phone_text" name="phone3" type="text" maxlength="4" onkeyup="noSpaceForm(this)"/>
								</td>
							</tr>
							<tr class="tr_space">
								<th><label for="extension">내선 번호</label></th>
								<td><input id="extension" name="extension" type="text" maxlength="4" onkeyup="noSpaceForm(this)" /></td>
							</tr>
							<tr class="tr_space">
								<th><label for="dep_seq">부서</label></th>
								<td>
								<select name="depSeq" id="dep_seq">
									<option value="1001">재경팀</option>
									<option value="1002">재무예상팀</option>
									<option value="1003">경영기획팀</option>
									<option value="1004">홍보팀</option>
									<option value="1005">인사팀</option>
									<option value="1006">비서팀</option>
									<option value="1007">고객지원팀</option>
									<option value="1008">법무팀</option>
									<option value="1009">영업지원팀</option>
									<option value="1010">사업지원팀</option>
									<option value="1011">총무/제작팀</option>
									<option value="1012">자산관리팀</option>
									<option value="1013">시설관리팀</option>
									<option value="1014">교육팀</option>
									<option value="1015">상품연구팀</option>
									<option value="1016">비주얼디자인팀</option>
									<option value="1017">사운드디자인팀</option>
									<option value="1018">영상디자인팀</option>
									<option value="1019">콘텐츠개발팀</option>
									<option value="1020">기술기획팀</option>
									<option value="1021">기술개발팀</option>
									<option value="1022">기술지원팀</option>
									<option value="1023">B2C사업팀</option>
									<option value="1024">홈사업팀</option>
									<option value="1025">학원사업팀</option>
								</select>
								</td>
							</tr>
							<tr class="tr_space">
							<th><label for="author_type">권한</label></th>
								<td>
								<select name="userType" id="author_type">
									<option value="0">일반회원</option>
									<option value="1">관리자</option>
								</select>
								</td>
							</tr>
						</tbody>
					</table>
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
				<div id="create_form_btn">
					<button class="btn type_02 bg_purple" type="button" id="insertbtn" onclick="insertForm()">등록 완료</button>
					<button class="btn type_02 bg_aaa" id="cancelbtn" type="button" onclick="location.href='/admin/member/list'">취소</button>
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
									