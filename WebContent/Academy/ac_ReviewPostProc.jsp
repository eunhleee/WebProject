<!-- ac_ReviewPostProc.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="mgr" class="alcinfo.AcreviewMgr"/>
<jsp:useBean id="bean" class="alcinfo.AcreviewBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
	String nowPage = request.getParameter("nowPage");	
	String numPerPage = request.getParameter("numPerPage");	
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	int acnum = Integer.parseInt(request.getParameter("acnum"));
	bean.setAc_serialnum(acnum);
	bean.setAc_id(request.getParameter("acqid"));
	bean.setAc_title(request.getParameter("acrtitle"));
	bean.setAc_star(Double.parseDouble(request.getParameter("acrstar")));
	bean.setAc_content(request.getParameter("acrcontent"));
	bean.setAc_ip(request.getParameter("acqip"));
	mgr.insertAcr(bean);
%>
<script>
	location.href = "acRead.jsp?num=<%=acnum%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
  	 	if(!(keyWord==null||keyWord.equals(""))){
		     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>";
</script>