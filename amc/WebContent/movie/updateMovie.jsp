<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"   pageEncoding="EUC-KR"%>

<%@page import="java.util.Arrays"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.codehaus.jackson.map.ObjectMapper"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Collection"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.util.JSONBuilder"%>
<%@page import="net.sf.json.JSONArray"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<html lang="ko">
	

   <meta charset="EUC-KR">
   
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <!-- <link rel="stylesheet" href="https://code.jquery.com/ui/1.11.4/themes/ui-darkness/jquery-ui.css" >  -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/sunny/jquery-ui.css">
    <link rel="stylesheet" type="text/css" media="screen" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.7.1/css/bootstrap-datepicker.css" />
    <link href="/css/animate.min.css" rel="stylesheet">
    <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    
     
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.14.1/css/ui.jqgrid.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.14.1/jquery.jqgrid.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.7.1/js/bootstrap-datepicker.js"></script>
 	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
 	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 	  body {
            padding-top: 70px;
            }
            .thumbnail {
            width: 150px;
            height: 200px;
            overflow: auto;
      }	
     </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	$(function() {
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
		 $( "#updateMoviebtn" ).on("click" , function() {
			 	alert("���� ��ư Ŭ�� Ȯ��");
				//Debug..
				// <!-- <a href="javascript:history.go(-1)"></a> -->
				fncUpdateMovie()
		});
	});	



	$(function() {
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
		 $( "#deleteMoviebtn" ).on("click" , function() {
				//Debug..
				// <!-- <a href="javascript:history.go(-1)"></a> -->
				fncDeleteMovie()
			 	
		});
	});	
	
	
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
	
		
	
		if(directors == null || directors.length<1){
			alert("�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if(actors == null || actors.length<1){
			alert("������ �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if(genres == null || genres.length<1){
			alert("�帣���� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if(watchGradeNm == null || watchGradeNm.length<1){
			alert("��������� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if(openDt == null || openDt.length<1){
			alert("������¥��  �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if(showTm == null || showTm.length<1){
			alert("����Ÿ����  �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if(endDt == null || endDt.length<1){
			alert("�󿵸�����  �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
	
	
		$("form").attr("method","POST").attr("action","/movie/updateMovie").submit();
	}	
	
	
	 //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	function fncDeleteMovie() {		
		 
		var movieNo=$("input[name='movieNo']").val();
		alert("movieNo" + movieNo );
		 
		$("form").attr("method","POST").attr("action","/movie/deleteMovie?movieNo="+movieNo).submit();
	}	
	 
	 </script>
	
</head>

<form id="updateMovie" enctype="multipart/form-data" method="POST">  
<input type="hidden" name="movieNo" value="${movie.movieNo}"/>


	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/topToolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->

<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">${movie.movieNm}</h3>
	    </div>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>����</strong></div>
			<input type="text" name="directors" value="${movie.directors}"
				   class="ct_input_g" 	     style="width: 160px; 
				   height: 20px" 		     maxLength="30"/>
		</div>
		
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>���</strong></div>
			<input type="text" name="actors" 	
				   value="${movie.actors}"
				   class="ct_input_g" 
				   style="width: 160px;      height: 20px" maxLength="30"/>
	
		</div>
		
			
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�帣</strong></div>
			<input type="text" name="genres" 	
				   class="ct_input_g"    value="${movie.genres}"
				   style="width: 160px;  height: 20px" maxLength="30" />
	
		</div>
		
		<div class="row">
  		<div class="col-xs-4 col-md-2 "><strong>�������</strong></div>
		<input type="text" name="watchGradeNm" 	
			   class="ct_input_g"    value="${movie.watchGradeNm}"
			   style="width: 160px;  height: 20px" maxLength="30" />
	
		</div>

		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>������¥ </strong></div>
			<input 	type="date" name="openDt" class="ct_input_g" 
							value="${movie.openDt}" 	
							style="width: 160px; height: 20px" maxLength="30"/>					
		</div>

		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>����Ÿ��</strong></div>
			<input type="text" name="showTm" 	
				   class="ct_input_g"    value="${movie.showTm}" 
				   style="width: 160px;  height: 20px" maxLength="30" /> &nbsp;��
		
		</div>


		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�󿵸��� </strong></div>
			<input 	type="date" name="endDt" class="ct_input_g" 
							value="${movie.endDt}" 	
							style="width: 160px; height: 20px" maxLength="30"/>		
		</div>		
	
					
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>������</strong></div>
	  		<img src="${movie.postUrl}" width="160px" height="180px" align="left"/>
	  		
		</div>
		
		<hr/>
		
	    <div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�ٰŸ�</strong></div>	  	
	    <textarea name="synopsis" cols="90" rows="8" >${movie.synopsis} </textarea> 	
	    </div>
		
		<hr/>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��ƿ��</strong></div>
	  		<a class='thumbnail' style="text-decoration:none;">
	  		<!-- <img src="file:C:/amcPoster/${movie.steelCut1}" width="160px" height="180px" align="left"/>  -->
	  		<img src="../images/movie/${movie.steelCut1} " width="160px" height="180px" align="left"/>
	  		<img src="../images/movie/${movie.steelCut2} " width="160px" height="180px" align="left"/>
	  		<img src="../images/movie/${movie.steelCut3} " width="160px" height="180px" align="left"/>
	  		</a>
	  	</div>
	 
	  	
	    <hr/>
	    
		<div><input class="ui-button ui-widget ui-corner-all"  type="file" id="file1" name="file" required="required" /></div>
		<div><input class="ui-button ui-widget ui-corner-all"  type="file" id="file2" name="file"  /></div>
		<div><input class="ui-button ui-widget ui-corner-all"  type="file" id="file2" name="file"  /></div>   
				
		<hr/>
	    
	    <div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>Ʈ���Ϸ� URL</strong></div>	  	
	    <textarea name="trailer" cols="90" rows="2" >${movie.trailer} </textarea> 	

		<hr/>
		<div class="row">
	  		<div class="col-md-2 text-left ">
	  			<button type="button" id="updateMoviebtn"  class="btn btn-primary">����</button>
	  		</div>
	  		<div class="col-md-2 text-left ">
	  			<button type="button" id="deleteMoviebtn"   class="btn btn-primary">����</button>
	  		</div>
		</div>
		
		<br/>
		
 	</div>
 </div>
 	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->

</form>
</body>
</html>

