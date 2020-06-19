<!-- ac_QnAPostProc.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="mgr" class="alcinfo.AcqueryMgr"/>
<jsp:useBean id="bean" class="alcinfo.AcqueryBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
	int num = Integer.parseInt(request.getParameter("acnum"));
	String nowPage = request.getParameter("nowPage");	
	String numPerPage = request.getParameter("numPerPage");	
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	bean.setAc_num(num);
	bean.setAc_title(request.getParameter("acqtitle"));
	bean.setAc_subject(request.getParameter("acqsubject"));
	bean.setAc_content(request.getParameter("acqcontent"));
	bean.setAc_id(request.getParameter("acqid"));
	bean.setAc_ip(request.getParameter("acqip"));
	bean.setAc_secret(request.getParameter("acqsecret"));
	mgr.insertAcq(bean);
%>
<script>
	location.href = "ac_QnA.jsp?ac_num=<%=num%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
  	 	if(!(keyWord==null||keyWord.equals(""))){
		     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>";
</script>