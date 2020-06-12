<!-- st_QnADelete.jsp -->
<%@page import="alcinfo.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="stqmgr" class="alcinfo.StinqueryMgr"/>
<jsp:useBean id="stqcmgr" class="alcinfo.StQcommentsMgr"/>
<%
	String nowPage = request.getParameter("nowPage");	
	String numPerPage = request.getParameter("numPerPage");	
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	int stunum = UtilMgr.parseInt(request, "stunum");
	int num = UtilMgr.parseInt(request, "num");
	
	stqcmgr.deleteAllStQComment(num);
	stqmgr.deleteStQ(num);
%>
<script>
	alert("삭제되었습니다.");
	location.href = "stRead.jsp?stunum=<%=stunum%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
  	 	if(!(keyWord==null||keyWord.equals(""))){
		     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>";
</script>