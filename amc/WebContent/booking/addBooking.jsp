<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<!DOCTYPE html >
<html>
<head> 
<title>selectScreenMovie.jsp</title>
</head>
	<body>
		<h2>[����3�ܰ�] ������ ���� â�Դϴ�.</h2>
		
		<h2></h2>
	</body>
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

				    	jQuery.ajax({
				    		url: "https://api.iamport.kr/payments/complete", //cross-domain error�� �߻����� �ʵ��� ������ ���������� ����
				    		type: 'POST',
				    		dataType: 'json',
				    		data: {
					    		imp_uid : rsp.imp_uid
					    		//��Ÿ �ʿ��� �����Ͱ� ������ �߰� ����
				    		}
				    	}).done(function(data) {
				    		//[2] �������� REST API�� ��������Ȯ�� �� ���񽺷�ƾ�� �������� ���
				    		if ( everythings_fine ) {
				    			var msg = '������ �Ϸ�Ǿ����ϴ�.';
				    			msg += '\n����ID : ' + rsp.imp_uid;
				    			msg += '\n���� �ŷ�ID : ' + rsp.merchant_uid;
				    			msg += '\���� �ݾ� : ' + rsp.paid_amount;
				    			msg += 'ī�� ���ι�ȣ : ' + rsp.apply_num;

				    			alert(msg);
				    		} else {
				    			//[3] ���� ����� ������ ���� �ʾҽ��ϴ�.
				    			//[4] ������ �ݾ��� ��û�� �ݾװ� �޶� ������ �ڵ����ó���Ͽ����ϴ�.
				    		}
				    	});
				    	
				    } else {
				        var msg = '������ �����Ͽ����ϴ�.';
				        var errorMsg = '���л��� : ' + rsp.error_msg;
				    }//end of rsp.success else 
				    alert(msg+"\n"+errorMsg);
				}); //end of Imp.request_pay
			}//end of kakaoPay function
				 
		
				
						/* 
				    IMP.request_pay({
					    pg : 'kakao',
					    pay_method : 'kapy',
					    merchant_uid : '1' + new Date().getTime(),
					    name : 'order:test',
					    amount : 1000,
					    buyer_email : 'iamport@siot.do',
					    buyer_name : 'purchaseName',
					    buyer_tel : '010-1234-5678',
					    buyer_addr : 'Seoul',
					    buyer_postcode : '123-456'
						}, function(rsp) {
						    if ( rsp.success ) {
						    	jQuery.ajax({
						    		url : "/payments/complete",
						    		type : 'POST',
						    		dataType : 'json',
						    		data : {
						    			imp_uid : rsp.imp_uid
						    		}
						    	}).done(function(data){
						    		if(everythings_fine){
							    		var msg = 'pay ok.';
								        msg += 'ID : ' + rsp.imp_uid; 
								        msg += 'rjfo ID : ' + rsp.merchant_uid;
								        msg += 'price : ' + rsp.paid_amount;
								        msg += 'card accept : ' + rsp.apply_num;
								        alert(msg);
								    } else {
								        
								    }
						    	});
						    }
							else{
								var msg = 'pay fail.';
						        msg += 'error : ' + rsp.error_msg;
						        alert(msg);
							}    
						};
					}); */
	function addBooking(){
						
		$("form").attr("method" , "POST").attr("action" , "/booking/addBooking").submit();	
		
	}

	
</script>

	<input type="button" value="�����ϱ�" onClick="javascript:kakaoPay()"/>
	
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

</html>
