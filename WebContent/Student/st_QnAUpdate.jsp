<!-- st_QnAUpdate.jsp -->
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="alcinfo.StinqueryBean"%>
<%@page import="alcinfo.StQcommentsBean"%>
<%@page import="alcinfo.MemberBean"%>
<%@page import="java.util.Vector"%>
<%@page import="alcinfo.StudentBean"%>
<%@page import="alcinfo.LeteaBean"%>
<%@page import="alcinfo.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="alcinfo.StudentMgr" />
<jsp:useBean id="Lmgr" class="alcinfo.LeteaMgr" />
<jsp:useBean id="Rmgr" class="alcinfo.ReportMgr" />
<jsp:useBean id="stqmgr" class="alcinfo.StinqueryMgr"/>
<jsp:useBean id="stqcmgr" class="alcinfo.StQcommentsMgr"/>

<%
	request.setCharacterEncoding("UTF-8");
	int stunum = Integer.parseInt(request.getParameter("stunum"));
	MemberBean mbean=Rmgr.getStuId(stunum);
	StudentBean stbean = mgr.getStudent(stunum);

	int num = UtilMgr.parseInt(request, "num");
	String nowPage = request.getParameter("nowPage");	
	String numPerPage = request.getParameter("numPerPage");	
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	String stqid = (String)session.getAttribute("idKey");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    Calendar today = Calendar.getInstance();
 	String strToday = sdf.format(today.getTime());
 	
	StinqueryBean stqbean = (StinqueryBean)session.getAttribute("bean");
	String title = stqbean.getTitle();
	String id = stqbean.getId();
	String content = stqbean.getContent();
	String secret = stqbean.getSt_secret();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>우리 학원 어디?-학생 문의</title>
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
#list td {
	border-bottom: 1px solid lightgray;
}

#title td {
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
.stqReply {
	display:none;
}
#inputdiv2{
	margin:10px;
	width:490px;
	border:1px solid gray;
	border-radius: 6px;
	padding:3px;
}
#inputdiv2 input{
	width:480px;
	border:none;
	font-size:15px;
}

#inputdiv3{
	margin:10px;
	width:200px;
	border:1px solid gray;
	border-radius: 6px;
	padding:3px;
}

#inputdiv3 input{
	width:180px;
	border:none;
	font-size:15px;
	
}

#textareadiv{
	margin:10px;
	width:490px;
	border:1px solid gray;
	border-radius: 6px;
	padding:3px;
}
#textareadiv textarea{
	border:none;
	font-size:15px;
	width:480px;
}
</style>
<link href="style.css" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://www.gstatic.com/charts/loader.js"></script>
<script>

function insert() // no ';' here
{
    var elem = document.getElementById("myButton1");
    location.href="insertTeaProc.jsp?stunum=<%=stunum%>";
}
function deleteT(){
	var elem = document.getElementById("myButton2");
    location.href="deleteTeaProc.jsp?stunum=<%=stunum%>";
	
}

google.charts.load('current',{packages:['corechart']});
google.charts.setOnLoadCallback(drawChart);
google.charts.setOnLoadCallback(function(){
	setInterval(columnChart1(),30000);
	}); 

function columnChart1(arrayList) {
	// 실 데이터를 가진 데이터테이블 객체를 반환하는 메소드
	var dataTable = google.visualization.arrayToDataTable(arrayList);
	// 옵션객체 준비
	var options = {
	title: '날짜 별 등록 선생님 수'
	};
	// 차트를 그릴 영역인 div 객체를 가져옴
	var objDiv = document.getElementById('column_chart_div1');
	// 인자로 전달한 div 객체의 영역에 컬럼차트를 그릴수 있는 차트객체를 반환
	var chart = new google.charts.Bar(objDiv);
	// 차트객체에 데이터테이블과 옵션 객체를 인자로 전달하여 차트 그리는 메소드
	chart.draw(dataTable,google.charts.Bar.convertOptions(options));
} // drawColumnChart1()의 끝


function graph(){
	
		$.ajax({
		url:'columnChart2.jsp?stunum=<%=stunum%>',
		success:function(result){
		columnChart1(result);
		}
		});
		document.getElementById("btn").value='그래프 숨기기';
	
}

function goReport() {
	url = "../Report/reportReceiptLInf.jsp?stopid="+<%=mbean.getId()%>;
	window.open(url, "GoReport", "width=360, height=300, top=200, left=300");
}


</script>

