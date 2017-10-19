<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!-- /////////////JSTL/////////////-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	
	function kakaoPay(){
				IMP.request_pay({
				    pg : 'kakao',
				    pay_method : 'kapy',
				    merchant_uid : 'merchant_' + new Date().getTime(),
				    name : 'AMC:����',
				    amount : 1000,
				    buyer_email : 'iamport@siot.do',
				    buyer_name : '�������̸�',
				    buyer_tel : '010-1234-5678',
				    buyer_addr : '����Ư���� ������ �Ｚ��',
				    buyer_postcode : '123-456'
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
</script>
	<body>
		<h2>[����3�ܰ�] ������ ���� â�Դϴ�.</h2>
		
		<h2></h2>
		
		<input type="button" value="�����ϱ�" onClick="javascript:kakaoPay()"/>
	
		<input type="button" value="�������" onClick="javascript:kakaoPayCancel()"/>
	
	</body>
</html>
