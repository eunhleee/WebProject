<!-- st_QnAPostProc.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="mgr" class="alcinfo.StinqueryMgr"/>
<jsp:useBean id="bean" class="alcinfo.StinqueryBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
	String nowPage = request.getParameter("nowPage");	
	String numPerPage = request.getParameter("numPerPage");	
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	int num = Integer.parseInt(request.getParameter("stunum"));
	bean.setStunum(num);
	bean.setTitle(request.getParameter("stqtitle"));
	bean.setContent(request.getParameter("stqcontent"));
	bean.setId(request.getParameter("stqid"));
	bean.setIp(request.getParameter("stqip"));
	bean.setSt_secret(request.getParameter("stqsecret"));
	mgr.insertStq(bean);
%>
<script>
	location.href = "stRead.jsp?stunum=<%=num%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
  	 	if(!(keyWord==null||keyWord.equals(""))){
		     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>";
</script>