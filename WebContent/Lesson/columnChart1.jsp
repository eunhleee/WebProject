<%@page import="alcinfo.UtilMgr"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page contentType="application/json; charset=utf-8"%>
<jsp:useBean id="mgr" class="alcinfo.LessonMgr"></jsp:useBean>
<%
		request.setCharacterEncoding("utf-8");
		String id=request.getParameter("id");
		JSONArray array=mgr.getCountStudent(id);
%>
<%=array%>