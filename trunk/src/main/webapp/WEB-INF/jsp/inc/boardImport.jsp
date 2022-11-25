<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css">

<script src="/js/summernote-lite.js"></script>
<script src="/js/summernote-ko-KR.js"></script>
<script>
	$(function(){
		/* summernote 초기화 */
		$('#summernote').summernote({
		  /*placeholder: '내용을 입력해주세요',*/
		  tabsize: 2,
		  height: 300,
		  lang: 'ko-KR',
		  toolbar: [
		  	['style', ['style']],
			['font', ['bold', 'underline', 'clear']]
		 	/* ['insert', ['link', 'picture', 'video']] */
			/*['style', ['style']],
			['font', ['bold', 'underline', 'clear']],
			['color', ['color']],
			['para', ['ul', 'ol', 'paragraph']],
			['table', ['table']],								
			['view', ['fullscreen', 'codeview', 'help']]*/
			]
		});
		
	});
</script>

<script src="/js/boardWriteModify.js"></script>
<script src="/js/commentsWriteModify.js"></script>
<script src="/js/delview.js"></script>
<script src="/js/nestedcommWrite.js"></script>
<script src="/js/delcomments.js"></script>
<script src="/js/commnetsShowHide.js"></script>
<script src="/js/randomName.js"></script>
<script src="/js/enterkeyevent.js"></script>
