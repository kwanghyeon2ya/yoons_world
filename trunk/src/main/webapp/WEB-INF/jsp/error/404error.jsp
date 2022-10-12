<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>웹사이트에서 페이지를 표시할 수 없습니다</h1>

<h2>가능성이 높은 원인 :</h2>

<section>
	<ul><li>주소에 오타가 있는지 확인해주십시오</li></ul>
	<ul><li>클릭한 링크가 만료되었을 수 있습니다</li></ul>
</section>

<h2>개선방법</h2>
<p>주소의 오타를  확인합니다</p>
<a href="javascript:history.go(-1)">이전페이지로 돌아갑니다</a><br/>
<a href="/main">메인페이지로 이동합니다</a>

<details>
<summary>추가정보</summary>
<p>error code :&nbsp ${code} ${msg}</p>
<p></p>
<p>${timestamp}</p>
</details>