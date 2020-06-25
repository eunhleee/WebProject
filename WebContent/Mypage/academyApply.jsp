<!-- academyApply.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="aMgr" class="alcinfo.AcademyMgr"/>
    <jsp:useBean id="mgr" class="alcinfo.MemberMgr"/>
     <%@page import="alcinfo.MemberBean"%>
    <jsp:useBean id="amgr" class="alcinfo.AcademyMgr"/>
    <jsp:useBean id="lmgr" class="alcinfo.LeteaMgr"/>
    <%@page import="alcinfo.LeteaBean"%>
    
<!DOCTYPE html>
  
<%
if(session.getAttribute("idKey")==null||session.getAttribute("idKey").equals("")){
	response.sendRedirect("../alcinfo/cards-gallery.jsp");
	}
	else{
	String id=(String)session.getAttribute("idKey");
	MemberBean bean=mgr.getUpMember(id);
	LeteaBean gbean=lmgr.getgrade(id);
	int grade=gbean.getGrade();	%>
<html>
<head>
<script type="text/javascript">
function setChildValue(name,num){
	   document.acapply.name.value=name;
	   document.acapply.num.value=num;
}
function acquestion(id){
	msg="선생님으로 권한을 변경하시겠습니까?";
	if(confirm(msg)){
		<%
		amgr.Uptea(id);
	    session.setAttribute("idgrade",bean.getGrade());
		%>
		alert("변경되셨습니다.");
		window.location.reload();
	}else{
		
	}
}
function goAclist() {
    window.name = "parentForm";
 	url = "../Mypage/acSearch.jsp";
	window.open(url, "childForm", "width=620, height=460, top=200, left=300"); 
}

</script>
<meta charset="UTF-8">
<title>학원장 신청(권한변경)</title>
<style>
#totalframe{
	background-color:#FAF8EB;
	display:flex;
	width:96.5%;
	height:100%;
	padding:30px;
	
}

#categoryframe{
	margin-left:250px;
	margin-right:30px;
	flex:1;
	border:10px solid #FCBC7E;
	border-radius:15px;
	background-color:white;
	width:100px;
	height:300px;
	padding:30px 0px;
}

#atag {
	width:150px;
 	height:40px;
 	line-height:40px;
 	display: block;
 	margin-left:50px;
 }
 
 
#atag:hover{
 	background-color:#FAF8EB;
 	border-radius: 10px;
 }
 
#atag a {
	text-decoration: none;
	color: black;
}

#atag a:hover {
	color: gray;
}

#insertMember{
	padding:0px 150px;
	flex:4;
}

#imFrm{
	width:900px;
}

#inputdiv{
	background-color:white;
}
#btnJoin{
  background:#FCBC7E;
  color:#fff;
  border:none;
  position:relative;
  width:90px;
  height:50px;
  font-size:17px;
  line-height:50px;
  cursor:pointer;
  transition:800ms ease all;
  outline:none;
  border-radius: 6px;
}
#btnJoin:hover{
  background:#fff;
  color:#FCBC7E;
}
#btnJoin:before,#btnJoin:after{
  content:'';
  position:absolute;
  top:0;
  right:0;
  height:2px;
  width:0;
  background:#FCBC7E;
  transition:400ms ease all;
}
#btnJoin:after{
  right:inherit;
  top:inherit;
  left:0;
  bottom:0;
}
#btnJoin:hover:before,#btnJoin:hover:after{
  width:100%;
  transition:800ms ease all;
}
input {
	-webkit-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	-moz-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	-ms-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	-o-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	margin: 20px auto;
	max-width: 180px;
	text-decoration: none;
	border-radius: 4px;
 	padding: 5px 10px;
 }

input.btns {
	font-weight:bold; 
	color: rgba(76, 76, 76, 0.6);
	box-shadow: rgba(248, 140,101, 0.4) 0 0px 0px 2px inset;
}
input.btns:hover {
	font-weight:bold; 

	color: rgba(255, 255, 255, 0.85);
	box-shadow: rgba(248, 140,101, 0.7) 0 0px 0px 40px inset;
}

</style>
</head>
<body>
<jsp:include page="../alcinfo/headerSearch.jsp"></jsp:include>
<div id="totalframe">
<div id="categoryframe">
	<h3 style="margin-left:50px;">마이 페이지</h3>
<div id="atag"><a href="../Mypage/upTeacher.jsp">&#149; 개인 정보 수정</a></div>
	<div id="atag"><a href="../Mypage/myBoard.jsp">&#149; 내가 쓴 글</a></div>
	<div id="atag"><a href="../Mypage/MyReportList.jsp">&#149; 나의 신고</a></div>
	<div id="atag"><a href="../Mypage/myStudent.jsp">&#149; 내가 신청한 학생</a></div>
	<div id="atag"><a href="../Mypage/myReceiveStudent.jsp">&#149; 과외 신청함</a></div>
	<% 
		if(grade==2){	
	%>
		<div id="atag"><a href="../Mypage/academyApply.jsp">&#149; 권한 변경 신청</a></div>
	<%
		}
		else if(grade==3){%>
		<div id="atag"><a href="javascript:void(0);" onclick="javascript:acquestion();">&#149; 권한 변경 신청</a></div>
		<%}
	%>
	<% 
	
		if(bean.getGrade()==2){	
	%>
		<div id="atag"><a href="../Mypage/academyApply.jsp">&#149; 권한 변경 신청</a></div>
	<%
		}
		else if(bean.getGrade()==3){%>
		<div id="atag"><a href="javascript:void(0);" onclick="javascript:acquestion();">&#149; 권한 변경 신청</a></div>
		<%}
	%>
	
</div>
<div id="insertMember">
<form name="acapply" method="post" action="acApplyProc.jsp?flag=insert" enctype="multipart/form-data">
<table>
	<tr>
		<td colspan="3"><h3>권한변경</h3></td>
	</tr>
	<tr>
	<td width="80">아이디</td>
	<td width="120"><input id="inputdiv" type="text" name="ac_id" value="<%=session.getAttribute("idKey")%>" readonly="readonly"></td>
	</tr>	
	<tr>
		<td>학원검색</td>

			<td colspan="3">
		<input id="inputdiv" type="text" name="num" id="num" readonly="readonly">
		<input id="inputdiv" type="text" name="name" id="name" readonly="readonly">
		<input class="btns" type="button" onclick="goAclist();" value="검색"></td>

	</tr>
	<tr>
	<td colspan="4" style="padding-bottom:20px; padding-top:20px;"><strong>* 사진파일만 넣어주세요! 잘못된 정보를 입력하시면 신청이 취소되실 수 있습니다.</n></td>
	</strong></tr>
	<tr> 
		<td >신분증</td>
		<td><input type="file" name="identity"></td>
	</tr>
	<tr> 
		<td >사업자 파일</td>
		<td><input type="file" name="business"></td>
	</tr>
	<tr>
		<td colspan="3" align="right">
		<input style="margin-right:33px;" class="btns" type="submit" value="접수" onclick="send()">
		</td>
	</tr>
</table>
</form>
<%} %>
</div>
</div>
</body>
</html>