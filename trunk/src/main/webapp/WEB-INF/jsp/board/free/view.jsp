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
<!-- Header -->
<jsp:useBean id="today" class="java.util.Date" />
<jsp:include page="../../common/header.jsp" flush="false"/>


<!-- Main -->
<div id="main">
	<div class="container">
		<div class="col-12">
		
			<div class="title-page">
				<h3>공지사항</h3>
			</div>
			
			<div class="board_write">
                             
				<div class="area-board-title">
                    <span>${vo.subject}</span>				
                </div>

				<div class="area-board-info">
                    <p>작성자 : ${vo.writerName}</p>
					<p>2022.09.07 15:50 &nbsp;&nbsp; 조회 3</p>
                </div>
				
				<div class="area-board-btn">
					<c:if test="${sessionScope.sseq == vo.regrSeq}">
                        <button type="button" onclick="window.location='/board/free/modify?postSeq=${vo.postSeq}&subject=${vo.subject}&content=${vo.content}'">수정</button>
						<button type="button" onclick="window.location='/board/free/delete?postSeq=${vo.postSeq}'">삭제</button>
                   	</c:if>         
                </div>
				
				<div class="area-board-cont">
                  	${vo.content}
				</div>

				<div class="area-board-comm">
                    <p>댓글 2 ></p>
					<div class="area-board-comm-info">
						<p>작성자 : 윤수월드</p>
						<p>유익한 정보 감사합니다. 정말로 감사해요.</p>
						<p>2022.09.07 16:50</p>
					</div>
					<div class="area-board-comm-info">
						<p>작성자 : 윤수월드</p>
						<p>유익한 정보 감사합니다. 정말로 감사해요.</p>
						<p>2022.09.07 16:50</p>
					</div>
					<div class="area-board-comm-btn">
						<button type="button">댓글</button>
					</div>
				</div>

				<div class="area-board-comm">
                    <input type="text" placeholder="새로운 댓글을 등록해보세요"/>
					<div class="area-board-comm-btn">
						<button type="button">등록</button>
					</div>
				</div>
				
				<div class="area-button">
					<button onclick="window.location='/board/free/list'">목록</button>
				</div>
				
			</div>
		</div>
	</div>
</div>


<!-- Footer -->
<jsp:include page="../../common/footer.jsp" flush="false"/>