<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>


<html lang="UTF-8">	

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, user-scalable=0">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">


<head>
	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script> 
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<!-- Bootstrap Dropdown Hover CSS -->
   	<link href="/css/animate.min.css" rel="stylesheet">
    <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
    <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
   
    <!-- jQuery UI toolTip 사용 CSS-->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <!-- jQuery UI toolTip 사용 JS-->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
		

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
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/topToolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
<br/>

<!-- <div class="widget" align="center">	
		  <button type="button" class="btn btn-thumnail">썸네일로 보기</button>
		  <button type="button" class="btn btn-calendar">캘린더로 보기</button>		
</div> -->

<div class="page">	
	 
		<br/><br/>
		<div style="width:100%; max-width:1200px; display:inline-block;">
		    <button type="button" class="btn btn-thumnail">썸네일로 보기</button>
			<button type="button" class="btn btn-calendar">캘린더로 보기</button>		
			<div class="monthly" id="mycalendar"></div>
		</div>
		
</div>


<!-- JS ======================================================= -->
<script type="text/javascript" src="../javascript/jquery.js"></script>
<script type="text/javascript" src="../javascript/monthly.js"></script>
<script type="text/javascript" >

//============= "캘린더로 보기"  Event  처리 =============	
$(function() {
	 //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	$( "button.btn.btn-calendar" ).on("click" , function() {	
		 self.location = "/movie/getMovieList?menu=calendar";	
	});	
});

//============= "썸네일로 보기"  Event  처리 =============	
$(function() {
	 //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	$( "button.btn.btn-thumnail" ).on("click" , function() {	
		 self.location = "/movie/getMovieList?menu=commingsoon";	
	});	
});


/* 
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

 */
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

		
	 $(window).load( function() {			
			var movieEvents =  $.ajax({
			      url: "/movie/json/movieOnSchedule", //컨트롤러 URL					   
			      dataType: 'json',				    
			      type: 'POST',
			      async:false, // AJAX Return 값을 전역변수를 잡을 때 받드시 async = false로 설정해줘야 함...
			      global:true,		
			      success: function (responseData) {
			       	  //alert("성공적으로 서비스를 호출했습니다.");    
			      
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


</script>
<body>


</html>
