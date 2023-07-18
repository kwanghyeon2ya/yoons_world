<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	
	<script src="/js/main.js"></script>
	
	<script>
	
	function selectDep(value){
		if($("#search_select_id").val() == 'dep'){
			/* $("#search_text").css("display","none"); */
			$("#search_text").hide();
			$("#search_dep_select").show();
			$("input[name=keyword]").prop("disabled",true);
			$("select[name=keyword]").prop("disabled",false);
			/* $("#search_dep_select").css("display","block"); */
		}else{
			$("#search_text").show();
			$("#search_dep_select").hide();
			$("input[name=keyword]").prop("disabled",false);
			$("select[name=keyword]").prop("disabled",true);
		}
	}
	
	
	
	$(document).ready(function() {
		
		const background = $(".background");
		const window = $(".window");
		
		$(".show_modal").on("click",function(){ // 모달창 켜기
			/* background.css("display","block"); */
			document.body.style.overflow = 'hidden';
			$(".background").fadeIn('fast');
			background.toggleClass('show');
		});
		<c:if test="${pwCheck eq 1}"> // 초기비번 바꾼사람들에 한 해 검은색 화면 눌러도 모달꺼지게 기능구현
		
			$(".background").mouseup(function(e){
				console.log("클릭 진입");
				console.log(e.target); //누른곳의 요소가 다나옴
				console.log(e.target.length);
				console.log("팝업 length : "+$(".popup").has(e.target).length);//클릭 하면 요솟 수 / 딴데누르면 요소가 아니라서 0
				if($(".popup").has(e.target).length == 0){
					$(".background.show").removeClass('show');
				}
			});
		
		</c:if>
		
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
		
		<c:if test="${sessionScope.sessionSeqForUser != null && pwCheck eq 0}">
			/* window.open('/main/changePw','비밀번호 변경','width=500,height=270,scrollbars=no, toolbars=no, menubar=no'); */
			document.body.style.overflow = 'hidden';
			background.toggleClass('show');
		</c:if>
	});
	
	function modal_close(){ // 모달창 닫기
		document.body.style.overflow = 'auto';
		/*window.close();*/
		$(".background").removeClass('show');
	}
	</script>
	
