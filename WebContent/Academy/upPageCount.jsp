<%@page import="alcinfo.UtilMgr"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
		request.setCharacterEncoding("utf-8");
		String pageValue=request.getParameter("pageValue");
		int maxPage1=UtilMgr.parseInt(request,"maxPage1");
		maxPage1+=6;
%>
<script>
location.href="../Academy/AcademyMain.jsp?pageValue=<%=pageValue%>&maxPage1=<%=maxPage1%>";
</script>
