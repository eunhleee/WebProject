<!-- scDelete.jsp -->
<%@page import="alcinfo.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");  %>
<jsp:useBean id="scmgr" class="alcinfo.SCommunityMgr"/>
<jsp:useBean id="sccmgr" class="alcinfo.SCommentMgr"/>
<% 
	String pageValue=request.getParameter("pageValue");
	String nowPage = request.getParameter("nowPage");	
	String numPerPage = request.getParameter("numPerPage");	
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	int num = UtilMgr.parseInt(request, "num");

	sccmgr.deleteAllSComment(num);
	scmgr.deletesc(num);
%>
<script>
	alert("삭제되었습니다.");
	location.href="communityList.jsp?pageValue=<%=pageValue %>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
  	 	if(!(keyWord==null||keyWord.equals(""))){
		     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>";
</script>