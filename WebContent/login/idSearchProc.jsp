<!-- idSearchProc.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="ismgr" class="member.MemberMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	String isname = request.getParameter("isname");
	String isphone = request.getParameter("isphone");
	String isid = ismgr.idSearch(isname, isphone);
	
%>
<html>
<head>
<title>ID 찾기</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFCC">
<div align="center">
<br/>
<%
		if(isid==null){
			out.println("정보와 일치하는 아이디가 없습니다.<p/>");
		}else{
			out.println("아이디는 " + isid + " 입니다.<p/>");
		}
%>
<a href="#" onclick="self.close()">닫기</a>
</div>
</body>
</html>