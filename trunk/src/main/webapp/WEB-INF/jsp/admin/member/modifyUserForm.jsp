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

<script type="text/javascript">
			
			/* <c:if test="${userVO.emailPart2 eq 'self_writing'}">
				$("#email_part3").css("display","block");
			</c:if> */
	
	$(document).ready(function(){
		$("#email_part1").keyup(function(e){
			
			 var email_console = "0";
			    
			    if($("#email_part2 option:selected").val() == 'self_writing'){
			    	 email_console = "1";
				}
			
			console.log("email_console :"+email_console);
		})
	})
			
				
	function updateForm(){
				
			var name_confirm = RegExp(/^[가-힣]{2,5}$/);
			var id_confirm = RegExp(/^[a-zA-Z0-9]{4,15}$/);
			var password_confirm = RegExp(/^[a-zA-Z0-9]{4,12}$/);
			var phone1_confirm = RegExp(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})$/);
		    var phone2_confirm = RegExp(/^[0-9]{3,4}$/);
		    var phone3_confirm = RegExp(/^[0-9]{4}$/);
		    
		    var email_console = "0";
		    
		    if($("#email_part2 option:selected").val() == 'self_writing'){
				var email_confirm = RegExp(/^[A-Za-z0-9]+[@]{1}[A-Za-z0-9]+[.]{1}[A-Za-z]+[.]?[A-Za-z]+$/);
			}else{
				var email_confirm = RegExp(/^[A-Za-z0-9]+$/);
			}
		    
		    email_console = "1";
		    
		    console.log("email_console :"+email_console);

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
				if($("#email_part2 option:selected").val() == 'self_writing'){
					alert("올바른 이메일 형식으로 작성해주세요");
				}else{
					alert("이메일은 영문과 숫자로만 작성할 수 있습니다.");
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
	       		return false;
	       	}
			
	};
			
		
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
			}else{
				$("#email_part3").css("display","none");
				$("#email_part3").val("");
			};
		}; */
