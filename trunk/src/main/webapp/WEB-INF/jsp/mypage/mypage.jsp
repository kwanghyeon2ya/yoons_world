<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/WEB-INF/jsp/inc/import.jsp" flush="false" />
	
	<link rel="stylesheet" type="text/css" href="/css/main/main.css">
	
	
	<c:if test="${sessionScope.sessionSeqForUser == null}">
		<script>
			alert("로그인이 필요합니다")
			window.location.href = "/login/loginView";
		</script>
	</c:if>
	
	<script>
	
	$(document).ready(function() {
		$("#file").on('change',function(){
			var fileName = $("#file")[0].files[0].name;
			$(".upload_name").val(fileName);
		});
	});
	
	
		function fileCheck(value){
			var nameLength = value.length;
			var imgTag = $("#profileImg");
			var fileTag = $("input[name=file]")[0].files;
			if(nameLength != 0){
				var fileDot = value.lastIndexOf(".");
				var fileType = value.substring(fileDot+1,nameLength);
				var typeConfirm = ["png","jpg"];
				console.log(fileTag);
				console.log("파일 사이즈 : "+fileTag[0].size);
				
				if(!typeConfirm.includes(fileType)){
					alert("이미지 파일만 업로드할 수 있습니다.");
					$("input[name=file]").val("");
					return false;
				}
				if(fileTag[0].size > 10000000){
					alert("10MB이하의 파일만 업로드할 수 있습니다.");
					$("input[name=file]").val("");
					return false;
				}
				
				var reader = new FileReader();
				
				reader.onload = function(data){
					var dataUrl = reader.result;
					console.log(dataUrl);
					console.log("dataUrl : "+dataUrl);
					
					console.log(data);
					console.log("data.target.result : "+data.target.result);
					imgTag.src = data.target.result;
					imgTag.src = dataUrl; 
					imgTag.width = 250;
					imgTag.height = 250;
					$(".new_img_div").html('<img class="profileImg" style="width:15rem;height:15rem;padding:10px;" src='+dataUrl+'>');
				}
				console.log(imgTag);
				reader.readAsDataURL(fileTag[0]); // 왜 못 읽을까
			}else{
				imgTag.src = "";
			}
			
		}
		
		function updateMypage(){
			
			var form_data = new FormData($(".mypage_frm")[0]);
			if($("input[name=file]").val() == null){
				alert("이미지 파일을 업로드해주세요.");
				return false;
			}
			
			$.ajax({
				url : '/member/updateMypage',
				data : form_data,
				type : 'POST',
				enctype : 'multipart/form-data',
				processData : false,
				contentType : false,
				success : function(data){
					switch(Number(data)){
					case 0:
			 			alert("개인정보가 변경되지 않았습니다.");
			 			break;
			 		case 1:
		 				alert("개인정보가 변경되었습니다.");
		 				location.href='/main';
		 				rtn = true;
		 				break;
			 		case 9999:
						alert("잘못된 요청입니다. 로그인 화면으로 돌아갑니다");
						location.href="/login/logout";
						break;
			 		default:
			 			break;
					}
				}
				
			})
			
		}
	
	</script>
</head>
<body>
	<div id="page-wrapper">

		<!-- Header -->
		<jsp:include page="/WEB-INF/jsp/common/header2.jsp" flush="false" />

		<!-- Main -->
		<div id="container">
			<div class="content">
			<h1>Mypage</h1>
				<div id="mypage_tap">
					<a>프로필 변경</a>
					<a style="margin-left:30px;margin-left:30px;">이력 관리</a>
				</div>
				<p style="font-size:1.5rem;margin-top: 15px;">윤스 월드 대표 프로필 사진을 수정 하실 수 있습니다.</p>
				<div class="mypage_content">
					<div style="margin:0 auto;">
						<div class="profile_kind_div">
							<span class="profile_kind">기존 프로필 사진</span>
							<span class="profile_kind">변경할 프로필 사진</span>
						</div>
						<div class="img_div">
							<div class="origin_img_div">
								<c:if test="${sessionPicForUser ne null}">
									<img class="profile_img" src="<%=File.separator%>yoons_world<%=File.separator%>profile<%=File.separator%>${sessionPicForUser}"/>
								</c:if>
								<c:if test="${sessionPicForUser eq null}">
									<img class="profile_img" src="/img/common/profile.png"/>
								</c:if>
							</div>
							<div class="new_img_div">
								<span style="font-size:2rem;margin:10px;">이미지 선택 안 됨</span>
							</div>
						</div>	
					</div>
						<form class="mypage_frm">
							<input class="upload_name" placeholder="첨부파일" readOnly>
							<label for="file">사진 선택</label>
							<input type="file" id="file" name="file" accept="image/*" onchange="return fileCheck(this.value)"/><br>
							<span style="font-size:1.2rem;color:red;">※이미지를 선택하지 않고 등록 시 기존 이미지가 삭제됩니다.</span><br>
							<button type="button" class="btn type_02 bg_purple" style="margin-top:1rem;width: 37vh;" onclick="updateMypage()">등록하기</button>
						</form>
				</div>
			</div>
		</div>
	</div>