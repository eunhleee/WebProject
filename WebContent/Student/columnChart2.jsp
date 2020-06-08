<%@page import="alcinfo.UtilMgr"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page contentType="application/json; charset=utf-8"%>
<jsp:useBean id="mgr" class="alcinfo.StudentMgr"></jsp:useBean>
<%
		request.setCharacterEncoding("utf-8");
		int stunum=UtilMgr.parseInt(request,"stunum");
		JSONArray array=mgr.getCountTeachar(stunum);
%>
<%=array%>