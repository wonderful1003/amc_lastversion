<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html >
<html>
<head> 
<title>selectScreenMovie.jsp</title>

<script>
		function listener(event){		
			  document.getElementById('child').contentWindow.postMessage(event.data,"*");
			  alert("hi~ im in a function listener");
			  alert("event.data : "+event.data);
			  document.getElementById('target').textContent= event.data;
		}
		
		
		if (window.addEventListener){
			  addEventListener("message", listener, false);
		} else {
			  attachEvent("onmessage", listener)
		}
</script>

</head>
	<body>
		<h2>[예매 2단계]좌석선택입니다.</h2>
		<span id="target">여기값이 바뀌어랏</span>
		<iframe id="child" src="http://127.0.0.1:52273/yenakoh/3?screenNo=1020" width="400" height="400" frameborder="1">
				  <p>Your browser does not support iframes.</p>
		</iframe>
		<button onclick="myFunction()">Try it</button>
		<h2></h2>
		JSP Version: <%= JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() %> <br>
	</body>
</html>
