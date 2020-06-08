<!-- scDelete.jsp -->
<%@page import="alcinfo.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="scmgr" class="alcinfo.SCommunityMgr"/>
<jsp:useBean id="sccmgr" class="alcinfo.SCommentMgr"/>
<% 
	request.setCharacterEncoding("UTF-8"); 
	String nowPage = request.getParameter("nowPage");
	int num = UtilMgr.parseInt(request, "num");

	sccmgr.deleteAllSComment(num);
	scmgr.deletesc(num);
%>
<script>
	alert("삭제되었습니다.");
	location.href="communityList.jsp";
</script>