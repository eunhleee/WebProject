<!-- nickCheck.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="ncmgr" class="member.MemberMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	String ncnick = request.getParameter("imnick");
	String membernick = ncmgr.memberNick((String)session.getAttribute("idKey"));
	boolean ncresult = ncmgr.checkNickname1(ncnick, membernick);
%>
<html>

<head>
<title>닉네임 중복체크</title>
<link href="../alcinfo/fontStyle.css" rel="stylesheet">

</head>
<body>
<div align="center">
<br/><b><%=ncnick%></b>
<%
		if(ncresult){
			out.println("는 이미 존재하는 닉네임입니다.<p/>");
		}else{
			out.println("는 사용 가능합니다.<p/>");
		}
%>
<a href="#" onclick="self.close()">닫기</a>
</div>
</body>
</html>