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

<style type="text/css">
	button.ui.inverted.purple.button{
	font-size: 1.8rem;
	}

	div.ui.red.horizontal.label {
	 font-size: 1.52rem;
	}
	
</style>
<script>
		function listener(event){		
			  document.getElementById('child').contentWindow.postMessage(event.data,"*");
			  //console.log("event.data : "+event.data);
			  if(event.data == 'pay'){
				  alert('������û��!');
				  requestPay();	  
				
			  }else if(event.data == 'failed'){
				  var screenNo = ${screenContent.screenContentNo}+"";
				  self.location="/booking/selectSeat?screenContentNo="+screenNo+"";				  
			  }else{
				  $("input[name='seats']").val(event.data);
					console.log('data : '+event.data);
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
	                        	$("#displaySeat").text(JSONData.str);
	                        }//end of if��

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
	<jsp:include page="/layout/topToolbar.jsp" /><br><br><br><br><br><br>
	<div class="container">
	<div class="ui ordered steps">
	  <div class="completed step">
	    <div class="content">
	      <div class="title">�û�ȸ���� �����ϱ�</div>
	      <div class="description">�����Ͻ� �û�ȸ������ �����մϴ�.</div>
	    </div>
	  </div>
	  <div class="compeleted step">
	    <div class="content">
	      <div class="title">�����¼� �̿��ϱ�</div>
	      <div class="description">�����Ͻ� �û�ȸ�� �¼��� �������� ���õǾ����ϴ�.</div>
	    </div>
	  </div>
	  <div class="active step">
	    <div class="content">
	      <div class="title">�����ϱ�</div>
	      <div class="description">īī�����̷� �����Ͽ� ���Ÿ� �Ϸ��մϴ�.</div>
	    </div>
	  </div>
	</div>	
	
		<form>
		
		<input type="hidden" name="screenContentNo" value="${screenContent.screenContentNo}">
		<button onclick="requestPay()" class="ui inverted purple button">�����ϱ�</button>
		<div class="ui divided selection list">		  	    
		    <div class="ui red horizontal label" id="displaySeat"></div> �������� ���õ� �¼��Դϴ�.
		    ������ ���Ÿ� �Ϸ��Ͻô� ���� �� �¼��� Ȧ���Ǿ��ֽ��ϴ�.	  		
		</div>
			
			<input type="hidden" name="seats" value="">		
			<%-- <iframe id="child" src="http://127.0.0.1:52273/random_select?
			screenNo=${screenContent.screenContentNo}&count=${headCount}" width="600" height="400" > --%>
			<iframe id="child" src="http://127.0.0.1:52273/random_select?screenNo=10303&headCount=${headCount}"
			 width="600" height="500" frameborder="0" scrolling="no">		 
					  <p>Your browser does not support iframes.</p>
			</iframe>
			
			
								
		</form>
		</div>
	</body>
</html>
