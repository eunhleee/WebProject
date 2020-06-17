<!-- cs_Delete.jsp -->
<%@page import="alcinfo.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="csmgr" class="alcinfo.CSMgr"/>
<jsp:useBean id="cscmgr" class="alcinfo.CSCommentMgr"/>
<% 
	request.setCharacterEncoding("UTF-8"); 
	String cust_page=request.getParameter("cust_page");
	String nowPage = request.getParameter("nowPage");	
	String numPerPage = request.getParameter("numPerPage");	
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	int num = UtilMgr.parseInt(request, "num");

	cscmgr.deleteAllCSComment(num);
	csmgr.deletecs(num);
%>
<script>
	alert("삭제되었습니다.");
	location.href="custCenter.jsp?cust_page=<%=cust_page%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
  	 	if(!(keyWord==null||keyWord.equals(""))){
		     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>";
</script>