<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
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
	
	<!--  CSS �߰� : ���ٿ� ȭ�� ������ ���� �ذ� :  �ּ�ó�� ��, �� Ȯ��-->
	<style type="text/css">
	}
    body {
        padding-top : 100px;
    }
    </style>



</head>
<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/topToolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
<br></br>
	<div class="container">
	<br/><br/><br/>
			<div class="panel panel-success"> <!-- ��翵ȭ �˻� -->
	            <div class="panel-heading">
	              <div class="panel-title"><h2>��ȭ �˻� ���</h2></div>
	            </div>
	            <div class="panel-body">
	               <c:set var="i" value="0" />
					  <c:forEach var="movie" items="${unifiedSearch.uniMovieList}">
						<c:set var="i" value="${ i+1 }" />
						<div class="col-xs-6 col-md-4" >
						<a class='thumbnail' href="/movie/getMovie?movieNo=${movie.movieNo}&menu=search" style="text-decoration:none;">
							<img src="${movie.postUrl }">
						</a>
								<span><strong>��ȭ�� : ${movie.movieNm }</strong></span>
							    <span><li> ������ : ${movie.openDt }</li></span>	   
							    <div style="text-align: left;">
    						    </div>								
						<hr/>       
						</div>	
			        </c:forEach>
	            </div>
	          </div><!-- ��ȭ �ǳ� �� -->
	          <div class="panel panel-info"> <!-- �û�ȸ �˻� -->
	            <div class="panel-heading">
	              <div class="panel-title"><h2>�û�ȸ �˻� ���</h2></div>
	            </div>
	            <div class="panel-body">
		            <c:set var="i" value="0" />
						  <c:forEach var="screenContent" items="${unifiedSearch.uniPreviewList}">
							<c:set var="i" value="${ i+1 }" />
							<div class="col-xs-6 col-md-4" >
							<a class='thumbnail' href="/movie/getMovie?movieNo=${movie.movieNo}&menu=search" style="text-decoration:none;">
								<img src="${screenContent.movie.postUrl }">
							</a>
									<span><strong>�û�ȸ�� : ${screenContent.previewTitle }</strong></span>
								    <span><li> Ƽ�� ���� ��¥ : ${screenContent.ticketOpenDate }</li></span>	   
								    <div style="text-align: left;">
	    						    </div>								
							<hr/>       
							</div>	
				        </c:forEach>
	            </div>
	          </div><!-- �û�ȸ �ǳ� �� -->
	        <div class="panel panel-warning"> <!-- ���� �˻� -->
	            <div class="panel-heading">
	              <div class="panel-title"><h2>���� �˻� ���</h2></div>
	            </div>
	            <div class="panel-body">
	            		<c:set var="i" value="0" />
						  <c:forEach var="goods" items="${unifiedSearch.uniGoodsList}">
							<c:set var="i" value="${ i+1 }" />
							<div class="col-xs-6 col-md-4" >
							<a class='thumbnail' href="/product/getGoodsProduct?prodNo=${goods.prodNo}" style="text-decoration:none;">
								<img src="/images/uploadFiles/${goods.prodImage}">
							</a>
									<span><strong>��ǰ�� : ${goods.prodName }</strong></span>
								    <span><li> ���� : ${goods.prodPrice }</li></span>	   
								    <div style="text-align: left;">
	    						    </div>								
							<hr/>       
							</div>	
				          </c:forEach>
	            </div>
	          </div><!-- ���� �ǳ� �� -->
	        <div class="panel panel-danger"> <!-- ���� �˻� -->
	            <div class="panel-heading">
	              <div class="panel-title"><h2>���� �˻� ���</h2></div>
	            </div>
	            <div class="panel-body">
	            		<c:set var="i" value="0" />
						  <c:forEach var="snack" items="${unifiedSearch.uniSnackList}">
							<c:set var="i" value="${ i+1 }" />
							<div class="col-xs-6 col-md-4" >
							<a class='thumbnail' href="/product/getSnackProduct?prodNo=${snack.prodNo}" style="text-decoration:none;">
								<img src="/images/uploadFiles/${snack.prodImage}">
							</a>
									<span><strong>��ǰ�� : ${snack.prodName }</strong></span>
								    <span><li> ���� : ${snack.prodPrice }</li></span>	   
								    <div style="text-align: left;">
	    						    </div>								
							<hr/>       
							</div>	
				          </c:forEach>
	            </div>
	          </div><!-- ���� �ǳ� �� -->
	</div>
</body>
</html>