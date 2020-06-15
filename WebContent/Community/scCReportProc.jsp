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
	String t= request.getParameter("stopurl");
	if(t==null||t.trim().length()==0){
		System.out.println("값이 들어오지 않았습니다.");
	}
	int count=t.indexOf("/Community");
	String stopurl="../"+t.substring(count+1);
	
	String stopid= request.getParameter("stopid").trim();
	mgr.reportBoardcom(bean,stopurl);
	response.sendRedirect("scCReport.jsp?stopid="+stopid+"&renum="+renum+"&conum="+conum+"&stuc_depth="+stuc_depth);
	
%>
<script>
alert(renum);
alert(conum);

</script>


