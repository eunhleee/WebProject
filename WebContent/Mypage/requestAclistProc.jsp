<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="alcinfo.*"%>
<jsp:useBean id="amgr" class="alcinfo.AcademyMgr" />
<jsp:useBean id="abean" class="alcinfo.AcademyBean"/>
<jsp:useBean id="mbean" class="alcinfo.MemberBean"/>

<jsp:setProperty property="*" name="abean"/>
<%
	
	request.setCharacterEncoding("UTF-8");
	String flag= request.getParameter("flag");
	abean.setAca_id(request.getParameter("aca_id"));
	abean.setAca_state(request.getParameter("aca_state"));
	MemberBean ebean=amgr.getPhone(request.getParameter("aca_id"));
	System.out.println(flag+"아이디"+request.getParameter("aca_id")+"번호"+ebean.getPhone());

	String msg="오류가 발생하였습니다.";
  	if(flag.equals("Permit")){		
			msg="허가하였습니다.";
			amgr.Upstate((String)request.getParameter("aca_id"),"완료");
			amgr.Upac((String)request.getParameter("aca_id"));
			Smssend.send("[우리학원어디]\n"+request.getParameter("aca_id")+"님의 학원장 자격이 승인되셨습니다.", ebean.getPhone());
		
	}
	if(flag.equals("noPermit")){
		 /* if(result)  */ {
			 msg="허가하지 않았습니다.";
			 amgr.Upstate((String)request.getParameter("aca_id"),"거절");

			Smssend.send("[우리학원어디]\n"+request.getParameter("aca_id")+"님의 학원장 자격이 거절되셨습니다.", ebean.getPhone());

		 }
	} 
 
%>
<script>
	alert("<%=msg%>");
	location.href="requestAclist.jsp";
</script>