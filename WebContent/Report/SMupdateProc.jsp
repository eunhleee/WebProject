<%@page import="alcinfo.GmailSend"%>
<%@page import="java.util.Vector"%>
<%@page import="alcinfo.ReportBean"%>
<jsp:useBean id="rMgr" class="alcinfo.ReportMgr"/>

<%@ page contentType="text/html; charset=UTF-8"%>
<%
		request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="mgr" class="alcinfo.ReportMgr"/>
<jsp:useBean id="bean" class="alcinfo.ReportBean"/>
<jsp:setProperty property="*" name="bean"/>
 <%

	int plusdate= Integer.parseInt(request.getParameter("plusdate"));
	String contents= request.getParameter("contents");
	String stopid=request.getParameter("stopid");
	ReportBean mBean =rMgr.getEmail(stopid);
	ReportBean gBean =rMgr.getGrade(stopid);
	boolean result=mgr.sMupdate(bean,plusdate,stopid,gBean.getGrade());
	boolean result2=mgr.rMupdate(bean,plusdate,stopid);

	int num=Integer.parseInt(request.getParameter("num"));

	String msg="수정에 실패하였습니다.";
	String title="[우리학원어디]부적절한 활동으로 인해 정지되셨습니다.";
	String content="";
	if(result){

 		msg="수정하였습니다.";
		content="[우리학원어디]\n"+contents+"의 사유로 인해 신고당하셨습니다. 오늘부터 "+plusdate+"일간 계정이 정지됩니다.";
		GmailSend.send(title, content,mBean.getEmail());
		
	}
	else{
		msg="수정에 실패하였습니다.";
		
	}
		
%>
	<script>
	
	alert("<%=msg%>")
	location.href="StateManagement.jsp";
	</script>