</script>
</head>
<body>
	<div id="page-wrapper">

		<!-- Header -->
		<jsp:include page="/WEB-INF/jsp/common/header2.jsp" flush="false" />

		<!-- Main -->
		<div id="container">
			<div class="content">
		
			<h3 class="page_title">회원정보수정</h3>
			
			<form action="/admin/member/modifyUser" method="post" onSubmit="return updateForm();">
    			<table border=1>
						<tbody>
							<tr>
								<th><label for="userName" >이름</label></th>
								<td><input id="userName" name="userName" type="text" maxlength="5" value="${userVO.userName}" onkeyup="noSpaceForm(this)"/></td>
							</tr>			
							<tr>
								<th><label for="userSeq" >회원번호</label></th>
								<td><input id="userSeq" name="userSeq" type="text" value="${userVO.userSeq}" readonly="readonly" onkeyup="noSpaceForm(this)"/></td>
							</tr>
							<tr>
								<th><label for="userId" >아이디</label></th>
								<td><input id="userId" name="userId" type="text" value="${userVO.userId}" onkeyup="noSpaceForm(this)" readonly="readonly"/></td>
							</tr>
							<tr>
								<th><label for="userPw" >패스워드</label></th>
								<td><input id="userPw" name="userPw" type="password" maxlength="12" onkeyup="noSpaceForm(this)"/></td>
							</tr>
							<tr>	
								<th><label for="userPw2" style="margin-right: 7px;">패스워드 확인</label></th>
								<td><input id="userPw2" name="userPw2" type="password" maxlength="12" onkeyup="noSpaceForm(this)"/></td>
							</tr>
							<tr>
								<th><label for="email_part1">이메일</label></th>
								<td>
								
								<input id="email_part1" name="emailPart1" type="text" value="${userVO.emailPart1}" maxlength="30" onkeyup="noSpaceForm(this)"/>
								@
								<select name="emailPart2" id="email_part2">
									<option value="naver.com" ${userVO.emailPart2 eq 'naver.com'?'selected="selected"':''}>naver.com</option>
									<option value="daum.net" ${userVO.emailPart2 eq 'daum.net'?'selected="selected"':''}>daum.net</option>
									<option value="gmail.com" ${userVO.emailPart2 eq 'gmail.com'?'selected="selected"':''}>gmail.com</option>
									<option value="hanmail.com" ${userVO.emailPart2 eq 'hanmail.com'?'selected="selected"':''}>hanmail.com</option>
									<option value="yahoo.co.kr" ${userVO.emailPart2 eq 'yahoo.co.kr'?'selected="selected"':''}>yahoo.co.kr</option>
									<option value="self_writing" ${userVO.emailPart2 eq 'self_writing'?'selected="selected"':''}>직접입력</option>
								</select>
								</td>
							</tr>
							
							<!-- <tr>
								<td>
								</td>
								<td><input type="text" name="emailpart3" id="email_part3" style="display: none;"/><td>
							</tr> -->
							
							<tr>
								<th><label for="phone1">핸드폰 번호</label></th>
								<td>
								<input id="phone1" name="phone1" value="${userVO.phone1}" type="text" maxlength="3" onkeyup="noSpaceForm(this)" style="width:5rem;"/>-
								<input id="phone2" name="phone2" value="${userVO.phone2}" type="text" maxlength="4" onkeyup="noSpaceForm(this)" style="width:5rem;"/>-
								<input id="phone3" name="phone3" value="${userVO.phone3}" type="text" maxlength="4" onkeyup="noSpaceForm(this)" style="width:5rem;"/>
								</td>
							</tr>
							<tr>
								<th><label for="extension">내선 번호</label></th>
								<td><input id="extension" name="extension" type="text" value="${userVO.extension}" maxlength="4" onkeyup="noSpaceForm(this)" /></td>
							</tr>
							<tr>
								<th>부서</th>
								<td>
								<select name="depSeq" id="dep_seq" style="width:17rem;margin-right:0.5rem;">
									<option value="1001" ${userVO.depSeq eq '1001'?'selected="selected"':''}>재경팀</option>
									<option value="1002" ${userVO.depSeq eq '1002'?'selected="selected"':''}>재무예상팀</option>
									<option value="1003" ${userVO.depSeq eq '1003'?'selected="selected"':''}>경영기획팀</option>
									<option value="1004" ${userVO.depSeq eq '1004'?'selected="selected"':''}>홍보팀</option>
									<option value="1005" ${userVO.depSeq eq '1005'?'selected="selected"':''}>인사팀</option>
									<option value="1006" ${userVO.depSeq eq '1006'?'selected="selected"':''}>비서팀</option>
									<option value="1007" ${userVO.depSeq eq '1007'?'selected="selected"':''}>고객지원팀</option>
									<option value="1008" ${userVO.depSeq eq '1008'?'selected="selected"':''}>법무팀</option>
									<option value="1009" ${userVO.depSeq eq '1009'?'selected="selected"':''}>영업지원팀</option>
									<option value="1010" ${userVO.depSeq eq '1010'?'selected="selected"':''}>사업지원팀</option>
									<option value="1011" ${userVO.depSeq eq '1011'?'selected="selected"':''}>총무/제작팀</option>
									<option value="1012" ${userVO.depSeq eq '1012'?'selected="selected"':''}>자산관리팀</option>
									<option value="1013" ${userVO.depSeq eq '1013'?'selected="selected"':''}>시설관리팀</option>
									<option value="1014" ${userVO.depSeq eq '1014'?'selected="selected"':''}>교육팀</option>
									<option value="1015" ${userVO.depSeq eq '1015'?'selected="selected"':''}>상품연구팀</option>
									<option value="1016" ${userVO.depSeq eq '1016'?'selected="selected"':''}>비주얼디자인팀</option>
									<option value="1017" ${userVO.depSeq eq '1017'?'selected="selected"':''}>사운드디자인팀</option>
									<option value="1018" ${userVO.depSeq eq '1018'?'selected="selected"':''}>영상디자인팀</option>
									<option value="1019" ${userVO.depSeq eq '1019'?'selected="selected"':''}>콘텐츠개발팀</option>
									<option value="1020" ${userVO.depSeq eq '1020'?'selected="selected"':''}>기술기획팀</option>
									<option value="1021" ${userVO.depSeq eq '1021'?'selected="selected"':''}>기술개발팀</option>
									<option value="1022" ${userVO.depSeq eq '1022'?'selected="selected"':''}>기술지원팀</option>
									<option value="1023" ${userVO.depSeq eq '1023'?'selected="selected"':''}>B2C사업팀</option>
									<option value="1024" ${userVO.depSeq eq '1024'?'selected="selected"':''}>홈사업팀</option>
									<option value="1025" ${userVO.depSeq eq '1025'?'selected="selected"':''}>학원사업팀</option>
								</select>
								</td>
							</tr>
							<tr>
								<td>
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
						<button type="submit" class="btn type_02 size_s bg_purple" id="updatebtn">수정</button>
						<button type="button" class="btn type_02 size_s bg_aaa" id="cancelbtn" onclick="location.href='/admin/member/list'">취소</button>
					</div>
			</form>
			
			
		</div>
	</div>
</div>

<!-- Footer -->
			<jsp:include page="/WEB-INF/jsp/common/footer.jsp" flush="false" />

</body>
</html>
