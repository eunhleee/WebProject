<!-- leRead.jsp -->
<%@page import="alcinfo.MemberBean"%>
<%@page import="alcinfo.LessonBean"%>
<%@page import="alcinfo.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="alcinfo.LessonMgr" />
<jsp:useBean id="Lmgr" class="alcinfo.LeteaMgr" />
<jsp:useBean id="Mmgr" class="alcinfo.MemberMgr" />

<%
	request.setCharacterEncoding("UTF-8");
	String id = "";
	String url = "LessonMain.jsp?pageValue=top";
	LessonBean lebean = null;
	int num = UtilMgr.parseInt(request, "num"); 
	String logid = (String)session.getAttribute("idKey"); 
	
	if(request.getParameter("id") == null) {
		response.sendRedirect(url);
	} else {
		id = request.getParameter("id");
		lebean = mgr.getLesson(id);
		session.setAttribute("lebean", lebean);
		mgr.upLeCount(num);
		
		lebean.setId(id);		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리 학원 어디?-과외</title>

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
		    
			location.href="insertStudentProc.jsp?id=<%=id%>&num=<%=lebean.getNum()%>&phone=<%=lebean.getPhone()%>";
			   
		}
		
		function cancel(){
			var elem = document.getElementById("myButton2");
			location.href="deleteStudentProc.jsp?id=<%=id%>&num=<%=lebean.getNum()%>&phone=<%=lebean.getPhone()%>";
		}
		
	
	
	function goReport() {
		url = "../Report/reportReceiptLInf.jsp?stopid=<%=id%>";
		window.open(url, "GoReport", "width=900, height=560, top=200, left=300");
	}
		
	function goErr(){
		alert("로그인 후 이용가능합니다.");
	}
	function deleteLesson() {
		location.href = "leDelete.jsp?num=<%=num%>";
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
		<table width="100%" style="margin-bottom:50px;">
			<tr>
				<td align="center">
					<table width="100%" style="font-size: 20;">
						<tr>
							<td>
								<h1><%=lebean.getName()%> <font style="font-size:25px; color:lightgray;">선생님</font></h1>
							</td>
						</tr>
						<tr>
							
							<td width="70%" height="100%">
								<table width="70%" >
									<tr height="20">
										<td class="tdBorder" width="8%">성별</td>
										<td width="10%">&nbsp;<%=lebean.getGender() %></td>
									
										<td class="tdBorder" width="8%">가능지역</td>
										<td width="10%" colspan="4">&nbsp;<%=lebean.getArea() %></td>
								
									</tr>
									<tr height="5"></tr>
									<tr height="20">
										<td class="tdBorder">과목</td>
										<td >&nbsp;<%=lebean.getLeclass() %></td>
									
										<td class="tdBorder">학생 수</td>
										<td width="10%">&nbsp;<%=lebean.getStudent() %>명</td>
									
										<td width="8%" class="tdBorder">출신 학교</td>
										<td width="15%">&nbsp;<%=lebean.getSchool_name() %></td>
									</tr>
									<tr height="5"></tr>
									<tr height="20">
										<td class="tdBorder" width="8%">비고</td>
										<td width="15%">&nbsp;<%=lebean.getEtc() %></td>
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
									<% if(session.getAttribute("idKey")!=null) {
										if(logid.equals(lebean.getId()) || Lmgr.checkM(logid)==0) {
									%>
									<tr>
										<td><input type="button" value="삭제하기" id="myButton3"
										style="font-size: 20;" onclick="deleteLesson();"></td>
									</tr>	
									<% } }%>
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
				<img src="../TeacherImg/<%=lebean.getImgname() %>"	height="250" width="300">
				</div>
			</td>
			<td align="center"  rowspan="2" >
					<div style="border:10px solid #36ada9; border-radius:15px; padding:20px;height:100%;">
					<jsp:include page="lessonAskList.jsp"></jsp:include>
					</div>
				</td>
		</tr>
			<tr>
				<td  align="center">
					<div style="border:10px solid #FCBC7E; border-radius:15px; padding:20px;">
						<button type="button" id="btn" onclick="graph()" >그래프 보기</button>
						<div id="column_chart_div1"  style="height: 400px; width:300px;"></div>
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