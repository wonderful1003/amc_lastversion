<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>


<html lang="UTF-8">	

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, user-scalable=0">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">


<head>
<!--[if lt IE 9]>
	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->

<!-- META ===================================================== -->
    <title>Monthly - A jQuery Calendar Plugin</title>
    <meta name="description" content="A method for responsive tables">

<!-- Favicon  ========================================== -->


<!-- CSS ======================================================
	<link rel="stylesheet" href="css/responsivetables.css">-->
	<!-- Demo CSS (don't use) -->

   <link rel="stylesheet" href="../css/monthly.css">
	<style type="text/css">
		body {
			font-family: Malgun Gothic;
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

	<link rel="stylesheet" href="../css/monthly.css">
</head>
<body>
<div class="page">
		<h2>월간 영화 캘린더</h1>	
		<div style="width:100%; max-width:600px; display:inline-block;">
			<div class="monthly" id="mycalendar"></div>
		</div>
	
		
</div>
<!-- JS ======================================================= -->
<script type="text/javascript" src="../javascript/jquery.js"></script>
<script type="text/javascript" src="../javascript/monthly.js"></script>
<script type="text/javascript" >



var sampleEvents =  {
		"monthly": [
					{
					"id": 10024,
					"name": "킹스맨",
					"startdate": "2017-10-01",
					"enddate": "2017-10-03",	
					"color": "red",
					"url": "getMovie?movieNo=10009&menu=commingsoon"
					},		
					{
					"id": 10000,
					"name": "희생 부활자",
					"startdate": "2017-10-28",
					"enddate": "2017-10-30",	
				    "color": "orange",
					"url": ""
					},
					{
					"id": 10019,
					"name": "넛잡 2",
					"startdate": "2017-10-29",
					"enddate": "2017-10-30",			
					"endtime": "",	
				    "color": "yellow",
					"url": ""
					}
				]                              
                    
}

 	$(window).load( function() {
			$('#mycalendar').monthly({
				mode: 'event',
				contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
				dataType: 'json',
				//jsonUrl: '../javascript/events.json',
				events: sampleEvents,
			
			});
		}); 


/* 
$(window).load( function() {	
		var movieEvents = responseData;

		$.ajax({
			      url: "/movie/json/movieOnSchedule", //컨트롤러 URL					   
			      dataType: 'json',
			      processData: false,
			      contentType: false,				    
			      type: 'POST',
			      async:false, // AJAX Return 값을 전역변수를 잡을 때 받드시 async = false로 설정해줘야 함...
			      global:true,
			      success: function (responseData, textStatus, jqXHR) {
			      success: function (responseData) {
			       	  alert("성공적으로 서비스를 호출했습니다.");    
			       	  movieReturnData(responseData);
			    	  console.log(responseData);
			    	  console.log(textStatus);
			    	  console.log(jqXHR.status);				    

			      },error: function (jqXHR) {
			    	   alert("성공적으로 파일 업로드되었습니다.");
				       alert(jqXHR.responseText);
				       console.log(jqXHR.responseText);
			      }
			   })	
			   
			   $('#mycalendar').monthly({
					mode: 'event',
					contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
					dataType: 'json',
					events: movieEvents,
			  });

	    });
	    
		function movieReturnData(responseData){
			movieEvents = responseData;
		    console.log(movieEvents);
		}; */

		
	   /*  $(window).load( function() {			
			var movieEvents =  $.ajax({
			      url: "/movie/json/movieOnSchedule", //컨트롤러 URL					   
			      dataType: 'json',				    
			      type: 'POST',
			      async:false, // AJAX Return 값을 전역변수를 잡을 때 받드시 async = false로 설정해줘야 함...
			      global:true,		
			      success: function (responseData) {
			       	  alert("성공적으로 서비스를 호출했습니다.");    
			      
			      },error: function (jqXHR) {			    	
				       alert(jqXHR.responseText);
				       console.log(jqXHR.responseText);
			      }
		   }).responseJSON;			
			$('#mycalendar').monthly({
				mode: 'event',
				contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
				dataType: 'json',
				events: movieEvents,
			});
		
		});
 */

</script>
<body>


</html>
