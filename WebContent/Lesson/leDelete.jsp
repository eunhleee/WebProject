<!-- leDelete.jsp -->
<%@page import="alcinfo.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="Lmgr" class="alcinfo.LeteaMgr" />
<%
	int num = Integer.parseInt(request.getParameter("num"));
	Lmgr.deleteLesson(num);
%>
<script>
	alert("삭제되었습니다.");
	location.href = "LessonMain.jsp?pageValue=top";
</script>