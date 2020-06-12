<!-- idCheck.jsp -->
<%@ page language="java" 
    pageEncoding="UTF-8"%>
<jsp:useBean id="icmgr" class="member.MemberMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	String icid = request.getParameter("imid");
	boolean icresult = icmgr.checkId(icid);
%>
<html>
<head>
<title>ID 중복체크</title>
</head>
<body>
<div align="center">
<br/><b><%=icid%></b>
<%
		if(icresult){
			out.println("는 이미 존재하는 ID입니다.<p/>");
		}else{
			out.println("는 사용 가능합니다.<p/>");
		}
%>
<a href="#" onclick="self.close()">닫기</a>
</div>
</body>
</html>