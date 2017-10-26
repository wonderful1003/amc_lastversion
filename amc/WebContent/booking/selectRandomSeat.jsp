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
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!--   Modal CDN  -->
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script> 
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>

<title>selectScreenMovie.jsp</title>

<script>
		function listener(event){		
			  document.getElementById('child').contentWindow.postMessage(event.data,"*");
			  alert("event.data : "+event.data);
			  if(event.data == 'pay'){
				  alert('결제요청옴!');
				  requestPay();	  
				  
			  }else{
				  $("input[name='seats']").val(event.data);

				  $.ajax(
					{
						url : "/booking/json/getDisplaySeatNo/"+event.data,						
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						
						success : function(JSONData, status) {
							console.log('SeatNo 받아옴 : '+JSONData.str);								
	                        if(JSONData != ""){
	                        	$("#display2").text(JSONData.str);
	                        }//end of if문

						}
				});//end of ajax
				/////////////////////  
			  }

		}
		
		
		if (window.addEventListener){
			  addEventListener("message", listener, false);
		} else {
			  attachEvent("onmessage", listener)
		}
		
		function requestPay() {
			
			$("form").attr("method" , "POST").attr("action" , "/booking/requestPay").submit();
		}
		
		
		
</script>

</head>
	<body>
		<form>
		<h2>[예매 2단계] 랜덤으로 선택된 좌석선택입니다. 
			<input type="hidden" name="screenContentNo" value="${screenContentNo}">
		</h2>		
			<%-- <iframe id="child" src="http://127.0.0.1:52273/random_select?screenNo=${screenContentNo}&count=${headCount}" width="600" height="400" > --%>
			<iframe id="child" src="http://127.0.0.1:52273/random_select?screenNo=10000&count=2" width="800" height="400" >		 
					  <p>Your browser does not support iframes.</p>
			</iframe>
			<button onclick="myFunction()">Try it</button>
			<h2>선택하신 좌석번호는 : <input type="text" name="display" value="">
								<input type="text" id="display2" value=""></h2>
			<input type="hidden" name="seats" value="">
		</form>
	</body>
</html>
