<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
		<meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" type="image/png" href="favicon.ico">

        <!--Google Fonts link-->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet">

        <link href="https://fonts.googleapis.com/css?family=Crimson+Text:400,400i,600,600i,700,700i" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Roboto+Condensed:300,300i,400,400i,700,700i" rel="stylesheet">


        <link rel="stylesheet" href="assets/css/slick.css">
        <link rel="stylesheet" href="assets/css/slick-theme.css">
        <link rel="stylesheet" href="assets/css/animate.css">
        <link rel="stylesheet" href="assets/css/fonticons.css">
        <link rel="stylesheet" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" href="assets/css/bootstrap.css">
        <link rel="stylesheet" href="assets/css/magnific-popup.css">
        <link rel="stylesheet" href="assets/css/bootsnav.css">


        <!--For Plugins external css-->
        <!--<link rel="stylesheet" href="assets/css/plugins.css" />-->

        <!--Theme custom css -->
        <link rel="stylesheet" href="assets/css/style.css">
        <!--<link rel="stylesheet" href="assets/css/colors/maron.css">-->

        <!--Theme Responsive css-->
        <link rel="stylesheet" href="assets/css/responsive.css" />

        <script src="assets/js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
        
         <!-- JS includes -->

        <script src="assets/js/vendor/jquery-1.11.2.min.js"></script>
        <script src="assets/js/vendor/bootstrap.min.js"></script>

        <script src="assets/js/isotope.min.js"></script>
        <script src="assets/js/jquery.magnific-popup.js"></script>
        <script src="assets/js/jquery.easing.1.3.js"></script>
        <script src="assets/js/slick.min.js"></script>
        <script src="assets/js/jquery.collapse.js"></script>
        <script src="assets/js/bootsnav.js"></script>

        <script src="assets/js/plugins.js"></script>
        <script src="assets/js/main.js"></script>
	
</head>
<body data-spy="scroll" data-target=".navbar-collapse">
  <div class="culmn">
  	<!-- 상단 고정 메뉴바 start -->
  	<nav class="navbar navbar-default navbar-fixed white no-background bootsnav text-uppercase">
  	 <!-- Start Top Search -->
                <div class="top-search">
                    <div class="container">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-search"></i></span>
                            <input type="text" class="form-control" placeholder="Search">
                            <span class="input-group-addon close-search"><i class="fa fa-times"></i></span>
                        </div>
                    </div>
                </div>
                <!-- End Top Search -->
                <!-- Start Top Search -->
                <div class="top-search">
                    <div class="container">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-search"></i></span>
                            <input type="text" class="form-control" placeholder="Search">
                            <span class="input-group-addon close-search"><i class="fa fa-times"></i></span>
                        </div>
                    </div>
                </div>
                <!-- End Top Search -->

                <div class="container">    
                    <!-- Start Atribute Navigation -->
                    <div class="attr-nav">
                        <ul>
                            <li class="search"><a href="#"><i class="fa fa-search"></i></a></li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" >
                                    <i class="fa fa-shopping-bag"></i>
                                    <span class="badge">3</span>
                                </a>
                                <ul class="dropdown-menu cart-list">
                                    <li>
                                        <a href="#" class="photo"><img src="assets/images/thumb01.jpg" class="cart-thumb" alt="" /></a>
                                        <h6><a href="#">Delica omtantur </a></h6>
                                        <p class="m-top-10">2x - <span class="price">$99.99</span></p>
                                    </li>
                                    <li>
                                        <a href="#" class="photo"><img src="assets/images/thumb01.jpg" class="cart-thumb" alt="" /></a>
                                        <h6><a href="#">Delica omtantur </a></h6>
                                        <p class="m-top-10">2x - <span class="price">$99.99</span></p>
                                    </li>
                                    <li>
                                        <a href="#" class="photo"><img src="assets/images/thumb01.jpg" class="cart-thumb" alt="" /></a>
                                        <h6><a href="#">Delica omtantur </a></h6>
                                        <p class="m-top-10">2x - <span class="price">$99.99</span></p>
                                    </li>
                                    <!---- More List ---->
                                    <li class="total">
                                        <span class="pull-right"><strong>Total</strong>: $0.00</span>
                                        <a href="#" class="btn btn-cart">Cart</a>
                                    </li>
                                </ul>
                            </li>

                        </ul>
                    </div>        
                    <!-- End Atribute Navigation -->

                    <!-- Start Header Navigation -->
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-menu">
                            <i class="fa fa-bars"></i>
                        </button>
                        <a class="navbar-brand" href="index.html">

                            <img src="assets/images/logo.png" class="logo logo-display" alt="">
                            <img src="assets/images/logo-black.png" class="logo logo-scrolled" alt="">

                        </a>
                    </div>
                    <!-- End Header Navigation -->

                    <!-- Collect the nav links, forms, and other content for toggling -->
                    <div class="collapse navbar-collapse" id="navbar-menu">
                        <ul class="nav navbar-nav navbar-right" data-in="fadeInDown" data-out="fadeOutUp">
                            <li><a href="index.html">home</a></li> 
							<li><a href="aboutus.html">about</a></li> 							                   
                            <li><a href="model.html">our models</a></li> 							
                            <li><a href="blog.html">blog</a></li>                                    
                            <li><a href="contactus.html">contact</a></li>                    
                        </ul>
                    </div><!-- /.navbar-collapse -->
                </div>  
            </nav>
      <!-- 상단 고정 메뉴바 end -->
      
      <!--Home Sections-->
            <section id="hello" class="model-banner bg-mega">
                <div class="overlay"></div>
                <div class="container">
                    <div class="row">
                        <div class="main_home text-center">
                            <div class="model_text">
                                <h1 class="text-white text-uppercase">FIRSTFIRSTFIRSTFIRSTFIRSTFIRSTFIRSTFIRSTFIRSTFIRSTFIRST</h1>
                                <ol class="breadcrumb">
                                    <li><a href="#">Home</a></li>
                                    <li class="active"><a href="#">OUR MODELS</a></li>
                                </ol>
                            </div>
                        </div>
                    </div><!--End off row-->
                </div><!--End off container -->
            </section> <!--End off Home Sections-->
            
            
            
            <!--Testimonial Section-->
            <section id="testimonial" class="testimonial fix roomy-100">
                <div class="container">
                    <div class="row">
                        <div class="main_testimonial text-center">

                            <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                                <div class="carousel-inner" role="listbox">
                                 <c:set var="i" value="0" />
									 <c:forEach var="movie" items="${unifiedSearch.uniMovieList}">
										<c:set var="i" value="${ i + 1 }" />
											<c:if test="${i eq 1 }">
											 <div class="item active testimonial_item">
		                                     	<div class="col-sm-10 col-sm-offset-1">
			                                         <div class="test_authour">
			                                             <img class="img-circle" src="${movie.postUrl }" alt="" />
			                                             <h6 class="m-top-20">${movie.movieNm }</h6>
			                                             <h5><em>abcd</em> </h5>
			                                         </div>
			                                         <p class=" m-top-40"> 영화번호 : ${movie.movieNo }</p>
		                                     	</div>
		                                  	</div>											
											</c:if>
											<c:if test="${i ne 1 }">
											<div class="item testimonial_item">
		                                     	<div class="col-sm-10 col-sm-offset-1">
			                                         <div class="test_authour">
			                                             <img class="img-circle" src="${movie.postUrl }" alt="" />
			                                             <h6 class="m-top-20">${movie.movieNm }</h6>
			                                             <h5><em>abcd</em> </h5>
			                                         </div>
			                                         <p class=" m-top-40"> 영화번호 : ${movie.movieNo }</p>
		                                     	</div>
		                                  	</div>			
											</c:if>
							         </c:forEach>
                                </div>

                                <!-- Controls -->
                                <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                                    <span class="fa fa-long-arrow-left" aria-hidden="true"></span>
                                    <span class="sr-only">Previous</span>
                                </a>
                                <span class="slash">/</span>
                                <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                                    <span class="fa fa-long-arrow-right" aria-hidden="true"></span>
                                    <span class="sr-only">Next</span>
                                </a>

                            </div>
                        </div>
                    </div><!--End off row-->
                </div><!--End off container -->

                <br />
                <br />
                <br />

            </section> <!--End off Testimonial section -->
  </div>

