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

<c:if test="${sessionScope.sessionSeqForAdmin == null}">
	<c:redirect url="/login/loginView"/>
</c:if>

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
			alert('회원을 선택해주세요.');
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
					alert("상태가 변경되지 않았습니다.");
					break;
				case 1:
					alert("선택하신 회원이 정지되었습니다.");
					window.location.href = "/admin/member/list"; // 정지 후 회원 목록으로 
					break;
				default:
					alert("상태가 변경되지 않았습니다.");
					break;
				}
			}
		});
	});
	
	
	$('#modifyStatus').click(function() {
		
		var checked = $("input[type=checkbox]:checked");
		var userSeqArray = []; // 아이디 배열 생성
		
		$.each(checked, function(){
			userSeqArray.push($(this).val()); //체크한 아이디 배열로 입력
		});
		
		console.log(userSeqArray); //체크한 아이디 콘솔 확인
		//console.log(userIdArray.join(','));
		
		if(checked.length < 1) { //선택 값이 없으면 알림 메세지
			alert('회원을 선택해주세요.');
			return false;
		}
		
		$.ajax({
			url : '/admin/member/recoverUserStatus',
			type : 'POST',
			data : {'userSeqArray' : userSeqArray },
			dataType: 'json',
			success : function(result){
				switch (Number(result)) {
				case 0:
					alert("상태가 변경되지 않았습니다.");
					break;
				case 1:
					alert("선택하신 회원의 정지가 해제 되었습니다.");
					window.location.href = "/admin/member/list"; // 정지 후 회원 목록으로 
					break;
				default:
					alert("상태가 변경되지 않았습니다.");
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
			
			<form action="/admin/member/list" method="get">
				<div class="area-search">
					<div class="area-search-form">
						<select name="search">
							<option value="member_name" ${page.search == 'member_name'?'selected="selected"':''}>이름</option>
							<option value="member_id" ${page.search == 'member_id'?'selected="selected"':''}>아이디</option>
						</select>
						<input type="text" name="keyword"></input>
						<button id="submit_button" type="submit">검색</button>
					</div>
					
					<div class="area-button-chk">
						<c:if test="${count > 0}">
							<button type="button" id="deleteButton">중단</button>
							<button type="button" id="modifyStatus">활동</button>
						</c:if>
					</div>	
				</div>
			</form>
			
			<c:if test="${count eq 0}">
				<c:if test="${search ne ''}"><h1>검색하신 회원은 존재하지 않습니다..</h1>
				<a class="num" href="/admin/member/list">되돌아가기</a>
				</c:if>
				<c:if test="${search eq ''}"><h1>회원이 존재하지 않습니다..</h1></c:if>			
			</c:if>
			
			<c:if test="${count > 0}">
			
			<div class="board_member_list">
				<div class="top">
					<div class="mem-num">번호</div>
					<div class="mem-name">이름</div>
					<div class="mem-id">ID</div>
					<div class="mem-dep">이메일</div>
					<!-- <div class="mem-dep">부서</div> -->
					<div class="mem-status">회원상태</div>
					<div class="mem-type">권한</div>
					<div class="mem-check"><input type="checkbox" id="chkAll"/></div>
				</div>
				
				<c:forEach var="list" items="${userList}">
					<div>
						<div class="mem-num">${list.userSeq}</div>
						<div class="mem-name"><a href="/admin/member/modifyUserForm?userId=${list.userId}">${list.userName}</a></div>						
						<div class="mem-id"><a href="/admin/member/modifyUserForm?userId=${list.userId}">${list.userId}</a></div>
						<div class="mem-dep">${list.email}</div>
						<%-- <div class="mem-dep">${list.depName}</div> --%>
						<div class="mem-status">${list.userStatus eq 0?'정지':'활동중'}</div>
						
						<div class="mem-type">${list.userType eq 0?'일반회원':'관리자'}</div>
						<div class="mem-check"><input type="checkbox" name="chkMember" value="${list.userSeq}"/></div>
					
					</div>
				
				</c:forEach>
				
			</div>
			</c:if>
			
			<div class="area-button">
				<c:if test="${sessionScope.sessionSeqForAdmin ne null}">
					<button onclick="location.href='/admin/member/createUserForm'">회원등록</button>
				</c:if>
			</div>
			
			<div class="board_page">
			
				<c:if test="${count > 0}">
						
						<c:set var="pageCount" value="${count / page.pageSize + (count % page.pageSize == 0 ? 0 : 1)}"/>
						<fmt:parseNumber var="pageCount" value="${pageCount}" integerOnly="true"/>
						<fmt:parseNumber var="result" value="${((page.currentPage-1)/10)}" integerOnly="true"></fmt:parseNumber>
						<c:set var="startPage" value="${result*10+1}"/>
						<c:set var="pageBlock" value="${10}"/>
						<c:set var="endPage" value="${startPage + pageBlock -1}"/>
						${pageCount}					
						<c:if test="${endPage > pageCount}">
							<c:set var="endPage" value="${pageCount}"/>						
						</c:if>
						
						<c:if test="${startPage > 10}">
							<a class="num" href="/admin/member/list?pageNum=${startPage - 10}&search=${page.search}&keyword=${page.keyword}"> < </a>
						</c:if>
						
					<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
						<a class="num" href="/admin/member/list?search=${page.search}&keyword=${page.keyword}&pageNum=${i}&">
						<c:if test="${page.currentPage eq i}"><span style="font-weight:bold">${i}</span></c:if>
						<c:if test="${page.currentPage ne i}">${i}</c:if>
						</a>
					</c:forEach> 
					
					<c:if test="${endPage < pageCount}">
						<a class="num" href="/admin/member/list?search=${page.search}&keyword=${page.keyword}&pageNum=${startPage + 10}"> > </a>
					</c:if>
				</c:if>
			</div>
						
		</div>
	</div>
</div>

<script>
	$("#nav a").removeClass("current-page-item");
	$("#nav").find('a[href*="/member"]').addClass("current-page-item");
</script>
<!-- Footer -->
<jsp:include page="../../common/footer.jsp" flush="false"/>
