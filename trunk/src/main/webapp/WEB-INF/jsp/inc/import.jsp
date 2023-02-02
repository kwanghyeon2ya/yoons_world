<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="today" class="java.util.Date" />

<title>Yoons WoRLD</title>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap" rel="stylesheet">

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="/css/global.css?time=${today}">

<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="/js/browser.min.js"></script>
<script src="/js/breakpoints.min.js"></script>
	



<script>
	window.onpageshow = function(event){ // 뒤로가기 공부
		if(event.persisted){ //캐시 남아있는지 확인 후 남아있다면 true
			console.log(event.persisted);
			location.reload(true);
		}
	}
	
	$(function() {
		$('#btn_side_menu').click(function() {
			if($(this).hasClass('active')) {
				$('body').css('height', '');
				$(this).removeClass('active');
				$('#snb').removeClass('active');
			}
			else {
				$('body').css('height', '100vh');
				$(this).addClass('active');
				$('#snb').addClass('active');
			}
		});
	});
	
</script>