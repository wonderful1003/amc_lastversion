<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
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
   
    <!-- jQuery UI toolTip ��� CSS-->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <!-- jQuery UI toolTip ��� JS-->
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
	
	
	
	
		//=============    �˻� / page �ΰ��� ��� ���  Event  ó�� =============	
		function fncGetPageList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method","POST").attr("action", "/movie/getMovieList?menu=commingsoon").submit();			
			//$("form").attr("method","POST").attr("action", "/movie/getMovieList").submit();
			
		}
		
	
		
		//============= "�˻�"  Event  ó�� =============	
		 $(function() {
			 //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-default" ).on("click" , function() {
				fncGetPageList(1);
			});
			
		 });
		
		//============= "�˻� Icon"  Event  ó�� =============	
		 $(function() {
			 //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "#searchIcon").on("click" , function() {
				fncGetPageList(1);
			});
			
		 });
		
		//============= "���� �˻� Icon"  Event  ó�� =============	
		 $(function() {
			 //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "#voidSearchIcon").on("click" , function() {
				self.location = "/movie/getMovieList?menu=voiceRegniiton";
			});
			
		 });
		
		
		
			
		//============= "Ķ������ ����"  Event  ó�� =============	
		$(function() {
			 //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-calendar" ).on("click" , function() {	
				 self.location = "/movie/getMovieList?menu=calendar";	
			});	
		});
		
		//============= "����Ϸ� ����"  Event  ó�� =============	
		$(function() {
			 //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-thumnail" ).on("click" , function() {	
				 self.location = "/movie/getMovieList?menu=commingsoon";	
			});	
		});
		
		//============= "WishList(��) Event ó��"  Event  ó�� =============	
		$(function() {
			 //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "#emty-hear" ).on("click" , function() {	
				 self.location = "/movie/getMovieList?menu=calendar";	
			});	
		});
		
		
			
		//============= movieNo �� ��ȭ��������  Event  ó��(Click) =============	
		 $(function() {
					
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "td:nth-child(2)").on("click" , function() {
				
 				 //alert( $(this).text().trim());
				 //var prodNoVal=	$("#prodNoValue").val();
				 //var movieNo=$(this).find("input[name='movieNo']").val();
				 //alert(movieNo);
				 self.location = "/movie/getMovie?movieNo="+$($(this).find('input')).val()+"&menu=managed";

			});
						
			//==> prodNo LINK Event End User ���� ���ϼ� �ֵ��� 
			$( "td:nth-child(2)" ).css("color" , "red");
			
			//==> prodNo LINK Event End User ���� ���ϼ� �ֵ��� 
			$( "td:nth-child(6)" ).css("color" , "green");
			
			});	

		
			//==> prodNo LINK Event End User ���� ���ϼ� �ֵ��� 
			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
			$("h7").css("color" , "red");
			
			//==> �Ʒ��� ���� ������ ������ ??
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
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>�� ���� ��ȭ</h3>
	    </div>
	    
	    <!-- table ���� �˻� Start //////F///////////////////////////////-->
	    <div class="row">
	    
	       <!-- table ���� �˻� Start //////F///////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			     
			     <!--  <button type="button" class="btn btn-default">�˻�</button> -->
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<!-- <option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>   -->
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ȭ����</option>
						<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>����</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				 		
				  <i class='glyphicon glyphicon-search' id="searchIcon" style="color:grey"></i>  &nbsp; 	
				  <i class='glyphicon glyphicon-volume-up' id="voidSearchIcon" style="color:grey"></i>	  
				
		
				  
				  <!-- <img src="../images/movie/speechListening2.gif">  -->
				
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
	    
	 
	  <br/>   
	  
	  <div class="widget" align="center">	
		  <button type="button" class="btn btn-thumnail">����Ϸ� ����</button>
		  <button type="button" class="btn btn-calendar">Ķ������ ����</button>
		 
		  <!-- <input type="submit" value="Ķ������">   -->
		
	  </div>
	  
	  <br/>   <br/>   <br/>
  
	
	 <div>
		<div class="row">
		
			<c:set var="i" value="0"/>
				<c:forEach var="movie" items="${list}">
					<c:set var="i" value="${i+1 }"/>
						<div class="col-xs-6 col-md-4" >
						<a class='thumbnail' href="/movie/getMovie?movieNo=${movie.movieNo}&menu=commingsoon" style="text-decoration:none;">
							<img src="${movie.postUrl}">
						
							<br/>
							
							<span><strong>${movie.movieNm }</strong></span>
							
							<span><li> ������ : ${movie.openDt }</li></span>						
				
						
						 	<div style="text-align: center;"> 
						 	 
					 	
    						    							
   							 <!-- glyphicon glyphicon-heart -->
   							 
   							
						     <input type='hidden' name='screenMovieNo' value='"+val.movieNo+"'><i class='glyphicon glyphicon-heart-empty' id='emty-hear'>���ϱ� </i>                                                    
                               &nbsp;<input type='hidden' name='screenMovieNo' value='"+val.movieNo+"'>
                             <i class='glyphicon glyphicon-phone-alt'></i> ����      
	                       
      
   						
							</div>	
							
							</a>						    
						
						</div>	
										
				</c:forEach>
				
							
		
	</div>


			<!--  ȭ�鱸�� div End /////////////////////////////////////-->
			 	<!-- PageNavigation Start... -->
			<jsp:include page="../common/pageNavigator.jsp"/>
			<!-- PageNavigation End... -->
	  
 	</div>
 
 	
 	
</body>


</html>