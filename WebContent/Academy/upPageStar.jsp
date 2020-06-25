<%@page import="alcinfo.UtilMgr"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
		request.setCharacterEncoding("utf-8");
		String pageValue=request.getParameter("pageValue");
		int maxPage=UtilMgr.parseInt(request,"maxPage");
		maxPage+=6;
%>
<script>
location.href="../Academy/AcademyMain.jsp?pageValue=<%=pageValue%>&maxPage=<%=maxPage%>";
</script>
