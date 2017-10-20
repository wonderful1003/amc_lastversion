<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head> 
	<meta charset="EUC-KR">

	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--   jQuery , Bootstrap CDN  -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!--   Modal CDN  -->
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script> 
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
	<style>
        body {
            padding-top : 70px;
        }
   	</style>
   	
	<script type="text/javascript">
		
		//1. 영화제목 클릭시
		$( function() {
			
			$("td.movieName").on("click" , function() {
				
				var movieNo =  $($(this).find("input[name='movieNo']")).val();
				
				$.ajax(
						{
							url : "/booking/json/getScreenDate/"+movieNo,						
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData, status) {
								console.log('히히 : '+JSONData);								
		                        var str = "";
		                        if(JSONData != ""){
		                        	
		                            $(JSONData).each(
		                               function(){
		                            	   str+= '<div class="screenDay">'+this+'일<input type="hidden" name="day" value='+this+'></div>' 			

		                               }//end of function
		                             );
		                            
		                        }//end of if문
		                       
								$( "tbody").after(str);
							}
					});//end of ajax
			});

		});
		
		
		//2. 날짜 클릭시
		$(document).on("click", ".screenDay",  function(){
			alert("날짜를 선택하셨습니다.");
			
			var date =  $($(this).find("input[name='day']")).val();
			
			$.ajax(
					{
						url : "/booking/json/getScreenTime/"+date,						
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						async : false,
						success : function(JSONData, status) {
							console.log('screenTime 받아옴 : '+JSONData);								
	                        var str = "";
	                        if(JSONData != ""){
	                        	
	                            $(JSONData).each(
	                               function(){
	                            	   str+= '<div class="screenTime">시간 : '+this.screenOpenTime
	                            	   +     ', 상영번호 : '+this.screenContentNo+''
	                            	   +'<input type="hidden" name="contNo" value="'+this.screenContentNo+'">'
	                            	   +'</div>' ;				

	                               }//end of function
	                             );
	                            
	                        }//end of if문
	                       
							$( "tbody").after(str);
						}
				});//end of ajax
		});
		
		//3. 시간클릭시
		$(document).on("click", ".screenTime",  function(){
			
			var contNo = $($(this).find("input[name='contNo']")).val();
			alert("시간을 선택하셨습니다  상영번호는 : "+contNo);
			
			$("#display").text(contNo);	

		});
			
		$(document).on("click", "#gotoSeat",  function(){
			
			var scNo = $("#display").text();	
			self.location = "/booking/selectSeat?screenContentNo="+scNo;

		});
	
	</script>
	
<title>selectScreenMovie.jsp</title>
</head>
	<body>
	<div class="container">
		<h2>[예매1단계]영화 상영정보를 선택해 주세요.</h2>
			
	<table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">영화번호</th>
            <th align="center">영화제목</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		   <c:forEach var="movie" items="${movieList}">
			<c:set var="i" value="${ i+1 }" />
			<tr>

			  <td align="center">${ i } </td>			  
			  <td align="left" class="movieName">${movie.movieNm} 
			  	<input type="hidden" name="movieNo" value="${movie.movieNo}">
			  </td>
			  <td align="left">${movie.movieNo} </td>
			</tr>
          </c:forEach>
        
        </tbody>
      </table>
      <div id="display" >여기에 상영번호 setting해보기/ 나중에는 hidden으로</div>
	</div>	
		<!-- <h2>&nbsp;&nbsp;<a href="http://127.0.0.1:52273/yenakoh/3?screenNo=1020">▶좌석선택하기</a></h2> -->
		 <div id="gotoSeat"><h2>▶좌석선택하기</h2></div>
	</body>
</html>
