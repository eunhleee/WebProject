<!-- acApplyProc.jsp -->
<%@page import="alcinfo.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <jsp:useBean id="pMgr" class="alcinfo.AcademyMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	String flag= request.getParameter("flag");
	String msg="오류가 발생하였습니다.";
	boolean result=false;
	if(flag.equals("insert")){
		result=pMgr.insertProduct(request);
		if(result) msg="신청이 완료되었습니다.";
	}
%>
<script>
	alert("<%=msg%>");
	location.href="academyApply.jsp";
</script>