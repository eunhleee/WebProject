<%@page import="alcinfo.PaymentBean"%>
<%@page import="alcinfo.UtilMgr"%>
<%@ page contentType="text/html; charset=utf-8"%>

<jsp:useBean id="mgr" class="alcinfo.PaymentMgr"/>
<jsp:useBean id="bean" class="alcinfo.PaymentBean"/>

<%
		request.setCharacterEncoding("utf-8");
		bean=(PaymentBean)session.getAttribute("bean");
		int applynum = UtilMgr.parseInt(request,"apply_num");
		
		mgr.insertPayment(bean,applynum);
			
%>
<script>
location.href="../Payment/buyPoint.jsp";
</script>