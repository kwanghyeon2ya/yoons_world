<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/javascript">
	<c:if test="${result eq 0}">
	alert('저장이 완료 되었습니다.');
	</c:if>
	<c:if test="${result ne 0}">
	alert('저장에 실패 하였습니다.');
	</c:if>
	location.href = '/demo/getDemoList';
</script>


