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

	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<link rel="stylesheet" type="text/css" href="/semantic/semantic.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"
	integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
  	crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.js" ></script>
	
	<!--   Modal CDN  -->
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script> 
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
<title>selectScreenMovie.jsp</title>
</head>
<style>
                .line { overflow: hidden; }
                .head {
                
                    margin: 3px; 
                    /* height: 50px;  */
                    float: center; /*width: 20px; */
                    border-radius: 3px;
                    background: #CFD3D4;
                   
                }
                .screenDay {
                    margin: 3px;                   
                    border-radius: 3px;
                    background: #E8EBED;
;                   
                }
                .screenTime {
                    margin: 3px;                   
                    border-radius: 3px;
                    background: #E8EBED;
;                   
                }
                .movieName {
                    margin: 3px;                   
                    border-radius: 3px;
                    background: #E8EBED;                   
                }
                .screenTime:hover { background: #C1DEC1; }
                .screenDay:hover { background: #C1DEC1; }
                .movieName:hover { background: #C1DEC1; }
	button.ui.inverted.purple.button{
	font-size: 1.4rem;
	}
	button.ui.inverted.green.button{
	font-size: 1.4rem;
	}
	div.inline.fields{
	font-size: 1.5rem;
	}
	label.lb{
	font-size: 1.5rem;
	}

</style>

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
        	$("button[name='selectRandomSeat']").removeAttr("disabled");
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

    //////////////////////////////////////////////////
    //1. ��ȭ���� Ŭ����
		$( function() {
			
			$(".movieName").on("click" , function() {
				
				var movieNo =  $($(this).find("input[name='movieNo']")).val();
				var flag = $("input:hidden[name='flag']").val();
				var movieName =  $($(this).find("input[name='movieName']")).val();
				$(".item").eq(0).text(movieName);
				
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
							console.log('screenTime �޾ƿ� : '+JSONData);								
	                        var str = "";
	                        if(JSONData != ""){
	                        	
	                            $(JSONData).each(
	                               function(){
	                            	   str+= '<div class="screenTime">�ð� : '+this.screenOpenTime
	                            	   +     ', �󿵹�ȣ : '+this.screenContentNo+'  Ƽ�Ͽ��½ð��� : '+this.ticketOpenDate
	                            	   +'<input type="hidden" name="contNo" value="'+this.screenContentNo+'">'
	                            	   +'<input type="hidden" name="ticketOpenDate" value="'+this.ticketOpenDate+'">'
	                            	   +'<input type="hidden" name="screenTime" value="'+this.screenOpenTime+'">'
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
			var screenTime = $($(this).find("input[name='screenTime']")).val();
			$(".item").eq(2).text(screenTime);
			
			alert("Ƽ�Ͽ��½ð� :"+ticketOpenDate);
			
			$("#display").text(contNo);	
			
			setInterval("dpTime();",1000);
			
		});
			

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
    		var headCount = $("input:radio[name=headCount]:checked").val();
    		if( $("input:radio[name=headCount]:checked").length<1){
    			alert("�ο����� ���� �������ּ���.");
    		}else{
    			alert("�����¼��� "+headCount+"�� ��û�մϴ�.");
    			//self.location="/booking/selectRandomSeat?screenContentNo="+screeContentNo+"&headCount="+headCount;	
        		self.location="/booking/selectRandomSeat?screenContentNo=10172&headCount="+headCount+"";
    		}
    		
	    });
    
    })
</script>
</head>
	<body>
	<jsp:include page="/layout/topToolbar.jsp" /><br><br><br><br><br><br>
 	<div class="container">
    
	<div class="ui ordered steps">
	  <div class="completed step">
	    <div class="content">
	      <div class="title">�û�ȸ���� �����ϱ�</div>
	      <div class="description">�����Ͻ� �û�ȸ������ �����մϴ�.</div>
	    </div>
	  </div>
	  <div class="active step">
	    <div class="content">
	      <div class="title">�¼� �����ϱ�</div>
	      <div class="description">�����Ͻ� ��ȭ�� �¼��� �����մϴ�.</div>
	    </div>
	  </div>
	  <div class="active step">
	    <div class="content">
	      <div class="title">�����ϱ�</div>
	      <div class="description">īī�����̷� �����Ͽ� ���Ÿ� �Ϸ��մϴ�.</div>
	    </div>
	  </div>
	</div>
    
   	<h3>[����1�ܰ�]�û�ȸ �������� ������ �ּ���.</h3>
	<input type="hidden" name="flag" value="2">
	<input type="hidden" name="openTime" value="2017-10-27 12:00:00">

	<h3><span id ="timer">Ƽ�� ���±��� �����ð� : <span id="dpTime">����ð� ǥ��</span></span></h3>


	<button class="ui inverted green button" name="selectSeat" disabled="disabled">(�ð��Ǹ� Ȱ��ȭ) �¼�����</button>
	<button class="ui inverted green button" name="tempSelectSeat">[�׽�Ʈ��] �¼����� </button>
	
	<p>
	
	<div class="ui form">
		<button class="ui inverted purple button" name="selectRandomSeat" disabled="disabled"> �����¼� �����ϱ� </button>
	
	  <div class="inline fields">
	    <label>&nbsp;�����¼� Ȧ���� ���� �ο����� �������ּ���</label>
	    <div class="field">
	      <div class="ui radio checkbox">
	        <input type="radio" name="headCount" value="1">
	        <label class="lb">1��</label>
	      </div>
	    </div>
	    <div class="field">
	      <div class="ui radio checkbox">
	        <input type="radio" name="headCount" value="2">
	        <label class="lb">2��</label>
	      </div>
	    </div>	        
	 </div>
	</div>

 	<div class="item">���õ� ������</div>
	<div class="item"></div>
	<div class="item"></div>
	<div class="item"></div> 

	 <input type="hidden" name="flag" value="1">
      <div class="row">
        <div class="col-md-4">
         <div class="head"><h3>�û�ȸ ����</h3></div>
          <table>
	          <c:set var="i" value="0" />
			  <c:forEach var="screenContent" items="${screenContentList}">
				<c:set var="i" value="${ i+1 }" />
						  
				  <div align="left" class="movieName"><h5>${screenContent.previewTitle} </h5>
				  	<input type="hidden" name="movieNo" value="${screenContent.screenContentNo}">
				  	<input type="hidden" name="movieName" value="${screenContent.previewTitle}">
				  </div>
				
	          </c:forEach>        
          </table>
        </div>
		<div class="col-md-4" id="dayList">
			<div class="head"><h3>�� ��¥</h3></div>
	   	</div>
	   	<div class="col-md-4" id="dayList">
			<div class="head"><h3>�� ��¥</h3></div>
	   	</div>
      </div>
      
   	  </div> 

      <div id="display" ></div>
     </div>
	</body>
</html>
