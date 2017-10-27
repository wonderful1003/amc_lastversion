<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@page import="com.amc.service.domain.User"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	User user = new User();
	user.setUserId("testAdmin");
	user.setRole("admin");
	session.setAttribute("user", user);
%>

<head>
<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
</head>

<!-- ToolBar Start /////////////////////////////////////-->
<div class="navbar  navbar-inverse navbar-fixed-bottom">
	
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
