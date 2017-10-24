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
			document.getElementById('cancelAlarm').contentWindow.postMessage(event.data,"*");
			$("input[name='seats']").val(event.data);
			alert("event.data[0] : "+event.data[0]);
			alert("event.data[0][0] : "+event.data[0][0]);
				  
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
		<h2>[취소표 알리미 신청] 고갱님이 선택하신 상영번호는 :
			<input type="text" name="screenContentNo" value="${screenContentNo}">
		</h2>
			<%-- <iframe id="cancelAlarm" src="http://192.168.0.7:52273/cancelAlarm?screenNo=${screenContentNo}" width="600" height="400" > --%>
			<iframe id="cancelAlarm" src="http://127.0.0.1:52273/cancelAlarm?screenNo=10172" width="600" height="400" >		 
					  <p>Your browser does not support iframes.</p>
			</iframe>
		<h2>취소표알리미를 신청하실 좌석번호는 : <input type="text" name="seats" value=""></h2>
	</form>
	</body>
</html>
