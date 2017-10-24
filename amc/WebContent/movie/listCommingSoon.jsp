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
            padding-top : 50px;
        }
    </style>   
    
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	
	
	
		//=============    �˻� / page �ΰ��� ��� ���  Event  ó�� =============	
		function fncGetPageList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method","POST").attr("action", "/movie/getMovieList?menu=search").submit();			
			//$("form").attr("method","POST").attr("action", "/movie/getMovieList").submit();
			
		}
		
	
		
		//============= "�˻�"  Event  ó�� =============	
		 $(function() {
			 //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-default" ).on("click" , function() {
				fncGetPageList(1);
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
		
		
			
		//============= prodNo �� ��ǰ��������  Event  ó��(Click) =============	
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
  			<!--��������-->
            <div class="container">
            <div class="container-fluid full-width">
                <div class="row-fluid">                   
                    
                    <span class="input-group-btn pull-right"><button class="btn btn-default pull-right" type="button">�˻�</button></span>
                    <input type="text" class="pull-right form-control" placeholder="�˻���" style="width:200px;" />
                    
                </div>
                </div>
            </div>	    	
		</div>
	
	  <br/>   <br/>   <br/>
	  
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
							<img src="${movie.postUrl }">
							<span>${movie.movieNm }</span>
						</a>
						</div>					
				</c:forEach>
		
	</div>

	  
 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
 	
 	
</body>


</html>