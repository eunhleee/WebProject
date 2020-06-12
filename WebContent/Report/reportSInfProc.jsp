<!-- reportSInfProc.jsp -->

<%@ page contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="mgr" class="alcinfo.ReportMgr"/>

<jsp:useBean id="bean" class="alcinfo.ReportBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
	String stopid= request.getParameter("stopid").trim();
	String stopurl =request.getParameter("stopurl").trim();

	mgr.rePortAI(bean);
	response.sendRedirect("reportReceiptSInf.jsp?stopid="+stopid+"&stopurl="+stopurl);%>

