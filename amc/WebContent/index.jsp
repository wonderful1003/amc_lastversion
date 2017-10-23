<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>




<c:if test="${ indexList eq null }">
 	<jsp:forward page="/cinema/index"/>
</c:if>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head> 
	<meta charset="EUC-KR">

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
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!--  CSS 추가 : 툴바에 화면 가리는 현상 해결 :  주석처리 전, 후 확인-->
	<style>
        body {
            padding-top : 70px;
        }
   	</style>
   	
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
</head>
	<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/topToolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
		<h2>Hello World!</h2>
		
		<!-- <iframe width="200" height="200" src="https://www.daum.net" >
			<p>not suport</p>
		</iframe> -->
		<h2>예매</h2>
		<h2><a href = "/booking/getScreenMovieList">영화 예매 1단계로 가기</a></h2>
		<h2><a href = "/booking/selectPreview.jsp">시사회 예매 1단계로 가기</a></h2>
		
		<!-- Modal 화면 tool bar로 부터 받아오기 시작	 --> 
		<div id="modal-testNew" class="modal fade" tabindex="-1" role="dialog" 
										aria-labelledby="테스트정보 등록" aria-describedby="테스트 모달">
		    <div class="modal-dialog" style="width:1200px;height:700px">
		        <div class="modal-content">
		        </div>
		    </div>
		</div> 
		<!-- Modal 화면 tool bar로 부터 받아오기 끝  --> 
		
		<div class="container">
	<!-- Carousel
    ================================================== -->
	    <div id="myCarousel" class="carousel slide" data-ride="carousel">
	      <!-- Indicators -->
	      <ol class="carousel-indicators">
	        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
	        <li data-target="#myCarousel" data-slide-to="1"></li>
	        <li data-target="#myCarousel" data-slide-to="2"></li>
	      </ol>
	      <div class="carousel-inner" role="listbox">
	        <div class="item active">
	          <img class="img-responsive center-block" src="http://cfile30.uf.tistory.com/image/276817415415E08412A0E5" alt="First slide"
	          		style="width:1000px; height:400px;">
	          <div class="container">
	            <div class="carousel-caption">
	              <h1></h1>
	              <p><code></code></p>
	            </div>
	          </div>
	        </div>
	        <div class="item">
	          <img class="img-responsive center-block" src="http://kr.visitanaheim.org/images/header_images/shopping.jpg" alt="Second slide"
	          		style="width:1000px; height:400px;">
	          <div class="container">
	            <div class="carousel-caption">
	              <h1></h1>
	              <br/>
	              <br/>
	              <p><a class="btn btn-lg btn-primary" href="/product/listProduct?menu=search" role="button">쇼핑하기</a></p>
	            </div>
	          </div>
	        </div>
	        <div class="item">
	          <img class="img-responsive center-block" src="http://cfile4.uf.tistory.com/image/2349963C50EBD2C336AFDC" alt="Second slide"
	          		style="width:1000px; height:400px;">
	          <div class="container">
	            <div class="carousel-caption">
	              <p></p>
	              <p><a class="btn btn-lg btn-primary" href="/user/getUser?userId=${sessionScope.user.userId}" role="button">개인정보 수정</a></p>
	            </div>
	          </div>
	        </div>
	      </div>
	      <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
	        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
	        <span class="sr-only">Previous</span>
	      </a>
	      <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
	        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
	        <span class="sr-only">Next</span>
	      </a>
	    </div><!-- /.carousel -->
    </div>
    <a href='/screen/getScreenContentList/10000'>영화 번호 10000의 상영정보보기</a>
    
    	<div style="background:yellow;border:1px solid #cccccc;">
		<p>현재 상영중인 영화</p>
		</div>
	    <c:set var="i" value="0" />
		  <c:forEach var="mainMovieList" items="${indexList.mainMovieList}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="left">${mainMovieList.movieNo }</td>
			  <td align="left"></td>
			  <td align="left">${mainMovieList.movieNm }</td>
			  <td align="left"></td>
			  <td align="left">${mainMovieList.postUrl }</td>
			  <td align="left"></td>
			</tr>
          </c:forEach>
          
          <br></br><br></br><br></br><br></br>
    	
    	<div style="background:yellow;border:1px solid #cccccc;">
		<p>신상품</p>
		</div>
	    <c:set var="i" value="0" />
		  <c:forEach var="newProductList" items="${indexList.newProductList}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="left">${newProductList.prodNo }</td>
			  <td align="left"></td>
			  <td align="left">${newProductList.prodType }</td>
			  <td align="left"></td>
			  <td align="left">${newProductList.prodName }</td>
			  <td align="left"></td>
  			  <td align="left">${newProductList.prodPrice }</td>
			  <td align="left"></td>
			  <td align="left">${newProductList.prodImage }</td>
			  <td align="left"></td>
			</tr>
          </c:forEach>
          
          <br></br><br></br><br></br><br></br>
          
        <div style="background:yellow;border:1px solid #cccccc;">
		<p>베스트 상품</p>
		</div>
	    <c:set var="i" value="0" />
		  <c:forEach var="topProductList" items="${indexList.topProductList}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="left">${topProductList.prodNo }</td>
			  <td align="left"></td>
			  <td align="left">${topProductList.prodType }</td>
			  <td align="left"></td>
			  <td align="left">${topProductList.prodName }</td>
			  <td align="left"></td>
  			  <td align="left">${topProductList.prodPrice }</td>
			  <td align="left"></td>
			  <td align="left">${topProductList.prodImage }</td>
			  <td align="left"></td>
			</tr>
          </c:forEach>
          
          <br></br><br></br><br></br><br></br>
	</body>
</html>