
<%@page import="alcinfo.LeinsertBean"%>
<%@page import="alcinfo.UtilMgr"%>
<%@page import="alcinfo.ReportBean"%>
<%@page import="java.util.Vector"%>
<jsp:useBean id="mgr" class="alcinfo.LeinsertMgr"/>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
		request.setCharacterEncoding("UTF-8");
		if(session.getAttribute("idKey")==null||session.getAttribute("idKey").equals("")){
			response.sendRedirect("../alcinfo/cards-gallery.jsp");
		}
 		String id=(String)session.getAttribute("idKey");
%>

<html>
<head>

<title>신청한 과외</title>
<script type="text/javascript">

</script>
<style>
@font-face { 
font-family: 'Godo'; font-style: normal;
font-weight: 400;
src: url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoM.woff2') format('woff2'), 
	url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoM.woff') format('woff'); }
@font-face {
	font-family: 'Godo'; font-style: normal;
	font-weight: 700; 
 	src: url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoB.woff2') format('woff2'),
url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoB.woff') format('woff'); } 
 	.godo * { font-family: 'Godo', sans-serif; }
 body{
 	font-family:'Godo';}
#totalframe{
	background-color:#FAF8EB;
	width:96.5%;
	height:100%;
	padding:30px 50px;
	
}
#insertMember{
	float: right;
	margin-right:400px;
  	width: 800px;
}
#categoryframe{
	margin-left:280px;
	margin-right:80px;
	float:left;
	border:10px solid #FCBC7E;
	border-radius:15px;
	background-color:white;
	width:250px;
	height:300px;
	padding:30px 0px;
}

#atag {
	width:150px;
 	height:40px;
 	line-height:40px;
 	display: block;
 	margin-left:60px;
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

#list td {
	border-bottom: 1px solid lightgray;
	background-color:white;
	height:30px;
	
}

#title td {
	color: white;
	background-color: #F88C65;
}

select{
	font-size:15px;
}

#inputdiv{
	background-color:white;
}


</style>
</head>
<body>
<jsp:include page="../alcinfo/headerSearch.jsp"/>
<div id="totalframe">
	<div id="categoryframe">
		<h3 align="center">마이 페이지</h3>
		<div id="atag"><a href="../Mypage/upMember.jsp">&#149; 개인 정보 수정</a></div>
		<div id="atag"><a href="../Mypage/myBoard.jsp">&#149; 내가 쓴 글</a></div>
		<div id="atag"><a href="../Mypage/MyReportList.jsp">&#149; 나의 신고</a></div>
		<div id="atag"><a href="../Mypage/myLesson.jsp">&#149; 신청한 과외</a></div>
		<div id="atag"><a href="../Mypage/myReceiveLesson.jsp">&#149; 신청 받은 과외</a></div>
	</div>
    <!--nav-->
  <div id="insertMember" class="insertMember1" align="left">
	
	<div><h2>신청한 과외</h2></div>
		<table >
		<tr>
			<td align="center" colspan="2" width="800">
				<table cellspacing="0"  width="800" >
	
			<tr id="title" align="center">
				<td>선생님 성함</td>
				<td>과목</td>
				<td>상태</td>
				<td>접수 날짜</td>
			</tr>
			<%
				Vector<LeinsertBean> vlist = mgr.getMyLessonList(id);
				int listSize = vlist.size();//브라우저 화면에 표시될 게시물 번호
				if(vlist.isEmpty()){
					%>
					<tr>
						<td align="center" colspan="6" height="150" style="background-color:white;">
							<%
						out.println("등록된 게시물이 없습니다.");
					%>
						</td>
					</tr>
					<%
				} else {
		%>
	
		<%for(int i=0;i<listSize;i++){
			LeinsertBean bean=vlist.get(i);
		%>
			<tr id="list" align="center">
			<td><%=bean.getL_teaname()%></td>
			<td><%=bean.getL_teaclass()%></td>
			<td><%=bean.getL_state()%></td>
			<td><%=bean.getL_date()%></td>
			</tr>
			<%}//for%>
		</table>
		<%}//if-else %>
	</tr>
		<tr>
		<td colspan="6"><br><br></td>
	</tr>
	
	</table>
 </div>
</div>

<!-- //frame -->
</body>
</html>