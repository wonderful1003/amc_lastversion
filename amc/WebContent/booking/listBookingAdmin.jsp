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
	
	<!--  CSS �߰� : ���ٿ� ȭ�� ������ ���� �ذ� :  �ּ�ó�� ��, �� Ȯ��-->
	<style>
        body {
            padding-top : 70px;
        }
   	</style>
   	
	<script type="text/javascript">
			
		
		//A. ���Ź�ȣ Ŭ���� ���Ż������� �̵�
		$(document).on("click", ".bookingNo",  function(){
			
			var bookingNo =  $($(this).find("input[name='bookingNo']")).val();
			self.location = "/booking/getBooking?bookingNo="+bookingNo;
		});
		
		//B. ��ȭ���� Ŭ���� ��ȭ�������� �̵�
		$(document).on("click", ".movieName",  function(){
			
			var movieNo =  $($(this).find("input[name='movieNo']")).val();
			self.location = "/movie/getMovie?movieNo="+movieNo;
		});

	
	</script>
	
<title>listBookingAdmin.jsp</title>
</head>
	<body>
		<jsp:include page="/layout/topToolbar.jsp" /><br><br><br>
	
	<div class="container">
		<h2>�����ڿ� ���Ÿ�� ���� �������Դϴ�.</h2>
	<input type="hidden" name="flag" value="1">
			
	<table class="table table-hover table-striped" >
      
        <thead>
          <tr>
          	<th align="center">��ȣ</th>
            <th align="center">ȸ�����̵�</th>
            <th align="center">���Ź�ȣ</th>
            <th align="center">�����Ͻ�</th>
            <th align="center">��ȭ����</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		   <c:forEach var="booking" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${i}</td>
			  <td align="center">${booking.userId}</td>
			  <td align="center" class="bookingNo">${booking.bookingNo}
			  	<input type="hidden" name="bookingNo" value="${booking.bookingNo}">
			  </td>	
			  <td align="center">${booking.bookingRegDate}</td>		  
			  <td align="left" class="movieName">${booking.movie.movieNm} 
			  	<input type="hidden" name="movieNo" value="${booking.movie.movieNo}">
			  </td>
			</tr>
          </c:forEach>
        
        </tbody>
      </table>
	</div>	
	</body>
</html>
