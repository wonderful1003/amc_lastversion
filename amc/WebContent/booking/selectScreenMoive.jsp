<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head> 

	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--   jQuery , Bootstrap CDN  -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<link rel="stylesheet" type="text/css" href="/semantic/semantic.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"
	integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
  	crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.js" ></script>
	<!-- semantic.ui -->
	<script src="/semantic/semantic.js"></script>
	
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
   	<!--  not sure about this part -->
   	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>


   <!-- ------------------------------>
	<script type="text/javascript">
		
		//1. 영화제목 클릭시
		$( function() {
			
			$("td.movieName").on("click" , function() {
				
				var movieNo =  $($(this).find("input[name='movieNo']")).val();
				var movieName =  $($(this).find("input[name='movieName']")).val();
				$(".item").eq(0).text(movieName);
				var flag = $("input:hidden[name='flag']").val();
				
				$.ajax(
						{
							url : "/booking/json/getScreenDate/"+movieNo+"/"+flag,						
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
		                            	  	str+= 	'<div class="screenDay">'+this+'일'
		                            	  	str+=     '<input type="hidden" name="day" value='+this+'>'
		                            	  	str+=	'</div>';
		                               });//end of each fnc                            
		                        }//end of if문
		                        $(".col-md-4").eq(1).find(".screenDay").remove();
		                        $(".col-md-4").eq(2).find(".screenTime").remove();
		                        $(".col-md-4").eq(1).find(".head").after(str);
		                        
							}
					});//end of ajax
			});

		});
		
		
		//2. 날짜 클릭시
		$(document).on("click", ".screenDay",  function(){
			alert("날짜를 선택하셨습니다.");
			
			var date =  $($(this).find("input[name='day']")).val();
			$(".item").eq(1).text(date);
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
	                            	   +'<input type="hidden" name="screenTime" value="'+this.screenOpenTime+'">'
	                            	   +'</div>' ;				

	                               }//end of function
	                             );
	                        }//end of if문
	                        
	                        $(".col-md-4").eq(2).find(".screenTime").remove();
	                        $(".col-md-4").eq(2).find(".head").after(str);
						}
				});//end of ajax
		});
		
		//3. 시간클릭시
		$(document).on("click", ".screenTime",  function(){
			
			var screenTime = $($(this).find("input[name='screenTime']")).val();
			var contNo = $($(this).find("input[name='contNo']")).val();
			alert("시간을 선택하셨습니다  상영번호는 : "+contNo);
			$(".item").eq(2).text(screenTime);
			
			$("#display").text(contNo);	

		});
			
		$(document).on("click", "#gotoSeat",  function(){
			
			var screenContentNo = $("#display").text();	
			self.location = "/booking/selectSeat?screenContentNo="+"10000";

		});
	
	</script>
	
<title>selectScreenMovie.jsp</title>
</head>
	<body>
	<jsp:include page="/layout/topToolbar.jsp" /><br><br><br><br><br><br>

	 <div class="container">
	 
	 <div class="ui ordered steps">
	  <div class="completetd step">
	    <div class="content">
	      <div class="title">영화정보 선택하기</div>
	      <div class="description">관람하실 영화정보를 선택합니다.</div>
	    </div>
	  </div>
	  <div class="active step">
	    <div class="content">
	      <div class="title">좌석 선택하기</div>
	      <div class="description">관람하실 영화의 좌석을 선택합니다.</div>
	    </div>
	  </div>
	  <div class="active step">
	    <div class="content">
	      <div class="title">결제하기</div>
	      <div class="description">카카오페이로 결제하여 예매를 완료합니다.</div>
	    </div>
	  </div>
	</div>	
	
 	<div class="item">선택된 상영정보</div>
	<div class="item"></div>
	<div class="item"></div>
	<div class="item"></div> 

	 
	 <h4>[예매1단계]영화 상영정보를 선택해 주세요.</h4>
	 <input type="hidden" name="flag" value="1">
      <div class="row">
        <div class="col-md-4">
         <div class="head"><h4>영화 제목</h4></div>
          <table>
	          <c:set var="i" value="0" />
			  <c:forEach var="movie" items="${movieList}">
				<c:set var="i" value="${ i+1 }" />
				<tr>		  
				  <td align="left" class="movieName"><h5>${movie.movieNm}  ${movie.movieNo}</h5>
				  	<input type="hidden" name="movieNo" value="${movie.movieNo}">
				  	<input type="hidden" name="movieName" value="${movie.movieNm}">
				  </td>
				</tr>
	          </c:forEach>        
          </table>
        </div>
		<div class="col-md-4" id="dayList">
			<div class="head"><h4>상영 날짜</h4></div>
	   	</div>
	   	<div class="col-md-4" id="dayList">
			<div class="head"><h4>상영 날짜</h4></div>
	   	</div>
      </div>
      
   	  </div> 
   	  
	  <!-- /container -->	
	<div id="display" ></div>
	<div id="gotoSeat"><h4>▶좌석선택하기</h4></div>
	
	
	</body>	
</html>
