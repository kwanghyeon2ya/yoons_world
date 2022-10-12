<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>웹사이트에서 페이지를 표시할 수 없습니다</h1>



<p>error code :&nbsp ${code} ${msg}</p>
<p>${timestamp}</p>

<h2>개선방법</h2>
<a href="javascript:location.reload(true)">페이지를 새로고칩니다</a><br/>
<a href="javascript:history.go(-1)">이전페이지로 돌아갑니다</a><br/>
<a href="/main">메인페이지로 이동합니다</a>