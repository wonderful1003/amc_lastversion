<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<style>
	  body {
            padding-top : 50px;
        }
    </style>

<title>selectScreenMovie.jsp</title>
</head>
	<body>
	<div class="container">
		<h2>[����1�ܰ�]��ȭ �������� ������ �ּ���.</h2>
			
	<table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">��ȭ����</th>
            <th align="center">��ȭ��ȣ</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		   <c:forEach var="movie" items="${movieList}">
			<c:set var="i" value="${ i+1 }" />
			<tr>

			  <td align="center">${ i } ��ȣ������ �κ�</td>			  
			  <td align="left">${movie.movieNm} ���񳪿��� �κ�
			  	<input type="hidden" value="${movie.movieNo}">
			  </td>
			  <td align="left">${movie.movieNo} ��ȣ������ �κ�</td>
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	</div>	
		<h2>&nbsp;&nbsp;<a href="http://127.0.0.1:52273/yenakoh/3?screenNo=1020">���¼������ϱ�</a></h2>
	</body>
</html>
