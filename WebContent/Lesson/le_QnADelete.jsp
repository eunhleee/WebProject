<!-- le_QnADelete.jsp -->
<%@page import="alcinfo.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="leqmgr" class="alcinfo.LequeryMgr"/>
<jsp:useBean id="leqcmgr" class="alcinfo.LeQcommentsMgr"/>
<%
	String nowPage = request.getParameter("nowPage");	
	String numPerPage = request.getParameter("numPerPage");	
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	int lq_lnum = UtilMgr.parseInt(request, "lq_lnum");
	int num = UtilMgr.parseInt(request, "num");
	
	leqcmgr.deleteAllLeQComment(num);
	leqmgr.deleteLeQ(num);
%>
<script>
	alert("삭제되었습니다.");
	location.href = "le_QnA.jsp?lq_lnum=<%=lq_lnum%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
  	 	if(!(keyWord==null||keyWord.equals(""))){
		     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>";
</script>