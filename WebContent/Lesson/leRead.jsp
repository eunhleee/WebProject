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
	String url = "LessonMain.jsp?pageValue=top";
	LessonBean lebean = null;
	int num = UtilMgr.parseInt(request, "num"); 
	
	if(request.getParameter("id") == null) {
		response.sendRedirect(url);
	} else {
		id = request.getParameter("id");
		lebean = mgr.getLesson(id);
		session.setAttribute("lebean", lebean);
		mgr.upLeCount(num);
		
		lebean.setId(id);
		  System.out.println("선생님아이디는"+id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Team Read</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>


<script>
google.charts.load("current",{packages:['corechart']});

function columnChart1(arrayList) {
	// 실 데이터를 가진 데이터테이블 객체를 반환하는 메소드
	 
	
	 arrayList = eval('('+arrayList+')');

	var dataTable = new google.visualization.DataTable();
	dataTable.addColumn('string','Date');
	dataTable.addColumn('number','register');
	dataTable.addRows(arrayList);
	// 옵션객체 준비
	var options = {
	title: '날짜 별 등록 학생수',
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
	
	url:'columnChart1.jsp?id=<%=id%>',
	success:function(result){
	columnChart1(result);
	}, 
	error:function(request, error){
		alert("에러");
		alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	} 
	});
}
	
	function moveQnA(){
			url = "le_QnA.jsp?lq_lnum="+<%=lebean.getNum()%>;
			window.open(url, "Le_QnA", "width=900, height=560, top=200, left=400");
			
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
		
	
	
	function goReport() {
<<<<<<< HEAD
		url = "../Report/reportReceiptLInf.jsp?stopid=<%=id%>&stopurl=../Lesson/leRead.jsp?num=<%=num%>";
		window.open(url, "GoReport", "width=400, height=350, top=200, left=300");
=======
		url = "../Report/reportReceiptLInf.jsp?stopid=<%=id%>";
		window.open(url, "GoReport", "width=900, height=560, top=200, left=300");
>>>>>>> branch 'master' of https://github.com/eunhleee/WebProject.git
	}
		
	function goErr(){
		alert("로그인을 해주세요");

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
							<img src="../img/<%=lebean.getImgname() %>"	width="100%" height="250">
							</td>
							<td width="60%" height="100%">
								<table width="100%"  style="font-size: 20;">
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
									<%	if(session.getAttribute("idKey")==null||session.getAttribute("idKey").equals("")){ %>
									<td><input type="button" value="잘못된정보 신고하기"
									style="font-size: 20;" onclick="goErr();"></td>
										<%}else{%><td><input type="button" value="잘못된정보 신고하기"
											style="font-size: 20;" onclick="goReport();"></td><%} %>
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
		<table width="70%" height="280" align="center">
			<tr>
				<td width="30%" align="center">
				<div style="border:10px solid #FCBC7E; border-radius:15px; padding:10px">
				<button type="button" id="btn" onclick="graph()" >그래프 보기</button>
				<div id="column_chart_div1"  style="height: 440px; width:350px;"></div>
				</div>
				</td>
				<td width="70%" align="center">
				<div style="border:10px solid #36ada9; border-radius:15px; padding:20px">
					<jsp:include page="lessonAskList.jsp"></jsp:include>
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