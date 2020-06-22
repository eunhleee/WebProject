<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="alcinfo.*"%>
<jsp:useBean id="amgr" class="alcinfo.AcademyMgr" />
<jsp:useBean id="abean" class="alcinfo.AcademyBean"/>
<jsp:setProperty property="*" name="abean"/>
<%
	
	request.setCharacterEncoding("UTF-8");
	String flag= request.getParameter("flag");
	abean.setAca_id(request.getParameter("aca_id"));
	abean.setAca_state(request.getParameter("aca_state"));
	System.out.println(flag+"아이디"+request.getParameter("aca_id"));
	String msg="오류가 발생하였습니다.";
	boolean result=false;
	boolean result2=false;

	if(flag.equals("Permit")){
		result=amgr.upAcstate(request.getParameter("aca_id"));
		result2=amgr.delAcstate(request.getParameter("aca_id"));
		if(result&&result2) msg="허가하였습니다.";
	}
	if(flag.equals("noPermit")){
		/* if(result)  */msg="허가하지 않았습니다.";
	}

%>
<script>
	alert("<%=msg%>");
	location.href="requestAclist.jsp";
</script>