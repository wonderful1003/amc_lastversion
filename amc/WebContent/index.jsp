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
   
   <!--   Sweetalert2 CDN  -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.0/sweetalert2.all.min.js"></script>
	
	<!--   semantic UI  -->
	<link rel="stylesheet" type="text/css" href="../semantic/semantic.min.css">
	<script
	  src="https://code.jquery.com/jquery-3.1.1.min.js"
	  integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
	  crossorigin="anonymous"></script>
	<script src="../semantic/semantic.min.js"></script>
	
	<!--  CSS �߰� : ���ٿ� ȭ�� ������ ���� �ذ� :  �ּ�ó�� ��, �� Ȯ��-->
	<style type="text/css">
	.carousel {
    margin-bottom: 0;
	padding: 0 40px 30px 40px;
	}
	/* Reposition the controls slightly */
	.carousel-control {
		top: -30px;
		left: -12px;
	}
	.carousel-control.right {
		top: -30px;
		right: -12px;
	}
	/* Changes the position of the indicators */
	.carousel-indicators {
		right: 50%;
		top: auto;
		bottom: 0px;
		margin-right: -19px;
	}
	/* Changes the colour of the indicators */
	.carousel-indicators li {
		background: #c0c0c0;
	}
	.carousel-indicators .active {
	background: #333333;
	}
    body {
        padding-top : 70px;
        padding-bottom : 70px;
    }
    
	.jumbotron {
	  text-align: center;
	  border-bottom: 1px solid #e5e5e5;
	}
	.jumbotron .btn {
	  padding: 14px 24px;
	  font-size: 21px;
	}
   	</style>
   	<script>
   	function day(){
   		var now = new Date();
   		var then = new Date("November 24,2017"); // ������ 
   		var gap = then.getTime() - now.getTime();
   		gap = Math.floor(gap / (1000 * 60 * 60 * 24));
   		swal({
			  //position: 'top-right',
			  type: 'success',
			  title: gap+'�� ������!',
			  showConfirmButton: true,
			  timer: 2000
			})
   	}
   	</script>
   	

