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
<link href="../login/idpwdstyle.css" rel="stylesheet" type="text/css">
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
<br/>
<%
		if(isid==null){
			out.println("정보와 일치하는 아이디가 없습니다.<p/>");
		}else{
			out.println("아이디는 " + isid + " 입니다.<p/>");
		}
%>
<input type="button" class="loginb" value="닫기" onclick="self.close()">
</div>
</body>
</html>