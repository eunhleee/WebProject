<!-- loginProc.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="lbean" class="alcinfo.MemberBean"/>
<jsp:useBean id="Mmgr" class="member.MemberMgr"/>
<jsp:useBean id="Lmgr" class="alcinfo.LoginMgr"/>
<%@page import="alcinfo.MemberBean"%>

<%
	  request.setCharacterEncoding("UTF-8");
	  String lid = request.getParameter("lid");
	  String lpass = request.getParameter("lpwd");
	  String lmsg = "로그인에 실패 하였습니다.";
	  lbean = Mmgr.loginMember(lid,lpass);
	  String url="../alcinfo/cards-gallery.jsp";
	  boolean lresult = Lmgr.insertLogin(lbean);
	  MemberBean gBean =Mmgr.getGrade(lid);

	  if(lresult){
	    session.setAttribute("idKey",lid);
	    session.setAttribute("idgrade",gBean.getGrade());
	    lmsg = "로그인에 성공 하였습니다.";
	    url=request.getHeader("referer");
	  }
	  
%>
<script>
	alert("<%=lmsg%>");
	location.href = "<%=url%>";
</script>