</head>
	<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/topToolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	<!-- Modal ȭ�� tool bar�� ���� �޾ƿ��� ����	 -->
   	<div class="container"> 
		<div id="modal-testNew" class="modal fade" tabindex="-1" role="dialog" 
										aria-labelledby="�׽�Ʈ���� ���" aria-describedby="�׽�Ʈ ���">
		    <div class="modal-dialog" style="width:1200px;height:700px">
		        <div class="modal-content">
		        </div>
		    </div>
		</div> 
	</div>
   	

		
	<!-- Modal ȭ�� tool bar�� ���� �޾ƿ��� ��  --> 
	<div class="container"> <!-- main container ���� -->
			<div class="row">
				<div class="jumbotron">
					<div class="container">
						<h1>Welcome</h1><p/>
						<h1>Americode Cinema!</h1>
				        <p class="lead">11�� 24�ϱ��� �ϼ�!</p>
				        <p><a class="btn btn-lg btn-success" role="button" onClick="javascript:day()">D-Day!</a></p>
					</div>
				</div>
			</div>
    </div> <!-- main Container �� -->


    <div class="container"><!-- second Container -->
    	<c:set var="who" value=""/>
    	<c:if test="${sessionScope.user.role ne 'admin'}">
    		<c:set var="who" value="search"/>	
    	</c:if>
    	<c:if test="${sessionScope.user eq null || sessionScope.user eq ''}">
    		<c:set var="who" value="search"/>	
    	</c:if>
    	<c:if test="${sessionScope.user.role eq 'admin'}">
    		<c:set var="who" value="admin"/>	
    	</c:if>
    	<div class="row" align="center">
    		<div class ="col-md-1"></div>
    		<div class ="col-md-10">
	    		<div class="ui link cards">
				  <div class="card">
				    <div class="image">
				      <img src="/images/cinema/Cancel.jpg">
				    </div>
				    <div class="content">
				      <div class="header">���ǥ �˸� ���!</div>
				      <div class="description">
				         ���� 2�ܰ迡�� ���ǥ �˸� ����� ����Ͻø� ���ǥ�� �߻��� SMS,���÷� �˷��帳�ϴ�!
				      </div>
				    </div>
				  </div>
				  <div class="card">
				    <div class="image">
				      <img src="/images/cinema/Alarm.jpg">
				    </div>
				    <div class="content">
				      <div class="header">Ƽ�Ͽ��� �˸� ���!</div>
				      <div class="description">
				        	�û�ȸ Ƽ�� ���� 30�� ���� SMS,���÷� �˷��帳�ϴ�!
				      </div>
				    </div>
				  </div>
				  <div class="card">
				    <div class="image">
				      <img src="/images/cinema/realTime.jpg">
				    </div>
				    <div class="content">
				      <div class="header">�ǽð� �¼� ����!</div>
				      <div class="meta">
				        <a>Coworker</a>
				      </div>
				      <div class="description">
				        	Ƽ�� ���� ȭ���� �ǽð����� �¼� ��Ȳ�� �����帳�ϴ�!
				      </div>
				    </div>
				  </div>
				</div>
			</div>
			<div class ="col-md-1"></div>
    	</div>
    	<p/><p/><p/><p/><p/><p/>
		<div class="row">
		  <div class="panel panel-success">
		  	<div class="panel-heading">
		  		<div class="panel-title" align="center">
		  			<h3>���� �� ��ȭ</h3>
		  		</div>
            </div>
           	 	<div class="panel-body">
           	 	<br/>
					<c:set var="maxThumb" value="3"/>
					<c:set var="size" value="${indexList.mainMovieList.size()}"/>
					<c:set var="temp" value="${size/maxThumb}"/>
					<c:set var="page" value="${temp+(1-(temp%1))%1}"/>
					<c:set var="check" value="0"/>
				
					<div class="col-md-12">
					    <div id="movieCarousel" class="carousel slide" data-ride="carousel"><!-- /.carousel start -->
					      <!-- Indicators -->
					      <ol class="carousel-indicators">
					      	<c:forEach var="count" begin="1" end="${page }" step="1">
					      		<c:if test="${count eq 1 }"> 
					        		<li data-target="#movieCarousel" data-slide-to="${count}" class="active" background="#c0c0c0"></li>
					        	</c:if>
					        	<c:if test="${count ne 1 }"> 
					        		<li data-target="#movieCarousel" data-slide-to="${count}" class="active"></li>
					        	</c:if>
					        </c:forEach>
					      </ol>
					      <div class="carousel-inner" role="listbox">
					      	<c:forEach var="pageNo" begin="1" end="${page}" step="1">
						      		<c:if test="${pageNo eq 1 }">
					      				<div class="item active">
					      					<div class="row">
					      					  <c:forEach var="count" begin="1" end="${maxThumb}" step="1">
					      					  <c:if test="${check < size}">
									          <div class="col-sm-4">
									          <a href="/movie/getMovie?movieNo=${indexList.mainMovieList[check].movieNo}&menu=${who}">
									          <img class="img-responsive center-block" src="${indexList.mainMovieList[check].postUrl}" style="width:500px; height:500px;">
									          </a>
									          </div>
									          </c:if>
									          <c:if test="${check >= size}">
											  <!-- <div class="col-sm-4"><img class="img-responsive center-block" src="http://placehold.it/500x500">
											  </div> -->
									          </c:if>
									          <c:set var="check" value="${ check+1 }" />
									          </c:forEach>
									        </div>  
								      	</div>
						      		</c:if>
						      		<c:if test="${pageNo ne 1 }">
					      				<div class="item">
					      					<div class="row">
					      					  <c:forEach var="count" begin="1" end="${maxThumb}" step="1">
					      					  <c:if test="${check < size}">
									          <div class="col-sm-4">
									          <a href="/movie/getMovie?movieNo=${indexList.mainMovieList[check].movieNo}&menu=${who}">
									          <img class="img-responsive center-block" src="${indexList.mainMovieList[check].postUrl}" style="width:500px; height:500px;">
									          </a>
									          </div>
									          </c:if>
									          <c:if test="${check >= size}">
											  <!-- <div class="col-sm-4"><img class="img-responsive center-block" src="http://placehold.it/500x500">
											  </div> -->
									          </c:if>
									          <c:set var="check" value="${ check+1 }" />
									          </c:forEach>
									         </div>
								      	</div>
						      		</c:if>
					      	</c:forEach>
					      <c:set var="check" value="0"/>
					      </div>
					      <a class="left carousel-control" href="#movieCarousel" role="button" data-slide="prev">
					        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
					        <span class="sr-only">Previous</span>
					      </a>
					      <a class="right carousel-control" href="#movieCarousel" role="button" data-slide="next">
					        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					        <span class="sr-only">Next</span>
					      </a>
					    </div><!-- /.carousel end-->
				    </div><!-- col-md-12  end-->
				</div><!-- panel-body end -->
			</div><!-- Panel Main end -->
		</div><!-- ���� �� ��ȭ row end-->    
			
		<div class="row"> <!--  �Ż�ǰ row  -->      
			 <div class="panel panel-info">
			  	<div class="panel-heading">
			  		<div class="panel-title" align="center">
			  			<h3>�� �� ǰ</h3>
			  		</div>
	            </div>
	         	<div class="panel-body">
	         	<br/>
				 <c:set var="i" value="0" />
				  <c:forEach var="newProductList" items="${indexList.newProductList}"> </c:forEach>
				  <c:set var="size" value="${indexList.newProductList.size()}"/>
				<c:set var="i" value="${ i+1 }" />
				
					<div class="row"> <!-- carousel row -->
						<div class="col-md-12">
						    <div id="newProductCarousel" class="carousel slide" data-ride="carousel"><!-- /.carousel start -->
						      <!-- Indicators -->
						      <ol class="carousel-indicators">
						      	<c:forEach var="count" begin="1" end="${size}" step="1">
						      		<c:if test="${count eq 1}">				      	
						        		<li data-target="#newProductCarousel" data-slide-to="${count-1}" class="active" background="#c0c0c0"></li>
						        	</c:if>
						        	<c:if test="${count ne 1}">				      	
						        		<li data-target="#newProductCarousel" data-slide-to="${count-1}"></li>
						        	</c:if>
						        </c:forEach>
						      </ol>
						      <div class="carousel-inner" role="listbox">
						      	  <c:forEach var="count" begin="1" end="${size}" step="1">
						      	  	 <c:if test="${count eq 1}">
							      	  	 <div class="item active">
							      	  	  	 <c:if test="${indexList.newProductList[count].prodType eq 'G'}">
							      	  	 	 	<a href="/product/getGoodsProduct?prodNo=${indexList.newProductList[count-1].prodNo}&menu=${who}">
							      	  	 	 </c:if>
							      	  	 	 <c:if test="${indexList.newProductList[count].prodType eq 'S'}">
							      	  	 	 	<a href="/product/getSnackProduct?prodNo=${indexList.newProductList[count-1].prodNo}&menu=${who}">
							      	  	 	 </c:if>
										     <img class="img-responsive center-block" 
										     src="/images/uploadFiles/${indexList.newProductList[count-1].prodImage}" 
										     style="width:600px; height:600px;
										     alt="${count} slide">
										     </a>
								      	 </div>	
						      	  	 </c:if>
						      	  	 <c:if test="${count ne 1}">
							      	  	 <div class="item">
							      	  	 	 <c:if test="${indexList.newProductList[count-1].prodType eq 'G'}">
							      	  	 	 	<a href="/product/getGoodsProduct?prodNo=${indexList.newProductList[count-1].prodNo}&menu=${who}">
							      	  	 	 </c:if>
							      	  	 	 <c:if test="${indexList.newProductList[count-1].prodType eq 'S'}">
							      	  	 	 	<a href="/product/getSnackProduct?prodNo=${indexList.newProductList[count-1].prodNo}&menu=${who}">
							      	  	 	 </c:if>
									    	 <img class="img-responsive center-block" 
									    	 src="/images/uploadFiles/${indexList.newProductList[count-1].prodImage}"
									    	 style="width:600px; height:600px;
									    	 alt="${count} slide">
									    	 </a>
								      	 </div>	
						      	  	 </c:if>
							      </c:forEach>
						      </div>
						      <a class="left carousel-control" href="#newProductCarousel" role="button" data-slide="prev">
						        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
						        <span class="sr-only">Previous</span>
						      </a>
						      <a class="right carousel-control" href="#newProductCarousel" role="button" data-slide="next">
						        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
						        <span class="sr-only">Next</span>
						      </a>
						    </div><!-- /.carousel end-->
						</div><!-- col-md-12 end-->
					</div><!-- carousel row end -->
				</div><!-- panel-body end -->
			</div><!-- Panel Main end -->
		</div><!--  �Ż�ǰ row end -->
		
		<div class="row"> <!--  ����Ʈ row  -->      
			 <div class="panel panel-danger">
			  	<div class="panel-heading">
			  		<div class="panel-title" align="center">
			  			<h3>����Ʈ ��ǰ</h3>
			  		</div>
	            </div>
	         	<div class="panel-body">
	         	<br/>
				 <c:set var="i" value="0" />
				  <c:forEach var="bestProductList" items="${indexList.bestProductList}"> </c:forEach>
				  <c:set var="size" value="${indexList.bestProductList.size()}"/>
				<c:set var="i" value="${ i+1 }" />
				
					<div class="row"> <!-- carousel row -->
						<div class="col-md-12">
						    <div id="bestProductCarousel" class="carousel slide" data-ride="carousel"><!-- /.carousel start -->
						      <!-- Indicators -->
						      <ol class="carousel-indicators">
						      	<c:forEach var="count" begin="1" end="${size}" step="1">
						      		<c:if test="${count eq 1}">				      	
						        		<li data-target="#bestProductCarousel" data-slide-to="${count }" class="active" background="#c0c0c0"></li>
						        	</c:if>
						        	<c:if test="${count ne 1}">				      	
						        		<li data-target="#bestProductCarousel" data-slide-to="${count }"></li>
						        	</c:if>
						        </c:forEach>
						      </ol>
						      <div class="carousel-inner" role="listbox">
						      	  <c:forEach var="count" begin="1" end="${size}" step="1">
						      	  	 <c:if test="${count eq 1}">
							      	  	 <div class="item active">
							      	  	 	 <c:if test="${indexList.bestProductList[count-1].prodType eq 'G'}">
							      	  	 	 	<a href="/product/getGoodsProduct?prodNo=${indexList.bestProductList[count-1].prodNo}&menu=${who}">
							      	  	 	 </c:if>
							      	  	 	 <c:if test="${indexList.bestProductList[count-1].prodType eq 'S'}">
							      	  	 	 	<a href="/product/getSnackProduct?prodNo=${indexList.bestProductList[count-1].prodNo}&menu=${who}">
							      	  	 	 </c:if>
									         <img class="img-responsive center-block" 
									         src="/images/uploadFiles/${indexList.bestProductList[count-1].prodImage}"
									         style="width:600px; height:600px; 
									         alt="${count} slide">
									         </a>
								      	 </div>	
						      	  	 </c:if>
						      	  	 <c:if test="${count ne 1}">
							      	  	 <div class="item">
	 							      	  	 <c:if test="${indexList.bestProductList[count-1].prodType eq 'G'}">
							      	  	 	 	<a href="/product/getGoodsProduct?prodNo=${indexList.bestProductList[count-1].prodNo}&menu=${who}">
							      	  	 	 </c:if>
							      	  	 	 <c:if test="${indexList.bestProductList[count-1].prodType eq 'S'}">
							      	  	 	 	<a href="/product/getSnackProduct?prodNo=${indexList.bestProductList[count-1].prodNo}&menu=${who}">
							      	  	 	 </c:if>
									          <img class="img-responsive center-block" 
									          src="/images/uploadFiles/${indexList.bestProductList[count-1].prodImage}"
									          style="width:600px; height:600px; 
									          alt="${count} slide">
									          </a>
								      	 </div>	
						      	  	 </c:if>
							      </c:forEach>
						      </div>
						      <a class="left carousel-control" href="#bestProductCarousel" role="button" data-slide="prev">
						        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
						        <span class="sr-only">Previous</span>
						      </a>
						      <a class="right carousel-control" href="#bestProductCarousel" role="button" data-slide="next">
						        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
						        <span class="sr-only">Next</span>
						      </a>
						    </div><!-- /.carousel end-->
						</div><!-- col-md-12 end-->
					</div><!-- carousel row end -->
				</div><!-- panel-body end -->
			</div><!-- Panel Main end -->
		</div><!--  ����Ʈ row end -->
	  <div class="row">
	  <!-- bttomToolBar Start /////////////////////////////////////-->
	  <jsp:include page="/layout/bottomToolbar.jsp" />
   	  <!-- bottomToolBar End /////////////////////////////////////-->
	  </div>
	  </div><!-- second Container -->
	</body>
</html>