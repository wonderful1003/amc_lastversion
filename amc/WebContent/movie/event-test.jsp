<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="EUC-KR"%>

<html lang="EUC-KR">	
 
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, user-scalable=0">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta charset='EUC-KR'>


<head>
    <title>Monthly - Event Tests</title>
	<link rel="stylesheet" href="../css/monthly.css">
	<style type="text/css">
		body {
			font-family: Calibri;
			background-color: #f0f0f0;
			padding: 0em 1em;
		}
		#mycalendar {
			width: 100%;
			margin: 2em auto 0 auto;
			max-width: 80em;
			border: 1px solid #666;
		}
	</style>
</head>

<body>
<h1>Monthly.js Event Tests</h1>
<h2>October - December 2016</h2>
<p>This contains events intended to test basic event span functionality of monthly.js</p>
<div class="monthly" id="mycalendar"></div>
<script type="text/javascript" src="../javascript/jquery.js"></script>
<script type="text/javascript" src="../javascript/monthly.js"></script>
<script type="text/javascript">


var sampleEvents = {
		"monthly": [
			{
			"id": 1,
			"name": "킹스맨",
			"startdate": "2017-10-01",
			"enddate": "2017-10-01",
			"starttime": "12:00",
			"endtime": "2:00",
			"color": "#99CCCC",
			"url": "http://localhost:8080/movie/getMovie?movieNo=10005&menu=preview"
			},
			{
			"id": 2,
			"name": "남한산성",
			"startdate": "2017-10-05",
			"enddate": "2017-10-05",
			"starttime": "12:00",
			"endtime": "2:00",
			"color": "#CC99CC",
			"url": ""
			},
			{
			"id": 3,
			"name": "범죄도시",
			"startdate": "2017-10-07",
			"enddate": "",
			"starttime": "",
			"endtime": "",
			"color": "orange",
			"url": "https://www.google.com/"
			},
			{
			"id": 4,
			"name": "아이캔스피크",
			"startdate": "2017-10-11",
			"enddate": "",
			"starttime": "",
			"endtime": "",
			"color": "#666699",
			"url": "https://www.google.com/"
			},
			{
			"id": 5,
			"name": "블레이드 러너 2043",
			"startdate": "2017-10-17",
			"enddate": "",
			"starttime": "12:00",
			"endtime": "02:00",
			"color": "dark grey",
			"url": ""
			},
			{
			"id": 6,
			"name": "Deep 팁",
			"startdate": "2017-10-20",
			"enddate": "2017-10-22",
			"starttime": "",
			"endtime": "",
			"color": "#999999",
			"url": ""
			},
			{
			"id": 7,
			"name": "주키퍼스 와이프",
			"startdate": "2017-10-25",
			"enddate": "",
			"starttime": "",
			"endtime": "",
			"color": "#99CC99",
			"url": ""
			},
			{
			"id": 8,
			"name": "희생 부활자",
			"startdate": "2017-10-28",
			"enddate": "",
			"starttime": "",
			"endtime": "",
			"color": "#669966",
			"url": ""
			},
			{
			"id": 9,
			"name": "넛잡 2",
			"startdate": "2017-10-29",
			"enddate": "",
			"starttime": "",
			"endtime": "",
			"color": "#999966",
			"url": ""
			}
		]
		}; 

	$(window).load( function() {
		$('#mycalendar').monthly({
			mode: 'event',
			dataType: 'json',
			events: sampleEvents
		});
	});
</script>
</body></html>