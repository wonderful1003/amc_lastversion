<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@page import="com.amc.service.domain.User"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!-- 여기가 다른 jsp 페이지에 있는 cdn 시작///////////////////////////////////////////////////////////////////////////////////////////// -->
	<!-- <meta name="viewport" content="width=device-width, initial-scale=1.0" /> -->
	
	<!--  해림 CDN 순서변경-->
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->	
	<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->


	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<!-- 여기가 다른 jsp 페이지에 있는 cdn 끝/////////////////////////////////////////////////////////////////////////////////////////////// -->
	
	<!--  해림 캐러셀 사용 js-->
	<script type="text/javascript" src="http://kenwheeler.github.io/slick/slick/slick.min.js"></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
  
   	<!-- 카카오 로그인 -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
	<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
	<!-- 카카오 로그인 -->
   
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
</head>

<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-inverse navbar-fixed-top">
	 
	<div class="container">
	       <!-- 절대경로로 변경  -->
		<a class="navbar-brand" href="/index.jsp">
			<img src="/images/common/AMC_Logo.png" width="80px" height="30px"/>
		</a>
		
		<!-- toolBar Button Start //////////////////////// -->
		<div class="navbar-header">
		    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		    </button>
		</div>
		<!-- toolBar Button End //////////////////////// -->
		
	    <!--  dropdown hover Start -->
		<div 	class="collapse navbar-collapse" id="target" 
	       			data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew">
	         
	         	<!-- Tool Bar 를 다양하게 사용하면.... -->
	             <ul class="nav navbar-nav">
	             
	              <!-- 영화 DrowDown -->
	              <li class="dropdown">
	                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	                         <span>영화</span>
	                         <span class="caret"></span>
	                     </a>
	                     <ul class="dropdown-menu">
	                         <li><a href="#">현재 상영영화</a></li>
	                         <li><a href="#">상영 예정영화</a></li>
	                         <li class="divider"></li>
	                         <li><a href="#">시사회</a></li>
	                     </ul>
	                 </li>
	                 
	              <!-- 예매 DrowDown  -->
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span>예매</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">영화 예매</a></li>
		                         <li><a href="#">시사회 예매</a></li>
		                     </ul>
		                </li>
		                
	              <!-- 영화관  -->
					  <li><a href="#">영화관</a></li>
				
				  <!-- 커뮤니티  -->  
					  <li><a href="#">커뮤니티</a></li>
		                
	              <!-- 스토어 DrowDown  -->
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span>스토어</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">굿즈</a></li>
		                         <li><a href="#">스낵바</a></li>
		                     </ul>
		                </li>
	                 
	             <!-- 관리자메뉴 DrowDown  -->
	             
	               <c:if test="${sessionScope.user.role == 'admin'}">
		              <li class="dropdown">
		                     <a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		                         <span >[관리자 메뉴]</span>
		                         <span class="caret"></span>
		                     </a>
		                     <ul class="dropdown-menu">
		                         <li><a href="#">회원관리</a></li>
		                         <li><a href="#">상품관리</a></li>
		                         <li><a href="#">판매관리</a></li>
		                         <li><a href="#">영화관리</a></li>
		                         <li><a href="#">상영관리</a></li>
		                         <li><a href="#">예매관리</a></li>
		                     </ul>
		                </li>
	                 </c:if>
	                 
	             </ul>
	             
	             
	             
	             <ul class="nav navbar-nav navbar-right">
	             <li>
	             	<div></div>
	             </li>
	             <li>
	             	<div></div>
	             </li>
	             <li>
	             	<div></div>
	             </li>
	             <li>
	           		<div style = margin:10px>
						<form class="form-inline" action="/cinema/unifiedSearch" method="post" role="form">
							<input type="text" class="form-control" name="searchKeyword" placeholder="통합검색">
							<input type="button" class="form-control" value="검색" onClick="javascript:unifiedSearch()">
						</form>
					</div>  
	          	 </li>
	             </ul>
	             
	           	 <!-- 유저가 비로그인 상태일 시 -->	
	 			<c:if test="${empty user}">		
	 				<li>			
						<form class="navbar-form navbar-right">
						<!-- <a data-toggle="modal" href="../user/loginUser" data-target="#modal-testNew" role="button" data-backdrop="static"> -->
						<a data-toggle="modal" href="/user/loginUser" data-target="#modal-testNew" role="button" data-backdrop="static">
							<button type="button" class="btn btn-primary">Log in</button>
						</a >
							<a href="/user/authForm.jsp"><button type="button" class="btn btn-primary">Sign in</button></a>
						</form>
					</li>	
				</c:if>	
				
				<c:if test="${!empty user}">
					<ul class="nav navbar-nav navbar-right">
						<li><a href="#" class="user-info">[${sessionScope.user.userName}]</a>
						<li><a href="/cinema/myPage.jsp">마이페이지</a></li>
						<li><a href="#">로그아웃</a></li>
					</ul>
				</c:if> 
   
		</div>
		<!-- dropdown hover END -->	       
	</div>
