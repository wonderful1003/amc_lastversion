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
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
		//=============    검색 / page 두가지 경우 모두  Event  처리 =============	
		function fncGetPageList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method","POST").attr("action", "/movie/getMovieList?menu=manage").submit();
			//$("form").attr("method","POST").attr("action", "/movie/getMovieList").submit();
			
		}
			
		
		//============= "검색"  Event  처리 =============	
		 $(function() {
			 //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-default" ).on("click" , function() {
				fncGetPageList(1);
			});
			
		 });
		
		//============= "영화등록"  Event  처리 =============	
		 $(function() {
			 //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-register" ).on("click" , function() {
				 self.location = "/movie/addMovie.jsp";
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
	       <h3>영화 정보 관리</h3>
	    </div>
	    
	    <!-- table 위쪽 검색 Start //////F///////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<!-- <option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>   -->
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>영화제목</option>
						<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>감독</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
	
	
	  <br/>
	  <button type="button" class="btn btn-register">영화등록</button>
	
	
	   <br/> <br/> 
	  
		
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >영화제목</th>
            <th align="left">감독</th>
            <th align="left">개봉날자</th>
            <th align="left">장르</th>
            <th align="left">상영등급</th>
			<th align="left">등록날짜</th>
			 
          </tr>
        </thead>
       
		<tbody>
		  <c:set var="i" value="0" />
		  <c:forEach var="movie" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			    <td align="left">
			    
				<input name="movieNo" id = "movieNo" value = "${movie.movieNo}" type="hidden"/>	
			
			    ${movie.movieNm} 
		
			  </td>	
			  		   		 
			  <td align="left">${movie.directors}</td>
			  <td align="left">${movie.openDt}</td>
			  <td align="left">${movie.genres}</td>			  	  		   		 
			  <td align="left">${movie.watchGradeNm}</td>			
			  <td align="left">${movie.movieRegDate}</td>
		
			  <td align="left">
			  
			   
			      	<i class="glyphicon glyphicon-ok" id= "${movie.movieNo}"></i>
			  		<input type="hidden" id="pronNo" value="${movie.movieNo}">
			
			  </td>
			</tr>
          </c:forEach>
     
  
 
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator.jsp"/>
	<!-- PageNavigation End... -->
	
</body>


</html>