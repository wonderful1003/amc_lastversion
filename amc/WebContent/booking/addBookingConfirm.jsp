<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html >
<html>
<head> 
<title>selectScreenMovie.jsp</title>
</head>
	<body>
		<jsp:include page="/layout/topToolbar.jsp" /><br><br><br>
	
		<h2>예매가 완료되었습니다!.</h2>
		<h6>불라불라불라 결제 됐는데 불라불라불라 정보정보정보</h6>
		<div style="background:yellow;border:1px solid #cccccc;">
		<p>현재 상영중인 영화</p>
		</div>
		<ul>
			<li>${booking.bookingNo}</li>
			<li>${booking.impId}</li>
			<li>${booking.userId}</li>
			<li>${booking.screenContentNo}</li>
			<li>${booking.bookingRegDate}</li>
			<li>${booking.headCount}</li>
			<li>${booking.totalTicketPrice}</li>
			<li>${booking.bookingSeatNo}</li>
		</ul>
		<iframe id="child" src="${booking.qrUrl}" 
		width="600" height="800" frameborder="0" scrolling="no">		 
					  <p>Your browser does not support iframes.</p>
		</iframe> 		
	</body>
</html>
