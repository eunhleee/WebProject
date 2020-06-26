<!-- requestAclist.jsp -->
<%@page import="alcinfo.LeteaBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="alcinfo.UtilMgr"%>
<%@page import="alcinfo.AcademyBean"%>
<%@page import="java.util.Vector"%>
<%@page import="alcinfo.LeteaBean"%>

<jsp:useBean id="aMgr" class="alcinfo.AcademyMgr" />
<%
	request.setCharacterEncoding("UTF-8");
	if(session.getAttribute("idKey")==null||session.getAttribute("idKey").equals("")){
		response.sendRedirect("../alcinfo/cards-gallery.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>학원장 신청목록</title>
<meta charset="UTF-8">
<script type="text/javascript">
function noPermit(aca_id,aca_state,aca_num,name){
	document.permitFrm.name.value=name;
    document.permitFrm.aca_state.value=aca_state;
    document.permitFrm.aca_num.value=aca_num;
    document.permitFrm.aca_id.value=aca_id;
	document.permitFrm.action="requestAclistProc.jsp?flag=noPermit&name="+name;
	document.permitFrm.submit();
}
function Permit(aca_id,aca_state,aca_num,name){
	document.permitFrm.name.value=name;

	document.permitFrm.aca_id.value=aca_id;
    document.permitFrm.aca_state.value=aca_state;
    document.permitFrm.aca_num.value=aca_num;
	document.permitFrm.action="requestAclistProc.jsp?flag=Permit&name="+name;
	document.permitFrm.submit();
}
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
.tablelist
{
	border:10px solid #36ada9;
	padding-left:50px;
	padding-right:50px;
	margin-top:10px;
	margin-bottom:10px;
	
	margin-left:10px;
	margin-right:10px;
	border-radius:10px;
	
}
.wrapper{
display:grid;
  grid-template-columns: 1fr 1fr;


}
#listtable{
	padding:15px; 

	border:5px solid #36ada9;
	border-radius:10px;

}
#content{
	margin : auto;
  	width: 100%;
  	border: 10px solid #36ada9; 
	border-radius:10px;
	margin-top:50px;
}
#list td {
	border-bottom: 1px solid lightgray;
	height:30px;
}

#title td {
	height:30px;
	color: white;
	background-color: #36ada9;
}
a {
	text-decoration: none;
	color: black;
}
a:hover {
	color: gray;
}
#nav_table tr {
	border:5px solid #56C8D3;
}

#nav_td {
	text-align: center;
	width:330px;
	height: 100px;
	border: none;
	
}

#nav_td a {
	color: black;
	text-decoration: none;
}

#nav_td a:hover {
	color: white;
	font-weight: bold;
}

#nav_td:hover {
	background-color: #56C8D3;
}
#graphList{
	width:70%;
}

#novalue{
	margin-bottom:50px;
	margin-top:50px;
	padding:50px; 
	text-algin:center; 
	background-color:#FBC1AD;
	color:White;	
	border: none;
	border-radius:20px;
	font-weight: bold;	
}
.nulltable{
border:10px solid #36ada9;
border-radius:10px;
padding-bottom:50px;
padding-top:50px;
margin-bottom:50px;
margin-top:50px;

}
</style>
</head>
<body>

<jsp:include page="../alcinfo/headerSearch.jsp" />
	<div id="frame" >
		<div id="container" align="center">
			<div id="total" align="center">
				<table id="nav_table">
					<tr>
						<td id="nav_td"><a href="../Mypage/managerPage.jsp?pageValue=salesList">매출 현황</a></td>
						<td id="nav_td"><a href="../Mypage/managerPage.jsp?pageValue=memberChart">회원 현황</a></td>
						<td id="nav_td"><a href="../Report/MGMemberControl.jsp">신고 접수건</a></td>
						<td id="nav_td"><a href="../Report/StateManagement.jsp">회원 관리</a></td>
						<td id="nav_td"><a href="../Mypage/requestAclist.jsp">학원장 접수 관리</a></td>
						
					</tr>
				</table>
			</div>



<table>
<%
	Vector<AcademyBean> mvlist=aMgr.mGMList();
	int listStze = mvlist.size();
	if(mvlist.isEmpty()){
		%>
		<table width="70%" class="nulltable">
			<tr>
				<td align="center" colspan="2">
				 신청된 것이 없습니다.
				</td>
			</tr>
		</table>
	<%}else{
		for(int i=0;i<mvlist.size();i++){
		AcademyBean mbean=mvlist.get(i);
		if(i%2==0){%>
		<tr><%}%>
			<td>
				<div>
		<table class="tablelist">
			<tr>
			<td>
			<tr>
				<td style="width:60px; margin-bottom:20px;"><h2><%=mbean.getNum()%></h2></td>
			</tr>
			<tr>
				<td colspan="2">
				<div class="wrapper" >			
				<div>
				<img src="../authority/<%=mbean.getAca_business()%>" style="margin-bottom:10px;width:250px; height:200px; "><br>
				</div>
				<div>
				<img src="../authority/<%=mbean.getAca_identity()%>" style="margin-bottom:10px;width:250px; height:200px; "><br>
				</div>
				</div>
				</td> 
			</tr>
			<tr>
				<td style="width:60px;" name="aca_id">아이디</td>
				<td style="width:250px;"><%=mbean.getAca_id()%></td>
			</tr>
			<tr>
				<td style="width:60px;" name="aca_num">학원번호</td>
				<td style="width:250px;"><%=mbean.getAca_num()%></td>
			</tr>
			<tr>
				<td style="width:60px;" name="aca_name">학원이름</td>
				<td style="width:250px;"><%=mbean.getAca_name()%></td>
			</tr> 
			<tr>
				<td style="width:60px;" name="aca_state">상태</td>
				<td style="width:250px;"><%=mbean.getAca_state()%></td>
			</tr>
			<tr>
				<td colspan="2" align="right" style="padding-top:15px; padding-bottom:30px; " >
				<input type="submit" value="비허가"
				 onclick="noPermit('<%=mbean.getAca_id()%>','<%=mbean.getAca_state()%>','<%=mbean.getAca_num()%>','<%=mbean.getName()%>')">
				<input style="margin-right:30px;" type="submit" value="허가" 
				onclick="Permit('<%=mbean.getAca_id()%>','<%=mbean.getAca_state()%>','<%=mbean.getAca_num()%>','<%=mbean.getName()%>')">
				</td>
			</tr>
		</table>
				</div>
			</td>
		<%if(i%2==1){%>
		</tr>
<%}}}%>
</table>
</div>
<form name="permitFrm" method="post">
		<input type="hidden" name="aca_num">
		<input type="hidden" name="aca_id">
		<input type="hidden" name="aca_state">
</form>
		<jsp:include page="../alcinfo/footer.jsp" />
</div> b
</body>
</html>