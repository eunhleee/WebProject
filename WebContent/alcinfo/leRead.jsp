<!-- leRead.jsp -->
<%@page import="alcinfo.MemberBean"%>
<%@page import="alcinfo.LessonBean"%>
<%@page import="alcinfo.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="alcinfo.LessonMgr" />
<jsp:useBean id="Mmgr" class="alcinfo.MemberMgr" />

<%
	request.setCharacterEncoding("UTF-8");
	String id = "";
	String url = "LessonMain.jsp";
	LessonBean lebean = null;
	
	if(request.getParameter("id") == null) {
		response.sendRedirect(url);
	
	} else {
		id = request.getParameter("id");
		lebean = mgr.getLesson(id);
		session.setAttribute("lebean", lebean);
		
		lebean.setId(id);
		  
		%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Team Read</title>
<link href="style.css" rel="stylesheet" type="text/css">


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://www.gstatic.com/charts/loader.js"></script>
<script>
	
	function moveQnA(){
			url = "le_QnA.jsp?lq_lnum="+<%=lebean.getNum()%>;
			window.open(url, "Le_QnA", "width=360, height=300, top=300, left=300");
			
		}
		
		
		function insert() // no ';' here
		{
		    var elem = document.getElementById("myButton1");
		    
			location.href="insertStudentProc.jsp?id=<%=id%>&num=<%=lebean.getNum()%>";
			   
		}
		
		function cancel(){
			var elem = document.getElementById("myButton2");
			location.href="deleteStudentProc.jsp?id=<%=id%>&num=<%=lebean.getNum()%>";
		}
		google.charts.load('current',{packages:['bar']});
		google.charts.setOnLoadCallback(drawChart);
		google.charts.setOnLoadCallback(function(){
			setInterval(columnChart1(),30000);
			}); 
		
		function columnChart1(arrayList) {
			// 실 데이터를 가진 데이터테이블 객체를 반환하는 메소드
			var dataTable = google.visualization.arrayToDataTable(arrayList);
			// 옵션객체 준비
			var options = {
			title: '날짜 별 등록 학생수',
			legend: 'top',
			 colors: ['#FCBC7E']
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
		url:'columnChart1.jsp?id=<%=id%>',
		success:function(result){
		columnChart1(result);
		}
		});
	}
	function goReport() {
		url = "reportReceiptLInf.jsp?stopid="+<%=id%>;
		window.open(url, "GoReport", "width=360, height=300, top=200, left=300");
	}
		
	

	
</script>

</head>
<body>

	<%@ include file="headerSearch.jsp"%>
	<br>
	<br>
	<form name="cart" action="">
		<table width="70%" align="center">
			<tr>
				<td align="center">
					<table width="100%" border="1"
						style="font-size: 20; background: rgb(250, 248, 235);">
						<tr>
							<td width="25%" align="center"><img src="img/banner1.jpg"
								width="100%" height="250"></td>
							<td width="60%" height="100%">
								<table width="100%" border="1" style="font-size: 20;">
									<tr height="40">
										<td width="30%">선생님명 / 성별</td>
										<td width="70%"><%=lebean.getName()%> / <%=lebean.getGender() %></td>
									</tr>
									<tr height="40">
										<td width="30%">과외가능지역</td>
										<td width="70%"><%=lebean.getArea() %></td>
									</tr>
									<tr height="40">
										<td width="30%">전화번호</td>
										<td width="70%"><%=lebean.getPhone() %></td>
									</tr>
									<tr height="35">
										<td width="30%">과외 가능한 과목</td>
										<td width="70%"><%=lebean.getLeclass() %></td>
									</tr>
									<tr height="35">
										<td width="30%">과외중인 학생 수</td>
										<td width="70%"><%=lebean.getStudent() %>명</td>
									</tr>
									<tr height="40">
										<td width="30%">재학(졸업)중인 학교</td>
										<td width="70%"><%=lebean.getSchool_name() %></td>
									</tr>
									<tr height="40">
										<td width="30%">비고</td>
										<td width="70%"><%=lebean.getEtc() %></td>
									</tr>

								</table>
							</td>
							<td width="15%" align="center">
								<table name="buttonTable">
									<tr>
										<td><input type="button" value="문의하기"
											style="font-size: 20;" onclick="moveQnA();"></td>
									</tr>
									<tr>
										<td><input type="button" value="잘못된정보 신고하기"
											style="font-size: 20;" onclick="goReport();"></td>
									</tr>
									<tr>
										<td><input type="button" value="신청하기" id="myButton1"
											style="font-size: 20;" onclick="insert()"></input>
											</td>
									</tr>
									<tr>
										<td><input type="button" value="취소하기" id="myButton2"
											style="font-size: 20;" onclick="cancel()"></input>
											</td>
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
		<table width="70%" height="300" align="center" border="1">
			<tr>
				<td width="30%" align="center">
				<button type="button" id="btn" onclick="graph()" >그래프 보기</button>
				<div id="column_chart_div1"  style="height: 500px;"></div>
				</td>
				<td width="70%" align="center">
					<jsp:include page="lessonAskList.jsp"></jsp:include>
				</td>
			</tr>
		</table>
		<br>
	</form>
</body>
<%@ include file="footer.jsp"%>
</html>
<%
	}
%>