<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head> 
<meta charset="EUC-KR">
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
		<h2>예매</h2>
		<h2><a href = "/booking/getScreenMovieList">영화 예매 1단계로 가기</a></h2>
		<h2><a href = "/booking/selectPreview.jsp">시사회 예매 1단계로 가기</a></h2>
	</body>
</html>