</head>
<body>

	<div class="background">
		<div class="window">
			<div class="popup">
				<!-- <a href="javascript:void(0)" class="close_modal">X</a> -->

				<form method="post" id="change_pw_frm" style="text-align: center;" onSubmit="return false;">
					<table border=1 style="margin: 0 auto;">
						<tbody>
							<tr>
								<th><span style="font-size: 1.5rem;"><label for="user_pw">기존 비밀번호</label></span></th>
								<td><input type="password" name="userPw" id="user_pw"></td>
							</tr>
							<tr>
								<th><span style="font-size: 1.5rem;"><label for="change_user_pw">변경할 비밀번호</label></span></th>
								<td><input type="password" name="changeUserPw" id="change_user_pw" placeholder="4-12자 영문과 숫자 조합"></td>
							</tr>
							<tr>
								<th><span style="font-size: 1.5rem;"><label for="change_user_pw2">비밀번호 확인</label></span></th>
								<td><input type="password" id="change_user_pw2"></td>
							</tr>
						</tbody>
					</table>
					<button type="submit" class="btn type_02 bg_purple"
					 ${pwCheck eq 1?'style="width: 24rem;"':'style="width: 30.5rem;"'} 
					 onclick="changePwForm()">변경</button>
					<c:if test="${pwCheck eq 1}">
						<button type="button" class="btn type_02 bg_aaa" style="width: 5rem;" onclick="modal_close()">취소</button>
					</c:if>
					<c:if test="${pwCheck eq 0}">
						<br>
						<span style="font-size: 1rem; color: red">보안을 위해 초기 비밀번호를 꼭 변경하세요</span>
					</c:if>
				</form>

			</div>
			<div>
				<div></div>
			</div>
		</div>
	</div>



	<div id="page-wrapper">
		
		<!-- Header -->
		<jsp:include page="/WEB-INF/jsp/common/header2.jsp" flush="false"/>
		
		<!-- Container -->
		<div id="container">
			<div class="content">
				
				<!-- main_wrapper begin -->
				<div class="main_wrappper">
					
					<!-- 메인 영역 (right) -->
					<div>

						<!-- 로그인 영역 -->
						<div class="login_area">
							<%-- 로그인 전 --%>
							<c:if test="${sessionScope.sessionSeqForUser == null}">
							<div class="login_info">
								<div>
									<p>
										<strong>Yoons World</strong> - 윤선생 직원들의 새로운 세상
									</p>
								</div>
							</div>
							<button onClick="location.href='/login/loginView'">LOGIN</button>
							</c:if>
							
							<%-- 로그인 후 --%>
							<c:if test="${sessionScope.sessionSeqForUser != null}">
							
							<div class="login_info">
								<div style="display:align-items">
								</div>
								<img class="profile" src="/img/common/profile.png">
								<div>
									<p>
										<strong>${sessionScope.sessionNameForUser}</strong>님 환영합니다.
									</p>
									<div style="display:flex;align-items: center;">
										<p style="display:inline">${sessionScope.sessionSeqForAdmin != null ? "관리자" : "일반 회원"}</p>
									</div>
								</div>
								<button type="button" class="btn type_03 bg_purple" onclick="location.href='/admin/member/list'">Admin</button>
							</div>
							
														
							<button onClick="location.href='/login/logout'">LOGOUT</button>
							<!-- <a href="javascript:window.open('/main/changePw','비밀번호 변경','top=400,left=400,width=500,height=270,scrollbars=no, toolbars=no, menubar=no')">비밀번호 변경</a> -->
							<a href="javascript:void(0)" class="show_modal">비밀번호 변경</a>
							</c:if>
						</div>
						
							<h3>회원 검색</h3>
					
						<div class="search_area right" id="main_search_form">
							<form action="/main/userSearchList" id="search_frm" method="get">
								<select name="search" id="search_select_id" onChange="selectDep(this.value);">
									<option value="user_name">성명</option>
									<option value="dep">부서명</option>
								</select>
								 
								<input type="text" id="search_text" name="keyword" value="${keyword}"></input>
								
								<select name="keyword" id="search_dep_select" style="display:none;" disabled>
									<option value="재경팀">재경팀</option>
									<option value="재무예상팀">재무예상팀</option>
									<option value="경영기획팀">경영기획팀</option>
									<option value="홍보팀">홍보팀</option>
									<option value="인사팀">인사팀</option>
									<option value="비서팀">비서팀</option>
									<option value="고객지원팀">고객지원팀</option>
									<option value="법무팀">법무팀</option>
									<option value="영업지원팀">영업지원팀</option>
									<option value="사업지원팀">사업지원팀</option>
									<option value="총무/제작팀">총무/제작팀</option>
									<option value="자산관리팀">자산관리팀</option>
									<option value="시설관리팀">시설관리팀</option>
									<option value="교육팀">교육팀</option>
									<option value="상품연구팀">상품연구팀</option>
									<option value="비주얼디자인팀">비주얼디자인팀</option>
									<option value="사운드디자인팀">사운드디자인팀</option>
									<option value="영상디자인팀">영상디자인팀</option>
									<option value="콘텐츠개발팀">콘텐츠개발팀</option>
									<option value="기술기획팀">기술기획팀</option>
									<option value="기술개발팀">기술개발팀</option>
									<option value="기술지원팀">기술지원팀</option>
									<option value="B2C사업팀">B2C사업팀</option>
									<option value="홈사업팀">홈사업팀</option>
									<option value="학원사업팀">학원사업팀</option>
								</select>
								
								<button type="submit" id="submit_button" class="btn type_02 bg_purple">검색</button>
							</form>
						</div>

						<!-- 조회수 TOP 리스트 -->
						<h3>조회수 TOP (한달)</h3>
						<div id="rank_board_list" class="rank_area"></div>
						<button id="rank_more_btn">더보기</button>
						
					</div>
					
					<!-- 메인 영역 (left) -->
					<div>
						<!-- 전체 게시글 리스트 -->
						<div id="main_board_list"></div>
					</div>
					
				</div>
				<!-- main_wrapper end -->
				
			</div>
		</div>
		
		<!-- footer -->
		<jsp:include page="/WEB-INF/jsp/common/footer.jsp" flush="false"/>
		
	</div>

</body>
</html>