<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head> 
	<meta charset="EUC-KR">

	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--   jQuery , Bootstrap CDN  -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!--   Modal CDN  -->
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script> 

   
<title></title>
</head>
	<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/topToolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
		<h2>Hello World!</h2>
		
		<iframe width="200" height="200" src="https://www.daum.net" >
			<p>not suport</p>
		</iframe>
		<h2>����</h2>
		<h2><a href = "/booking/getScreenMovieList">��ȭ ���� 1�ܰ�� ����</a></h2>
		<h2><a href = "/booking/selectPreview.jsp">�û�ȸ ���� 1�ܰ�� ����</a></h2>
		
		<!-- Modal ȭ�� tool bar�� ���� �޾ƿ��� ����	 --> 
		<div id="modal-testNew" class="modal fade" tabindex="-1" role="dialog" 
										aria-labelledby="�׽�Ʈ���� ���" aria-describedby="�׽�Ʈ ���">
		    <div class="modal-dialog" style="width:1200px;height:700px">
		        <div class="modal-content">
		        </div>
		    </div>
		</div> 
		<!-- Modal ȭ�� tool bar�� ���� �޾ƿ��� ��  --> 
	</body>
</html>