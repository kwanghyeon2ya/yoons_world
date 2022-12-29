<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<jsp:include page="/WEB-INF/jsp/inc/boardImport.jsp" flush="false" />

<link rel="stylesheet" type="text/css" href="/css/board/board.css">

<c:if test="${sessionScope.sessionSeqForUser == null}">
	<c:redirect url="/login/loginView" />
</c:if>
	<script>
	$(document).ready(function() {
		$("#search_frm").submit(function(){
			if ($("#search_text").val().trim().length == 0) {
				if($("#search_select_id").val() == 'user_name'){
					alert("검색창에 성명을 입력하세요");
					return false;
				}
				if($("#search_select_id").val() == 'dep'){
					alert("검색창에 소속 부서명을 입력하세요");
					return false;
				}
			};
		});
	});
	</script>
</head>
<body>

	<div id="page-wrapper">
		<!-- Header -->
		<jsp:include page="/WEB-INF/jsp/common/header2.jsp" flush="false" />

		<div id="container">
			<div class="content">

				<h2>회원 검색</h2>

				<div class="search_area right">
					<form action="/main/userSearchList" id="search_frm" method="get">
						<select name="search">
							<option value="user_name" ${userVO.search == 'userName'?'selected="selected"':''}>이름</option>
							<option value="dep" ${userVO.search == 'dep'?'selected="selected"':''}>부서명</option>
						</select> 
						<input type="text" id="search_text" class="size_s" name="keyword" value="${userVO.keyword}"/>
						<button type="submit" id="submit_button" class="btn type_02 size_s bg_purple">검색</button>
					</form>
				</div>

				<div class="list_area">
					<div class="member_search_list table type_02">
						<div class="th">이름</div>
						<div class="th">소속 부서명</div>
						<div class="th">이메일</div>
						<div class="th">전화번호</div>
						<div class="th">휴대폰 번호</div>
						<!-- <div class="mem-dep">부서</div> -->
					<c:if test="${count == 0}">
						<div class="non_data">회원이 존재하지 않습니다.</div>
					</c:if>

					<c:if test="${count > 0}">

					<c:forEach var="list" items="${uslist}" varStatus="loop">
							<div>${list.userName}</div>
							<div>${list.depName}</div>
							<div>${list.email}</div>
							<%-- <div class="mem-dep">${list.depName}</div> --%>
							<div>02-2225-${list.extension}</div>
							<div>${list.phone}</div>
					</c:forEach>
					</c:if>
					</div>
				
				</div>
			</div>
		</div>

		<jsp:include page="/WEB-INF/jsp/common/footer.jsp" flush="false" />

	</div>

</body>
</html>
