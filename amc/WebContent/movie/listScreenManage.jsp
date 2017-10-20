<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
  <%@ page contentType="text/html; charset=EUC-KR" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

<jsp:include page="/layout/topToolbar.jsp" />



<div class="container">
		<div>
			<h3>상영 관리</h3>
		</div>
		
		<div class="row">
			<div class="col-md-6 text-left">
				<p> 전체  ${resultPage.totalCount } 건, 현재 ${resultPage.currentPage } 페이지</p>
			</div>
			
			
			<div class="col-md-6 text-right">
			
				<form name="detailForm">
					<div>
						<select name="searchCondition">
							<option value="0">영화 제목</option>
							<option value="1">감독명</option>
						</select>
					</div>
			
			<div>
				<label for="searchKeyword">검색어</label>
				<input type="text" id="searchKeyword" name="searchKeyword" placeholder="검색어">
			</div>
			
			<button type="button" name = "searchButton">검색</button>
			
			<input type="hidden" id="currnetPage" name="currentPage" value=""/>
			</form>

		</div>
	</div>
	
	
	
	<div>
		<div class="row">
		
			<c:set var="i" value="0"/>
				<c:forEach var="screen" items="${list }">
					<c:set var="i" value="${i+1 }"/>
						<div class="col-xs-6 col-md-4" name ="screenThumbnail">
						<a class='thumbnail' href="/screen/getScreenContentList/${screen.movieNo}" style="text-decoration:none;">
							<img src="${screen.postUrl }">
							<span>${screen.movieNm }</span>
						</a>
						</div>
					
				</c:forEach>
		
		</div>
	
	</div>
	
	
	
	
	
</div>
</body>
</html>