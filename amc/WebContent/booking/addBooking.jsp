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
	user.setPhone2("7777");
	user.setPhone3("8888");
	session.setAttribute("user", user);
	
	
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
	
	var things = "Ƽ��";
	function kakaoPay(){
				IMP.request_pay({
				    pg : 'kakao',
				    pay_method : 'kapy',
				    merchant_uid : 'merchant_' + new Date().getTime(),
				    name : 'AMC:'+things,
				    amount : 1000, //ticket or product price
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
				    		//[2] �������� REST API�� ��������Ȯ�� �� ���񽺷�ƾ�� �������� ���
				    		if ( data == 'paid' ) {
				    			var msg = '������ �Ϸ�Ǿ����ϴ�.';
				    			msg += '\n����ID : ' + rsp.imp_uid;
				    			msg += '\n���� �ŷ�ID : ' + rsp.merchant_uid;
				    			msg += '\n���� �ݾ� : ' + rsp.paid_amount;
				    			msg += '\nī�� ���ι�ȣ : ' + rsp.apply_num;

				    			alert("���۽� �� �����Ϸ� �� "+"\n"+msg);
				    			
				    			location.href="/index.jsp"
				    			//location.href="/#"
				    			
				    		} else {
				    			alert("���� �ݾ��� ��û�� �ݾװ� �޶� ������ �ڵ����ó�� �Ͽ����ϴ�");
				    			//[3] ���� ����� ������ ���� �ʾҽ��ϴ�.
				    			//[4] ������ �ݾ��� ��û�� �ݾװ� �޶� ������ �ڵ����ó���Ͽ����ϴ�.
				    		}
				    	});
				    	
				    } else {
				        var msg = '������ �����Ͽ����ϴ�.';
				        var errorMsg = '���л��� : ' + rsp.error_msg;
				        alert("���۽��� �ȵ� ����"+"\n"+msg+"\n"+errorMsg);
				    }//end of rsp.success else 
				}); //end of Imp.request_pay
			}//end of kakaoPay function
			
			
	function kakaoPayCacnel(){
		    		$.ajax({
					    		url: "/cinema/json/cancelPay/"+impUid, //cross-domain error�� �߻����� �ʵ��� ������ ���������� ����
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

	
</script>
<body>
<h2>[����3�ܰ�] ������ ���� â�Դϴ�.</h2>

	<input type="button" value="�����ϱ�" onClick="javascript:kakaoPay()"/>
	<input type="button" value="�������" onClick="javascript:kakaoPayCancel()"/>
	
	<form>
	<!--  !!!!!!!!!!!!!!!!!!!!!!!!!input type hidden���� ���߿� �ٲٱ� -->
		<input type="text" name="userId" value="${session.user.userId}"/>
		<input type="text" name="screenContentNo" value="${screenContent.screenContentNo}"/>
		<input type="text" name="bookingSeatNo" value="${seats}"/>
		
	</form>

	<div>
		<div>����� �󿵳ѹ� : ${screenContent.screenContentNo}</div>
		<div>����� �󿵽ð� : ${screenContent.screenOpenTime}</div>
		<div>����� �󿵰��� : ${screenContent.ticketPrice}</div>
		<div>����� �¼���ȣ : ${seats}</div>
	</div>
	</body>
</html>
