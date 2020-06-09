<!-- ac_QnADelete.jsp -->
<%@page import="alcinfo.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="acqmgr" class="alcinfo.AcqueryMgr"/>
<jsp:useBean id="acqcmgr" class="alcinfo.AcQcommentsMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	String nowPage = request.getParameter("nowPage");
	int acnum = UtilMgr.parseInt(request, "ac_num");
	int num = UtilMgr.parseInt(request, "num");
	
	acqcmgr.deleteAllAcQComment(num);
	acqmgr.deleteAcQ(num);
%>
<script>
	alert("삭제되었습니다.");
	location.href = "ac_QnA.jsp?ac_num=<%=acnum%>";
</script>