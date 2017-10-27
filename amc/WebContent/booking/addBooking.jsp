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
	user.setUserName("제이슨");
	user.setAddr("경기도 성남시 분당구");
	user.setAddrDetail("대왕판교로 477 서초구");
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
//imp초기화는 페이지 첫단에 해주는게 좋음
IMP.init('imp41659269');
	var things = "AMC : ";
	if( "${booking}"=="" ){
		things += "물품"
	}else{
		things += "예매"
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
						
				    	alert("impuid : " + rsp.imp_uid); //결제되서 여기는 뜸
				    	console.log("impuid : "+rsp.imp_uid);
				    	var impUid = rsp.imp_uid; 
				    	
				    	$.ajax({
				    		url: "/cinema/json/checkPay/"+impUid, //cross-domain error가 발생하지 않도록 동일한 도메인으로 전송
				    		type: 'GET',
				    	}).done(function(data) {
				    		alert("data : " + data);
				    		var payStatusCheck = (data.split(','))[0];
				    		var amountCheck = (data.split(','))[1];
				    		alert("payStatusCheck : "+payStatusCheck+"\n"+"amountCheck : "+amountCheck);
				    		
				    		//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
				    		if (  payStatusCheck == 'paid' && amountCheck == '${booking.totalTicketPrice}') {
				    			var msg = '결제가 완료되었습니다.';
				    			msg += '\n고유ID : ' + rsp.imp_uid;
				    			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
				    			msg += '\n결제 금액 : ' + rsp.paid_amount;
				    			msg += '\n카드 승인번호 : ' + rsp.apply_num;

				    			$("input[name='qrUrl']").val("https://chart.googleapis.com/chart?chs=150x150&cht=qr&chl="+impUid);
				    			$("input[name='impId']").val(impUid);
				    			
				    			alert("AJAX 후 결제완료 후 "+"\n"+msg);
				    			
				    			addBooking();
				    			
				    		} else {
				    			alert("AJAX 후 실패\n 결제 금액이 요청한 금액과 달라 결제를 자동취소처리 하였습니다");
				    			kakaoPayCancel(impUid);
				    			//[3] 아직 제대로 결제가 되지 않았습니다.
				    			//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
				    		}
				    	});
				    	
				    } else {
				        var msg = '결제에 실패하였습니다.';
				        var errorMsg = '실패사유 : ' + rsp.error_msg;
				        alert("AJAX 전 실패"+"\n"+msg+"\n"+errorMsg);
				    }//end of rsp.success else 
				}); //end of Imp.request_pay
			}//end of kakaoPay function
			
	function kakaoPayCancel(impUid){
		$.ajax({
		    		url: "/cinema/json/cancelPay/"+impUid,
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
						console.log('SeatNo 받아옴 : '+JSONData.str);								
                      if(JSONData != ""){
                      	$("#displaySeat").text(JSONData.str);
                      }//end of if문

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
	      <div class="title">영화정보 선택하기</div>
	      <div class="description">관람하실 영화정보를 선택하셨습니다.</div>
	    </div>
	  </div>
	  <div class="completed step">
	    <div class="content">
	      <div class="title">좌석 선택하기</div>
	      <div class="description">관람하실 영화의 좌석을 선택하셨습니다.</div>
	    </div>
	  </div>
	  <div class="active step">
	    <div class="content">
	      <div class="title">결제하기</div>
	      <div class="description">카카오페이로 결제하여 예매를 완료합니다.</div>
	    </div>
	  </div>
	</div>
	
<h2 class="ui header">
  	예매정보
  <div class="sub header">결제하시기 전 예매내역을 다시 한번 확인해 주세요.</div>
</h2>		
<div class="ui segment">
  <h3 class="ui right aligned header">
   	<!-- <input type="button" value="결제하기" onClick="javascript:addBooking()"/> -->
	<input type="button" value="결제하기" onClick="javascript:kakaoPay()"/>
	<input type="button" value="결제취소" onClick="javascript:kakaoPayCancel()"/>
  </h3>
<h2 class="ui center aligned icon header">
  <i class="circular users icon"></i>

  <div>	
		<%-- <div>::: ${booking.screenContent.movie.movieNm}</div>
		<div>여기는 상영넘버 : ${booking.screenContent.screenContentNo}</div> --%>
		<div>${booking.screenContent.previewTitle}</div>
		<div>영화명	킹스맨</div>
		<div>일시	${booking.screenContent.screenDate}&nbsp; ${booking.screenContent.screenOpenTime}</div>
		<div>상영관 	${booking.screenContent.screenTheater}</div>
		<div>인원 	${booking.headCount} </div>
		<div>좌석<span id="displaySeat">좌석번호</span></div>
		
		<h5>결제정보</h5>
		<div>결제금액 ${screenContent.ticketPrice}원</div>
		<div>결제수단  Kakaopay</div>
	</div>
</h2>
</div>
		
	<form>
	<!--  !!!!!!!!!!!!!!!!!!!!!!!!!input type hidden으로 나중에 바꾸기 -->
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




	
	
	<!-- <input type="button" value="결제하기" onClick="javascript:kakaoPay()"/> -->

	
	</div>
	</body>
</html>
