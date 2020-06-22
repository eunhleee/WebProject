<%@ page contentType="text/html; charset=utf-8"%>
<%
		request.setCharacterEncoding("utf-8");
%>
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
google.charts.load("current",{packages:['corechart']});


$.ajax({
dataType:"text",

url:'monthChart.jsp',
success:function(result){
columnChart1(result);
}, 
error:function(request, error){
	alert("에러");
	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
} 
});

$.ajax({
	dataType:"text",

	url:'weekChart.jsp',
	success:function(result){
	columnChart2(result);
	}, 
	error:function(request, error){
		alert("에러");
		alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	} 
	});
	
function columnChart1(arrayList) {
	// 실 데이터를 가진 데이터테이블 객체를 반환하는 메소드
	 
	
	 arrayList = eval('('+arrayList+')');

	var dataTable = new google.visualization.DataTable();
	dataTable.addColumn('string','Month');
	dataTable.addColumn('number','Sales');
	dataTable.addRows(arrayList);
	// 옵션객체 준비
	var options = {
	title: '월별 매출',
	legend: 'top',
	 colors: ['#FCBC7E']
	};
	// 차트를 그릴 영역인 div 객체를 가져옴
	var objDiv = document.getElementById('monthChart');
	// 인자로 전달한 div 객체의 영역에 컬럼차트를 그릴수 있는 차트객체를 반환
	var chart = new google.visualization.ColumnChart(objDiv);
	// 차트객체에 데이터테이블과 옵션 객체를 인자로 전달하여 차트 그리는 메소드
	chart.draw(dataTable, options);
	/* var chart = new google.charts.Bar(objDiv);
	// 차트객체에 데이터테이블과 옵션 객체를 인자로 전달하여 차트 그리는 메소드
	chart.draw(dataTable,google.charts.Bar.convertOptions(options)); */
} // drawColumnChart1()의 끝

function columnChart2(arrayList) {
	// 실 데이터를 가진 데이터테이블 객체를 반환하는 메소드
	 
	
	 arrayList = eval('('+arrayList+')');

	var dataTable = new google.visualization.DataTable();
	dataTable.addColumn('string','Week');
	dataTable.addColumn('number','Sales');
	dataTable.addRows(arrayList);
	// 옵션객체 준비
	var options = {
	title: '주간별 매출',
	legend: 'top',
	 colors: ['#FCBC7E']
	};
	// 차트를 그릴 영역인 div 객체를 가져옴
	var objDiv = document.getElementById('weekChart');
	// 인자로 전달한 div 객체의 영역에 컬럼차트를 그릴수 있는 차트객체를 반환
	var chart = new google.visualization.ColumnChart(objDiv);
	// 차트객체에 데이터테이블과 옵션 객체를 인자로 전달하여 차트 그리는 메소드
	chart.draw(dataTable, options);
	/* var chart = new google.charts.Bar(objDiv);
	// 차트객체에 데이터테이블과 옵션 객체를 인자로 전달하여 차트 그리는 메소드
	chart.draw(dataTable,google.charts.Bar.convertOptions(options)); */
} // drawColumnChart1()의 끝




	
</script>
<style>

</style>
</head>
<body>
	<div>
		<div><h2>총 매출 : </h2></div>
		<div id="chartDiv">
			<div id="monthChart"  style="height: 440px; width:350px;"></div>
			<table>
				<tr>
					<td>
						<div id="weekChart1"  style="height: 440px; width:350px;"></div>
					</td>
					<td>
						<div id="weekChart1"  style="height: 440px; width:350px;"></div>
					</td>
					<td>
						<div id="weekChart1"  style="height: 440px; width:350px;"></div>
					</td>
					<td>
						<div id="weekChart1"  style="height: 440px; width:350px;"></div>
					</td>
				</tr>
				<tr>
					<td>
						<div id="weekChart1"  style="height: 440px; width:350px;"></div>
					</td>
					<td>
						<div id="weekChart1"  style="height: 440px; width:350px;"></div>
					</td>
					<td>
						<div id="weekChart1"  style="height: 440px; width:350px;"></div>
					</td>
					<td>
						<div id="weekChart1"  style="height: 440px; width:350px;"></div>
					</td>
				</tr>
				<tr>
					<td>
						<div id="weekChart1"  style="height: 440px; width:350px;"></div>
					</td>
					<td>
						<div id="weekChart1"  style="height: 440px; width:350px;"></div>
					</td>
					<td>
						<div id="weekChart1"  style="height: 440px; width:350px;"></div>
					</td>
					<td>
						<div id="weekChart1"  style="height: 440px; width:350px;"></div>
					</td>
				</tr>
			</table>
		</div>
		<div id="listDiv">
			
		</div>
	</div>
</body>
</html>