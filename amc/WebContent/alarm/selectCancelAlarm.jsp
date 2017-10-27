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
   
   	<!--   Sweetalert CDN  -->
	<!-- <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> -->
	
	<!--   Sweetalert2 CDN  -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.0/sweetalert2.all.min.js"></script>
	

<title>selectScreenMovie.jsp</title>

<script>
	function listener(event){		
		document.getElementById('cancelAlarm').contentWindow.postMessage(event.data,"*");
		$("input[name='seats']").val(event.data);
		
		  $.ajax({
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
	                    	$("#display2").val(JSONData.str);
	                    }//end of if문
					}
		});//end of ajax
			  
	}

		
		if (window.addEventListener){
			  addEventListener("message", listener, false);
		} else {
			  attachEvent("onmessage", listener)
		}
		
		function requestPay() {			
			$("form").attr("method" , "POST").attr("action" , "/booking/requestPay").submit();
		}
		
		function addCancelAlarm(){
			$.ajax({
			    		url: "/alarm/json/addCancelAlarm/",
			    		type: 'POST',
			    	}).done(function(result) {
			    		alert("result : " + result);
			    		if ( result == 'success' ) {
			    			var msg = '취소표 알림 신청 성공';
			    			swal({
			    				  //position: 'top-right',
			    				  type: 'success',
			    				  title: '취소표 알림 신청 성공!',
			    				  showConfirmButton: true,
			    				  timer: 2000
			    				})
			    		} else if( result == 'exceed'){
			    			swal(
			    					  '취소표알림 자리 수 초과!',
			    					  '신청 가능한 취소표알림 수 초과 (최대 4 좌석)',
			    					  'error'
			    					)
			    		} else {
			    			swal(
			    					  '중복 좌석 신청!',
			    					  '신청한 좌석 중 기존에 중복된 좌석이 있습니다.'+"\n"+result,
			    					  'error'
			    					)
			    		}
			    	});
		}	
			
		
</script>

</head>
	<body>
	<form>
		<h2>[취소표 알리미 신청] 고갱님이 선택하신 상영번호는 :
			<input type="text" name="screenContentNo" value="${screenContentNo}">
			<!-- hidden타입으로 바꾸기 -->
		</h2>
			<%-- <iframe id="cancelAlarm" src="http://192.168.0.7:52273/cancelAlarm?screenNo=${screenContentNo}" width="600" height="400" > --%>
			<iframe id="cancelAlarm" src="http://127.0.0.1:52273/cancelAlarm?screenNo=10000" width="600" height="400" >		 
					  <p>Your browser does not support iframes.</p>
			</iframe>
		<h2>취소표알리미를 신청하실 좌석번호는 : <input type="text" id="display2" name="seats" value="">
		<!-- <input type="text" id="display2" value=""> --></h2>
		<input type="hidden" name="seats" value="">
		<input type="button" value="취소표 알림 신청" onClick="javascript:addCancelAlarm()">
		
	</form>
	</body>
</html>
