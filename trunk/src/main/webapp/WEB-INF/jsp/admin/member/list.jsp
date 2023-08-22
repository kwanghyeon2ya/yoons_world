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

<c:if test="${sessionScope.sessionSeqForAdmin == null}">
	<c:redirect url="/login/loginView" />
</c:if>

<style>
	.show{
		display:block;
	}
</style>

<script>
	$(function() {
		
		
		function changeList(){//select box 변경시
			var select = document.getElementById("selectList");
			var selectVal = select.options[select.selectedIndex].value;
			
			if(selectVal == '회원 리스트'){
				
			}
			if(selectVal == '회의실 예약 현황'){
				
			}
			
		}
		
		$("#chkAll").click(function() {
			console.log("yeah!");
			if ($("#chkAll").is(":checked"))
				$("input[name=chkMember]").prop("checked", true);
			else
				$("input[name=chkMember]").prop("checked", false);
		});

		$("input[name=chkMember]").click(function() {
			var total = $("input[name=chkMember]").length;
			var checked = $("input[name=chkMember]:checked").length;

			if (total != checked)
				$("#chkAll").prop("checked", false);
			else
				$("#chkAll").prop("checked", true);
		});

		$('#deleteButton').click(function() {

			var checked = $("input[type=checkbox]:checked");
			var userSeqArray = []; // 아이디 배열 생성

			$.each(checked, function() {
				userSeqArray.push($(this).val()); //체크한 아이디 배열로 입력
			});

			console.log(userSeqArray); //체크한 아이디 콘솔 확인
			//console.log(userIdArray.join(','));

			if (checked.length < 1) { //선택 값이 없으면 알림 메세지
				alert('회원을 선택해주세요.');
				return false;
			}

			$.ajax({
				url : '/admin/member/deleteUser',
				type : 'POST',
				data : {
					'userSeqArray' : userSeqArray
				},
				dataType : 'json',
				success : function(result) {
					switch (Number(result)) {
					case 0:
						alert("상태가 변경되지 않았습니다.");
						break;
					case 1:
						alert("선택하신 회원이 정지되었습니다.");
						window.location.href = "/admin/member/list"; // 정지 후 회원 목록으로 
						break;
					case 9999:
						alert("잘못된 요청입니다. 로그인 화면으로 돌아갑니다");
						location.href="/login/loginView";
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

			$.each(checked, function() {
				userSeqArray.push($(this).val()); //체크한 아이디 배열로 입력
			});

			console.log(userSeqArray); //체크한 아이디 콘솔 확인
			//console.log(userIdArray.join(','));

			if (checked.length < 1) { //선택 값이 없으면 알림 메세지
				alert('회원을 선택해주세요.');
				return false;
			}

			$.ajax({
				url : '/admin/member/recoverUserStatus',
				type : 'POST',
				data : {
					'userSeqArray' : userSeqArray
				},
				dataType : 'json',
				success : function(result) {
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
</head>
<body>

	<div id="page-wrapper">
		<!-- Header -->
		<jsp:include page="/WEB-INF/jsp/common/header2.jsp" flush="false" />

		<div id="container">
			<div class="content">

				<select id="selectList" onchange="changeList()">
					<option selected="selected">회원 리스트</option>
					<option>회의실 예약 현황</option>				
				</select>


				<div id="memberDiv" class="show">
				
						<div class="search_area right">
							<form action="/admin/member/list" method="get">
								<select name="search">
									<option value="member_name"
										${page.search == 'member_name'?'selected="selected"':''}>이름</option>
									<option value="member_id"
										${page.search == 'member_id'?'selected="selected"':''}>아이디</option>
								</select> <input type="text" name="keyword"></input>
								<button type="submit" id="submit_button"
									class="btn type_02 size_s bg_purple">검색</button>
		
								<div class="area-button-chk" style="margin-top: 2rem;">
									<c:if test="${count > 0}">
										<button type="button" class="btn type_02 size_s bg_purple" id="deleteButton">중단</button>
										<button type="button" class="btn type_02 size_s bg_purple" id="modifyStatus">활동</button>
									</c:if>
								</div>
							</form>
						</div>
		
						<c:if test="${count eq 0}">
							<c:if test="${search ne ''}">
								<h1>검색하신 회원은 존재하지 않습니다..</h1>
								<a href="/admin/member/list">되돌아가기</a>
							</c:if>
							<c:if test="${search eq ''}">
								<h1>회원이 존재하지 않습니다..</h1>
							</c:if>
						</c:if>
				
					
					
						<div class="list_area">
							<div class="member_list_brd table type_03">
								<div class="th">번호</div>
								<div class="th">이름</div>
								<div class="th">ID</div>
								<div class="th">이메일</div>
								<!-- <div class="mem-dep">부서</div> -->
								<div class="th">회원상태</div>
								<div class="th">권한</div>
								<div class="th">
									<input type="checkbox" id="chkAll" />
									<label for="chkAll"> 
									</label>
								</div>
								
							<c:if test="${count == 0}">
								<div class="non_data">회원이 존재하지 않습니다.</div>
							</c:if>
	
							<c:if test="${count > 0}">
		
							<c:forEach var="list" items="${userList}" varStatus="loop">
									<div>${list.userSeq}</div>
									<div>
										<a href="/admin/member/modifyUserForm?userSeq=${list.userSeq}&userId=${list.userId}">${list.userName}</a>
									</div>
									<div>
										<a href="/admin/member/modifyUserForm?userSeq=${list.userSeq}&userId=${list.userId}">${list.userId}</a>
									</div>
									<div>${list.email}</div>
									<%-- <div class="mem-dep">${list.depName}</div> --%>
									<div>${list.userStatus eq 0?'정지':'활동중'}</div>
	
									<div>${list.userType eq 0?'일반회원':'관리자'}</div>
									<div>
										<input type="checkbox" id="chkMember_${loop.index}" name="chkMember" value="${list.userSeq}" />
										 
										<label for="chkMember_${loop.index}"> 
											
										</label>
										
									</div>
							</c:forEach>
							</c:if>
						</div>
					
					</div>
					
					<div class="btn_area right">
						<c:if test="${sessionScope.sessionSeqForAdmin ne null}">
							<button class="btn type_02 size_s bg_purple"
								onclick="location.href='/admin/member/createUserForm'">회원등록</button>
						</c:if>
					</div>
	
					<div class="paging_area">
	
						<c:if test="${count > 0}">
							<c:set var="pageCount"
								value="${count / page.pageSize + (count % page.pageSize == 0 ? 0 : 1)}" />
							<fmt:parseNumber var="result" value="${((page.currentPage-1)/10)}"
								integerOnly="true"/>
							<fmt:parseNumber var="pageCount" value="${pageCount}"
								integerOnly="true" />	
							<c:set var="startPage" value="${result*10+1}" />
							<c:set var="pageBlock" value="${10}" />
							<c:set var="endPage" value="${startPage + pageBlock -1}" />
							
							<c:if test="${endPage > pageCount}">
								<c:set var="endPage" value="${pageCount}" />
							</c:if>
	
							<c:if test="${startPage > 10}">
								<a
									href="/admin/member/list?pageNum=${startPage - 10}&search=${page.search}&keyword=${page.keyword}">
									&lt; </a>
							</c:if>
							<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
								<c:if test="${page.currentPage eq i}">
									<a class="bg_purple txt_white"
										href="/admin/member/list?search=${page.search}&keyword=${page.keyword}&pageNum=${i}&">${i}</a>
								</c:if>
								<c:if test="${page.currentPage ne i}">
									<a
										href="/admin/member/list?search=${page.search}&keyword=${page.keyword}&pageNum=${i}&">${i}</a>
								</c:if>
							</c:forEach>
	
							<c:if test="${endPage < pageCount}">
								<a
									href="/admin/member/list?search=${page.search}&keyword=${page.keyword}&pageNum=${startPage + 10}">
									&gt; </a>
							</c:if>
						</c:if>
					</div>
				
				</div><!-- 멤버div -->
				
				<div id="reservationDiv" style="display:none;">
				
					<div class="search_area right">
						<form action="/admin/member/list" method="get">
							<select name="search">
								<option value="member_name"
									${page.search == 'member_name'?'selected="selected"':''}>이름</option>
								<option value="member_id"
									${page.search == 'member_id'?'selected="selected"':''}>아이디</option>
							</select> <input type="text" name="keyword"></input>
							<button type="submit" id="submit_button"
								class="btn type_02 size_s bg_purple">검색</button>
	
							<div class="area-button-chk" style="margin-top: 2rem;">
								<c:if test="${count > 0}">
									<button type="button" class="btn type_02 size_s bg_purple" id="deleteButton">중단</button>
									<button type="button" class="btn type_02 size_s bg_purple" id="modifyStatus">활동</button>
								</c:if>
							</div>
						</form>
					</div>
	
					<c:if test="${count eq 0}">
						<c:if test="${search ne ''}">
							<h1>검색하신 회원은 존재하지 않습니다..</h1>
							<a href="/admin/member/list">되돌아가기</a>
						</c:if>
						<c:if test="${search eq ''}">
							<h1>회원이 존재하지 않습니다..</h1>
						</c:if>
					</c:if>
				
					<div class="list_area">
							<div class="reservation_list_brd table type_03">
								<div class="th">예약자</div>
								<div class="th">부서명</div>
								<div class="th">층수</div>
								<div class="th">회의실명</div>
								<div class="th">회의시작일자</div>
								<div class="th">회의시작시각</div>
								<div class="th">회의종료일자</div>
								<div class="th">회의종료시각</div>
								<div class="th">반복여부코드</div>
								<div class="th">예약상태</div>
								<div class="th">등록일</div>
								<div class="th">수정자</div>
								<div class="th">수정일</div>
								<div class="th">
									<input type="checkbox" id="chkrevAll" />
									<label for="chkrevAll"> 
									</label>
								</div>
								
							<c:if test="${revCount == 0}">
								<div class="non_data">회의실 예약 정보가 없습니다.</div>
							</c:if>
	
							<c:if test="${revCount > 0}">
		
							<c:forEach var="list" items="${userList}" varStatus="loop">
									<div>${list.userSeq}</div>
									<div>
										<a href="/admin/member/modifyUserForm?userSeq=${list.userSeq}&userId=${list.userId}">${list.userName}</a>
									</div>
									<div>
										<a href="/admin/member/modifyUserForm?userSeq=${list.userSeq}&userId=${list.userId}">${list.userId}</a>
									</div>
									<div>${list.email}</div>
									<%-- <div class="mem-dep">${list.depName}</div> --%>
									<div>${list.userStatus eq 0?'정지':'활동중'}</div>
	
									<div>${list.userType eq 0?'일반회원':'관리자'}</div>
									<div>
										<input type="checkbox" id="chkMember_${loop.index}" name="chkMember" value="${list.userSeq}" />
										 
										<label for="chkMember_${loop.index}"> 
											
										</label>
										
									</div>
							</c:forEach>
							</c:if>
						</div>
					
					</div>
					
					<div class="btn_area right">
						<c:if test="${sessionScope.sessionSeqForAdmin ne null}">
							<button class="btn type_02 size_s bg_purple"
								onclick="location.href='/admin/member/createUserForm'">회원등록</button>
						</c:if>
					</div>
	
					<div class="paging_area">
	
						<c:if test="${count > 0}">
							<c:set var="pageCount"
								value="${count / page.pageSize + (count % page.pageSize == 0 ? 0 : 1)}" />
							<fmt:parseNumber var="result" value="${((page.currentPage-1)/10)}"
								integerOnly="true"/>
							<fmt:parseNumber var="pageCount" value="${pageCount}"
								integerOnly="true" />	
							<c:set var="startPage" value="${result*10+1}" />
							<c:set var="pageBlock" value="${10}" />
							<c:set var="endPage" value="${startPage + pageBlock -1}" />
							
							<c:if test="${endPage > pageCount}">
								<c:set var="endPage" value="${pageCount}" />
							</c:if>
	
							<c:if test="${startPage > 10}">
								<a
									href="/admin/member/list?pageNum=${startPage - 10}&search=${page.search}&keyword=${page.keyword}">
									&lt; </a>
							</c:if>
							<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
								<c:if test="${page.currentPage eq i}">
									<a class="bg_purple txt_white"
										href="/admin/member/list?search=${page.search}&keyword=${page.keyword}&pageNum=${i}&">${i}</a>
								</c:if>
								<c:if test="${page.currentPage ne i}">
									<a
										href="/admin/member/list?search=${page.search}&keyword=${page.keyword}&pageNum=${i}&">${i}</a>
								</c:if>
							</c:forEach>
	
							<c:if test="${endPage < pageCount}">
								<a
									href="/admin/member/list?search=${page.search}&keyword=${page.keyword}&pageNum=${startPage + 10}">
									&gt; </a>
							</c:if>
						</c:if>
					</div>
				
				</div><!-- reservation div -->
				
				
			</div>
		</div>

		<jsp:include page="/WEB-INF/jsp/common/footer.jsp" flush="false" />

	</div>

</body>
</html>
