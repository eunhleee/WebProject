<%@page import="org.json.simple.JSONArray"%>
<%@ page contentType="text/html; charset=utf-8"%>

<jsp:useBean id="mgr" class="alcinfo.PaymentMgr"></jsp:useBean>
<%
	request.setCharacterEncoding("utf-8");
	int total = mgr.totalSales();
	JSONArray monthArray=mgr.getMonthSales();
	String st=monthArray.toString();
	JSONArray[] weekArray=new JSONArray[13];
	String[] weekst=new String[13];
	for(int i=1;i<=12;i++){
		weekArray[i-1]=mgr.getWeekSales(i);
		weekst[i-1]=weekArray[i-1].toString();
		out.print(weekArray[i-1]);
	}
%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->
<!-- <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script> -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
	google.charts.load("current", {packages : ['corechart']});
	google.charts.setOnLoadCallback(columnChart1);
	google.charts.setOnLoadCallback(columnChart2);
	function columnChart1(){
		var dataTable1 = new google.visualization.arrayToDataTable(<%=st%>);
		<%-- dataTable1.addColumn('string', 'Month');
		dataTable1.addColumn('number', 'Sales');
		// 실 데이터를 가진 데이터테이블 객체를 반환하는 메소드
		var arrayList = eval('(' + <%=st%> + ')');
		dataTable1.addRows(arrayList); --%>
		// 옵션객체 준비
		var options = {
			title : '월별 매출',
			legend : 'top',
			colors : [ '#FCBC7E' ]
		};
		// 차트를 그릴 영역인 div 객체를 가져옴
		var objDiv = document.getElementById('monthChart');
		// 인자로 전달한 div 객체의 영역에 컬럼차트를 그릴수 있는 차트객체를 반환
		var chart = new google.visualization.LineChart(objDiv);
		// 차트객체에 데이터테이블과 옵션 객체를 인자로 전달하여 차트 그리는 메소드
		chart.draw(dataTable1, options);
		/* var chart = new google.charts.Bar(objDiv);
		// 차트객체에 데이터테이블과 옵션 객체를 인자로 전달하여 차트 그리는 메소드
		chart.draw(dataTable,google.charts.Bar.convertOptions(options)); */
		// drawColumnChart1()의 끝
	}

	function columnChart2() {
		<% for(int i=0;i<12;i++){%>
		var dataTable1 = new google.visualization.arrayToDataTable(<%=weekst[i]%>);
		// 옵션객체 준비
		var options = {
			title : '월별 매출',
			legend : 'top',
			colors : [ '#FCBC7E' ]
		};
		// 차트를 그릴 영역인 div 객체를 가져옴
		var objDiv = document.getElementById('weekChart<%=i+1%>');
		// 인자로 전달한 div 객체의 영역에 컬럼차트를 그릴수 있는 차트객체를 반환
		var chart = new google.visualization.ColumnChart(objDiv);
		// 차트객체에 데이터테이블과 옵션 객체를 인자로 전달하여 차트 그리는 메소드
		chart.draw(dataTable1, options);
		/* var chart = new google.charts.Bar(objDiv);
		// 차트객체에 데이터테이블과 옵션 객체를 인자로 전달하여 차트 그리는 메소드
		chart.draw(dataTable,google.charts.Bar.convertOptions(options)); */
		// drawColumnChart1()의 끝
		<%}%>
	}
	
</script>
<style>
</style>
</head>
<body>
	<div>
		<div>
			<h2>
				총 매출 :
				<%=total%>
				원
			</h2>
		</div>
		<div id="chartDiv">
			<div id="monthChart" style="height: 440px; width:1000px;"></div>
			<table>
				<tr>
					<td>
						<div id="weekChart1" style="height: 440px; width: 350px;"></div>
					</td>
					<td>
						<div id="weekChart2" style="height: 440px; width: 350px;"></div>
					</td>
					<td>
						<div id="weekChart3" style="height: 440px; width: 350px;"></div>
					</td>
					<td>
						<div id="weekChart4" style="height: 440px; width: 350px;"></div>
					</td>
				</tr>
				<tr>
					<td>
						<div id="weekChart5" style="height: 440px; width: 350px;"></div>
					</td>
					<td>
						<div id="weekChart6" style="height: 440px; width: 350px;"></div>
					</td>
					<td>
						<div id="weekChart7" style="height: 440px; width: 350px;"></div>
					</td>
					<td>
						<div id="weekChart8" style="height: 440px; width: 350px;"></div>
					</td>
				</tr>
				<tr>
					<td>
						<div id="weekChart9" style="height: 440px; width: 350px;"></div>
					</td>
					<td>
						<div id="weekChart10" style="height: 440px; width: 350px;"></div>
					</td>
					<td>
						<div id="weekChart11" style="height: 440px; width: 350px;"></div>
					</td>
					<td>
						<div id="weekChart12" style="height: 440px; width: 350px;"></div>
					</td>
				</tr>
			</table>
		</div>
		<div id="listDiv"></div>
	</div>
	
</body>
</html>