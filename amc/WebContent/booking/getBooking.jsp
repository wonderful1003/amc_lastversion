<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--   jQuery , Bootstrap CDN  -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!--   Modal CDN  -->
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script> 
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
<title>예매상세보기</title>
<script>
$( function() {
	
	$("#deleteBooking").on("click" , function() {
		if(confirm("예매를 취소하시겠습니까?")){
			var bookingNo = $("input[name='bookingNo']").val();
			self.location = "/booking/deleteBooking?bookingNo="+bookingNo;
		}		
	});

});

</script>
</head>
		
<body>
		<jsp:include page="/layout/topToolbar.jsp" /><br><br><br>

	<div class="container">
	<h2>예매상세보기 페이지입니다.</h2>
	<input type="hidden" name="bookingNo" value="${booking.bookingNo}">
			
	<table class="table table-hover table-striped" >
		<tbody>
			<tr align="center">
			  	<td>예매번호</td>
			  	<td>${booking.bookingNo}</td> 
			</tr>
			<tr align="center">
			  	<td>예매 가격</td>
			  	<td>${booking.totalTicketPrice}</td> 
			</tr>
			<tr align="center">
			  	<td>예매 좌석</td>
			  	<td>${booking.bookingSeatNo}</td> 
			</tr>
			<tr align="center">
			  	<td>영화제목</td>
			  	<td>${booking.movie.movieNm}</td> 
			</tr>				  
 
        </tbody>
      </table>

	</div>	
		 <div id="deleteBooking"><h3>▶예약취소하기</h3></div>
	</body>

	</body>
</html>
