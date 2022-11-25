<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.iyoons.world.controller.LoginController" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.http.Cookie" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<% 
LoginController lc = new LoginController();

Cookie [] cookies = request.getCookies();
String cookieValue = null;
	for(Cookie c : cookies){
		String cookieName = c.getName();
			if(cookieName.equals("token")){
				cookieValue = c.getValue();
			}
	}
/* HttpSession session = request.getSession();
Model model;
lc.checkSessionCookie(cookieValue,session,model); */
%>


<!-- + 모든페이지 jsp에서 호출한 checkCookie -->

</body>
</html>