
<%@page import="alcinfo.StinsertBean"%>
<%@page import="alcinfo.LeinsertBean"%>
<%@page import="alcinfo.UtilMgr"%>
<%@page import="alcinfo.LeteaBean"%>
<%@page import="alcinfo.ReportBean"%>
<jsp:useBean id="aMgr" class="alcinfo.AcademyMgr" />
<%@page import="java.util.Vector"%>
<jsp:useBean id="mgr" class="alcinfo.StinsertMgr"/>
<jsp:useBean id="lmgr" class="alcinfo.LeteaMgr"/>

<%@ page contentType="text/html; charset=UTF-8"%>
<%
		
		request.setCharacterEncoding("UTF-8");
		if(session.getAttribute("idKey")==null||session.getAttribute("idKey").equals("")){
			response.sendRedirect("../alcinfo/cards-gallery.jsp");
		}
 		String id=(String)session.getAttribute("idKey");
 		LeteaBean gbean=lmgr.getgrade(id);
 		int grade=gbean.getGrade();

%>

<html>
<head>

<title>신청한 과외</title>
<script type="text/javascript">

function acquestion(id){
	msg="선생님으로 권한을 변경하시겠습니까?";
	if(confirm(msg)){
		<%
		aMgr.Uptea(id);
		%>
		alert("변경되셨습니다.");
		window.location.reload();
	}else{
		
	}

</script>
<style>
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
	</div>
    <!--nav-->
  <div id="insertMember" class="insertMember1" align="left">
	
	<div><h2>내가 신청한 학생</h2></div>
		<table >
		<tr>
			<td align="center" colspan="2" width="800">
				<table cellspacing="0"  width="800" >
	
			<tr id="title" align="center">
				<td>학생 이름</td>
				<td>과목</td>
				<td>번호</td>
				<td>상태</td>
				<td>접수 날짜</td>
			</tr>
			<%
				Vector<StinsertBean> vlist = mgr.getMyLessonList(id);
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
			StinsertBean bean=vlist.get(i);
		%>
			<tr id="list" align="center">
			<td><%=bean.getStname()%></td>
			<td><%=bean.getStclass()%></td>
			<td><%=bean.getState()%></td>
			<td><%=bean.getDate()%></td>
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