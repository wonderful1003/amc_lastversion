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
	
	<!--   semantic UI  -->
	<link rel="stylesheet" type="text/css" href="../semantic/semantic.min.css">
	<script
	  src="https://code.jquery.com/jquery-3.1.1.min.js"
	  integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
	  crossorigin="anonymous"></script>
	<script src="../semantic/semantic.min.js"></script>
	
	<style type="text/css">
	body {
        padding-top : 70px;
    }
	</style>

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
						console.log('SeatNo �޾ƿ� : '+JSONData.str);								
	                    if(JSONData != ""){
	                    	$("#display2").val(JSONData.str);
	                    }//end of if��
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
			var userId = $("input[name='userId']").val(); 
			if( userId == null || userId == ''){
				swal({
					  title: '��û ����',
					  html: $('<div>')
					    .addClass('some-class')
					    .text('�α��� ���°� �ƴմϴ�'),
					  animation: false,
					  customClass: 'animated swing'
					})
				return;
			}
			$.ajax({
			    		url: "/alarm/json/addCancelAlarm/",
			    		type: 'POST',
			    	}).done(function(result) {
			    		console.log("result : " + result);
			    		if ( result == 'success' ) {
			    			var msg = '���ǥ �˸� ��û ����';
			    			swal({
			    				  //position: 'top-right',
			    				  type: 'success',
			    				  title: '���ǥ �˸� ��û ����!',
			    				  showConfirmButton: true,
			    				  timer: 2000
			    				})
			    		} else if( result == 'exceed'){
			    			swal(
			    					  '���ǥ�˸� �ڸ� �� �ʰ�!',
			    					  '��û ������ ���ǥ�˸� �� �ʰ� (�ִ� 4 �¼�)',
			    					  'error'
			    					)
			    		} else {
			    			swal(
			    					  '�ߺ� �¼� ��û!',
			    					  '��û�� �¼� �� ������ �ߺ��� �¼��� �ֽ��ϴ�.'+"\n"+result,
			    					  'error'
			    					)
			    		}
			    	});
		}	
			
		
</script>

</head>
	<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/topToolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	<div class="container"> 
   		<input type="hidden" name="userId" value="${sessionScope.user.userId}" >
		<form>
			<div align="center" class="alert alert-info" role="alert">
				<h4><strong>���ǥ �˸��� ��û</strong>&nbsp;&nbsp;[�ִ� 4�ڸ� ��û ����]</h4>
	      	</div>
      	
			<!-- hiddenŸ������ �ٲٱ� -->
			<input type="hidden" name="screenContentNo" value="${screenContentNo}" disabled>
		<div class="col-md-12">
				<div class="col-md-8">
				<%-- <iframe id="cancelAlarm" src="http://192.168.0.7:52273/cancelAlarm?screenNo=${screenContentNo}" width="600" height="400" > --%>
				<iframe id="cancelAlarm" 
						src="http://127.0.0.1:52273/cancelAlarm?screenNo=10000"
						width="600" height="400" align="left">		 
						  <p>Your browser does not support iframes.</p>
				</iframe>
				</div>
				<div class="col-md-4">
				<div class="ui container">
					<p/>
					<div class="ui top attached warning icon message">
					    <i class="attention icon"></i>
					    <div class="content">
					      	���ǥ �˸� ��û �¼�
					    </div>
				 	</div>
					<table class="ui bottom attached table">
					    <tbody>
					      <tr>
					        <td>seatNo</td>
					      </tr>
					      <tr>
					        <td>seatNo</td>
					      </tr>
					      <tr>
					        <td>seatNo</td>
					      </tr>
					      <tr>
					        <td>seatNo</td>
					      </tr>
					    </tbody>
				  	</table>
				  	
				  	<button class="ui blue button" 
					style="font-size:20px; height:50px;width:300px" 
					onClick="javascript:addCancelAlarm()">
					���ǥ �˸� ��û</button>
					
				  	</div>
				</div>
		</div>
		<input type="hidden" name="seats" value="" disabled>
		<!-- <input type="text" id="display2" value=""> -->
		<input type="hidden" name="seats" value="">
		</form>
	</div>
	</body>
</html>