</div>
		<!-- ToolBar End /////////////////////////////////////-->
 	
   	
   	
   	<script type="text/javascript">
	
   	
	   	function openHistory(){
	   		popWin = window.open("../openHistory.jsp","popWin","left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
	   	}
	   	
	   	function unifiedSearch(){
	   		$("form").attr("method" , "POST").attr("action" , "/cinema/unifiedSearch").submit();
	   	}
   	
		
		//============= 영화 Event  처리 =============	
		/*  $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("a:contains('영화')").on("click" , function() {
				//$(self.location).attr("href","/user/logout");
				self.location = "/movie/getMovieList"
			}); 
		 }); */
		
		//=============  현재 상영영화 Event  처리 =============	
	 	$( "a:contains('현재 상영영화'),a:contains('ID')" ).on("click" , function() {
	 		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$(self.location).attr("href","/movie/getMovieList?menu=movie");
		});
		
		
	 	//=============  상영 예정영화 Event  처리 =============	
	 	$( "a:contains('상영 예정영화')" ).on("click" , function() {
			$(self.location).attr("href","/movie/getMovieList?menu=commingsoon");
		});
	 	
	 	//=============  시사회 Event  처리 =============	
	 	$( "a:contains('시사회')" ).on("click" , function() {
			$(self.location).attr("href","/movie/getMovieList?menu=preview");
		});
	 	
	 	//=============  예매 Event  처리 =============	
	 	$( "a:contains('예매')" ).on("click" , function() {
			$(self.location).attr("href","/booking/getScreenMovieList");
		});
	 	
	 	//=============  영화 예매 Event  처리 =============	
	 	$( "a:contains('영화 예매')" ).on("click" , function() {
			$(self.location).attr("href","/booking/getScreenMovieList");
		});
	 	
	 	//=============  시사회 예매 Event  처리 =============	
	 	$( "a:contains('시사회 예매')" ).on("click" , function() {
			$(self.location).attr("href","/booking/getPreviewList");
		});
		
	 	//=============  영화관 Event  처리 =============	
	 	$( "a:contains('영화관')" ).on("click" , function() {
			$(self.location).attr("href","/cinema/theaterInfo.jsp");
		});
	 	
	 	//=============  커뮤니티 Event 처리 =============	
	 	$( "a:contains('커뮤니티')" ).on("click" , function() {
			$(self.location).attr("href","/community/getFreeBoardList");
		});
	 	
	 	//============= 스토어 Event 처리 =============	
	 	$( "a:contains('스토어')" ).on("click" , function() {
			$(self.location).attr("href","/product/getGoodsList?menu=search");
		});
	 	
	 	//=============  굿즈 Event 처리 =============	
	 	$( "a:contains('굿즈')" ).on("click" , function() {
			$(self.location).attr("href","/product/getGoodsList?menu=search");
		});
	 	
	 	//=============  스낵바 Event 처리 =============	
	 	$( "a:contains('스낵바')" ).on("click" , function() {
			$(self.location).attr("href","/product/getSnackList?menu=search");
		});
	 	
	 	//=============  회원관리 Event  처리 =============	
	 	$( "a:contains('회원관리')" ).on("click" , function() {
			$(self.location).attr("href","/user/getUserList");
		});
	 	
	 	//=============  상품관리 Event  처리 =============	
	 	$( "a:contains('상품관리')" ).on("click" , function() {
			$(self.location).attr("href","/product/getGoodsList?menu=manage");
		});
	 	
	 	//=============  판매관리 Event  처리 =============	
	 	$( "a:contains('판매관리')" ).on("click" , function() {
			$(self.location).attr("href","/purchase/getSaleList");
		});
	 	
	 	//=============  영화관리 Event  처리 =============	
	 	$( "a:contains('영화관리')" ).on("click" , function() {
			$(self.location).attr("href","/movie/getMovieList?menu=manage");
		});
	 	
	 	//=============  상영관리 Event  처리 =============	
	 	$( "a:contains('상영관리')" ).on("click" , function() {
			$(self.location).attr("href","/screen/getScreenList");
		});
	 	
	 	//=============  예매관리 Event  처리 =============	
	 	$( "a:contains('예매관리')" ).on("click" , function() {
			$(self.location).attr("href","/booking/getAdminBookingList");
		});
	 	
	 	
/* 	 	//============= login Event  처리 =============	
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		 	$("input:contains('로그인')").on("click" , function() {
				$(self.location).attr("href","/user/loginUser");
			}); 
		 });
 */	 	
	 	//============= logout Event  처리 =============	
/*		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
 		 	$("a:contains('로그아웃')").on("click" , function() {
				$(self.location).attr("href","/user/logoutUser");
			}); 
		 });
 */	 	
 
	 $(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("a:contains('로그아웃')").on("click" , function() {
			//alert("카카오로그아웃");
			logoutWithKakao();
			
		}); 
	});
 
		function logoutWithKakao() {
			Kakao.init('fc5658887af25f840e94144f6722b228');
			Kakao.Auth.logout(function(){
				setTimeout(function(){
					location.href="/user/logoutUser/"
				},300);
				});
		}

		//=============  최근 본 상품  처리 =============	
		 	$( "a:contains('최근 본 상품')" ).on("click" , function() {
		 		openHistory();
			});
	 	
	</script>  