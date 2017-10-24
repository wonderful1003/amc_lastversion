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
				  alert('������û��!');
				  requestPay();	  
				  
			  }else{
				  $("input[name='seats']").val(event.data);
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
		<h2>[���� 2�ܰ�]�¼������Դϴ�. ������ �����Ͻ� �󿵹�ȣ�� :
			<input type="text" name="screenContentNo" value="${screenContentNo}">
		</h2>
		
			<%-- <iframe id="child" src="http://127.0.0.1:52273/yenakoh/3?screenNo=${screenContentNo}" width="400" height="400" > --%>
			<iframe id="child" src="http://192.168.0.3:52273/yenakoh/3?screenNo=${screenContentNo}" width="600" height="400" >		 
					  <p>Your browser does not support iframes.</p>
			</iframe>
			<button onclick="myFunction()">Try it</button>
			<h2>�����Ͻ� �¼���ȣ�� : <input type="text" name="seats" value=""></h2>
			JSP Version: <%= JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() %> <br>
		</form>
	</body>
</html>
