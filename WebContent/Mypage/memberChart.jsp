<%@page import="org.json.simple.JSONArray"%>
<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="mgr" class="member.MemberMgr"></jsp:useBean>
<jsp:useBean id="Tmgr" class="alcinfo.LeteaMgr"></jsp:useBean>
<%
		request.setCharacterEncoding("utf-8");
		JSONArray ratio=mgr.getRatio();
		String st=ratio.toString();
		int member=mgr.countMember();
		int[] tea=Tmgr.countTea();
		JSONArray countSchool_grade=mgr.countSchool_grade();
		String school_grade=countSchool_grade.toString();
		JSONArray countTeacher=Tmgr.getAge();
		String teacher=countTeacher.toString();
		int total=member+tea[0]+tea[1];
		
%>
<html>
<head>
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      google.charts.setOnLoadCallback(columnChart1);
      google.charts.setOnLoadCallback(columnChart2);
      function drawChart() {
        var data = google.visualization.arrayToDataTable(<%=st%>);

        var options = {
          title: '성별 비율',
          pieHole: 0.2,
          colors:['#0099FF','#FF6699']
        };

        var chart = new google.visualization.PieChart(document.getElementById('donutChart'));
        chart.draw(data, options);
      }
      

  	function columnChart1() {
  		
  		var dataTable1 = new google.visualization.arrayToDataTable(<%=school_grade%>);
  		// 옵션객체 준비
  		var options = {
  			title : '학교 구분 별 학생 수',
  			legend : 'top',
  			colors : [ '#FFCC00' ]
  		};
  		// 차트를 그릴 영역인 div 객체를 가져옴
  		var objDiv = document.getElementById('gradeChart');
  		// 인자로 전달한 div 객체의 영역에 컬럼차트를 그릴수 있는 차트객체를 반환
  		var chart = new google.visualization.ColumnChart(objDiv);
  		// 차트객체에 데이터테이블과 옵션 객체를 인자로 전달하여 차트 그리는 메소드
  		chart.draw(dataTable1, options);
  		/* var chart = new google.charts.Bar(objDiv);
  		// 차트객체에 데이터테이블과 옵션 객체를 인자로 전달하여 차트 그리는 메소드
  		chart.draw(dataTable,google.charts.Bar.convertOptions(options)); */
  		// drawColumnChart1()의 끝
  		
  	}
	function columnChart2() {
  		var dataTable1 = new google.visualization.arrayToDataTable(<%=teacher%>);
  		// 옵션객체 준비
  		var options = {
  			title : '연령대별 선생님 수',
  			legend : 'top',
  			colors : [ '#FF9900' ]
  		};
  		// 차트를 그릴 영역인 div 객체를 가져옴
  		var objDiv = document.getElementById('teacherChart');
  		// 인자로 전달한 div 객체의 영역에 컬럼차트를 그릴수 있는 차트객체를 반환
  		var chart = new google.visualization.ColumnChart(objDiv);
  		// 차트객체에 데이터테이블과 옵션 객체를 인자로 전달하여 차트 그리는 메소드
  		chart.draw(dataTable1, options);
  		/* var chart = new google.charts.Bar(objDiv);
  		// 차트객체에 데이터테이블과 옵션 객체를 인자로 전달하여 차트 그리는 메소드
  		chart.draw(dataTable,google.charts.Bar.convertOptions(options)); */
  		// drawColumnChart1()의 끝
  		
  	}
    </script>
  </head>
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
 #graphDiv2{
 	display:flex;
 }
 #donutChart{
 	border-right: 1px solid lightgray;
 }
 
  </style>
  <body>
  <div id="frame"  align="left">
  	<div>
	  	<div><h2>총 회원 수  <%=total %> 명</h2></div>
	  	<div><h4>학생 수 : <%=member %> 명 선생님 수: <%=tea[0] %> 명 학원장 수: <%=tea[1] %> 명 </h4></div>
  	</div>
    <div id="graphDiv2">
   		<div id="donutChart" style="height:450px; flex:1.4;" ></div>
   		<div id="gradeChart" style="height: 500px; flex:1;"></div>
   		<div id="teacherChart" style=" height: 500px; flex:1;"></div>
    </div>
    </div>

</body>
</html>