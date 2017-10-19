<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<!DOCTYPE html >
<html>
<head> 
<title>selectScreenMovie.jsp</title>
</head>
	<body>
		<h2>[예매3단계] 결제를 위한 창입니다.</h2>
		
		<h2></h2>
	</body>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>
//imp초기화는 페이지 첫단에 해주는게 좋음
IMP.init('imp41659269');
	
	function kakaoPay(){
				IMP.request_pay({
				    pg : 'kakao',
				    pay_method : 'kapy',
				    merchant_uid : 'merchant_' + new Date().getTime(),
				    name : 'AMC:예매',
				    amount : 1000,
				    buyer_email : 'iamport@siot.do',
				    buyer_name : '구매자이름',
				    buyer_tel : '010-1234-5678',
				    buyer_addr : '서울특별시 강남구 삼성동',
				    buyer_postcode : '123-456'
				}, function(rsp) {
				    if ( rsp.success ){

				    	jQuery.ajax({
				    		url: "https://api.iamport.kr/payments/complete", //cross-domain error가 발생하지 않도록 동일한 도메인으로 전송
				    		type: 'POST',
				    		dataType: 'json',
				    		data: {
					    		imp_uid : rsp.imp_uid
					    		//기타 필요한 데이터가 있으면 추가 전달
				    		}
				    	}).done(function(data) {
				    		//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
				    		if ( everythings_fine ) {
				    			var msg = '결제가 완료되었습니다.';
				    			msg += '\n고유ID : ' + rsp.imp_uid;
				    			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
				    			msg += '\결제 금액 : ' + rsp.paid_amount;
				    			msg += '카드 승인번호 : ' + rsp.apply_num;

				    			alert(msg);
				    		} else {
				    			//[3] 아직 제대로 결제가 되지 않았습니다.
				    			//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
				    		}
				    	});
				    	
				    } else {
				        var msg = '결제에 실패하였습니다.';
				        var errorMsg = '실패사유 : ' + rsp.error_msg;
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

	<input type="button" value="결제하기" onClick="javascript:kakaoPay()"/>
	
	<form>
	<!--  !!!!!!!!!!!!!!!!!!!!!!!!!input type hidden으로 나중에 바꾸기 -->
		<input type="text" name="userId" value="${session.user.userId}"/>
		<input type="text" name="screenContentNo" value="${screenContent.screenContentNo}"/>
		<input type="text" name="bookingSeatNo" value="${seats}"/>
		
	</form>

	<div>
		<div>여기는 상영넘버 : ${screenContent.screenContentNo}</div>
		<div>여기는 상영시간 : ${screenContent.screenOpenTime}</div>
		<div>여기는 상영가격 : ${screenContent.ticketPrice}</div>
		<div>여기는 좌석번호 : ${seats}</div>
	</div>

</html>
