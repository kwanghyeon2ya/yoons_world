<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/javascript">
	<c:if test="${result eq 0}">
	alert('������ �Ϸ� �Ǿ����ϴ�.');
	</c:if>
	<c:if test="${result ne 0}">
	alert('���忡 ���� �Ͽ����ϴ�.');
	</c:if>
	location.href = '/demo/getDemoList';
</script>


