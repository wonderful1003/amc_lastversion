<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@page import="com.amc.service.domain.User"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<head>
<meta charset="EUC-KR">
	
</head>

<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-inverse navbar-fixed-bottom">
	<div class="container"> 
		<div id="modal-testNew" class="modal fade" tabindex="-1" role="dialog" 
										aria-labelledby="테스트정보 등록" aria-describedby="테스트 모달">
		    <div class="modal-dialog" style="width:1200px;height:700px">
		        <div class="modal-content">
		        </div>
		    </div>
		</div> 
	</div>
	
	<div class="container">
	       
		<a class="navbar-brand" href="/index.jsp">
			<img src="../images/common/AMC_Logo.png" width="80px" height="30px"/>
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
	             <ul class="nav navbar-nav navbar-middle">
	             
	             	
	                 <li><a href="#"></a></li>
	                 <li><a href="#"></a></li>
	                 <li><a href="#"></a></li>
	                 <li><a href="#"></a></li>
	                 <li><a href="#"></a></li>
	                 <li><a href="#"></a></li>
	                 <li><a href="#"></a></li>
	                 <li><a href="#"></a></li>
	                 <li><a href="#"></a></li>
	                 <li><a href="#"></a></li>	                 
	                 <li><a href="#">Americode Company</a></li>
	                 
	                 
	             </ul>
	             
	             
	             
	             <ul class="nav navbar-nav navbar-right">
	             
		             <li><a href="#">@Copyright 2017 Americode Cinema</a></li>

	            </ul>
		</div>
		<!-- dropdown hover END -->	       
	</div>
</div>
		<!-- ToolBar End /////////////////////////////////////-->
