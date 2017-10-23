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
	<!--  <link rel="stylesheet" href="/resources/demos/style.css">  -->
	<!-- <link href="https://maxcdn.bootstrapcdn.com/bootswatch/3.3.7/flatly/bootstrap.min.css"   rel="stylesheet">  -->
	<!-- <link href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet"> -->
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   	<link href="/css/animate.min.css" rel="stylesheet">
    <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
    <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
   
    <!-- jQuery UI toolTip 사용 CSS-->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <!-- jQuery UI toolTip 사용 JS-->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>   
    
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	
	
	
		//=============    검색 / page 두가지 경우 모두  Event  처리 =============	
		function fncGetPageList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method","POST").attr("action", "/movie/getMovieList?menu=search").submit();			
			//$("form").attr("method","POST").attr("action", "/movie/getMovieList").submit();
			
		}
		
	
		
		//============= "검색"  Event  처리 =============	
		 $(function() {
			 //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-default" ).on("click" , function() {
				fncGetPageList(1);
			});
			
		 });
		
			
		//============= "캘린더로 보기"  Event  처리 =============	
		$(function() {
			 //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-calendar" ).on("click" , function() {	
				 self.location = "/movie/getMovieList?menu=calendar";	
			});	
		});
		
		//============= "썸네일로 보기"  Event  처리 =============	
		$(function() {
			 //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-thumnail" ).on("click" , function() {	
				 self.location = "/movie/getMovieList?menu=commingsoon";	
			});	
		});
		
		
			
		//============= prodNo 에 상품정보보기  Event  처리(Click) =============	
		 $(function() {
					
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "td:nth-child(2)").on("click" , function() {
				
 				 //alert( $(this).text().trim());
				 //var prodNoVal=	$("#prodNoValue").val();
				 //var movieNo=$(this).find("input[name='movieNo']").val();
				 //alert(movieNo);
				 self.location = "/movie/getMovie?movieNo="+$($(this).find('input')).val()+"&menu=managed";

			});
						
			//==> prodNo LINK Event End User 에게 보일수 있도록 
			$( "td:nth-child(2)" ).css("color" , "red");
			
			//==> prodNo LINK Event End User 에게 보일수 있도록 
			$( "td:nth-child(6)" ).css("color" , "green");
			
			});	

		
			//==> prodNo LINK Event End User 에게 보일수 있도록 
			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
			$("h7").css("color" , "red");
			
			//==> 아래와 같이 정의한 이유는 ??
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
	
			
			$('a[data-toggle="tooltip"]').tooltip({
				    animated: 'fade',
				    placement: 'bottom',
				    html: true
			}); 

	</script>
	
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/topToolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>상영 예정 영화</h3>
	    </div>
	    
	    <!-- table 위쪽 검색 Start //////F///////////////////////////////-->
	    <div class="row">
  			<!--센터정렬-->
            <div class="container">
            <div class="container-fluid full-width">
                <div class="row-fluid">                   
                    
                    <span class="input-group-btn pull-right"><button class="btn btn-default pull-right" type="button">검색</button></span>
                    <input type="text" class="pull-right form-control" placeholder="검색어" style="width:200px;" />
                    
                </div>
                </div>
            </div>	    	
		</div>
	
	  <br/>   <br/>   <br/>
	  
	  <div class="widget" align="center">	
		  <button type="button" class="btn btn-thumnail">썸네일로 보기</button>
		  <button type="button" class="btn btn-calendar">캘린더로 보기</button>
		 
		  <!-- <input type="submit" value="캘린더로">   -->
		
	  </div>
	  
	  <br/>   <br/>   <br/>
  
	
	 <div>
		<div class="row">
		
			<c:set var="i" value="0"/>
				<c:forEach var="movie" items="${list}">
					<c:set var="i" value="${i+1 }"/>
						<div class="col-xs-6 col-md-4" >
						<a class='thumbnail' href="/movie/getMovie?movieNo=${movie.movieNo}&menu=commingsoon" style="text-decoration:none;">
							<img src="${movie.postUrl }">
							<span>${movie.movieNm }</span>
						</a>
						</div>					
				</c:forEach>
		
	</div>

	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	
</body>


</html>