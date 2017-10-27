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
<style>
/* 	#child {
		position:relative;top:50px;left:-200px;
	} */
</style>
<script>
		function listener(event){		
			  document.getElementById('child').contentWindow.postMessage(event.data,"*");
			  alert("event.data : "+event.data);
			  if(event.data == 'pay'){
				  alert('������û��!');
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
							console.log('SeatNo �޾ƿ� : '+JSONData.str);								
	                        if(JSONData != ""){
	                        	$("#display2").val(JSONData.str);
	                        }//end of if��
						}
				});//end of ajax
				  	  
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
		
		function selectCancelAlarm(){
			$("form").attr("method" , "POST").attr("action" , "/alarm/selectCancelAlarm").submit();
		}
		
		
</script>

</head>
	<body>
	<jsp:include page="/layout/topToolbar.jsp" /><br><br><br>
	 <div class="container">
	 
	<div class="ui ordered steps">
	  <div class="completed step">
	    <div class="content">
	      <div class="title">��ȭ���� �����ϱ�</div>
	      <div class="description">�����Ͻ� ��ȭ������ �����ϼ̽��ϴ�.</div>
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
	
	<h5>�ο����� ���� ������ �� �¼��� �������ּ���</h5>
		<form>
<%-- 	<h2>[���� 2�ܰ�]�¼������Դϴ�. ������ �����Ͻ� �󿵹�ȣ�� :
			<input type="text" name="screenContentNo" value="${screenContentNo}">
		</h2> --%>
	
			<input type="hidden" name="screenContentNo" value="${screenContentNo}">
			<h5><span><button onclick="selectCancelAlarm()" class="ui purple button">���ǥ �˸��� ��û�ϱ�</button>
			������ �¼���ȣ : <input type="text" id="display2" value=""></span></h5>
			<%-- <iframe id="child" src="http://127.0.0.1:52273/yenakoh/3?screenNo=${screenContentNo}" width="400" height="400" > --%>
			<iframe id="child" src="http://127.0.0.1:52273/yenakoh/3?screenNo=${screenContentNo}" 
			width="600" height="800" frameborder="0" scrolling="no">		 
					  <p>Your browser does not support iframes.</p>
			</iframe>
			
			<input type="hidden" name="seats" value="">
		</form>
	</div>
	</body>
</html>
