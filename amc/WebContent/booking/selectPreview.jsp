<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<!DOCTYPE html >
<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<title>selectScreenMovie.jsp</title>
<script type="text/javascript">

	var screenTime = new Date('2017/10/16 12:04:00');
	

    setInterval("dpTime()",1000);
    
    function dpTime(){
    	var now = new Date();
 	 
 	  	console.log("now : "+now);  //mon oct 16 2017 10:51:31 GMT+0900
 	  	console.log("now.getTime() : "+now.getTime()); //1508118721142
 	 
 	  	var _second = 1000;
 	  	var _minute = _second * 60;
 	  	var _hour = _minute * 60;
 	  	var _day = _hour * 24;
 	  	var timer;

 	   var diff = (screenTime.getTime() - now.getTime());
 	  	
 	  	var days = Math.floor(diff / _day);
 	  	var hours = Math.floor((diff % _day) / _hour);
 	  	var minutes = Math.floor((diff % _hour) / _minute);
 	  	var seconds = Math.floor((diff % _minute) / _second);
 	  	
        if(diff<1){
        	$(".selectSeat").removeAttr("disabled");
        	$("#timer").remove();
        } 
 	 
 	  console.log("diff: "+diff); 
 	  console.log("diff sec_gap : "+ seconds);
 	  console.log("diff min_gap : "+ minutes);
 	  console.log("diff hour_gap : "+ hours);
 	  console.log("diff day_gap : "+days);
		
/* 	 	 if (days < 10){
	         days = "0" + days;
	     } */
        
        if (hours < 10){
            hours = "0" + hours;
        }
        
        if (minutes < 10){
            minutes = "0" + minutes;
        }
        
        if (seconds < 10){
            seconds = "0" + seconds;
        }
        

        
		document.getElementById("dpTime").innerHTML =days+ "일 " + hours + ":" + minutes + ":" + seconds;
    }

    
	$( function(){	

    	$(".selectSeat").on("click", function(){
	    	//self.location="http://127.0.0.1:52273/yenakoh/3?screenNo=1020";
	    	self.location="http://127.0.0.1:8080";
	    });
    	$(".realSelectSeat").on("click", function(){
	    	//self.location="http://127.0.0.1:52273/yenakoh/3?screenNo=1020";
	    	self.location="/booking/selectSeat";
	    });
    
    })
    
    
    

    
</script>
</head>
	<body>
		<h2>[예매1단계]시사회 상영정보를 선택해 주세요.</h2>
		

 
		<h1><span id ="timer">티켓 오픈까지 남은시간 : <span id="dpTime">현재시간 표시</span></span></h1>


		<!-- <h2><a href="http://127.0.0.1:52273/yenakoh/3?screenNo=1020">▶좌석선택</a></h2> -->
		<button class="selectSeat" disabled="disabled">시간되면 활성화되는 [좌석선택]버튼</button>
		<button class="realSelectSeat">테스트용 [좌석선택]버튼</button>
		<h2><a href="">▶랜덤좌석</a></h2>
		
	</body>
</html>
