<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${sessionScope.sessionSeqForUser ne null}">
	<c:import url="/WEB-INF/jsp/main/changePw.jsp"/>
</c:if>
 

