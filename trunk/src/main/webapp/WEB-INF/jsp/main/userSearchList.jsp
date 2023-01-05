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
	
	function selectDep(value){
		if($("#search_select_id option:selected").val() == 'dep'){
			/* $("#search_text").css("display","none"); */
			$("#search_text").hide();
			$("#search_dep_select").show();
			$("input[name=keyword]").prop("disabled",true);
			$("select[name=keyword]").prop("disabled",false);
			/* $("#search_dep_select").css("display","block"); */
		}else{
			$("#search_text").show();
			$("#search_text").val("");
			$("#search_dep_select").hide();
			$("input[name=keyword]").prop("disabled",false);
			$("select[name=keyword]").prop("disabled",true);
		}
	}
	
	$(document).ready(function() {
		
		if($("#search_select_id").val() == 'dep'){
			$("#search_text").hide();
			$("#search_dep_select").show();
			$("input[name=keyword]").prop("disabled",true);
		}
		
		$("#search_frm").submit(function(){
			if ($("#search_text").val().trim().length == 0) {
				if($("#search_select_id").val() == 'user_name'){
					alert("검색창에 성명을 입력하세요");
					return false;
				}
				/* if($("#search_select_id").val() == 'dep'){
					alert("검색창에 소속 부서명을 입력하세요");
					return false;
				} */
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
						<select name="search" id="search_select_id" onchange="selectDep(this.value)">
							<option value="user_name" ${userVO.search == 'userName'?'selected="selected"':''}>이름</option>
							<option value="dep" ${userVO.search == 'dep'?'selected="selected"':''}>부서명</option>
						</select> 
						<input type="text" id="search_text" class="size_s" name="keyword" value="${userVO.keyword}"/>
						
						<select name="keyword" id="search_dep_select" style="display:none;width:20rem;">
									<option value="재경팀" ${userVO.keyword == '재경팀'?'selected="selected"':''}>재경팀</option>
									<option value="재무예상팀" ${userVO.keyword == '재무예상팀'?'selected="selected"':''}>재무예상팀</option>
									<option value="경영기획팀" ${userVO.keyword == '경영기획팀'?'selected="selected"':''}>경영기획팀</option>
									<option value="홍보팀" ${userVO.keyword == '홍보팀'?'selected="selected"':''}>홍보팀</option>
									<option value="인사팀" ${userVO.keyword == '인사팀'?'selected="selected"':''}>인사팀</option>
									<option value="비서팀" ${userVO.keyword == '비서팀'?'selected="selected"':''}>비서팀</option>
									<option value="고객지원팀" ${userVO.keyword == '고객지원팀'?'selected="selected"':''}>고객지원팀</option>
									<option value="법무팀" ${userVO.keyword == '법무팀'?'selected="selected"':''}>법무팀</option>
									<option value="영업지원팀" ${userVO.keyword == '영업지원팀'?'selected="selected"':''}>영업지원팀</option>
									<option value="사업지원팀" ${userVO.keyword == '사업지원팀'?'selected="selected"':''}>사업지원팀</option>
									<option value="총무/제작팀" ${userVO.keyword == '총무/제작팀'?'selected="selected"':''}>총무/제작팀</option>
									<option value="자산관리팀" ${userVO.keyword == '자산관리팀'?'selected="selected"':''}>자산관리팀</option>
									<option value="시설관리팀" ${userVO.keyword == '시설관리팀'?'selected="selected"':''}>시설관리팀</option>
									<option value="교육팀" ${userVO.keyword == '교육팀'?'selected="selected"':''}>교육팀</option>
									<option value="상품연구팀" ${userVO.keyword == '상품연구팀'?'selected="selected"':''}>상품연구팀</option>
									<option value="비주얼디자인팀" ${userVO.keyword == '비주얼디자인팀'?'selected="selected"':''}>비주얼디자인팀</option>
									<option value="사운드디자인팀" ${userVO.keyword == '사운드디자인팀'?'selected="selected"':''}>사운드디자인팀</option>
									<option value="영상디자인팀" ${userVO.keyword == '영상디자인팀'?'selected="selected"':''}>영상디자인팀</option>
									<option value="콘텐츠개발팀" ${userVO.keyword == '콘텐츠개발팀'?'selected="selected"':''}>콘텐츠개발팀</option>
									<option value="기술기획팀" ${userVO.keyword == '기술기획팀'?'selected="selected"':''}>기술기획팀</option>
									<option value="기술개발팀" ${userVO.keyword == '기술개발팀'?'selected="selected"':''}>기술개발팀</option>
									<option value="기술지원팀" ${userVO.keyword == '기술지원팀'?'selected="selected"':''}>기술지원팀</option>
									<option value="B2C사업팀" ${userVO.keyword == 'B2C사업팀'?'selected="selected"':''}>B2C사업팀</option>
									<option value="홈사업팀" ${userVO.keyword == '홈사업팀'?'selected="selected"':''}>홈사업팀</option>
									<option value="학원사업팀" ${userVO.keyword == '학원사업팀'?'selected="selected"':''}>학원사업팀</option>
								</select>
								
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
