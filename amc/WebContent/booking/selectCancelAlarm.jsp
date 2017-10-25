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
	user.setUserName("제이슨");
	user.setAddr("경기도 성남시 분당구");
	user.setAddrDetail("대왕판교로 477 서초구");
	user.setPhone1("010");
	user.setPhone2("7116");
	user.setPhone3("7840");
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
	
	<!--  ///////////////////////// Sweetalert CDN ////////////////////////// -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	
<script>
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
	

</script>
<body>
<h2>[취소표 알림 신청] 취소표 알림을 위한 창입니다.</h2>

	<input type="button" value="취소표알림 신청" onClick="javascript:addCancelAlarm()"/>
	
	</body>
</html>