</head>
<body>
<%@ include file="../alcinfo/headerSearch.jsp"%>
	<br>
	<br>
	<form name="cart" action="">
		<table width="70%" align="center">
			<tr>
				<td align="center">
					<table width="100%" style="font-size: 20; background: rgb(250, 248, 235);">
						<tr>
							<td width="25%" align="center">
							<img src="../StudentImg/<%=stbean.getImgname() %>" width="100%" height="250"></td>
							<td width="60%" height="100%">
								<table width="100%" style="font-size: 20;">
									<tr height="40">
										<td width="30%">학생명 / 성별</td>
										<td width="70%"><%=stbean.getName()%> / <%=stbean.getGender() %></td>
									</tr>
									<tr height="40">
										<td width="30%">원하는지역</td>
										<td width="70%"><%=stbean.getAddress() %></td>
									</tr>
									<tr height="40">
										<td width="30%">전화번호</td>
										<td width="70%"><%=stbean.getPhone() %></td>
									</tr>
									<tr height="35">
										<td width="30%">원하는과목</td>
										<td width="70%"><%=stbean.getStclass() %></td>
									</tr>
									<tr height="40">
										<td width="30%">재학중인 학교 / 학년</td>
										<td width="70%"><%=stbean.getSchool_name() %> / <%=stbean.getSchool_grade() %></td>
									</tr>
									<tr height="40">
										<td width="30%">비고</td>
										<td width="70%"><%=stbean.getEtc() %></td>
									</tr>

								</table>
							</td>
							<td width="15%" align="center">
								<table>
									
									<tr>
										<td><input type="button" value="잘못된정보 신고하기"
											style="font-size: 20;" onclick="goReport();"></td>
									</tr>
									<tr>
										<td><input type="button" value="신청하기" id="myButton1"
											style="font-size: 20;" onclick="insert();"></td>
									</tr>
									<tr>
										<td><input type="button" value="취소하기" id="myButton2"
											style="font-size: 20;" onclick="deleteT();"></td>
									</tr>								
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>
		<br>
		<br>
		<table width="70%" height="280" align="center" >
			<tr>
				<td width="30%" align="center">
				<div style="border:10px solid #FCBC7E; border-radius:15px; padding:20px">
				<button type="button" id="btn" onclick="graph()" >그래프 보기</button>
				<div id="column_chart_div1" style="height: 440px;"></div>
				</div>
				</td>
				<td width="70%" align="center">
				
				<!-- 글수정 Start -->
				
					<div style="border:10px solid #36ada9; border-radius:15px; padding:20px">
					<h2><img src="../img/questionmark.png" width="40" height="40">&nbsp;문의 하기</h2>	
					<hr style="border:1px solid #36ada9;">
					<form name="stqupdateFrm" method="post" action="st_QnAUpdateProc.jsp">
					<table width="800" cellpadding="4">
						<tr>
							<td align=center>
							<table align="center">
							<tr>
								<td>작성자</td>
								<td>
								<div id="inputdiv3">
								<input size="50" maxlength="30" disabled="disabled"
								value="<%=stqid%>">
								</div>
								</td>
								<td>작성일</td>
								<td>
								<div id="inputdiv3">
								<input size="50" maxlength="30" disabled="disabled"
								value="<%=strToday%>">
								</div>
								</td>
							</tr>
								<tr>
									<td>제 목</td>
									<td colspan="3"><div id="inputdiv2">
										<input name="stqtitle" size="50" maxlength="30" value="<%=title%>">
									</div></td>
								</tr>
								<tr>
									<td>내 용</td>
									<td colspan="3"><div id="textareadiv">
										<textarea name="stqcontent" rows="10" cols="50"><%=content%></textarea>
									</div></td>
								</tr>
								<tr>
					    			<td colspan="1">
					    			비밀글
									</td>
									<td colspan="3"><input type="checkbox" name="stqsecret" 
									id="checkbox" <% if(secret!=null) {%>checked<%} %>></td>
					    		</tr>
								<tr>
									<td colspan="4" align="center">
										 <input type="submit" value="수정">
										 <input type="reset" value="다시쓰기">
										 <input type="button" value="취소" 
										 onClick="javascript:location.href='st_QnARead.jsp?num=<%=num%>&stunum=<%=stunum%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
			  	 	if(!(keyWord==null||keyWord.equals(""))){
					     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>'">
									</td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					 <input type="hidden" name="stqid" value="<%=id%>">
					 <input type="hidden" name="acrip" value="<%=request.getRemoteAddr()%>">
					 <input type="hidden" name="nowPage" value="<%=nowPage %>">
					 <input type="hidden" name="num" value="<%=num%>">
					 <input type='hidden' name="stunum" value="<%=stunum%>">
					 <input type='hidden' name="numPerPage" value="<%=numPerPage%>">
					 <%
				  	 	if(!(keyWord==null||keyWord.equals(""))){
				     %>
				     <input type="hidden" name="keyField" value="<%=keyField%>">
				     <input type="hidden" name="keyWord" value="<%=keyWord%>">
				 	 <%
						}
					 %>
					</form>
					</div>
					
					<!-- 글수정 End -->

				</td>
			</tr>
		</table>
		<br>
</body>
<%@ include file="../alcinfo/footer.jsp"%>
</html>