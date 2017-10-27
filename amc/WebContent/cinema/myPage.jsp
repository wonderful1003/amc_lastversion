<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
   
   	<!--   Sweetalert CDN  -->
	<!-- <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> -->
	
	<!--   Sweetalert2 CDN  -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.0/sweetalert2.all.min.js"></script>
	
	<!--   semantic UI  -->
	<link rel="stylesheet" type="text/css" href="../semantic/semantic.min.css">
	<script
	  src="https://code.jquery.com/jquery-3.1.1.min.js"
	  integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
	  crossorigin="anonymous"></script>
	<script src="../semantic/semantic.min.js"></script>
	
	<style type="text/css">
	body {
        padding-top : 70px;
        /* Location of the image */
	  background-image: url(http://cfs13.blog.daum.net/image/33/blog/2008/07/20/23/06/488346649fe48&filename=%EC%9D%B4%EC%81%9C%EC%97%B0%EC%9D%B8.jpg);
	  
	  /* Background image is centered vertically and horizontally at all times */
	  background-position: center center;
	  
	  /* Background image doesn't tile */
	  background-repeat: no-repeat;
	  
	  /* Background image is fixed in the viewport so that it doesn't move when 
	     the content's height is greater than the image's height */
	  background-attachment: fixed;
	  
	  /* This is what makes the background image rescale based
	     on the container's size */
	  background-size: cover;
	  
	  /* Set a background color that will be displayed
	     while the background image is loading */
	  background-color: #464646;
    }
    .bs-calltoaction{
    position: relative;
    width:auto;
    padding: 15px 25px;
    border: 1px solid black;
    margin-top: 10px;
    margin-bottom: 10px;
    border-radius: 5px;
}

    .bs-calltoaction > .row{
        display:table;
        width: calc(100% + 30px);
    }
     
        .bs-calltoaction > .row > [class^="col-"],
        .bs-calltoaction > .row > [class*=" col-"]{
            float:none;
            display:table-cell;
            vertical-align:middle;
        }

            .cta-contents{
                padding-top: 10px;
                padding-bottom: 10px;
            }

                .cta-title{
                    margin: 0 auto 15px;
                    padding: 0;
                }

                .cta-desc{
                    padding: 0;
                }

                .cta-desc p:last-child{
                    margin-bottom: 0;
                }

            .cta-button{
                padding-top: 10px;
                padding-bottom: 10px;
            }

@media (max-width: 991px){
    .bs-calltoaction > .row{
        display:block;
        width: auto;
    }

        .bs-calltoaction > .row > [class^="col-"],
        .bs-calltoaction > .row > [class*=" col-"]{
            float:none;
            display:block;
            vertical-align:middle;
            position: relative;
        }

        .cta-contents{
            text-align: center;
        }
}



.bs-calltoaction.bs-calltoaction-default{
    color: #333;
    background-color: #fff;
    border-color: #ccc;
}

.bs-calltoaction.bs-calltoaction-primary{
    color: #fff;
    background-color: #337ab7;
    border-color: #2e6da4;
}

.bs-calltoaction.bs-calltoaction-info{
    color: #fff;
    background-color: #5bc0de;
    border-color: #46b8da;
}

.bs-calltoaction.bs-calltoaction-success{
    color: #fff;
    background-color: #5cb85c;
    border-color: #4cae4c;
}

.bs-calltoaction.bs-calltoaction-warning{
    color: #fff;
    background-color: #f0ad4e;
    border-color: #eea236;
}

.bs-calltoaction.bs-calltoaction-danger{
    color: #fff;
    background-color: #d9534f;
    border-color: #d43f3a;
}

.bs-calltoaction.bs-calltoaction-primary .cta-button .btn,
.bs-calltoaction.bs-calltoaction-info .cta-button .btn,
.bs-calltoaction.bs-calltoaction-success .cta-button .btn,
.bs-calltoaction.bs-calltoaction-warning .cta-button .btn,
.bs-calltoaction.bs-calltoaction-danger .cta-button .btn{
    border-color:#fff;
}
	</style>
</head>
<body>
	<!-- ToolBar Start /////////////////////////////////////-->	
	<jsp:include page="/layout/topToolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	<!-- Modal 화면 tool bar로 부터 받아오기 시작	 --> 
	<div id="modal-testNew" class="modal fade" tabindex="-1" role="dialog" 
									aria-labelledby="테스트정보 등록" aria-describedby="테스트 모달">
	    <div class="modal-dialog" style="width:1200px;height:700px">
	        <div class="modal-content">
	        </div>
	    </div>
	</div> 
   	<div class="container">
            <div class="col-sm-12">
                <div class="bs-calltoaction bs-calltoaction-default">
                    <div class="row">
                        <div class="col-md-9 cta-contents">
                            <h1 class="cta-title">내 정보 보기</h1>
                            <div class="cta-desc">
                            	<div class="ui list">
								  <div class="item">
								    <i class="map marker icon"></i>
								    <div class="content">
								      <div class="header">내 정보 수정</div>
								    </div>
								  </div>
								  <div class="item">
								    <i class="map marker icon"></i>
									   <div class="content">
									      <div class="header">회원 탈퇴</div>
									    </div>
								  </div>
								</div>
                            </div>
                        </div>
                        <div class="col-md-3 cta-button">
                        	<a href="/user/getUser?userId=${sessionScope.user.userId}" class="btn btn-lg btn-block btn-default">이동</a>
                        </div>
                     </div>
                </div>

                <div class="bs-calltoaction bs-calltoaction-primary">
                    <div class="row">
                        <div class="col-md-9 cta-contents">
                           <h1 class="cta-title">예매 목록</h1>
                            <div class="cta-desc">
                            	<div class="ui list">
								  <div class="item">
								    <i class="map marker icon"></i>
								    <div class="content">
								      <div class="header">상세 예매 내역 조회</div>
								    </div>
								  </div>
								  <div class="item">
								    <i class="map marker icon"></i>
									   <div class="content">
									      <div class="header">예매 리스트 보기</div>
									    </div>
								  </div>
								</div>
                            </div>
                        </div>
                        <div class="col-md-3 cta-button">
                            <a href="/booking/getBookingList" class="btn btn-lg btn-block btn-primary">이동</a>
                        </div>
                     </div>
                </div>

                <div class="bs-calltoaction bs-calltoaction-info">
                    <div class="row">
                        <div class="col-md-9 cta-contents">
                            <h1 class="cta-title">위시 리스트</h1>
                            <div class="cta-desc">
                            	<div class="ui list">
								  <div class="item">
								    <i class="map marker icon"></i>
								    <div class="content">
								      <div class="header">영화 위시리스트 조회</div>
								    </div>
								  </div>
								  <div class="item">
								    <i class="map marker icon"></i>
									   <div class="content">
									      <div class="header">시사회 위시리스트 조회</div>
									    </div>
								  </div>
								</div>
                            </div>
                        </div>
                        <div class="col-md-3 cta-button">
                            <a href="/movie/getWishList" class="btn btn-lg btn-block btn-info">이동</a>
                        </div>
                     </div>
                </div>

                <div class="bs-calltoaction bs-calltoaction-success">
                    <div class="row">
                        <div class="col-md-9 cta-contents">
                           <h1 class="cta-title">취소표 알리미</h1>
                            <div class="cta-desc">
                            	<div class="ui list">
								  <div class="item">
								    <i class="map marker icon"></i>
								    <div class="content">
								      <div class="header">취소표 알리미 조회</div>
								    </div>
								  </div>
								  <div class="item">
								    <i class="map marker icon"></i>
									   <div class="content">
									      <div class="header">취소표 알리미 취소</div>
									    </div>
								  </div>
								</div>
                            </div>
                        </div>
                        <div class="col-md-3 cta-button">
                            <a href="/alarm/getCancelAlarmList" class="btn btn-lg btn-block btn-success">이동</a>
                        </div>
                     </div>
                </div>

                <div class="bs-calltoaction bs-calltoaction-warning">
                    <div class="row">
                      <div class="col-md-9 cta-contents">
                        <h1 class="cta-title">티켓오픈시간 알리미</h1>
                            <div class="cta-desc">
                            	<div class="ui list">
								  <div class="item">
								    <i class="map marker icon"></i>
								    <div class="content">
								      <div class="header">티켓오픈시간 알리미</div>
								    </div>
								  </div>
								  <div class="item">
								    <i class="map marker icon"></i>
									   <div class="content">
									      <div class="header">티켓오픈시간 알리미 취소</div>
									    </div>
								  </div>
								</div>
                            </div>
                        </div>
                        <div class="col-md-3 cta-button">
                            <a href="/alarm/getOpenAlamList" class="btn btn-lg btn-block btn-warning">이동</a>
                        </div>
                     </div>
                </div>

                <div class="bs-calltoaction bs-calltoaction-danger">
                    <div class="row">
                     <div class="col-md-9 cta-contents">
                       <h1 class="cta-title">스토어 구매 목록</h1>
                            <div class="cta-desc">
                            	<div class="ui list">
								  <div class="item">
								    <i class="map marker icon"></i>
								    <div class="content">
								      <div class="header">구매 상세 조회</div>
								    </div>
								  </div>
								  <div class="item">
								    <i class="map marker icon"></i>
									   <div class="content">
									      <div class="header">구매 물품 조회</div>
									    </div>
								  </div>
								</div>
                            </div>
                        </div>
                        <div class="col-md-3 cta-button">
                            <a href="/purchase/listPurchase" class="btn btn-lg btn-block btn-danger">이동</a>
                        </div>
                     </div>
                </div>
            </div>
        </div>
</body>
</html>