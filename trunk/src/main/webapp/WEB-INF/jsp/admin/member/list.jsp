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
					<button type="button">삭제</button>
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
						<div class="mem-check"><input type="checkbox" name="chkMember"/></div>
					
					</div>
				
				</c:forEach>
				
			</div>
			
			<div class="area-button">
				<button onclick="location.href='/admin/member/createUserForm'">회원등록</button>
			</div>
			
			<div class="board_page">
				<a href="#" class="num"><</a>
				<a href="#" class="num on">1</a>
				<a href="#" class="num">2</a>
				<a href="#" class="num">3</a>
				<a href="#" class="num">4</a>
				<a href="#" class="num">5</a>
				<a href="#" class="num">></a>
			</div>
			
		</div>
	</div>
</div>


<!-- Footer -->
<jsp:include page="../../common/footer.jsp" flush="false"/>