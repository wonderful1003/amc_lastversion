<%@page import="com.amc.service.domain.Booking"%>
<%@page import="com.amc.service.domain.User"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!-- /////////////JSTL/////////////-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	User user = new User();
	user.setUserId("sadf@naver.com");
	user.setRole("user");
	user.setUserName("���̽�");
	user.setAddr("��⵵ ������ �д籸");
	user.setAddrDetail("����Ǳ��� 477 ���ʱ�");
	user.setPhone1("010");
	user.setPhone2("7116");
	user.setPhone3("7840");
	session.setAttribute("user", user);
	
	Booking booking = new Booking();
	booking.setTotalTicketPrice(1111);
	session.setAttribute("booking",booking);
%>

<!DOCTYPE html >
<html>
<head> 
<title>selectScreenMovie.jsp</title>
</head>
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	
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
	

</script>
<body>
<h2>[����3�ܰ�] ������ ���� â�Դϴ�.</h2>

	<input type="button" value="�����ϱ�" onClick="javascript:kakaoPay()"/>
	<input type="button" value="�������" onClick="javascript:kakaoPayCancel()"/>
	
	<form>
	<!--  !!!!!!!!!!!!!!!!!!!!!!!!!input type hidden���� ���߿� �ٲٱ� -->
		<input type="text" name="userId" value="${session.user.userId}"/>
		<input type="text" name="screenContentNo" value="${booking.screenContent.screenContentNo}"/>
		<input type="text" name="bookingSeatNo" value="${booking.bookingSeatNo}"/>
		<input type="text" name="impId" value=""/>
		<input type="text" name="headCount" value="${booking.headCount}"/>
		<input type="text" name="totalTicketPrice" value="${booking.totalTicketPrice}"/>
		<input type="hidden" name="qrUrl" value=""/>
		
	</form>

	<div>
		<div>����� �󿵳ѹ� : ${booking.screenContent.screenContentNo}</div>
		<div>�����Ͻ� �󿵽ð� : ${booking.screenContent.screenOpenTime}</div>
		<div>�� ��ȭ(�û�ȸ)�� �¼��� ���� : ${screenContent.ticketPrice}</div>
		<div>������ �¼���ȣ : ${booking.bookingSeatNo}</div>
	</div>
	</body>
</html>
