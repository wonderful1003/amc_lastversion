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
   
<title>selectScreenMovie.jsp</title>
</head>
<script type="text/javascript">
var ticketOpenDate="";

    function dpTime(){
    	
    	
    	console.log("open : "+ticketOpenDate);
    	var templist = ticketOpenDate.split('.');
    	console.log("���½ð� : "+templist[0]);
    	
    	var now = new Date();
    	var screenTime = new Date(templist[0]);
 	   //var screenTime = new Date('17/10/22 12:00:00');
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
        	$("button[name='selectSeat']").removeAttr("disabled");
        	$("#dpTime").html("����");
        } 
		
 	 	 if (days < 1){
	         days = "";
	     }
        
        if (hours < 10){
            hours = "0" + hours;
        }
        
        if (minutes < 10){
            minutes = "0" + minutes;
        }
        
        if (seconds < 10){
            seconds = "0" + seconds;
        }
       
        if(diff<1){
        	
        }else{
			document.getElementById("dpTime").innerHTML =days+ "�� " + hours + ":" + minutes + ":" + seconds;
        }
    }

    
	$( function(){	

    	$("button[name='selectSeat']").on("click", function(){
    		var screeContentNo = $("#display").text();
	    	self.location="/booking/selectSeat?screenContentNo="+"10000";
	    });
    	$("button[name='tempSelectSeat']").on("click", function(){
    		var screeContentNo = $("#display").text();
    		self.location="/booking/selectSeat?screenContentNo="+"10000";
	    });
    	$("button[name='selectRandomSeat']").on("click", function(){
    		var screeContentNo = $("#display").text();
    		//var headCount = 
    		self.location="/booking/selectRandomSeat?screenContentNo="+"10172";
	    });
    
    })
    //////////////////////////////////////////////////
    //1. ��ȭ���� Ŭ����
		$( function() {
			
			$("td.movieName").on("click" , function() {
				
				var movieNo =  $($(this).find("input[name='movieNo']")).val();
				var flag = $("input:hidden[name='flag']").val();
				alert("flag�� 2�ΰ� ? :"+flag)
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
								console.log('���� : '+JSONData);								
		                        var str = "";
		                        if(JSONData != ""){
		                        	
		                           $(JSONData).each(
		                               function(){
		                            	  str+= 	'<div class="screenDay">'+this+'��'
		                            	  str+=     '<input type="hidden" name="day" value='+this+'>'
		                            	  str+=	'</div>';
				                      });//end of each fnc                            
			                        }//end of if��
			                        $(".col-md-4").eq(1).find(".screenDay").remove();
			                        $(".col-md-4").eq(2).find(".screenTime").remove();
			                        $(".col-md-4").eq(1).find(".head").after(str);

							}
					});//end of ajax
			});

		});
		
		
		//2. ��¥ Ŭ����
		$(document).on("click", ".screenDay",  function(){
			alert("��¥�� �����ϼ̽��ϴ�.");
			
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
							console.log('screenTime �޾ƿ� : '+JSONData);								
	                        var str = "";
	                        if(JSONData != ""){
	                        	
	                            $(JSONData).each(
	                               function(){
	                            	   str+= '<div class="screenTime">�ð� : '+this.screenOpenTime
	                            	   +     ', �󿵹�ȣ : '+this.screenContentNo+'  Ƽ�Ͽ��½ð��� : '+this.ticketOpenDate
	                            	   +'<input type="hidden" name="contNo" value="'+this.screenContentNo+'">'
	                            	   +'<input type="hidden" name="ticketOpenDate" value="'+this.ticketOpenDate+'">'
	                            	   +'</div>' ;				
	                            	   
	                               }//end of function
	                             );
	                        }//end of if��
	                        
	                        $(".col-md-4").eq(2).find(".screenTime").remove();
	                        $(".col-md-4").eq(2).find(".head").after(str);
						}
				});//end of ajax
		});
		
		//3. �ð�Ŭ����
		$(document).on("click", ".screenTime",  function(){
			
			var contNo = $($(this).find("input[name='contNo']")).val();
			ticketOpenDate = $($(this).find("input[name='ticketOpenDate']")).val();
			alert("������ �󿵹�ȣ�� : "+contNo+", Ƽ�Ͽ���Ÿ���� :"+ticketOpenDate);
			
			$("#display").text(contNo);	
			
			setInterval("dpTime();",1000);
			
		});
			
		$(document).on("click", "#gotoSeat",  function(){
			
			var scNo = $("#display").text();	
			self.location = "/booking/selectSeat?screenContentNo="+scNo;

		});

    
</script>
</head>
	<body>
		<h2>[����1�ܰ�]�û�ȸ �������� ������ �ּ���.</h2>
		<input type="hidden" name="flag" value="2">
		<input type="hidden" name="openTime" value="2017-10-27 12:00:00">
		 
		<h1><span id ="timer">Ƽ�� ���±��� �����ð� : <span id="dpTime">����ð� ǥ��</span></span></h1>


		<button class="select" name="selectSeat" disabled="disabled">(�ð��Ǹ� Ȱ��ȭ) �¼�����</button>
		<button class="select" name="tempSelectSeat">[�׽�Ʈ��] �¼����� </button>
		<button class="select" name="selectRandomSeat"> �����¼� �����ϱ� </button>
		

    <div class="container">
	 <h2>[����1�ܰ�]�û�ȸ �������� ������ �ּ���.</h2>
	 <input type="hidden" name="flag" value="1">
      <div class="row">
        <div class="col-md-4">
         <div class="head"><h2>�û�ȸ ����</h2></div>
          <table>
	          <c:set var="i" value="0" />
			  <c:forEach var="screenContent" items="${screenContentList}">
				<c:set var="i" value="${ i+1 }" />
				<tr>		  
				  <td align="left" class="movieName"><h5>${screenContent.previewTitle} </h5>
				  	<input type="hidden" name="movieNo" value="${screenContent.screenContentNo}">
				  </td>
				</tr>
	          </c:forEach>        
          </table>
        </div>
		<div class="col-md-4" id="dayList">
			<div class="head"><h2>�� ��¥</h2></div>
	   	</div>
	   	<div class="col-md-4" id="dayList">
			<div class="head"><h2>�� ��¥</h2></div>
	   	</div>
      </div>
      
   	  </div> 

      <div id="display" ></div>
	</body>
</html>
