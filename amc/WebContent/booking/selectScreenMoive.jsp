<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
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
		<h2>[예매1단계]영화 상영정보를 선택해 주세요.</h2>
			
	<table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">영화제목</th>
            <th align="center">영화번호</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		   <c:forEach var="movie" items="${movieList}">
			<c:set var="i" value="${ i+1 }" />
			<tr>

			  <td align="center">${ i } 번호나오는 부분</td>			  
			  <td align="left">${movie.movieNm} 제목나오는 부분
			  	<input type="hidden" value="${movie.movieNo}">
			  </td>
			  <td align="left">${movie.movieNo} 번호나오는 부분</td>
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	</div>	
		<h2>&nbsp;&nbsp;<a href="http://127.0.0.1:52273/yenakoh/3?screenNo=1020">▶좌석선택하기</a></h2>
	</body>
</html>
