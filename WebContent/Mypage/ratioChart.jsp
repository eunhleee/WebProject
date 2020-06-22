
<%@page import="org.json.simple.JSONArray"%>
<%@ page contentType="application/json; charset=utf-8"%>
<jsp:useBean id="mgr" class="alcinfo.PaymentMgr"></jsp:useBean>
<%
		request.setCharacterEncoding("utf-8");
		JSONArray array=mgr.getMonthSales();
		
%>
<%=array%>