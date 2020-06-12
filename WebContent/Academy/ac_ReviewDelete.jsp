<!-- ac_ReviewDelete.jsp -->
<%@page import="alcinfo.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="acrmgr" class="alcinfo.AcreviewMgr"/>
<jsp:useBean id="acrcmgr" class="alcinfo.AcRcommentsMgr"/>
<%
	int acrnum = UtilMgr.parseInt(request, "acrnum");
	int num = UtilMgr.parseInt(request, "num");
	String nowPage = request.getParameter("nowPage");
	String numPerPage = request.getParameter("numPerPage");
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	
	acrcmgr.deleteAllAcrComment(acrnum);
	acrmgr.deleteAcr(acrnum);
%>
<script>
	alert("삭제되었습니다.");
	location.href = "acRead.jsp?num=<%=num%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
  	 	if(!(keyWord==null||keyWord.equals(""))){
		     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>";
</script>