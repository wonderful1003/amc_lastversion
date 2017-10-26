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
            padding-top: 70px;
            }
            .thumbnail {
            width: 300px;
            height: 250px;
            overflow: auto;
      }	
      
      #searchIcon
       {    color: #fff;       		
    		text-shadow: 1px 1px 1px #ccc;
    		font-size: 1.5em;
       }
       
     #voidSearchIcon
       {    color: #fff;       		
    		text-shadow: 1px 1px 1px #ccc;
    		font-size: 1.5em;
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
		
		//============= "검색 Icon"  Event  처리 =============	
		 $(function() {
			 //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "#searchIcon").on("click" , function() {
				fncGetPageList(1);
			});
			
		 });
		
		//============= "음성 검색 Icon"  Event  처리 =============	
		 $(function() {
			 //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "#voidSearchIcon").on("click" , function() {
				self.location = "/movie/getMovieList?menu=voiceRegniiton";
			});
			
		 });
		
		//============= "WishList(찜) Event 처리"  Event  처리 =============	
			$(function() {
				 //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				$("span:contains('찜하기')" ).on("click" , function() {
					 self.location = "/movie/getMovieList?menu=calendar";	
				});	
			});
			
				
			//============= "예약  Event 처리"  Event  처리 =============	
			$(function() {
				 //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				$("span:contains('예매')" ).on("click" , function() {
					 self.location = "/booking/getScreenMovieList";	
				});	
			});
			
		
		//============= movieNo 에 영화정보보기  Event  처리(Click) =============	
		 $(function() {
					
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "td:nth-child(2)").on("click" , function() {
				
 				 //alert( $(this).text().trim());
				 //var prodNoVal=	$("#prodNoValue").val();
				 //var movieNo=$(this).find("input[name='movieNo']").val();
				 //alert(movieNo);
				 self.location = "/movie/getMovie?movieNo="+$($(this).find('input')).val()+"&menu=managed";

			});
		
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
	       <h3>현재 상영 영화</h3>
	    </div>
	    
	    <!-- table 위쪽 검색 Start //////F///////////////////////////////-->
	    <div class="row">
	    
	      <%--    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div> --%>
		    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		
		    	</p>
		    </div> 
	    
	       <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				 <%--   <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>영화제목</option>
						<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>감독</option>
					</select>
				  </div> --%>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				   		
				  <i class='glyphicon glyphicon-search' id="searchIcon" style="color:grey"></i>  &nbsp; 	
				  <i class='glyphicon glyphicon-volume-up' id="voidSearchIcon" style="color:grey"></i>	  
				
		
				  
				<!--   <button type="button" class="btn btn-default">검색</button> -->
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
    
  		<!-- 		
            <div class="container">
            <div class="container-fluid full-width">
                <div class="row-fluid">                   
                    
                    <span class="input-group-btn pull-right"><button class="btn btn-default pull-right" type="button">검색</button></span>
                    <input type="text" class="pull-right form-control" placeholder="검색어" style="width:200px;" />
                    
                </div>
                </div>
            </div>	    	
		</div> -->
	
	  <br/>   <br/>   <br/>
	
	 <div>
		<div class="row">
		
			<c:set var="i" value="0"/>
				<c:forEach var="movie" items="${list}">
					<c:set var="i" value="${i+1 }"/>
						<div class="col-xs-6 col-md-4" >
						<a class='thumbnail' href="/movie/getMovie?movieNo=${movie.movieNo}&menu=search" style="text-decoration:none;">
							<img src="${movie.postUrl }">
						</a>
						
						<hr/>
								
								<span><strong>${movie.movieNm }</strong></span>
							    <span><li> 개봉일 : ${movie.openDt }</li></span>	
							    
							    <div style="text-align: left;">
    						    
    						    </div>								
    							 
							    <span>
							     <i class='glyphicon glyphicon-heart-empty' id='emty-hear'>찜하기 </i> 
							     </span>                                                   
	                               &nbsp;&nbsp;
	                             <span>
	                             <input type='hidden' name='screenMovieNo' value='"+val.movieNo+"'>
	                             <i class='glyphicon glyphicon-phone-alt' id='reserve-ticket'>예매 </i>   
	                             </span>
	                             
                             <hr/>       
      
    						
					
						</div>					
				</c:forEach>
		
	</div>

	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator.jsp"/>
	<!-- PageNavigation End... -->
	
</body>


</html>