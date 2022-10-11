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

<c:if test="${sessionScope.sessionIdForUser == null}">
	<script>
		alert("로그인이 필요합니다")
		window.location.href="/login/loginView";
	</script>
</c:if>

<!-- Header -->
<jsp:include page="../../common/header.jsp" flush="false"/>

<script>
	$("#chkAll").click(function() {
		if($("#chkAll").is(":checked")) $("input[name=chkMember]").prop("checked", true);
		else $("input[name=chkMember]").prop("checked", false);
	});
	
	$("input[name=chkMember]").click(function() {
		var total = $("input[name=chkMember]").length;
		var checked = $("input[name=chkMember]:checked").length;
	
		if(total != checked) $("#chkAll").prop("checked", false);
		else $("#chkAll").prop("checked", true); 
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
					<div class="m_num">번호</div>
					<div class="m_name">이름</div>
					<div class="m_id">ID</div>
					<div class="m_dep">부서</div>
					<div class="m_status">상태</div>
					<div class="m_type">구분</div>
					<div class="m_check"><input type="checkbox" id="chkAll"/></div>
				</div>
				
				<c:forEach var="list" items="${userList}">
					<div>
						<div class="m_num">1</div>
						<div class="m_name"><a href="/admin/member/createUserForm">${list.userName}</a></div>
						<div class="m_id"><a href="/admin/member/createUserForm">${list.userId}</a></div>
						<div class="m_dep">${list.depName}</div>
						<div class="m_status">${list.userStatus}</div>
						<div class="m_type">${list.userType}</div>
						<div class="m_check"><input type="checkbox" name="chkMember"/></div>
					
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