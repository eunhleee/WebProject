  <!-- 학생의 정보창 -->
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

<%
	request.setCharacterEncoding("UTF-8");
	int stunum = 0;
	String url = "StudentMain.jsp";
	StudentBean stbean = null;
	int num=Integer.parseInt(request.getParameter("stunum"));
	MemberBean mbean=Rmgr.getStuId(num);
	//System.out.println("학생의 아이디는"+mbean.getId());

	if(request.getParameter("stunum") == null) {
		//response.sendRedirect(url);
	} else if (!UtilMgr.isNumeric(request.getParameter("stunum"))) {
		response.sendRedirect(url);
	} else {
		stunum = Integer.parseInt(request.getParameter("stunum"));
		//한준씨 getStudent 메소드 수정함
		stbean = mgr.getStudent(stunum);
		stbean.setNum(stunum);
		mgr.upStCount(num); // 조회수 증가
		%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>우리 학원 어디?-학생 문의</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<link href="style.css" rel="stylesheet" type="text/css">

<script>

google.charts.load("current",{packages:['corechart']});
google.charts.setOnLoadCallback(columnChart1);

function columnChart1(arrayList) {
	// 실 데이터를 가진 데이터테이블 객체를 반환하는 메소드
	 
	 arrayList = eval('('+arrayList+')');

	var dataTable = new google.visualization.DataTable();
	dataTable.addColumn('string','Date');
	dataTable.addColumn('number','register');
	dataTable.addRows(arrayList);
	// 옵션객체 준비
	var options = {
	title: '날짜 별 등록 선생님수',
	legend: 'top',
	 colors: ['#FCBC7E']
	};
	// 차트를 그릴 영역인 div 객체를 가져옴
	var objDiv = document.getElementById('column_chart_div1');
	// 인자로 전달한 div 객체의 영역에 컬럼차트를 그릴수 있는 차트객체를 반환
	var chart = new google.visualization.ColumnChart(objDiv);
	// 차트객체에 데이터테이블과 옵션 객체를 인자로 전달하여 차트 그리는 메소드
	chart.draw(dataTable, options);
	/* var chart = new google.charts.Bar(objDiv);
	// 차트객체에 데이터테이블과 옵션 객체를 인자로 전달하여 차트 그리는 메소드
	chart.draw(dataTable,google.charts.Bar.convertOptions(options)); */
} // drawColumnChart1()의 끝

function graph(){
	$.ajax({
	dataType:"text",
	
	url:'columnChart2.jsp?stunum=<%=stunum%>',
	success:function(result){
	columnChart1(result);
	},  
	error:function(request, error){
		alert("에러");
		alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	} 
	});
}
function insert() // no ';' here
{
    var elem = document.getElementById("myButton1");
    location.href="insertTeaProc.jsp?stunum=<%=stunum%>&phone=<%=stbean.getPhone()%>";
}
function deleteT(){
	var elem = document.getElementById("myButton2");
    location.href="deleteTeaProc.jsp?stunum=<%=stunum%>&phone=<%=stbean.getPhone()%>";
	
}

 

function goReport() {
	url = "../Report/reportReceiptSInf.jsp?stopid=<%=mbean.getId()%>";
	window.open(url, "GoReport", "width=900, height=560, top=200, left=300");
}
	
function goErr(){
	alert("로그인을 해주세요");

}

</script>
<style>
.totalFrame{
	background-color:#FAF8EB;
	margin-top:-40px;
	padding:40px 0px;
}
.subFrame{
	width:70%;
	border:1px solid gray;
	background-color:white;
	padding:30px 30px;
	margin-bottom:40px;
}
.tdBorder{
	border-right:3px solid #F88C65;
}
</style>
</head>
<body>
	<%@ include file="../alcinfo/headerSearch.jsp"%>
	<br>
	<br>
	<div class="totalFrame" align="center">
	<div class="subFrame">
	<form name="cart" action="">
		<table width="100%" >
			<tr>
				<td align="center">
					<table width="100%" style="font-size: 20;">
						<tr>
							<td>
								<h1><%=stbean.getName()%> <font style="font-size:25px; color:lightgray;">학생</font></h1>
							</td>
						</tr>
						<tr>
							
							<td width="70%" height="100%">
								<table width="70%" style="font-size: 17px;">
									<tr height="20">
										<td class="tdBorder" width="8%">성별</td>
										<td width="10%">&nbsp;<%=stbean.getGender() %></td>
									
										<td class="tdBorder" width="8%">과목</td>
										<td width="10%">&nbsp;<%=stbean.getStclass() %></td>
										<td class="tdBorder" width="8%">번호</td>
										<td colspan="2">&nbsp;<%=stbean.getPhone()%></td>
										
									</tr>
									<tr height="5"></tr>
									<tr height="20">
										<td class="tdBorder" width="12%">가능 지역</td>
										<td colspan="5">&nbsp;<%=stbean.getAddress() %></td>
									</tr>
									<tr height="5"></tr>
									<tr height="20">
										<td class="tdBorder" width="12%">학교 /학년</td>
										<td colspan="5">&nbsp;<%=stbean.getSchool_name() %> / <%=stbean.getSchool_grade() %></td>
									</tr>
									<tr height="5"></tr>
									<tr height="20">
										<td class="tdBorder" width="8%">비고</td>
										<td colspan="5">&nbsp;<%=stbean.getEtc() %></td>
									</tr>

								</table>
							</td>
							<td width="15%" align="center">
								<table>
									<tr>
										<td><input type="button" value="신청하기" id="myButton1"
											style="font-size: 20;" onclick="insert();"></td>
									</tr>
									<tr>
										<td><input type="button" value="취소하기" id="myButton2"
											style="font-size: 20;" onclick="deleteT();"></td>
									</tr>		
									<tr>
									<%	if(session.getAttribute("idKey")==null||session.getAttribute("idKey").equals("")){ %>
									<td><input type="button" value="잘못된정보 신고하기"
											style="font-size: 20;" onclick="goErr();"></td>
									<%}else{%><td><input type="button" value="잘못된정보 신고하기"
											style="font-size: 20;" onclick="goReport();"></td><%} %>
									</tr>						
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<br>
		<br>
		<table width="70%" height="300" align="center" >
			<tr>
			<td>
			<div style="padding:20px 30px;">
				<img src="../img/<%=stbean.getImgname() %>" width="300" height="250">
			</div>
			</td>
			<td  align="center" rowspan="2">
					<div style="border:10px solid #36ada9; border-radius:15px; padding:20px">
						<jsp:include page="studentAskList.jsp?stunum=<%=stunum %>"/>
					</div>
				</td>
			</tr>
		
			<tr>
				<td  align="center">
				<div style="border:10px solid #FCBC7E; border-radius:15px; padding:20px">
				<button type="button" id="btn" onclick="graph()" >그래프 보기</button>
				<div id="column_chart_div1" style="height: 440px; width:300px;"></div>
				</div>
				</td>
				
			</tr>
		</table>
		<br>
	</form>
	</div>
	<%@ include file="../alcinfo/footer.jsp"%>
</div>
</body>

</html>
<%
	}
%>