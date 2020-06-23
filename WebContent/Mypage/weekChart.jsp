
<%@page import="alcinfo.UtilMgr"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page contentType="application/json; charset=utf-8"%>
<jsp:useBean id="mgr" class="alcinfo.PaymentMgr"></jsp:useBean>
<%
		request.setCharacterEncoding("utf-8");
		JSONArray[] array=new JSONArray[12];
		for(int i=1;i<=12;i++){
			array[i]=mgr.getWeekSales(i);
		}
%>
