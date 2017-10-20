<%@page import="com.amc.service.domain.User"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!-- /////////////JSTL/////////////-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	User user = new User();
	user.setUserId("sadf@naver.com");
	user.setRole("user");
	user.setUserName("제이슨");
	user.setAddr("경기도 성남시 분당구");
	user.setAddrDetail("대왕판교로 477 서초구");
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
//imp초기화는 페이지 첫단에 해주는게 좋음
IMP.init('imp41659269');
	
	var things = "티켓";
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
						
				    	alert("impuid : " + rsp.imp_uid); //결제되서 여기는 뜸
				    	console.log("impuid : "+rsp.imp_uid);
				    	var impUid = rsp.imp_uid; 
				    	
				    	$.ajax({
				    		url: "/cinema/json/checkPay/"+impUid, //cross-domain error가 발생하지 않도록 동일한 도메인으로 전송
				    		type: 'GET',
				    	}).done(function(data) {
				    		alert("data : " + data);
				    		//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
				    		if ( data == 'paid' ) {
				    			var msg = '결제가 완료되었습니다.';
				    			msg += '\n고유ID : ' + rsp.imp_uid;
				    			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
				    			msg += '\n결제 금액 : ' + rsp.paid_amount;
				    			msg += '\n카드 승인번호 : ' + rsp.apply_num;

				    			alert("아작스 후 결제완료 후 "+"\n"+msg);
				    			
				    			location.href="/index.jsp"
				    			//location.href="/#"
				    			
				    		} else {
				    			alert("결제 금액이 요청한 금액과 달라 결제를 자동취소처리 하였습니다");
				    			//[3] 아직 제대로 결제가 되지 않았습니다.
				    			//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
				    		}
				    	});
				    	
				    } else {
				        var msg = '결제에 실패하였습니다.';
				        var errorMsg = '실패사유 : ' + rsp.error_msg;
				        alert("아작스도 안들어간 실패"+"\n"+msg+"\n"+errorMsg);
				    }//end of rsp.success else 
				}); //end of Imp.request_pay
			}//end of kakaoPay function
			
			
	function kakaoPayCacnel(){
		    		$.ajax({
					    		url: "/cinema/json/cancelPay/"+impUid, //cross-domain error가 발생하지 않도록 동일한 도메인으로 전송
					    		type: 'GET',
					    	}).done(function(data) {
					    		alert("data : " + data);
					    		//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
					    		if ( data == 'cancelled' ) {
					    			var msg = '취소가 성공적으로 처리되었습니다.';
					    			/* msg += '\n고유ID : ' + rsp.imp_uid;
					    			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
					    			msg += '\n결제 금액 : ' + rsp.paid_amount;
					    			msg += '\n카드 승인번호 : ' + rsp.apply_num; */
	
					    			alert("아작스 취소 후 "+"\n"+msg);
					    			
					    			//location.href="/index.jsp"
					    			location.href="/#"
					    			
					    		} else {
					    			alert("취소가 실패하였습니다.");
					    			//[3] 아직 제대로 결제가 되지 않았습니다.
					    			//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
					    		}
					    	});
			}//end of kakaoPayCancel function	

	function addBooking(){
						
		$("form").attr("method" , "POST").attr("action" , "/booking/addBooking").submit();	
		
	}

	
</script>
<body>
<h2>[예매3단계] 결제를 위한 창입니다.</h2>

	<input type="button" value="결제하기" onClick="javascript:kakaoPay()"/>
	<input type="button" value="결제취소" onClick="javascript:kakaoPayCancel()"/>
	
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
	</body>
</html>
