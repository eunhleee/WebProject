<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="alcinfo.*"%>
<jsp:useBean id="amgr" class="alcinfo.AcademyMgr" />
<jsp:useBean id="abean" class="alcinfo.AcademyBean"/>
<jsp:useBean id="mbean" class="alcinfo.MemberBean"/>
<jsp:useBean id="lbean" class="alcinfo.LeteaBean"/>

<jsp:setProperty property="*" name="abean"/>
<%
	
	request.setCharacterEncoding("UTF-8");
	String flag= request.getParameter("flag");
	abean.setName(request.getParameter("name"));
	abean.setAca_id(request.getParameter("aca_id"));
	abean.setAca_state(request.getParameter("aca_state"));
	MemberBean ebean=amgr.getPhone(request.getParameter("aca_id"));
	String name=request.getParameter("name");

	String msg="오류가 발생하였습니다.";
  	if(flag.equals("Permit")){		
			msg="허가하였습니다.";
		 	amgr.Upstate((String)request.getParameter("aca_id"),"완료");
			amgr.Upac((String)request.getParameter("aca_id"));
			amgr.Upacnum((String)request.getParameter("aca_id"),Integer.parseInt(request.getParameter("aca_num")));

			Smssend.send("[우리학원어디]\n"+request.getParameter("name")+"님의 학원장 자격이 승인되셨습니다.", ebean.getPhone());
	}
	if(flag.equals("noPermit")){
		 /* if(result)  */ {
			 msg="허가하지 않았습니다.";
			   amgr.Upstate((String)request.getParameter("aca_id"),"거절");

			Smssend.send("[우리학원어디]\n"+request.getParameter("name")+"님의 학원장 자격이 거절되셨습니다.", ebean.getPhone());
 
		 }
	} 

%>
<script>
	alert("<%=msg%>");
	location.href="requestAclist.jsp";
</script>