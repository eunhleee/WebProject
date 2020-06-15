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
<title>Team Read</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<link href="style.css" rel="stylesheet" type="text/css">

<script>

google.charts.load("current",{packages:['corechart']});

function columnChart1(arrayList) {
	// 실 데이터를 가진 데이터테이블 객체를 반환하는 메소드
	 
	alert(arrayList);
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
    location.href="insertTeaProc.jsp?stunum=<%=stunum%>";
}
function deleteT(){
	var elem = document.getElementById("myButton2");
    location.href="deleteTeaProc.jsp?stunum=<%=stunum%>";
	
}


function goReport() {
	url = "../Report/reportReceiptLInf.jsp?stopid=<%=mbean.getId()%>";
	window.open(url, "GoReport", "width=400, height=350, top=200, left=300");
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
							<img src="../img/<%=stbean.getImgname() %>" width="100%" height="250"></td>
							<td width="60%" height="100%">
								<table width="100%" style="font-size: 20;">
									<tr height="40">
										<td width="30%">학생명 / 성별</td>
										<td width="70%"><%=stbean.getName()%> / <%=stbean.getGender() %></td>
									</tr>
									<tr height="40">
										<td width="30%">원하는지역</td>
										<td width="70%"><%=stbean.getAddress() %> / <%=stbean.getImgname() %></td>
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
		<br>
		<br>
		<table width="70%" height="280" align="center" >
			<tr>
				<td width="30%" align="center">
				<div style="border:10px solid #FCBC7E; border-radius:15px; padding:20px">
				<button type="button" id="btn" onclick="graph()" >그래프 보기</button>
				<div id="column_chart_div1" style="height: 440px; width:300px;"></div>
				</div>
				</td>
				<td width="70%" align="center">
					<div style="border:10px solid #36ada9; border-radius:15px; padding:20px">
						<jsp:include page="studentAskList.jsp?stunum=<%=stunum %>"/>
					</div>
				</td>
			</tr>
		</table>
		<br>
	</form>
</body>
<%@ include file="../alcinfo/footer.jsp"%>
</html>
<%
	}
%>