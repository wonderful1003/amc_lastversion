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
<title>���Ż󼼺���</title>
<script>
$( function() {
	
	$("#deleteBooking").on("click" , function() {
		if(confirm("���Ÿ� ����Ͻðڽ��ϱ�?")){
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
	<h2>���Ż󼼺��� �������Դϴ�.</h2>
	<input type="hidden" name="bookingNo" value="${booking.bookingNo}">
			
	<table class="table table-hover table-striped" >
		<tbody>
			<tr align="center">
			  	<td>���Ź�ȣ</td>
			  	<td>${booking.bookingNo}</td> 
			</tr>
			<tr align="center">
			  	<td>���� ����</td>
			  	<td>${booking.totalTicketPrice}</td> 
			</tr>
			<tr align="center">
			  	<td>���� �¼�</td>
			  	<td>${booking.bookingSeatNo}</td> 
			</tr>
			<tr align="center">
			  	<td>��ȭ����</td>
			  	<td>${booking.movie.movieNm}</td> 
			</tr>				  
 
        </tbody>
      </table>

	</div>	
		 <div id="deleteBooking"><h3>����������ϱ�</h3></div>
	</body>

	</body>
</html>
