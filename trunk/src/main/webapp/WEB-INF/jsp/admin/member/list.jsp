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

<script>

$(function(){
	$("#chkAll").click(function() {
		console.log("yeah!");
		if($("#chkAll").is(":checked")) $("input[name=chkMember]").prop("checked", true);
		else $("input[name=chkMember]").prop("checked", false);		
	});
	
	$("input[name=chkMember]").click(function() {
		var total = $("input[name=chkMember]").length;
		var checked = $("input[name=chkMember]:checked").length;
	
		if(total != checked) $("#chkAll").prop("checked", false);
		else $("#chkAll").prop("checked", true); 
	});
	
	$('#deleteButton').click(function() {
				
		var checked = $("input[type=checkbox]:checked");
		var userSeqArray = []; // 아이디 배열 생성
		
		$.each(checked, function(){
			userSeqArray.push($(this).val()); //체크한 아이디 배열로 입력
		});
		
		console.log(userSeqArray); //체크한 아이디 콘솔 확인
		//console.log(userIdArray.join(','));
		
		if(checked.length < 1) { //선택 값이 없으면 알림 메세지
			alert('삭제할 회원을 선택해주세요.');
			return false;
		}
		
		$.ajax({
			url : '/admin/member/deleteUser',
			type : 'POST',
			data : {'userSeqArray' : userSeqArray },
			dataType: 'json',
			success : function(result){
				switch (Number(result)) {
				case 0:
					alert("삭제 실패하였습니다.");
					break;
				case 1:
					alert("선택하신 회원이 삭제되었습니다.");
					window.location.href = "/admin/member/list"; // 삭제 후 회원 목록으로 

				default:
					break;
				}
			}
		});
	});
	
});
</script>


<!-- Main -->
<div id="main">
	<div class="container">
		<div class="col-12">
		
			<div class="title-page">
				<h3>회원리스트</h3>
			</div>
			
			<div class="area-search">
				<div class="area-search-form">
					<form action="" method="POST">
						<select name="search">
							<option value="member_name">이름</option>
							<option value="member_id">아이디</option>
						</select>
						<input type="text" name="keyword" value=""></input>
						<button type="submit">검색</button>
					</form>
				</div>
				
				<div class="area-button-chk">
					<button onclick="location.href='/admin/member/createUserForm'">회원등록</button> &nbsp;
					<button type="button" id="deleteButton">삭제</button>
				</div>	
			</div>
					
			
			<div class="board_member_list">
				<div class="top">
					<div class="mem-num">번호</div>
					<div class="mem-name">이름</div>
					<div class="mem-id">ID</div>
					<div class="mem-dep">부서</div>
					<div class="mem-status">상태</div>
					<div class="mem-type">구분</div>
					<div class="mem-check"><input type="checkbox" id="chkAll"/></div>
				</div>
				
				<c:forEach var="list" items="${userList}">
					<div>
						<div class="mem-num">1</div>
						<div class="mem-name"><a href="/admin/member/modifyUserForm?userId=${list.userId}">${list.userName}</a></div>
						<div class="mem-id"><a href="/admin/member/modifyUserForm?userId=${list.userId}">${list.userId}</a></div>
						<div class="mem-dep">${list.depName}</div>
						<div class="mem-status">${list.userStatus}</div>
						<div class="mem-type">${list.userType}</div>
						<div class="mem-check"><input type="checkbox" name="chkMember" value="${list.userSeq}"/></div>
					
					</div>
				
				</c:forEach>
				
			</div>
			
			
			<div class="board_page">
			
			
			
			
			</div>
			
		</div>
	</div>
</div>


<!-- Footer -->
<jsp:include page="../../common/footer.jsp" flush="false"/>