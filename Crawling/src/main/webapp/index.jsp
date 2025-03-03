<%@page import="dto.MovieDTO"%>
<%@page import="java.util.List"%>
<%@page import="movie.MovieChart"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
List<MovieDTO> list = MovieChart.getCgvData();

for (MovieDTO m : list) {
	System.out.println(m.toString());
}

// list to JSON(String)
String jsonStr = "[";

for (MovieDTO m : list) {
	jsonStr += "{ name:'" + m.getTitle() + "', y:" + m.getPercent() + "}, "; 
}

jsonStr = jsonStr.substring(0, jsonStr.lastIndexOf(","));
jsonStr += "]";

request.setAttribute("MovieChart", jsonStr);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.highcharts-figure, .highcharts-data-table table {
	min-width: 320px;
	max-width: 800px;
	margin: 1em auto;
}

.highcharts-data-table table {
	font-family: Verdana, sans-serif;
	border-collapse: collapse;
	border: 1px solid #ebebeb;
	margin: 10px auto;
	text-align: center;
	width: 100%;
	max-width: 500px;
}

.highcharts-data-table caption {
	padding: 1em 0;
	font-size: 1.2em;
	color: #555;
}

.highcharts-data-table th {
	font-weight: 600;
	padding: 0.5em;
}

.highcharts-data-table td, .highcharts-data-table th,
	.highcharts-data-table caption {
	padding: 0.5em;
}

.highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even)
	{
	background: #f8f8f8;
}

.highcharts-data-table tr:hover {
	background: #f1f7ff;
}

input[type="number"] {
	min-width: 50px;
}
</style>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
</head>
<body>
	<div id="container"></div>
	<script type="text/javascript">
	// Data retrieved from https://netmarketshare.com
		Highcharts
			.chart(
				'container',
				{
					chart : {
						plotBackgroundColor : null,
						plotBorderWidth : null,
						plotShadow : false,
						type : 'pie'
					},
					title : {
						text : '2023/02/17 영화 예매율',
						align : 'left'
					},
					tooltip : {
						pointFormat : '{series.name}: <b>{point.percentage:.1f}%</b>'
					},
					accessibility : {
						point : {
							valueSuffix : '%'
						}
					},
					plotOptions : {
						pie : {
							allowPointSelect : true,
							cursor : 'pointer',
							dataLabels : {
								enabled : true,
								format : '<b>{point.name}</b>: {point.percentage:.1f} %'
							}
						}
					},
					series : [ {
						name : 'Brands',
						colorByPoint : true,
						data : <%=request.getAttribute("MovieChart") %>
					} ]
				});
	</script>
</body>
</html>