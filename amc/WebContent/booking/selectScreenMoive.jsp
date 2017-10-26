<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
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
	
	<!--  CSS �߰� : ���ٿ� ȭ�� ������ ���� �ذ� :  �ּ�ó�� ��, �� Ȯ��-->
	<style>
        body {
            padding-top : 70px;
        }
   	</style>
   	<!--  not sure about this part -->
   	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>

   <!-- ------------------------------>
	<script type="text/javascript">
		
		//1. ��ȭ���� Ŭ����
		$( function() {
			
			$("td.movieName").on("click" , function() {
				
				var movieNo =  $($(this).find("input[name='movieNo']")).val();
				var flag = $("input:hidden[name='flag']").val();
				
				$.ajax(
						{
							url : "/booking/json/getScreenDate/"+movieNo+"/"+flag,						
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData, status) {
								console.log('���� : '+JSONData);								
		                        var str = "";
		                        if(JSONData != ""){
		                            $(JSONData).each(
		                               function(){		                            	   	
		                            	  	str+= 	'<div class="screenDay">'+this+'��'
		                            	  	str+=     '<input type="hidden" name="day" value='+this+'>'
		                            	  	str+=	'</div>';
		                               });//end of each fnc                            
		                        }//end of if��
		                        $(".col-md-4").eq(1).find(".screenDay").remove();
		                        $(".col-md-4").eq(2).find(".screenTime").remove();
		                        $(".col-md-4").eq(1).find(".head").after(str);
		                        
							}
					});//end of ajax
			});

		});
		
		
		//2. ��¥ Ŭ����
		$(document).on("click", ".screenDay",  function(){
			alert("��¥�� �����ϼ̽��ϴ�.");
			
			var date =  $($(this).find("input[name='day']")).val();
			
			$.ajax(
					{
						url : "/booking/json/getScreenTime/"+date,						
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						}, 
						async : false,
						success : function(JSONData, status) {
							console.log('screenTime �޾ƿ� : '+JSONData);								
	                        var str = "";
	                        if(JSONData != ""){
	                            $(JSONData).each(
	                               function(){
	                            	   str+= '<div class="screenTime">�ð� : '+this.screenOpenTime
	                            	   +     ', �󿵹�ȣ : '+this.screenContentNo+''
	                            	   +'<input type="hidden" name="contNo" value="'+this.screenContentNo+'">'
	                            	   +'</div>' ;				

	                               }//end of function
	                             );
	                        }//end of if��
	                        
	                        $(".col-md-4").eq(2).find(".screenTime").remove();
	                        $(".col-md-4").eq(2).find(".head").after(str);
						}
				});//end of ajax
		});
		
		//3. �ð�Ŭ����
		$(document).on("click", ".screenTime",  function(){
			
			var contNo = $($(this).find("input[name='contNo']")).val();
			alert("�ð��� �����ϼ̽��ϴ�  �󿵹�ȣ�� : "+contNo);
			
			$("#display").text(contNo);	

		});
			
		$(document).on("click", "#gotoSeat",  function(){
			
			var screenContentNo = $("#display").text();	
			self.location = "/booking/selectSeat?screenContentNo="+"10000";

		});
	
	</script>
	
<title>selectScreenMovie.jsp</title>
</head>
	<body>

	 <div class="container">
	 <h2>[����1�ܰ�]��ȭ �������� ������ �ּ���.</h2>
	 <input type="hidden" name="flag" value="1">
      <div class="row">
        <div class="col-md-4">
         <div class="head"><h2>��ȭ ����</h2></div>
          <table>
	          <c:set var="i" value="0" />
			  <c:forEach var="movie" items="${movieList}">
				<c:set var="i" value="${ i+1 }" />
				<tr>		  
				  <td align="left" class="movieName"><h5>${movie.movieNm}  ${movie.movieNo}</h5>
				  	<input type="hidden" name="movieNo" value="${movie.movieNo}">
				  </td>
				</tr>
	          </c:forEach>        
          </table>
        </div>
		<div class="col-md-4" id="dayList">
			<div class="head"><h2>�� ��¥</h2></div>
	   	</div>
	   	<div class="col-md-4" id="dayList">
			<div class="head"><h2>�� ��¥</h2></div>
	   	</div>
      </div>
      
   	  </div> 
   	  
	  <!-- /container -->	
	<div id="display" ></div>
	<div id="gotoSeat"><h2>���¼������ϱ�</h2></div>
	
	
	</body>	
</html>
