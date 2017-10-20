<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>

<%@page import="java.util.Arrays"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService"%> 
<%@page import="org.codehaus.jackson.map.ObjectMapper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Collection"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.util.JSONBuilder"%>
<%@page import="net.sf.json.JSONArray"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<html lang="UTF-8">
	

<head>
	<meta charset="UTF-8">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   <script type="text/javascript" src="../javascript/calendar.js"></script>
   
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
     </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	

	function fncUpdateMovie() {
		// document.fncAddProduct.submit();
		
		var movieNm=$("input[name='movieNm']").val();
		
		var directors=$("input[name='directors']").val();	
		var actors=$("input[name='actors']").val();
		var genres=$("input[name='genres']").val();
		var watchGradeNm=$("input[name='watchGradeNm']").val();
		var openDt=$("input[name='openDt']").val();
		var showTm=$("input[name='showTm']").val();
		var endDt=$("input[name='endDt']").val();
		var synopsis=$("input[name='synopsis']").val();
		var trailer=$("input[name='trailer']").val();		
		
		
		if(movieNm == null || movieNm.length<1){
			alert("영화 제목 Null 오류 발생");
			return;
		}
		if(directors == null || directors.length<1){
			alert("감독명은 반드시 입력하여야 합니다.");
			return;
		}
		if(actors == null || actors.length<1){
			alert("배우명은 반드시 입력하여야 합니다.");
			return;
		}
		if(genres == null || genres.length<1){
			alert("장르명은 반드시 입력하셔야 합니다.");
			return;
		}
		if(watchGradeNm == null || watchGradeNm.length<1){
			alert("관람등급은 반드시 입력하셔야 합니다.");
			return;
		}
		if(openDt == null || openDt.length<1){
			alert("개봉날짜는  반드시 입력하셔야 합니다.");
			return;
		}
		if(showTm == null || showTm.length<1){
			alert("러닝타임은  반드시 입력하셔야 합니다.");
			return;
		}
		if(endDt == null || endDt.length<1){
			alert("상영마감은  반드시 입력하셔야 합니다.");
			return;
		}
		if(synopsis == null || synopsis.length<1){
			alert("줄거리는 반드시 입력하셔야 합니다.");
			return;
		}
		if(trailer == null || trailer.length<1){
			alert("스틸컷은  반드시 입력하셔야 합니다.");
			return;
		}
	
		$("form").attr("method","GET").attr("action","/movie/updateMovie").submit();
	}
		
	
	$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
			 $( "#moviebtn" ).on("click" , function() {
					//Debug..
					// <!-- <a href="javascript:history.go(-1)"></a> -->
					fncUpdateMovie()
			});
			
			
			 $( "#deletebtn" ).on("click" , function() {
					//Debug..
					// <!-- <a href="javascript:history.go(-1)"></a> -->
					$("form")[0].reset();
				 	
			});
			
			 $("#btn-upload").on("click", function(){
     			alert("steelCut click event occurred...")
				 
				if(($("#file1").val() == "" || $("#file1").val() == null)) {
     			    alert("파일 첫 번째가 없습니다.");
     			} 
     			
     			/* else if(($("#file2").val() == "" || $("#file2").val() == null)) {
     			    alert("파일 두 번째가 없습니다.");
     			} else { */

     			   var form = new FormData(document.getElementById('uploadForm'));
			    $.ajax({
				      url: "/movie/json/upload", //컨트롤러 URL
				      data: form,
				      dataType: 'json',
				      processData: false,
				      contentType: false,
				      type: 'POST',
				      success: function (response) {
				    	  alert("성공적으로 파일 업로드되었습니다.");
				    	  console.log(response);
				      },error: function (jqXHR) {
				    	   //alert("성공적으로 파일 업로드되었습니다.");
					       alert(jqXHR.responseText);
					       console.log(jqXHR.responseText);
				      }
			   });
			    
		  });
	 });
	
	
	
	 
	/* $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
			 $( "#deletebtn" ).on("click" , function() {
					//Debug..
					// <!-- <a href="javascript:history.go(-1)"></a> -->
					$("form")[0].reset();
				 	
			});
	});	
	 */
	
	
	</script>
	
</head>

<body>

<form id="updateMovie" enctype="multipart/form-data" method="POST">  
<input type="hidden" name="movieNo" value="${movie.movieNo}"/>


	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/topToolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">${movie.movieNm}</h3>
	    </div>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>감독</strong></div>
			<input type="text" name="directors" value="${movie.directors}"
				   class="ct_input_g" 	     style="width: 160px; 
				   height: 20px" 		     maxLength="30"/>
		</div>
		
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>배우</strong></div>
			<input type="text" name="actors" 	
				   value="${movie.actors}"
				   class="ct_input_g" 
				   style="width: 160px;      height: 20px" maxLength="30"/>
	
		</div>
		
			
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>장르</strong></div>
			<input type="text" name="genres" 	
				   class="ct_input_g"    value="${movie.genres}"
				   style="width: 160px;  height: 20px" maxLength="30" />
	
		</div>
		
		<div class="row">
  		<div class="col-xs-4 col-md-2 "><strong>관람등급</strong></div>
		<input type="text" name="watchGradeNm" 	
			   class="ct_input_g"    value="${movie.watchGradeNm}"
			   style="width: 160px;  height: 20px" maxLength="30" />
	
		</div>

		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>개봉날짜 </strong></div>
			<input 	type="date" name="openDt" class="ct_input_g" 
							value="${movie.openDt}" 	
							style="width: 160px; height: 20px" maxLength="30"/>					
		</div>

		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>러닝타임</strong></div>
			<input type="text" name="showTm" 	
				   class="ct_input_g"    value="${movie.showTm}" 
				   style="width: 160px;  height: 20px" maxLength="30" /> &nbsp;분
		
		</div>


		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상영마감 </strong></div>
			<input 	type="date" name="endDt" class="ct_input_g" 
							value="${movie.endDt}" 	
							style="width: 160px; height: 20px" maxLength="30"/>		
		</div>		
	
					
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>포스터</strong></div>
	  		<img src="${movie.postUrl}" width="160px" height="180px" align="left"/>
	  		
		</div>
		
		<hr/>
		
		<!-- 
		<div class="row">
		<input		type="file" name="file"  class="ct_input_g" value="${movie.steelCut}"
				    style="width: 245px; height: 20px" maxLength="30" align="right"/>
		</div>
		 -->
		
		<div><input class="ui-button ui-widget ui-corner-all"  type="file" id="file1" name="file" required="required" /></div>
		<div><input class="ui-button ui-widget ui-corner-all"  type="file" id="file2" name="file"  /></div>
		<div><input class="ui-button ui-widget ui-corner-all"  type="file" id="file2" name="file"  /></div>   
	    
	    <br/> 
	  	<div> <button id="btn-upload">스팉컷 추가</button></div>
		
				
		<hr/>
			
		<div class="row">
	  		<div class="col-md-2 text-left ">
	  			<button type="button" id="moviebtn"  class="btn btn-primary">수정</button>
	  		</div>
	  		<div class="col-md-2 text-left ">
	  			<button type="button" id="deletebtn"   class="btn btn-primary">삭제</button>
	  		</div>
		</div>
		
		<br/>
		
 	</div>
 	<!--  화면구성 div Start /////////////////////////////////////-->

</form>
</body>

</html>