<br></br>
		<div style="background:yellow;border:1px solid #cccccc;">
		<p>검색한 영화</p>
		</div>
	    <c:set var="i" value="0" />
		  <c:forEach var="movie" items="${unifiedSearch.uniMovieList}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="left">${movie.movieNo }</td>
			  <td align="left"></td>
			  <td align="left">${movie.movieNm }</td>
			  <td align="left"></td>
			  <td align="left">${movie.postUrl }</td>
			  <td align="left"></td>
			</tr>
          </c:forEach>
          
          <br></br><br></br><br></br><br></br>

		<div style="background:yellow;border:1px solid #cccccc;">
		<p>검색한 굿즈</p>
		</div>
	    <c:set var="i" value="0" />
		  <c:forEach var="goods" items="${unifiedSearch.uniGoodsList}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="left">${goods.prodNo }</td>
			  <td align="left"></td>
			  <td align="left">${goods.prodPrice }</td>
			  <td align="left"></td>
			  <td align="left">${goods.prodRegDate }</td>
			  <td align="left"></td>
			  <td align="left">${goods.prodType }</td>
			  <td align="left"></td>
			  <td align="left">${goods.prodName }</td>
			  <td align="left"></td>
			  <td align="left">${goods.prodPrice }</td>
			  <td align="left"></td>
			  <td align="left">${goods.prodImage }</td>
			</tr>
          </c:forEach>
          
          <br></br><br></br><br></br><br></br><br></br>
          
     	<div style="background:yellow;border:1px solid #cccccc;">
		<p>검색한 스낵</p>
		</div>
		    <c:set var="i" value="0" />
			  <c:forEach var="snack" items="${unifiedSearch.uniSnackList}">
				<c:set var="i" value="${ i+1 }" />
				<tr>
				  <td align="center">${ i }</td>
				  <td align="left">${snack.prodNo }</td>
				  <td align="left"></td>
				  <td align="left">${snack.prodPrice }</td>
				  <td align="left"></td>
				  <td align="left">${snack.prodRegDate }</td>
				  <td align="left"></td>
				  <td align="left">${snack.prodType }</td>
				  <td align="left"></td>
				  <td align="left">${snack.prodName }</td>
				  <td align="left"></td>
				  <td align="left">${snack.prodPrice }</td>
				  <td align="left"></td>
				  <td align="left">${snack.prodImage }</td>
				</tr>
	         </c:forEach>
          
          <br></br><br></br><br></br><br></br>
          
        <div style="background:yellow;border:1px solid #cccccc;">
		<p>검색한 시사회</p>
		</div>
	    <c:set var="i" value="0" />
		  <c:forEach var="screenContent" items="${unifiedSearch.uniPreviewList}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="left">${screenContent.previewFlag }</td>
			  <td align="left"></td>
			  <td align="left">${screenContent.previewTitle }</td>
			  <td align="left"></td>
			  <td align="left">${screenContent.movie.movieNo }</td>
			  <td align="left"></td>
			  <td align="left">${screenContent.movie.postUrl }</td>
			  <td align="left"></td>
			</tr>
          </c:forEach>
</body>
</html>