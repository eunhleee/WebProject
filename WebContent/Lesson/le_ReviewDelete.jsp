<!-- le_ReviewDelete.jsp -->
<%@page import="alcinfo.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="acrmgr" class="alcinfo.LereviewMgr"/>
<jsp:useBean id="acrcmgr" class="alcinfo.LeRcommentsMgr"/>
<%
	String nowPage = request.getParameter("nowPage");	
	String numPerPage = request.getParameter("numPerPage");	
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	int lernum = UtilMgr.parseInt(request, "lernum");
	int num = UtilMgr.parseInt(request, "num");
	String id = request.getParameter("id");
	
	acrcmgr.deleteAllLerComment(lernum);
	acrmgr.deleteLer(lernum);
%>
<script>
	alert("삭제되었습니다.");
	location.href = "leRead.jsp?num=<%=num%>&id=<%=id%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
  	 	if(!(keyWord==null||keyWord.equals(""))){
		     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>";
</script>