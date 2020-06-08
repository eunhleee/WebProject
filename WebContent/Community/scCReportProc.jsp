<%@ page contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="mgr" class="alcinfo.ReportMgr"/>
<%@ page import ="java.util.*,alcinfo.*"%>
<jsp:useBean id="bean" class="alcinfo.ReportBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
   	int renum=UtilMgr.parseInt(request,"renum");
	int conum=UtilMgr.parseInt(request,"conum");
	int stuc_depth=UtilMgr.parseInt(request,"stuc_depth");
	
	
	String stopid= request.getParameter("stopid").trim();
	mgr.reportBoardcom(bean);
	response.sendRedirect("scCReport.jsp?stopid="+stopid+"&renum="+renum+"&conum="+conum+"&stuc_depth="+stuc_depth);
	
%>
<script>
alert(renum);
alert(conum);

</script>


