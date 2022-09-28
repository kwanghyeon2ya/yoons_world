 <%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!-- Header -->
<jsp:include page="../common/header.jsp" flush="false"/>

<!-- Content -->
<div id="main">
	<div class="container">
		<div class="input-wrap">
                  <form action="" method="POST">
                  
                      <div class="area-login">
                          <label for="username">ID</label>
                          <input id="username" type="text" name="username" placeholder="ID를 입력해주세요">                      
                      </div>
                      
                      <div class="area-login">
                          <label for="password">Password</label>
                          <input id="password" type="password" name="password" placeholder="비밀번호를 입력해주세요">
                      </div>
                      
                      <input type="submit" class="input-button" value="Login">
                      
                  </form>	
               </div>
           </div>
      </div>

<!-- Footer -->
<jsp:include page="../common/footer.jsp" flush="false"/>
