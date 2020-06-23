<%@ page contentType="text/html; charset=utf-8"%>
<%
		request.setCharacterEncoding("utf-8");
%>
<html>
<head>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      
     
  		$.ajax({
  			dataType:"text",
  			
  			url:'ratioChart.jsp',
  			success:function(result){
  				drawChart(result);
  			}, 
  			error:function(request, error){
  				alert("에러");
  				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
  			} 
  		});
   
    	 
      function drawChart(arrayList) {
			
    	  arrayList = eval('('+arrayList+')');

    	  var dataTable = new google.visualization.DataTable();
    		dataTable.addColumn('string','gender');
    		dataTable.addColumn('number','count');
    		dataTable.addRows(arrayList);
    		
    		
          var options = {
            title: '남녀 비율'
          };

          var chart = new google.visualization.PieChart(document.getElementById('piechart'));

          chart.draw(data, options);
        }
</script>
</head>
<body>
<div>
<h2>총 인원 수 :  명</h2>
<div id="piechart" style="width: 900px; height: 500px;"></div>
</div>
</body>
</html>