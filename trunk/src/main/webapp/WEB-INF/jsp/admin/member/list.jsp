<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>

<c:if test="${sessionScope.sid == null}">
	<script>
		alert("�α����� �ʿ��մϴ�")
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
				<h3>ȸ������Ʈ</h3>
			</div>
			
			<div class="area-search">
				<div class="area-search-form">
					<form action="" method="POST">
						<select name="search">
							<option value="member_name">�̸�</option>
							<option value="member_id">���̵�</option>
						</select>
						<input type="text" name="keyword" value=""></input>
						<button type="submit">�˻�</button>			
					</form>
				</div>
				
				<div class="area-button-chk">
					<button type="button">����</button>
				</div>	
			</div>
					
			
			<div class="board_member_list">
				<div class="top">
					<div class="m_num">��ȣ</div>
					<div class="m_name">�̸�</div>
					<div class="m_id">ID</div>
					<div class="m_dep">�μ�</div>
					<div class="m_status">����</div>
					<div class="m_type">����</div>
					<div class="m_check"><input type="checkbox" id="chkAll"/></div>
				</div>
				
				<c:forEach var="list" items="${userList}">
					<div>
						<div class="m_num">1</div>
						<div class="m_name"><a href="/main">${list.userName}</a></div>
						<div class="m_id"><a href="/main">${list.userId}</a></div>
						<div class="m_dep">${list.depName}</div>
						<div class="m_status">${list.userStatus}</div>
						<div class="m_type">${list.userType}</div>
						<div class="m_check"><input type="checkbox" name="chkMember"/></div>
					
					</div>
				
				</c:forEach>
				
			</div>
			
			<div class="area-button">
				<button onclick="location.href='/member/regist'">ȸ�����</button>
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