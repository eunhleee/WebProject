<%@ page contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="mgr" class="alcinfo.ReportMgr"/>
<%@ page import ="java.util.*,alcinfo.*"%>
<jsp:useBean id="bean" class="alcinfo.ReportBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
   	int renum=UtilMgr.parseInt(request,"renum");
	String stopid= request.getParameter("stopid").trim();
	mgr.reportBoard(bean);
	response.sendRedirect("scReport.jsp?stopid="+stopid+"&renum="+renum);
	System.out.println("이곳은 Proc"+session.getAttribute("idKey")+"stopid는"+stopid+"renum은"+renum);

%>

