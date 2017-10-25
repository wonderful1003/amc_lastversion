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
<h2>[���ǥ �˸� ��û] ���ǥ �˸��� ���� â�Դϴ�.</h2>

	<input type="button" value="���ǥ�˸� ��û" onClick="javascript:addCancelAlarm()"/>
	
	</body>
</html>
