<%@page import="alcinfo.UtilMgr"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
		request.setCharacterEncoding("utf-8");
		String keyWord=request.getParameter("keyWord");
		int maxPage=UtilMgr.parseInt(request,"maxPage");
		maxPage+=6;
%>
<link href="../alcinfo/fontStyle.css" rel="stylesheet">
<script>
location.href="../alcinfo/SearchPage.jsp?keyWord=<%=keyWord%>&maxPage=<%=maxPage%>";
</script>
