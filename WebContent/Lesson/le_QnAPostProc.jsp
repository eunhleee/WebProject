<!-- le_QnAPostProc.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="alcinfo.LequeryMgr"/>
<jsp:useBean id="bean" class="alcinfo.LequeryBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("lq_lnum"));
	bean.setLq_lnum(num);
	bean.setLq_title(request.getParameter("leqtitle"));
	bean.setLq_subject(request.getParameter("leqsubject"));
	bean.setLq_content(request.getParameter("leqcontent"));
	bean.setLq_id(request.getParameter("leqid"));
	bean.setLq_ip(request.getParameter("leqip"));
	mgr.insertLeq(bean);
%>
<script>
	location.href = "le_QnA.jsp?lq_lnum=<%=num%>";
</script>