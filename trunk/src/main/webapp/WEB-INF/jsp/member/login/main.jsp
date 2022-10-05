<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>Main페이지</h1>

<hr align="left" style="border:solid 2px green; width:300px;">
어서오세요 "${sessionScope.sid}"님<br/>
<hr align="left" style="border:solid 2px green; width:300px;">

<button type="button" onclick="window.location.href='/board/free/list'">자유게시판</button>&nbsp
<button type="button" onclick="window.location.href='/board/notice/list'">공지사항</button>&nbsp
<button type="button" onclick="window.location.href='/board/pds/list'">자료실</button>
