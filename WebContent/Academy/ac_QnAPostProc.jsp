<!-- ac_QnAPostProc.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="mgr" class="alcinfo.AcqueryMgr"/>
<jsp:useBean id="bean" class="alcinfo.AcqueryBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
	int num = Integer.parseInt(request.getParameter("acnum"));
	bean.setAc_num(num);
	bean.setAc_title(request.getParameter("acqtitle"));
	bean.setAc_subject(request.getParameter("acqsubject"));
	bean.setAc_content(request.getParameter("acqcontent"));
	bean.setAc_id(request.getParameter("acqid"));
	bean.setAc_ip(request.getParameter("acqip"));
	mgr.insertAcq(bean);
%>
<script>
	location.href = "ac_QnA.jsp?ac_num=<%=num%>";
</script>