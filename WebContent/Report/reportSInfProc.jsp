<!-- reportSInfProc.jsp -->

<%@ page contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="mgr" class="alcinfo.ReportMgr"/>

<jsp:useBean id="bean" class="alcinfo.ReportBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
	String stopid= request.getParameter("stopid").trim();
	String t= request.getParameter("stopurl");
	if(t==null||t.trim().length()==0){
	System.out.println("값이 들어오지 않았습니다.");
	}
	int count=t.indexOf("/Student");
	String stopurl="../"+t.substring(count+1);

	mgr.rePortSI(bean,stopurl);
	response.sendRedirect("reportReceiptSInf.jsp?stopid="+stopid);
	%>
<script type="text/javascript">
window.close();
</script>

