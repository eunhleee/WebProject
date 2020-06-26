<!-- nickCheck.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="ncmgr" class="member.MemberMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	String ncnick = request.getParameter("imnick");
	boolean ncresult = ncmgr.checkNickname(ncnick);
%>
<html>
<link href="../alcinfo/fontStyle.css" rel="stylesheet">
<head>
<title>닉네임 중복체크</title>
<style>

@font-face 
{ font-family: 'Godo'; font-style: normal;
 font-weight: 400;
  src: url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoM.woff2') format('woff2'), 
  url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoM.woff') format('woff'); 
  }
  @font-face {
    font-family: 'Godo'; font-style: normal;
     font-weight: 700; 
     src: url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoB.woff2') format('woff2'),
      url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoB.woff') format('woff'); } 
      .godo * { font-family: 'Godo', sans-serif; }
 body{
 font-family:'Godo';
 }
.loginb{
	border:none;
	background-color:#56C8D3;
	border-radius:6px;
	color:white;
}
</style>
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
<input type="button" class="loginb" value="닫기" onclick="self.close()">
</div>
</body>
</html>