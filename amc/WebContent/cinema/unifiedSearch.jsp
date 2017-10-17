<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
꺄끼뀨
<br></br>

<%-- 		<input type="text" value="검색한 영화" >
	    <c:set var="i" value="0" />
		  <c:forEach var="movie" items="${unifiedSearch.uniMovieList}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="left">${movie.movieNo }</td>
			  <td align="left"></td>
			  <td align="left">${movie.movieTitle }</td>
			  <td align="left"></td>
			  <td align="left">${movie.poster }</td>
			  <td align="left"></td>
			</tr>
          </c:forEach> --%>
          
          <br></br><br></br><br></br><br></br>

		<input type="text" value="검색한 굿즈" >
	    <c:set var="i" value="0" />
		  <c:forEach var="goods" items="${unifiedSearch.uniGoodsList}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="left">${goods.prodNo }</td>
			  <td align="left"></td>
			  <td align="left">${goods.prodPrice }</td>
			  <td align="left"></td>
			  <td align="left">${goods.prodRegDate }</td>
			  <td align="left"></td>
			  <td align="left">${goods.prodType }</td>
			  <td align="left"></td>
			  <td align="left">${goods.prodName }</td>
			  <td align="left"></td>
			  <td align="left">${goods.prodPrice }</td>
			  <td align="left"></td>
			  <td align="left">${goods.prodImage }</td>
			</tr>
          </c:forEach>
          
          <br></br><br></br><br></br><br></br><br></br>
          
     		<input type="text" value="검색한 굿즈" >
		    <c:set var="i" value="0" />
			  <c:forEach var="snack" items="${unifiedSearch.uniSnackList}">
				<c:set var="i" value="${ i+1 }" />
				<tr>
				  <td align="center">${ i }</td>
				  <td align="left">${snack.prodNo }</td>
				  <td align="left"></td>
				  <td align="left">${snack.prodPrice }</td>
				  <td align="left"></td>
				  <td align="left">${snack.prodRegDate }</td>
				  <td align="left"></td>
				  <td align="left">${snack.prodType }</td>
				  <td align="left"></td>
				  <td align="left">${snack.prodName }</td>
				  <td align="left"></td>
				  <td align="left">${snack.prodPrice }</td>
				  <td align="left"></td>
				  <td align="left">${snack.prodImage }</td>
				</tr>
	         </c:forEach>
          
          <br></br><br></br><br></br><br></br>
          
        <input type="text" value="검색한 시사회" >
	    <c:set var="i" value="0" />
		  <c:forEach var="screenContent" items="${unifiedSearch.uniPreviewList}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="left">${screenContent.previewFlag }</td>
			  <td align="left"></td>
			  <td align="left">${screenContent.previewTitle }</td>
			  <td align="left"></td>
			  <td align="left">${screenContent.movie.movieNo }</td>
			  <td align="left"></td>
			  <td align="left">${screenContent.movie.poster }</td>
			  <td align="left"></td>
			</tr>
          </c:forEach>


</body>
</html>