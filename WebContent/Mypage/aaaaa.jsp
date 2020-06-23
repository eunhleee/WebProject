<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
  <head>
  <meta charset="utf-8">
  <title>개체현황</title>
   
 <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Year', '개체수', ''],
          ['2010', 797, 0],   ['2011', 864, 0],  ['2012', 822, 0],  ['2013', 814, 0],  ['2014', 899, 0],  ['2015', 1137, 0],  ['2016', 1176, 0]
        ]);

        var options = {
          title: '개체현황',
          curveType: 'function',
          legend: { position: 'bottom' },
 		   tooltip:{isHtml: true}
        };

        var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

        chart.draw(data, options);

      }
    </script>

  </head>


<style>
div.google-visualization-tooltip {
position:fixed;
top:50px;
left:40px;
          }
</style>
  <body>



    <div id="curve_chart" style="height: 500px;"></div>
 
 
 
  </body>
</html>