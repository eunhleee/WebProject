<!-- scReportProc.jsp -->

<!-- 커뮤니티페이지 proc -->
<%@ page contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="mgr" class="alcinfo.ReportMgr"/>
<%@ page import ="java.util.*,alcinfo.*"%>
<jsp:useBean id="bean" class="alcinfo.ReportBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
   	int renum=UtilMgr.parseInt(request,"renum");
	String stopid= request.getParameter("stopid").trim();
	String t= request.getParameter("stopurl");
	if(t==null||t.trim().length()==0){
		System.out.println("값이 들어오지 않았습니다.");
	}
	int count=t.indexOf("/Student");
	String stopurl="../"+t.substring(count+1);
	System.out.println(stopurl);

	mgr.reportBoard(bean,stopurl);
%>
<script>
	alert("신고가 접수되었습니다.");
	window.close();
</script>

