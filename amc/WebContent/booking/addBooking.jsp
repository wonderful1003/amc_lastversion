<%@page import="com.amc.service.domain.Booking"%>
<%@page import="com.amc.service.domain.User"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!-- /////////////JSTL/////////////-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--  <%
	User user = new User();
	user.setUserId("test@naver.com");
	user.setRole("user");
	user.setUserName("���̽�");
	user.setAddr("��⵵ ������ �д籸");
	user.setAddrDetail("����Ǳ��� 477 ���ʱ�");
	user.setPhone1("010");
	user.setPhone2("7116");
	user.setPhone3("7840");
	user.setGender("M");
	user.setBirth("1979/01/01");
	session.setAttribute("user", user);
	
	Booking booking = new Booking();
	booking.setTotalTicketPrice(1111);
	session.setAttribute("booking",booking);
%>  --%>

<!DOCTYPE html >
<html>
<head> 
<title>selectScreenMovie.jsp</title>
</head>
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<link rel="stylesheet" type="text/css" href="/semantic/semantic.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"
	integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
  	crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.js" ></script>
	
	<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	
	<!--  ///////////////////////// Sweetalert CDN ////////////////////////// -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	
<script>
//imp�ʱ�ȭ�� ������ ù�ܿ� ���ִ°� ����
IMP.init('imp41659269');
	var things = "AMC : ";
	if( "${booking}"=="" ){
		things += "��ǰ"
	}else{
		things += "����"
	}
	
	function kakaoPay(){
				IMP.request_pay({
				    pg : 'kakao',
				    pay_method : 'kapy',
				    merchant_uid : 'merchant_' + new Date().getTime(),
				    name : things,
				    amount : "${booking.totalTicketPrice}", /* ticket or product price */
				    buyer_email : "${user.userId}",
				    buyer_name : "${user.userName}",
				    buyer_tel : "${user.phone1}-${user.phone2}-${user.phone3}",
				    buyer_addr : "${user.addr}+${user.addrDetail}"
				}, function(rsp) {
				    if ( rsp.success ){
						
				    	alert("impuid : " + rsp.imp_uid); //�����Ǽ� ����� ��
				    	console.log("impuid : "+rsp.imp_uid);
				    	var impUid = rsp.imp_uid; 
				    	
				    	$.ajax({
				    		url: "/cinema/json/checkPay/"+impUid, //cross-domain error�� �߻����� �ʵ��� ������ ���������� ����
				    		type: 'GET',
				    	}).done(function(data) {
				    		alert("data : " + data);
				    		var payStatusCheck = (data.split(','))[0];
				    		var amountCheck = (data.split(','))[1];
				    		alert("payStatusCheck : "+payStatusCheck+"\n"+"amountCheck : "+amountCheck);
				    		
				    		//[2] �������� REST API�� ��������Ȯ�� �� ���񽺷�ƾ�� �������� ���
				    		if (  payStatusCheck == 'paid' && amountCheck == '${booking.totalTicketPrice}') {
				    			var msg = '������ �Ϸ�Ǿ����ϴ�.';
				    			msg += '\n����ID : ' + rsp.imp_uid;
				    			msg += '\n���� �ŷ�ID : ' + rsp.merchant_uid;
				    			msg += '\n���� �ݾ� : ' + rsp.paid_amount;
				    			msg += '\nī�� ���ι�ȣ : ' + rsp.apply_num;

				    			$("input[name='qrUrl']").val("https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl="+impUid);
				    			$("input[name='impId']").val(impUid);
				    			
				    			alert("AJAX �� �����Ϸ� �� "+"\n"+msg);
				    			
				    			addBooking();
				    			
				    		} else {
				    			alert("AJAX �� ����\n ���� �ݾ��� ��û�� �ݾװ� �޶� ������ �ڵ����ó�� �Ͽ����ϴ�");
				    			kakaoPayCancel(impUid);
				    			//[3] ���� ����� ������ ���� �ʾҽ��ϴ�.
				    			//[4] ������ �ݾ��� ��û�� �ݾװ� �޶� ������ �ڵ����ó���Ͽ����ϴ�.
				    		}
				    	});
				    	
				    } else {
				        var msg = '������ �����Ͽ����ϴ�.';
				        var errorMsg = '���л��� : ' + rsp.error_msg;
				        alert("AJAX �� ����"+"\n"+msg+"\n"+errorMsg);
				    }//end of rsp.success else 
				}); //end of Imp.request_pay
			}//end of kakaoPay function
			
	function kakaoPayCancel(impUid){
		$.ajax({
		    		url: "/cinema/json/cancelPay/"+impUid,
		    		type: 'GET',
		    	}).done(function(data) {
		    		alert("data : " + data);
		    		//[2] �������� REST API�� ��������Ȯ�� �� ���񽺷�ƾ�� �������� ���
		    		if ( data == 'cancelled' ) {
		    			var msg = '��Ұ� ���������� ó���Ǿ����ϴ�.';
		    			/* msg += '\n����ID : ' + rsp.imp_uid;
		    			msg += '\n���� �ŷ�ID : ' + rsp.merchant_uid;
		    			msg += '\n���� �ݾ� : ' + rsp.paid_amount;
		    			msg += '\nī�� ���ι�ȣ : ' + rsp.apply_num; */

		    			alert("���۽� ��� �� "+"\n"+msg);
		    			
		    			//location.href="/index.jsp"
		    			location.href="/#"
		    			
		    		} else {
		    			alert("��Ұ� �����Ͽ����ϴ�.");
		    			//[3] ���� ����� ������ ���� �ʾҽ��ϴ�.
		    			//[4] ������ �ݾ��� ��û�� �ݾװ� �޶� ������ �ڵ����ó���Ͽ����ϴ�.
		    		}
		    	});
	}//end of kakaoPayCancel function	
	
	function addBooking(){
						
		$("form").attr("method" , "POST").attr("action" , "/booking/addBooking").submit();	
		
	}
	
	function a(){
		$("input[name='qrUrl']").val("https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=123");
		alert($("input[name='qrUrl']").val());
	}
	
	$(document).ready(function() {
		var seatNo ="${booking.bookingSeatNo}"; 
	  $.ajax(
				{
					url : "/booking/json/getDisplaySeatNo/"+seatNo,						
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
	})
</script>
		

<body>
	<jsp:include page="/layout/topToolbar.jsp" /><br><br><br><br><br><br>
 	<div class="container">
	
	<div class="ui ordered steps">
	  <div class="completed step">
	    <div class="content">
	      <div class="title">��ȭ���� �����ϱ�</div>
	      <div class="description">�����Ͻ� ��ȭ������ �����ϼ̽��ϴ�.</div>
	    </div>
	  </div>
	  <div class="completed step">
	    <div class="content">
	      <div class="title">�¼� �����ϱ�</div>
	      <div class="description">�����Ͻ� ��ȭ�� �¼��� �����ϼ̽��ϴ�.</div>
	    </div>
	  </div>
	  <div class="active step">
	    <div class="content">
	      <div class="title">�����ϱ�</div>
	      <div class="description">īī�����̷� �����Ͽ� ���Ÿ� �Ϸ��մϴ�.</div>
	    </div>
	  </div>
	</div>
	
<h2 class="ui header">
  	��������
  <div class="sub header">�����Ͻñ� �� ���ų����� �ٽ� �ѹ� Ȯ���� �ּ���.</div>
</h2>		
<div class="ui segment">
  <h3 class="ui right aligned header">
   	<!-- <input type="button" value="�����ϱ�" onClick="javascript:addBooking()"/> -->
	<input type="button" value="�����ϱ�" onClick="javascript:kakaoPay()"/>
	<input type="button" value="�������" onClick="javascript:kakaoPayCancel()"/>
  </h3>
<h2 class="ui center aligned icon header">
  <i class="circular users icon"></i>

  <div>	
		<%-- <div>::: ${booking.screenContent.movie.movieNm}</div>
		<div>����� �󿵳ѹ� : ${booking.screenContent.screenContentNo}</div> --%>
		<div>${booking.screenContent.previewTitle}</div>
		<div>��ȭ��	ŷ����</div>
		<div>�Ͻ�	${booking.screenContent.screenDate}&nbsp; ${booking.screenContent.screenOpenTime}</div>
		<div>�󿵰� 	${booking.screenContent.screenTheater}</div>
		<div>�ο� 	${booking.headCount} </div>
		<div>�¼�<span id="displaySeat">�¼���ȣ</span></div>
		
		<h5>��������</h5>
		<div>�����ݾ� ${screenContent.ticketPrice}��</div>
		<div>��������  Kakaopay</div>
	</div>
</h2>
</div>
		
	<form>
	<!--  !!!!!!!!!!!!!!!!!!!!!!!!!input type hidden���� ���߿� �ٲٱ� -->
		<input type="hidden" name="userId" value="${sessionScope.user.userId}"/>
		<input type="hidden" name="screenContentNo" value="${booking.screenContent.screenContentNo}"/>
		<input type="hidden" name="bookingSeatNo" value="${booking.bookingSeatNo}"/>
		<!-- <input type="hidden" name="impId" value=""/>  -->
		<input type="hidden" name="impId" value="abc"/>
		<input type="hidden" name="headCount" value="${booking.headCount}"/>
		<input type="hidden" name="totalTicketPrice" value="${booking.totalTicketPrice}"/>
		<!-- <input type="hidden" name="qrUrl" value=""/> -->
		<input type="hidden" name="qrUrl" value="https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl=abc"/>
		
	</form>




	
	
	<!-- <input type="button" value="�����ϱ�" onClick="javascript:kakaoPay()"/> -->

	
	</div>
	</body>
</html>
